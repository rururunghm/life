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
      resource :favorites,only: [:create, :destroy]
      resources :comments,only: [:create, :destroy]
      collection do
          get   :others_post
      end 
    end
    resources :favorites,only: [:create, :destroy]
  end
  
  get "/user/search" => "user/searches#search"
  get "/user/information/edit" => "user/users#edit"
  get "/user/mypage" => "user/uesrs#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
