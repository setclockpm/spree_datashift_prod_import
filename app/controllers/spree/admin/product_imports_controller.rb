class Spree::Admin::ProductImportsController < Spree::Admin::BaseController
  SAMPLE_CSV_FILE = Rails.root.join("db/datashift/templates", "SpreeMultiVariant.csv")
  DATA_EXPORT_FILENAME = 'inventory'
  DATA_EXPORT_LOCATION = Rails.root.join("db/datashift/exports", DATA_EXPORT_FILENAME)
  
  def index
    # @data_export_file = DATA_EXPORT_LOCATION
    render
  end


  def reset
    if Rails.env.production?
      redirect_to admin_product_imports_path, flash: { notice: "Not authorized to perform this action." }
    end
      
    truncated_list = ['spree_products_taxons', 'spree_option_value_variants',
                      'spree_product_promotion_rules', 'spree_product_option_types']
    result_log = []
    truncated_list.inject(result_log) do |r,t|
      c = "TRUNCATE #{t}"
      ActiveRecord::Base.connection.execute(c)
      r.push("Command executed #{c}")
    end

    model_list = %w{ Image OptionType OptionValue Product Property ProductProperty ProductOptionType
     Variant StockMovement StockItem StockTransfer Taxonomy Taxon ShippingCategory TaxCategory
    }
    model_list.inject(result_log) do |r,m|
      klass = DataShift::SpreeEcom.get_spree_class(m)
      s = "Clearing model #{klass}"
      if(klass)
        begin
          klass.delete_all
        rescue => e
          s += "generated error #{e}"
        end
      else
        s = "#{m} not found or respective Model"
      end
      r.push(s)
    end

    delete_other_than_defaults = %w{ StockLocation }
    delete_other_than_defaults.inject(result_log) do |r,m|
      klass = DataShift::SpreeEcom.get_spree_class(m)
      s = "Clearing Other than Defaults #{klass}"
      if(klass)
        begin
          klass.where.not(default: true).delete_all
        rescue => e
          s += "generated error #{e}"
        end
      else
        s = "#{m} not found or respective Model"
      end
      r.push(s)
    end

    redirect_to admin_product_imports_path, flash: { notice: result_log.join("---,---") }
  end

  def sample_import
    if(File.exists? SAMPLE_CSV_FILE)
      @csv_table = CSV.open(SAMPLE_CSV_FILE, headers: true).read
      render
    else
      redirect_to admin_product_imports_path, flash: { error: "Sample Missing" }
    end
  end

  def download_sample_csv
    send_file SAMPLE_CSV_FILE
  end

  def sample_csv_import
    opts = {}
    opts[:mandatory] = ['sku', 'name', 'price']
    loader = DataShift::SpreeEcom::ProductLoader.new( nil, { verbose: true })
    loader.perform_load(SAMPLE_CSV_FILE, opts)
    redirect_to admin_product_imports_path, flash: { notice: "Check Sample Imported Data" }
  end
  
  def image_import
    generator = ImageGenerator.new
    if generator.process
      flash[:success] = "Image generation process complete!"
      redirect_to admin_data_import_utilities_path
    else
      render 'products/data'
      flash[:error] = "There was a problem importing your images."
    end
  end
  

end
