class User::SearchesController < ApplicationController
  before_action :authenticate_user!
 
  def search
    @model = params[:model]
		@content = params[:content] ||= ''
		@method = params[:method]
		
		if params[:content].blank?
			@model = nil
			@message = "検索にはキーワードをいれてください"
			return
		end
		
		if @model == 'user'
			@users = User.search_for(@content, @method)
		else
			@posts = Post.search_for(@content, @method)
		end
  end
end
