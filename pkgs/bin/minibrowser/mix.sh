{% extends '//bin/webkitproc/mix.sh' %}

{% block bld_tool %}
bin/pkg-config
{{super()}}
{% endblock %}

{% block cmake_flags %}
{{super()}}
ENABLE_MINIBROWSER=ON
{% endblock %}
