{% extends '//die/c/cmake.sh' %}

{% block fetch %}
https://github.com/fastfetch-cli/fastfetch/archive/refs/tags/2.3.3.tar.gz
sha:81ff290af3e1d93927e871500644d330a40422087450ddd64aa5be31e8232616
{% endblock %}

{% block bld_libs %}
lib/c
lib/z
lib/glib
lib/dbus
lib/chafa
#lib/opengl
lib/sqlite/3
lib/wayland/dl
#lib/drivers/3d
lib/pciutils/dl
lib/image/magick
lib/vulkan/headers
lib/vulkan/loader/dl
{% endblock %}

{% block patch %}
sed -e 's|command-not-found|mc|' -i src/detection/terminalshell/terminalshell_linux.c
{% endblock %}
