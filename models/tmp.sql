{% do log('test', info=true) %}
select '{{ var("event_type", "abc") }}' as my_col