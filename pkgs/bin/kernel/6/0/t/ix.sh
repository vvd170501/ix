{% extends '//bin/kernel/19/t/ix.sh' %}

{% block kernel_version %}6-0-10{% endblock %}

{% block fetch %}
{% include 'ver.sh' %}
{% endblock %}

{% block kernel_headers %}
bin/kernel/6/0/headers
{% endblock %}
