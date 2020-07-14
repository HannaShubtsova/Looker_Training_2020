include: "order_items.view"
view: order_items_turnover {
  extends: [order_items]


  dimension: turnover_created_delivered_days {
    type: number
    sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."DELIVERED_AT"::timestamp ) ;;
  }

 dimension: turnover_returned_created_days{
   type: number
   sql: DATEDIFF(day,${TABLE}."CREATED_AT"::timestamp , ${TABLE}."RETURNED_AT"::timestamp ) ;;

 }

}
