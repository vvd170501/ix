{% extends '//mix/meson.sh' %}

{% block fetch %}
https://download.gnome.org/sources/evince/41/evince-41.3.tar.xz
sha:3346b01f9bdc8f2d5ffea92f110a090c64a3624942b5b543aad4592a9de33bb0
{% endblock %}

{% block bld_libs %}
lib/c
lib/z
lib/t1
lib/intl
lib/dbus
lib/glib
lib/xml2
lib/gtk/3
lib/handy
lib/secret
lib/archive
lib/djvulibre
lib/gsettings/desktop/schemas
{% endblock %}

{% block run_data %}
aux/adwaita/icons
{% endblock %}

{% block bld_tool %}
lib/gtk/3
bin/gettext
bin/glib/codegen
{% endblock %}

{% block meson_flags %}
gtk_doc=false
user_doc=false
nautilus=false
introspection=false
{% endblock %}
