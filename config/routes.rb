Rails.application.routes.draw do

  root to: "homes#top"

  devise_for :admin, skip:[:registrations,:passwords],controllers:{
    sessions: "admin/sessions"
  }
  devise_for :end_users, controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    resources :end_users, only:[:index, :show, :edit, :update]
    resources :categories, only:[:index, :create, :edit, :update, :destroy]
    resources :post_images, only:[:index, :show, :edit, :destroy] do
      collection do
        get :search, to: "post_images#search"
      end
    end
  end

  namespace :public do
    get :"end_users/unsubscribe", to: "end_users#unsubscribe"
    patch :"end_users/withdraw", to: "end_users#withdraw"

    resources :post_images do
      collection do
        get :search, to: "post_images#search"
      end
    end
    resources :end_users
  end

end
