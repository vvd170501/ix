{% extends '//die/hub.sh' %}

{% block run_deps %}
bin/nheko/unwrap
org/freedesktop/secrets
{% endblock %}
