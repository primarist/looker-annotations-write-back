view: annotations {
  sql_table_name: `looker-hackathon-annotations.looker_hackathon23_annotations.annotations` ;;

  dimension: annotation_id {
    type: string
    sql: ${TABLE}.annotation_id ;;
  }

  dimension: dashboard_id {
    type: string
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: explore {
    type: string
    sql: ${TABLE}.explore ;;
  }

  dimension: filters {
    type: string
    sql: ${TABLE}.filters ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  measure: load_source {
    type: sum
    sql:
      (CASE WHEN (${dashboard_id} IS NOT NULL OR ${explore} IS NOT NULL) THEN 1 ELSE 0 END +
      CASE WHEN ${filters} IS NOT NULL THEN 1 ELSE 0 END +
      CASE WHEN ${url} IS NOT NULL THEN 1 ELSE 0 END)
    ;;
    html:
      {% if value == 3 %}
      <div title="Right click to analyze...">
      <img align=left height=20 width=20 src="https://raw.githubusercontent.com/primarist/looker-annotations-write-back/main/project_files/resources/plus-box-multiple.png" />
      </div>
      {% else %}
      <div></div>
      {% endif %}
    ;;
    link: {
      label: "Load annotation source"
      url: "{{ '' | append: annotations.url._value | append: '/' | append: annotations.dashboard_id._value | append: '?' | append: annotations.filters._value }}"
    }
    link: {
      label: "Explore annotation context"
      url: "{{ annotations.url._value | append: '/explore/' | append: annotations.explore._value | append: '/' }}"
    }
    link: {
      label: "adv link test"
      url:
      "@{generate_link_variable_defaults}
        {% assign link = '' | append: annotations.url._value | append: '/' | append: annotations.dashboard_id._value | append: '?' | append: annotations.filters._value %}
        {% assign filters_mapping = @{filter_mapping} %}
        {% assign drill_fields = '' %}
        {% assign different_explore = true %}
        {% assign target_model = 'ecommerce' %}
        {% assign target_explore = '' | append: annotations.explore._value %}
        @{generate_explore_link}"
    }
  }
}
