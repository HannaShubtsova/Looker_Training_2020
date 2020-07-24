- dashboard: test
  title: Orders delivery pulse over time
  description: This is placeholder for dashboard description
  layout: newspaper
  #tile_size: 100
  refresh: 1 hour
  #autorun: true




  filters:
  - name: category
    title: "Product Category"
    type: field_filter
    model: Model2
    explore: fact_orders
    field: products.category
    default_value: Looker filter expression
    allow_multiple_values: true
    required: true


  elements:
     - name: last_period_sales
       type: single_value
       #note: 'text note placeholder'
       model: Model2
       explore: fact_orders
       field: products.category
       listen:
        category: products.category
