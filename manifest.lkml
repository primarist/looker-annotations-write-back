project_name: "annotations_write_back"

### LINK GENERATION ###
constant: host {
  value: "{% assign host = '' %}" # Passing blank value for relative URL ref (no hardcoded hostname)
}

constant: generate_link_variable_defaults {
  value: "
  {% comment %} Variables to default if not created {% endcomment %}

  {% comment %} User Customizable Parameters {% endcomment %}
  {% assign drill_fields = '' %}
  {% assign pivots = '' %}
  {% assign subtotals = '' %}
  {% assign sorts = '' %}
  {% assign limit = '500' %}
  {% assign column_limit = '50' %}
  {% assign total = '' %}
  {% assign row_total = '' %}
  {% assign query_timezone = '' %}
  {% assign dynamic_fields = '' %}

  {% comment %} Default Visualizations Parameters {% endcomment %}
  @{table}

  {% comment %} Default Behavior Parameters {% endcomment %}
  {% assign default_filters_override = false %}
  {% assign default_filters = '' %}
  {% assign new_page = false %}
  {% assign different_explore = false %}
  {% assign target_model = '' %}
  {% assign target_explore = '' %}

  {% comment %} Variables to be built in code below {% endcomment %}
  {% assign filters_mapping = '' %}
  {% assign target_content_filters = '' %}
  {% assign target_default_content_filters = '' %}
  {% assign host = '' %}
  "
}

constant: extract_link_context {
  value: "
  {% assign filters_array = '' %}
  {% for parameter in link_query_parameters %}
  {% assign parameter_key = parameter | split:'=' | first %}
  {% assign parameter_value = parameter | split:'=' | last %}
  {% assign parameter_test = parameter_key | slice: 0,2 %}
  {% if parameter_test == 'f[' %} {% comment %} Link contains multiple parameters, need to test if filter {% endcomment %}
  {% if parameter_key != parameter_value %} {% comment %} Tests if the filter value is is filled in, if not it skips  {% endcomment %}
  {% assign parameter_key_size = parameter_key | size %}
  {% assign slice_start = 2 %}
  {% assign slice_end = parameter_key_size | minus: slice_start | minus: 1 %}
  {% assign parameter_key = parameter_key | slice: slice_start, slice_end %}
  {% assign parameter_clean = parameter_key | append:'|' |append: parameter_value %}
  {% assign filters_array =  filters_array | append: parameter_clean | append: ',' %}
  {% endif %}
  {% elsif parameter_key == 'dynamic_fields' %}
  {% assign dynamic_fields = parameter_value %}
  {% elsif parameter_key == 'query_timezone' %}
  {% assign query_timezone = parameter_value %}
  {% endif %}
  {% endfor %}
  {% assign size = filters_array | size | minus: 1 %}
  {% if size > 0 %}
  {% assign filters_array = filters_array | slice: 0, size %}
  {% endif %}
  "
}

constant: match_filters_to_destination {
  value: "
  {% assign filters_mapping = filters_mapping | split: ',' %}
  {% assign filters_array = filters_array | split: ',' %}
  {% assign filters_array_destination = '' %}

  {% for source_filter in filters_array %}
  {% assign source_filter_key = source_filter | split:'|' | first %}
  {% assign source_filter_value = source_filter | split:'|' | last %}

  {% for destination_filter in filters_mapping %} {% comment %} This will loop through the value pairs to determine if there is a match to the destination {% endcomment %}
  {% assign destination_filter_key = destination_filter | split:'|' | first %}
  {% assign destination_filter_value = destination_filter | split:'|' | last %}
  {% if source_filter_key == destination_filter_key %}
  {% assign parameter_clean = destination_filter_value | append:'|' | append: source_filter_value %}
  {% assign filters_array_destination =  filters_array_destination | append: parameter_clean | append:',' %}
  {% endif %}
  {% endfor %}
  {% endfor %}
  {% assign size = filters_array_destination | size | minus: 1 %}
  {% if size > 0 %}
  {% assign filters_array_destination = filters_array_destination | slice: 0, size %}
  {% endif %}
  "
}

constant: build_filter_string {
  value: "
  {% assign filter_string = '' %}
  {% assign filters_array_destination = filters_array_destination | split: ',' %}
  {% for filter in filters_array_destination %}
  {% if filter != blank %}
  {% assign filter_key = filter | split:'|' | first %}
  {% assign filter_value = filter | split:'|' | last %}
  {% if content == '/explore/' %}
  {% assign filter_compile = 'f[' | append: filter_key | append:']=' | append: filter_value %}
  {% else %}
  {% assign filter_value = filter_value | encode_url %}
  {% assign filter_compile = filter_key | append:'=' | append: filter_value %}
  {% endif %}
  {% assign filter_string = filter_string | append: filter_compile | append:'&' %}
  {% endif %}
  {% endfor %}
  {% assign size = filter_string | size | minus: 1 %}
  {% if size > 0 %}
  {% assign filter_string = filter_string | slice: 0, size %}
  {% else %}
  {% assign filter_string = '' %}
  {% endif %}
  "
}

constant: build_default_filter_string {
  value: "
  {% assign default_filter_string = '' %}
  {% assign default_filters = default_filters | split: ',' %}
  {% for filter in default_filters %}
  {% assign filter_key = filter | split:'=' | first %}
  {% assign filter_value = filter | split:'=' | last %}
  {% if content == '/explore/' %}
  {% assign filter_compile = 'f[' | append: filter_key | append:']=' | append: filter_value %}
  {% else %}
  {% assign filter_value = filter_value | encode_url %}
  {% assign filter_compile = filter_key | append:'=' | append: filter_value %}
  {% endif %}
  {% assign default_filter_string = default_filter_string | append: filter_compile | append:'&' %}
  {% endfor %}
  {% assign size = default_filter_string | size | minus: 1 %}
  {% if size > 0 %}
  {% assign default_filter_string = default_filter_string | slice: 0, size %}
  {% endif %}
  "
}

constant: generate_dashboard_link {
  value: "
  {% assign content = '/dashboards-next/' %}
  {% assign link_query = link | split: '?' | last %}
  {% assign link_query_parameters = link_query | split: '&' %}
  {% assign target_content_filters = '' %}
  {% assign host = '' %}

  {% if new_page %}
  @{host}
  {% endif %}

  @{extract_link_context}
  @{match_filters_to_destination}
  @{build_filter_string}

  {% if default_filters != '' %}
  @{build_default_filter_string}
  {% endif %}

  {% if default_filters_override == true and default_filters != '' %}
  {% assign target_content_filters = default_filter_string | append:'&' | append: filter_string %}
  {% elsif default_filters_override == false and default_filters != '' %}
  {% else %}
  {% assign target_content_filters = filter_string %}
  {% endif %}

  {% comment %} Builds final link to be presented in frontend {% endcomment %}
  {{ host | append:content | append:target_dashboard | append: '?' | append: target_content_filters }}
  "
}
### END LINK GENERATION ###

### LINK CONSTANTS ###
constant: filter_mapping {
  value:
  "'view_name.field_name|Filter Name,'"
}

constant: dashboard_link {
  value:
  "@{generate_link_variable_defaults}
  {% assign link = link_generator._link %}
  {% assign filters_mapping = @{filter_mapping} %}
  {% assign target_dashboard = 'annotations_write_back::' | append:  _user_attributes['access_level'] | append: '_summary' %}
  {% assign default_filters_override = true %}
  @{generate_dashboard_link}"
}

constant: table {
  value: "{% assign vis_config = '{\"type\":\"looker_grid\"}' | url_encode | prepend: '&vis_config=' %}"
}