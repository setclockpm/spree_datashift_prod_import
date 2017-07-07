class Spree::Admin::ProductExportsController < Spree::Admin::BaseController
  DATA_EXPORT_FILENAME = 'inventory'
  DATA_EXPORT_LOCATION = Rails.root.join("db/datashift/exports")
  
  def new
    # system "bundle exec thor datashift:export:csv --model=Spree::Variant --result=#{DATA_EXPORT_LOCATION}"
  #   if $?.exitstatus > 0
  #     flash[:error] = "Unable to generate export, check command line logs for more info."
  #   end
  #   head(:bad_request) and return unless File.exist?(DATA_EXPORT_FILENAME)
  #   send_file DATA_EXPORT_LOCATION, filename: (params[:filename] || DATA_EXPORT_FILENAME), type: "text/csv"
  end

  def generate
    respond_to do |format|
      format.html
      format.csv { call_datashift_export('csv') }
      format.xls { call_datashift_export('xls') }
    end
    
    if $?.exitstatus > 0
      raise "Unable to generate export, check command line logs for more info." if Rails.env == 'development'
      flash[:error] = "Unable to generate export, check command line logs for more info."
    else
      flash[:notice] = "Excel file generated successfully."
    end
    
    redirect_to spree.admin_product_imports_url
   
  end
  
  
  def download_export
    respond_to do |format|
      format.html
      format.csv { send_excel_file(:csv, 'text/csv') }
      format.xls { send_excel_file(:xls, 'application/vnd.ms-excel') }
    end
    
  end
  
  
  private
  
    # Argument is file extension as a string or symbol with out leading '.' period
    def call_datashift_export(frmat)
      result = DATA_EXPORT_LOCATION.join("#{DATA_EXPORT_FILENAME}.#{frmat.to_s}")
      system "bundle exec thor datashift:export:excel --model=Spree::Variant --result=#{result}"
    end
    
    def send_excel_file(frmat, mime_type=nil)
      file_location = DATA_EXPORT_LOCATION.join("#{DATA_EXPORT_FILENAME}.#{frmat.to_s}")
      head(:bad_request) and return unless File.exist?(file_location)
      
      if mime_type.present?
        send_file file_location, filename: (params[:filename] || "#{DATA_EXPORT_FILENAME}.#{frmat.to_s}"), type: mime_type
      else
        send_file file_location
      end
      
    end

end
