module Spree
  module Admin
    module ProductImportsHelper
      
      def spreadsheet_mime_types
        'text/csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.dataml.sheet'
      end
            
      def link_to_clear_product_data_with_icon
        return content_tag :div, "No Products to Clear", class: "alert alert-info no-objects-found" unless Spree::Product.count > 0
        link_to_with_icon 'delete', "Clear All Product Data", reset_admin_product_imports_path, class: "btn btn-default btn-danger"
      end
      
    end
  end
end