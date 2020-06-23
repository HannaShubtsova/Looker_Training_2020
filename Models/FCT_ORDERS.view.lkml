view: fct_orders {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

   measure: order_count {
    view_label: "Orders"
    type: count_distinct
#    drill_fields: [detail*]
    sql: ${order_id} ;;
  }


  measure: count_last_28d {
    label: "Count Sold in Trailing 28 Days"
    type: count_distinct
    sql: ${id} ;;
    hidden: yes
    filters:
    {field:created_date
      value: "28 days"
    }}

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;

  }

  dimension_group: created {
      #X# group_label:"Order Date"
      type: time
      timeframes: [time, hour, date, week, month, year, hour_of_day, day_of_week, month_num, raw, week_of_year]
      sql: ${TABLE}.created_at ;;
    }
}
