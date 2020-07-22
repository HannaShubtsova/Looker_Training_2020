- dashboard: test
  title: Orders delivery pulse over time
  description: This is placeholder for dashboard description
  layout: newspaper
  #tile_size: 100
  refresh: 1 hour
  #autorun: true




  filters:
  - name: Category
    title: "Product Category"
    type: field_filter
    model: Model2
    explore: fact_orders
    field: products.category
    default_value: Looker filter expression
    allow_multiple_values: true
    required: true


  elements:
    - name: hello_world
      type: looker_column
      explore: fact_orders
