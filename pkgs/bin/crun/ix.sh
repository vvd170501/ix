{% extends '//die/c/autorehell.sh' %}

{% block git_repo %}
https://github.com/containers/crun
{% endblock %}

{% block git_branch %}
1.9.1
{% endblock %}

{% block git_sha %}
ebdd3c57a520ca427dbf6cb12fbfa14960d655e690c4b07c76b1e850cc68b12c
{% endblock %}

{% block bld_libs %}
lib/c
lib/cap
lib/intl
lib/yajl
lib/seccomp
lib/argp/standalone
{% endblock %}

{% block bld_tool %}
bin/gperf
bld/python
bld/fakegit
{% endblock %}

{% block configure_flags %}
--disable-dl
--disable-systemd
--disable-embedded-yajl
{% endblock %}

{% block build %}
cat << EOF > git-version.h
#pragma once
#define GIT_VERSION "{{self.git_branch().strip()}}"
EOF
{{super()}}
{% endblock %}
