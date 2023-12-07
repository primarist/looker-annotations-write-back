view: annotations {
  sql_table_name: `looker-hackathon-annotations.looker_hackathon23_annotations.annotations` ;;

  dimension: notes_join_key {
    type: number
    sql: 1 ;;
  }

  dimension: annotation_id {
    type: string
    sql: ${TABLE}.annotation_id ;;
  }

  dimension: dashboard_id {
    type: string
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
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
    timeframes: [raw, time, date, week, month, quarter, year]
    convert_tz: no
    datatype: datetime
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
      url: "{{ '' | append: annotations.url._value | append: annotations.dashboard_id._value | append: annotations.filters._value }}"
    }
    link: {
      label: "Explore annotation context"
      url: "{{ annotations.url._value | append: '/explore/' | append: annotations.explore._value | append: '/' }}"
    }
    link: {
      label: "adv link test"
      url:
      "@{generate_link_variable_defaults}
      {% assign link = '' | append: annotations.url._value | append: '?' | append: annotations.filters._value %}
      {% assign drill_fields = '' %}
      {% assign filters_mapping = '\"products.category\"|Category,\"order_items.created_date\"|Created Date' %}
      {% assign target_dashboard = '' | append: annotations.dashboard_id._value %}
      {% assign default_filters_override = true %}
      @{generate_dashboard_link}"
    }
  }

  measure: inspect {
    type: number
    sql: 1 ;;
    html:
    {% comment %} INIT {% endcomment %}
    {% assign content = '/dashboards-next/' %}
    {% assign link = '' | append: annotations.url._value | append: '?' | append: annotations.filters._value %}
    {% assign link_clean = link | replace: '","', '|' | replace: '{', '' | replace: '}', '' %}
    {% assign link_query = link_clean | split: '?' | last %}
    {% assign link_query_parameters = link_query | split: '|' %}
    {% assign target_content_filters = '' %}
    {% assign host = '' %}
    {% assign target_dashboard = '89' %}
    {% assign default_filters_override = true %}



    {{ link_clean  }}
    ;;
  }

  # {{ host | append:content | append:target_dashboard | append: '?' | append: target_content_filters }}

  measure: link_generator {
    # hidden: yes
    type: number
    sql: 1 ;;
    html: {{link}} ;;
    drill_fields: [link_generator]
  }
}
