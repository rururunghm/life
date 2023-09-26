class User::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    # マイページ
    @user = current_user
  end

  def edit
    # マイページ編集画面
    unless @user == current_user
     redirect_to  user_mypage_path(@user)
    end
  end
  
  def update
    # 編集更新
    @user = current_user
    if current_user.update(user_params)
      flash[:notice] = "「 更新しました 」"
      redirect_to user_mypage_path(@user)
    else
      flash[:notice] = "「 更新できませんでした 」"
      redirect_to user_information_edit_path(@user)
    end
  end

  def complete
    # アカウント削除画面
    @user = current_user
  end
  
  def withdrow
    # アカウント削除実行
    @user = current_user
    @user.update(is_deleted: true)
    flash[:notice] = "本当に削除してもよろしいですか？"
    reset_session
    redirect_to root_path
  end
  
   private
  
  def user_params
    params.require(:user).permit(:email, :name, :telephone_number, :is_deleted, :image)  
  end
  
  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to  user_mypage_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_mypage_path(current_user)
    end
  end
  
  
end
