include: "order_items.view"
view: order_items_turnover {
  extends: [order_items]


  measure: Min_Turnover {
    type: min
    sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."DELIVERED_AT"::timestamp ) ;;
  }

 measure: Average_Turnover{
   type: average
   sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."DELIVERED_AT"::timestamp ) ;;
 }
  measure: Median_Turnover{
    type: median
    sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."DELIVERED_AT"::timestamp ) ;;
 }
 measure: Max_Turnover{
    type: max
    sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."DELIVERED_AT"::timestamp ) ;;
  }

measure: items_in_order{
  type: average
  sql: count(${TABLE}.ID) ;;
}
}
