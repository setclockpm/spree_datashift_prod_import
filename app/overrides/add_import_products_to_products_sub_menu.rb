Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'import_products_tab',
  insert_bottom: "#sidebar-product",
  text: %Q{ <%= tab :product_imports, label: 'Imports / Exports' %> },
  original: '5c6807c2920b4280184cbdf867b7ba98e41b576f'
)