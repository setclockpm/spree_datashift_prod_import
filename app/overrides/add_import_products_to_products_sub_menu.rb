Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'import_products_tab',
  insert_bottom: "#sidebar-product",
  text: %Q{ <%= tab :product_imports %> },
  original: '41d2419e728f18bfaf1ccf2ca0935f2c321bdf0c'
)
