{% extends '//bin/cmake/t/mix.sh' %}

{% block bld_libs %}
lib/curses
{{super()}}
{% endblock %}
