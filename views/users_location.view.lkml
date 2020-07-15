include: "users.view"
  view: users_location {
    extends: [users]
    dimension: location {
      label: "Destination location "
      type: location
      sql_latitude: ${TABLE}.latitude ;;
      sql_longitude: ${TABLE}.longitude ;;
    }


  }
