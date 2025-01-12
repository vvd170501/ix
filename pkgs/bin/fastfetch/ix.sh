{% extends '//die/c/cmake.sh' %}

{% block fetch %}
https://github.com/fastfetch-cli/fastfetch/archive/refs/tags/2.7.1.tar.gz
sha:64778068628426a1d4394f756cec70a62dd9f7fabc267dd7bdcbfc6302f6476e
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
