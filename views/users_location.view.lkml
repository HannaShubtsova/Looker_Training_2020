include: "users.view"
  view: users_location {
    extends: [users]
    dimension: location {
      label: "Destination location "
      type: location
      sql_latitude: users.latitude ;;
      sql_longitude: users.longitude ;;
    }


  }
