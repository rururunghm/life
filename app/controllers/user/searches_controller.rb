class User::SearchesController < ApplicationController
  before_action :authenticate_user!
 
  def search
  	#TODO: paramsでmodel,contentをうけとる
    @model = params[:model]
    #TODO: ||= '' nilガード
    #TODO: params[:content]がなかったら、''をいれる
		@content = params[:content] #||= ''
		#TODO: コンテンツが空っだたら
		if params[:content].blank?
		#TODO: メッセージを表示する
			@message = "検索にはキーワードをいれてください"
		#TODO:　returnは処理ここで終了する
			return
		end
		#TODO: modelがuserだったら
		if @model == 'user'
		#TODO: userのmodelはとぶ
			@users = User.search_for(@content)
		else
			@posts = Post.search_for(@content)
		end
  end
end
