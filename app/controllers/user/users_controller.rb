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
    @user = current_customer
  end
  
  def withdrow
    @user = current_user
    @user.update(is_deleted: true)
    flash[:notice] = "本当に削除してもよろしいですか？"
    reset_session
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :name, :telephone_number, :is_deleted)  
  end
  
  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_mypage_path(current_user)
    end
  end
  
  
end
