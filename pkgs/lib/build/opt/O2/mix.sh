{% extends '//mix/py.py' %}

{% block env %}
export OPTFLAGS="-O2 ${OPTFLAGS}"
{% endblock %}
