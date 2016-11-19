class ArticleController < ApplicationController
  def index
    # 获取所有Article中的数据
    @articles=Article.all
  end

  # 新建页面
  def new

  end
end
