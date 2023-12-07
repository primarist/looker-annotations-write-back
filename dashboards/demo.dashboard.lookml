- dashboard: dashnotes_demo
  title: DashNotes Demo
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: IOjugS3Qucb4SW0uLy6flA
  elements:
  - title: Total Sales per Week, by Department
    name: Total Sales per Week, by Department
    model: ecommerce
    explore: ecommerce_orders
    type: looker_line
    fields: [products.department, order_items.delivered_week, order_items.total_sale_price]
    pivots: [products.department]
    fill_fields: [order_items.delivered_week]
    filters:
      order_items.delivered_date: NOT NULL
    sorts: [products.department, order_items.delivered_week desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Department: products.department
      Category: products.category
      Created Date: order_items.created_date
    row: 14
    col: 12
    width: 12
    height: 6
  - title: Annotations Server Log
    name: Annotations Server Log
    model: ecommerce
    explore: annotations
    type: looker_grid
    fields: [annotations.annotation_id, annotations.created_time, annotations.filters,
      annotations.content]
    filters:
      annotations.dashboard_id: '89'
    sorts: [annotations.created_time desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_column_names: false
    defaults_version: 1
    hidden_pivots: {}
    listen: {}
    row: 13
    col: 0
    width: 12
    height: 7
  - title: Annotations Input
    name: Annotations Input
    model: ecommerce
    explore: ecommerce_orders
    type: annotations_write_back::viz1
    fields: [order_items.notes_join_key]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    defaults_version: 0
    listen:
      Department: products.department
      Category: products.category
      Created Date: order_items.created_date
    row: 6
    col: 0
    width: 12
    height: 7
  - title: Distribution Center Inventory
    name: Distribution Center Inventory
    model: ecommerce
    explore: ecommerce_orders
    type: looker_google_map
    fields: [distribution_centers.location, inventory_items.count, distribution_centers.name]
    sorts: [distribution_centers.location]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    map_plot_mode: heatmap
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 0
    hidden_pivots: {}
    listen:
      Department: products.department
      Category: products.category
      Created Date: order_items.created_date
    row: 0
    col: 12
    width: 12
    height: 8
  - title: Top 10 Brands by Total Sales
    name: Top 10 Brands by Total Sales
    model: ecommerce
    explore: ecommerce_orders
    type: looker_grid
    fields: [products.category, products.brand, order_items.total_sale_price]
    sorts: [order_items.total_sale_price desc]
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Department: products.department
      Category: products.category
      Created Date: order_items.created_date
    row: 8
    col: 12
    width: 12
    height: 6
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"DashNotes","bold":true},{"text":"
      is a custom visual that utilizes the Looker API and custom backend to create
      persistent, context-aware dashboard annotations."}]},{"type":"h3","children":[{"text":""}],"id":1701962332807},{"type":"h3","id":1701962332236,"children":[{"text":"On
      the left is the annotations visual itself, as well as a table that is monitoring
      the backend. To the right are some visuals based on a simple eCommerce model."}]},{"type":"h3","children":[{"text":""}],"id":1701962510278},{"type":"h3","id":1701962409944,"children":[{"text":"As
      you change filtering and dashboard contexts, the notes change as well! For instance,
      a note taken with the ‘Department’ filter equal to ‘Women’ will persist with
      that specific filter context. Changing between filtering contexts will automatically
      change the notes that are available to the user. Notes can also be edited by
      interacting with previously posted notes."}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 12
    height: 6
  filters:
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 2021/12/05 to 2022/12/06
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: ecommerce
    explore: ecommerce_orders
    listens_to_filters: []
    field: order_items.created_date
  - name: Department
    title: Department
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    model: ecommerce
    explore: ecommerce_orders
    listens_to_filters: [Category, Created Date]
    field: products.department
  - name: Category
    title: Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ecommerce
    explore: ecommerce_orders
    listens_to_filters: [Department, Created Date]
    field: products.category
