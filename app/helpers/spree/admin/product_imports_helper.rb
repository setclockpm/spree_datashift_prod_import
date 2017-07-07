module Spree
  module Admin
    module ProductImportsHelper
      
      DATA_EXPORT_FILENAME = 'inventory'
      DATA_EXPORT_DIRECTORY = Rails.root.join("db/datashift/exports")
  
      
      def spreadsheet_mime_types
        'text/csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.dataml.sheet'
      end
            
      def link_to_clear_product_data_with_icon
        return content_tag :div, "No Products to Clear", class: "alert alert-info no-objects-found" unless Spree::Product.count > 0
        link_to_with_icon 'trash', "Clear All Product Data", reset_admin_product_imports_path, class: "btn btn-default btn-danger"
      end
      
      
      
      def button_link_to_download_export(frmat)
        filename = "#{DATA_EXPORT_FILENAME}.#{frmat.to_s}"
        data_export_location = DATA_EXPORT_DIRECTORY.join(filename)
        if File.exist?(data_export_location)
          link_to_with_icon('download', "Download #{frmat.to_s.upcase}", download_export_admin_product_exports_path(frmat.to_s), class: "btn btn-default btn-primary")
          .concat(tag(:br)).concat(tag(:br))
        else
          button_link_to_generate_export(frmat.to_s)
        end
      end
      
      def link_to_generate_export(frmat)
        filename = "#{DATA_EXPORT_FILENAME}.#{frmat.to_s}"
        data_export_location = DATA_EXPORT_DIRECTORY.join(filename)
        return unless File.exist?(data_export_location)
        
        link_to "#{Spree.t(:generate)} #{frmat.to_s.upcase} New Data #{Spree.t(:export)} ", 
                spree.generate_admin_product_exports_url(format: frmat), 
                class: 'secondary-option', data: { action: 'export' }, id: "new-#{frmat.to_s}-export-link"
      end
      
      
      private
        def button_link_to_generate_export(frmat)
          button_link_to "Generate #{frmat.to_s.upcase} #{Spree.t(:file)}", 
                       spree.generate_admin_product_exports_url(format: frmat), 
                       class: 'btn-primary', 
                       data: { action: 'export' },
                       icon: 'export',
                       id: "new-#{frmat.to_s}-export-link"
      end
        
      
    end
  end
end