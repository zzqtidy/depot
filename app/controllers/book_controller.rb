class BookController < ApplicationController
  def index
    @books=Book.all
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @book = Book.where("id = #{params[:id]}").first
    # @book = Book.where("id =  ? ", params[:id]).first
    # @book = Book.find params[:id]
  end

  def new
  end

  def create
    Book.create :name => params[:name], :title=>params[:title], :author=>params[:author]
    redirect_to book_index_path
  end

  def edit
    # 以下三种写法都可以。 一般用find
    # @book = Book.where("id = #{params[:id]}").first
    # @book = Book.where("id =  ? ", params[:id]).first
    @book = Book.find params[:id]
  end

  def update
    book=Book.find(params[:id])
    book.title=params[:title]
    book.name=params[:name]
    book.author=params[:author]
    book.save
    redirect_to book_index_path
  end

def destroy
  @book = Book.where("id=#{params[:id]}").first
  @book.delete
  redirect_to root_path
end

end
