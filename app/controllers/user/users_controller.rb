class User::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
  end

  def edit
  end
  
  def update
  end

  def complete
  end
  
  def withdrow
  end
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
   
  def post_params
    params.require(:post).permit(:email, :name, :telephone_number, :is_deleted)  
  end
  
end
