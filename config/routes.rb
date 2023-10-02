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
    resources :comments,only: [:index, :destroy] 
    resources :posts,only: [:index, :destroy] 
    resources :users,only: [:index]
  end

  scope module: :user do
    root to: "homes#top"
    resources :users,only: [:show, :edit, :update] do
      collection do
          patch :withdrow
          get   :complete
      end 
    end
    resources :posts,only: [:index, :show, :new, :create, :destroy] do
      resources :comments,only: [:create, :destroy], shallow: true do 
        collection do
          get :favorite
        end
         resources :comment_favorites,only: [:create, :destroy] 
      end
      collection do
          get :favorite
          get :my_post
          get "other_user/:id", to: "posts#other_user", as: :other_user
      end
      resource :favorites,only: [:create, :destroy]
    end
    resources :favorites,only: [:create, :destroy]
  end
  
  get "/user/search" => "user/searches#search"
  get "/user/information/edit" => "user/users#edit"
  get "/user/mypage" => "user/users#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
