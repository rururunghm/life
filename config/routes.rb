Rails.application.routes.draw do
  
 
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    
  end

  scope module: :public do
    root to: "homes#top"
    resources :users,only: [:show, :edit, :update] do
      collection do
          patch :withdrow
          get :complete
      end 
    end
    resources :posts,only: [:index, :show, :new, :create, :destroy]
    resources :comments,only: [:create, :destroy]
    resources :favorites,only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
