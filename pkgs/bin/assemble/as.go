package main

import (
    "os"
    "fmt"
    "log"
    "sync"
    "strings"
    "os/exec"
    "encoding/json"
//    "golang.org/x/sync/semaphore"
)

const (
    ESC = "\x1b"
    RST = ESC + "[0m"
    R = ESC + "[91m"
    G = ESC + "[92m"
    Y = ESC + "[93m"
    B = ESC + "[94m"
)

type Cmd struct {
    Args []string `json:"args"`
    Stdin string `json:"stdin"`
    Env map[string]string `json:"env"`
}

type Node struct {
    InDirs []string `json:"in_dir"`
    OutDirs []string `json:"out_dir"`
    Cmds []Cmd `json:"cmd"`
}

type Graph struct {
    Nodes []Node `json:"nodes"`
    Targets []string `json:"targets"`
}

func toFiles(dirs []string) []string {
    res := []string{}

    for _, d := range dirs {
        res = append(res, d + "/touch")
    }

    return res
}

func outs(node *Node) []string {
    return toFiles(node.OutDirs)
}

func ins(node *Node) []string {
    return toFiles(node.InDirs)
}

func checkExists(path string) bool {
    if _, err := os.Stat(path); err == nil {
        return true
    }

    return false
}

func env(cmd *Cmd) []string {
    ret := []string{}

    for k, v := range cmd.Env {
        ret = append(ret, k + "=" + v)
    }

    return ret
}

func lookupPath(prog string, path string) string {
    for _, p := range strings.Split(path, ":") {
        pp := p + "/" + prog

        if checkExists(pp) {
            return pp
        }
    }

    log.Fatalf("%scan not find %s in %s%s\n", R, prog, path, RST)

    return ""
}

func complete(node *Node) bool {
    for _, o := range outs(node) {
        if !checkExists(o) {
            return false
        }

        fmt.Printf("%sREADY %s%s\n", G, o, RST)
    }

    return true
}

func executeCmd(c *Cmd) {
    cmd := exec.Cmd{
        Path: lookupPath(c.Args[0], c.Env["PATH"]),
        Args: c.Args,
        Env: env(c),
        Dir: "/",
        Stdin: strings.NewReader(c.Stdin),
        Stdout: os.Stdout,
        Stderr: os.Stderr,
    }

    if err := cmd.Run(); err != nil {
        log.Fatal(err)
    }
}

func executeNode(node *Node) {
    for _, o := range outs(node) {
        fmt.Printf("%sINFLY %s%s\n", Y, o, RST)
    }

    for _, cmd := range node.Cmds {
        executeCmd(&cmd)
    }

    for _, o := range outs(node) {
        if file, err := os.Create(o); err == nil {
            file.Close()
        }

        fmt.Printf("%sREADY %s%s\n", G, o, RST)
    }
}

type NodeFuture struct {
    f func()
    o sync.Once
}

func (self *NodeFuture) callOnce() {
    self.o.Do(self.f)
}

type Executor struct {
    byOut map[string]*Node
    lock sync.Mutex
    vis map[*Node]*NodeFuture
}

func (self *Executor) execute(node *Node) {
    if complete(node) {
        return
    }

    self.visitAll(ins(node))
    executeNode(node)
}

func newFuture(ex *Executor, node *Node) *NodeFuture {
    return &NodeFuture{f: func() {
        ex.execute(node)
    }}
}

func newExecutor(graph *Graph) *Executor {
    byOut := map[string]*Node{}
    vis := map[*Node]*NodeFuture{}

    for i, _ := range graph.Nodes {
        node := &graph.Nodes[i]

        for _, out := range outs(node) {
            byOut[out] = node
        }
    }

    return &Executor{byOut: byOut, vis: vis}
}

func (self *Executor) future(node *Node) *NodeFuture {
    self.lock.Lock()
    defer self.lock.Unlock()

    if fut, ok := self.vis[node]; ok {
        return fut
    }

    fut := newFuture(self, node)
    self.vis[node] = fut

    return fut
}

func (self *Executor) visit(node *Node) {
    if node == nil {
        log.Fatal(R + "empty node" + RST)
    }

    self.future(node).callOnce()
}

func (self *Executor) visitAll(nodes []string) {
    wg := &sync.WaitGroup{}
    defer wg.Wait()

    for _, n := range nodes {
        o := self.byOut[n]

        go func() {
            defer wg.Done()
            self.visit(o)
        }()

        wg.Add(1)
    }
}

func main() {
    var graph Graph

    if err := json.NewDecoder(os.Stdin).Decode(&graph); err != nil {
        log.Fatal(err)
    }

    newExecutor(&graph).visitAll(graph.Targets)
}
