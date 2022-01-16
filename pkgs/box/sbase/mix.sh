{% extends '//box/sbase/t/.sh' %}

{% block std_box %}
box/boot
{% endblock %}

{% block make_target %}
sbase-box
{% endblock %}

{% block make_install_target %}
sbase-box-install
{% endblock %}

{% block patch %}
chmod +x getconf.sh
cat util.h | grep -v 'undef realloc' > _ && mv _ util.h
{% endblock %}
