class ArticlesController < ApplicationController
	before_action :set_article, only: [:destroy, :edit, :update]

	def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
  end

  def new
    @article = Article.new
		flash.notice = "Article '#{@article.title}' Created!"
  end

	def create
		@article = Article.new(article_params)
  	@article.save
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' Deletedd!"

		redirect_to '/articles'
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end

	private

	def article_params
		params.require(:article).permit(:title, :body, :tag_list)
	end

	def set_article
		@article = Article.find(params[:id])
	end
end
