{% extends '//die/hub.sh' %}

{% block run_deps %}
bin/mpv
bin/celluloid/unwrap(gtk_ver=4)
bin/xdg/er(wrap=celluloid)
{% endblock %}
