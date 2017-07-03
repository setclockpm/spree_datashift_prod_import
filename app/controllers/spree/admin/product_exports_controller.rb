class Spree::Admin::ProductExportsController < Spree::Admin::BaseController
  CSV_FILE_NAME     = 'inventory.csv'
  CSV_FILE_LOCATION = Rails.root.join("db/datashift/exports", CSV_FILE_NAME)
  
  
  def new
    render
  end

  def download_sample_csv
    system "bundle exec thor datashift:export:csv --model=Spree::Variant --result=inventory.csv"
    if $?.exitstatus > 0
      flash[:error] = "Unable to generate export, check command line logs for more info."
    end
    head(:bad_request) and return unless File.exist?(CSV_FILE_NAME)
    send_file CSV_FILE_LOCATION, filename: (params[:filename] || CSV_FILE_NAME), type: "text/csv,"
  end

end
