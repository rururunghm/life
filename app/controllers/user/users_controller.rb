class User::UsersController < ApplicationController
  
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
   
  def post_params
    params.require(:post).permit(:email, :name, :telephone_number, :is_deleted)  
  end
  
end
