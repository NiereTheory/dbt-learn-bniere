{% macro say_hi(name='Ben') %}
  {% set sql %}
      'What is good, {{ name }}'
  {% endset %}
    
  {{ sql }}
{% endmacro %}