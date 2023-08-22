class User::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    redirect_to  user_mypage_path
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
   
  def user_params
    params.require(:user).permit(:email, :name, :telephone_number, :is_deleted)  
  end
  
end
