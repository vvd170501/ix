{% extends '//die/hub.sh' %}

{% block run_deps %}
bin/fixtty
bin/runsrv
bin/mingetty
bin/mingetty/runit/scripts(slot={{vt_slot}})
{% endblock %}
