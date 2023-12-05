# The name of this view in Looker is "Ad Groups"
view: ad_groups {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `dl_ecomm.ad_groups` ;;
  drill_fields: [ad_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: ad_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ad_id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Ad Type" in Explore.

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: campaign_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
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

  dimension: headline {
    type: string
    sql: ${TABLE}.headline ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_period {
    type: sum
    sql: ${period} ;;  }
  measure: average_period {
    type: average
    sql: ${period} ;;  }
  measure: count {
    type: count
    drill_fields: [ad_id, name, campaigns.campaign_name, campaigns.id]
  }
}
