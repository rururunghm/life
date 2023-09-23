Rails.application.routes.draw do
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end
 
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: "users#index"
    resources :users,only: [:index] do
      collection do
          get :user_post
          get :user_comment
      end 
    end
  end

  scope module: :user do
    root to: "homes#top"
    resources :users,only: [:index, :show, :edit, :update] do
      collection do
          patch :withdrow
          get   :complete
          get  :other_user
      end 
    end
    resources :posts,only: [:index, :show, :new, :create, :destroy] do
      collection do
          get :favorite
          get :my_post
      end
      resource :favorites,only: [:create, :destroy]
      resources :comments,only: [:create, :destroy], shallow: true do 
        collection do
          get :favorite
        end
         resources :comment_favorites,only: [:create, :destroy] 
      end
      

    end
    resources :favorites,only: [:create, :destroy]
  end
  
  get "/user/search" => "user/searches#search"
  get "/user/information/edit" => "user/users#edit"
  get "/user/mypage" => "user/users#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
