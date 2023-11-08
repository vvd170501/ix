{% extends '//die/python/bin.sh' %}

{% block bld_libs %}
pip/pyxdg
lib/python
lib/glib/dl
lib/pango/dl
pip/dbus-next
lib/drivers/3d
lib/gdk/pixbuf/dl
bin/qtile/module/register
{% endblock %}

{% block extra_modules %}
zipfile
{% endblock %}

{% block build_flags %}
{% endblock %}

{% block entry_point %}qtile{% endblock %}

{% block step_unpack %}
cat << EOF > qtile
import sys
sys.dont_write_bytecode = True
import libqtile.scripts.main as lm
lm.main()
EOF
{% endblock %}
