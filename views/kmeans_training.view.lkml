# The name of this view in Looker is "Kmeans Training"
view: kmeans_training {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `dl_ecomm.kmeans_training` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Accessories Avg Qty" in Explore.

  dimension: accessories_avg_qty {
    type: number
    sql: ${TABLE}.accessories_avg_qty ;;
  }

  dimension: active_avg_qty {
    type: number
    sql: ${TABLE}.active_avg_qty ;;
  }

  dimension: add_to_cart {
    type: number
    sql: ${TABLE}.add_to_cart ;;
  }

  dimension: avg_quantity_per_order {
    type: number
    sql: ${TABLE}.avg_quantity_per_order ;;
  }

  dimension: avg_unit_price {
    type: number
    sql: ${TABLE}.avg_unit_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_avg_unit_price {
    type: sum
    sql: ${avg_unit_price} ;;  }
  measure: average_avg_unit_price {
    type: average
    sql: ${avg_unit_price} ;;  }

  dimension: blazers_and_jackets_avg_qty {
    type: number
    sql: ${TABLE}.blazers_and_jackets_avg_qty ;;
  }

  dimension: cancel_order {
    type: number
    sql: ${TABLE}.cancel_order ;;
  }

  dimension: clothing_sets_avg_qty {
    type: number
    sql: ${TABLE}.clothing_sets_avg_qty ;;
  }

  dimension: dresses_avg_qty {
    type: number
    sql: ${TABLE}.dresses_avg_qty ;;
  }

  dimension: email {
    type: number
    sql: ${TABLE}.email ;;
  }

  dimension: event_usage {
    type: number
    sql: ${TABLE}.event_usage ;;
  }

  dimension: fashion_hoodie_avg_qty {
    type: number
    sql: ${TABLE}.fashion_hoodie_avg_qty ;;
  }

  dimension: home_visits {
    type: number
    sql: ${TABLE}.home_visits ;;
  }

  dimension: jeans_avg_qty {
    type: number
    sql: ${TABLE}.jeans_avg_qty ;;
  }

  dimension: jumpsuits_and_rompers_avg_qty {
    type: number
    sql: ${TABLE}.jumpsuits_and_rompers_avg_qty ;;
  }

  dimension: leggings_avg_qty {
    type: number
    sql: ${TABLE}.leggings_avg_qty ;;
  }

  dimension: maternity_avg_qty {
    type: number
    sql: ${TABLE}.maternity_avg_qty ;;
  }

  dimension: outerwear_and_coats_avg_qty {
    type: number
    sql: ${TABLE}.outerwear_and_coats_avg_qty ;;
  }

  dimension: pants_and_capris_avg_qty {
    type: number
    sql: ${TABLE}.pants_and_capris_avg_qty ;;
  }

  dimension: pants_avg_qty {
    type: number
    sql: ${TABLE}.pants_avg_qty ;;
  }

  dimension: purchases {
    type: number
    sql: ${TABLE}.purchases ;;
  }

  dimension: shorts_avg_qty {
    type: number
    sql: ${TABLE}.shorts_avg_qty ;;
  }

  dimension: skirts_avg_qty {
    type: number
    sql: ${TABLE}.skirts_avg_qty ;;
  }

  dimension: sleep_and_lounge_avg_qty {
    type: number
    sql: ${TABLE}.sleep_and_lounge_avg_qty ;;
  }

  dimension: sock_avg_qty {
    type: number
    sql: ${TABLE}.sock_avg_qty ;;
  }

  dimension: sweaters_avg_qty {
    type: number
    sql: ${TABLE}.sweaters_avg_qty ;;
  }

  dimension: swim_avg_qty {
    type: number
    sql: ${TABLE}.swim_avg_qty ;;
  }

  dimension: tops_and_tees_avg_qty {
    type: number
    sql: ${TABLE}.tops_and_tees_avg_qty ;;
  }

  dimension: underwear_avg_qty {
    type: number
    sql: ${TABLE}.underwear_avg_qty ;;
  }
  measure: count {
    type: count
  }
}
