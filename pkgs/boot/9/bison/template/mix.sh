{% extends '//dev/lang/bison/template.sh' %}

{% block lib_deps %}
boot/9/m4/mix.sh
{% endblock %}

{% block bld_deps %}
boot/9/flex/2.6.4.1.sh
boot/8/env/std/mix.sh
{% block bison %}
{% endblock %}
{% endblock %}

{% block toolconf %}
for x in perl makeinfo; do
    echo > ${x}
    chmod +x ${x}
done

cat << EOF > help2man
#!$(command -v dash)

touch doc/bison.1.tmp
EOF

chmod +x help2man
{% endblock %}

{% block build %}
make
{% endblock %}
