Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :product_imports, only: [:index] do
      collection do
        get :reset
        get :sample_import
        post :sample_csv_import
        post :user_csv_import
        post :image_import
        get :download_sample_csv
      end
    end
    # post "import/inventory_photos" => "data_import_utilities#inventory_photos",  as: :import_inventory_photos
    
    resources :product_exports, only: [:new] do
      collection do
        get :generate
        get :download_export
      end
    end
  end
end
