{% extends '//die/c/cmake.sh' %}

{% block fetch %}
https://github.com/martinus/robin-hood-hashing/archive/refs/tags/3.11.3.tar.gz
md5:4690c87ee1d402548cae96e541b41b5e
{% endblock %}

{% block lib_deps %}
lib/c
lib/c++
{% endblock %}

{% block build_flags %}
shut_up
{% endblock %}

{% block cmake_flags %}
RH_STANDALONE_PROJECT=OFF
{% endblock %}
