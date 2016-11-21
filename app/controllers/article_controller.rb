class ArticleController < ApplicationController
  layout 'layout_test'
  def index
    # 获取所有Article中的数据
    @articles=Article.all
  end

  # 新建页面
  def new
    @article=Article.new
  end

  def show
    @article=Article.find params[:id]
  end

  def create
    article=Article.new params.require(:article).permit(:title, :content)
    article.save
    redirect_to article_index_path
  #   另一中写法
  #   Article.create params[:article]
  end

  def edit
    @article=Article.where("id=#{params[:id]}").first
  end

  def update
    article=Article.find params[:id]
    article.update(params.require(:article).permit(:title, :content))
    redirect_to article_path
  end

  def destroy
    article=Article.find params[:id]
    article.delete()
    redirect_to article_index_path
  end
end
