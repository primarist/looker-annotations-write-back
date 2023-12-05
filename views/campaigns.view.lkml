# The name of this view in Looker is "Campaigns"
view: campaigns {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `dl_ecomm.campaigns` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Advertising Channel" in Explore.

  dimension: advertising_channel {
    type: string
    sql: ${TABLE}.advertising_channel ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_amount {
    type: sum
    sql: ${amount} ;;  }
  measure: average_amount {
    type: average
    sql: ${amount} ;;  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }
  measure: count {
    type: count
    drill_fields: [id, campaign_name, ad_groups.count]
  }
}
