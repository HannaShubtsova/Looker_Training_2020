include: "distribution_centers.view"
view: distribution_center_location {
  extends: [distribution_centers]
  dimension: location {
    label: "Distribution center location "
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }


  }
