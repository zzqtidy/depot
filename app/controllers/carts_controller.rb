class CartsController < ApplicationController
  # before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
    @cart=current_cart
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error '无效的购物车请求 #{:param[:id]}'
      redirect_to store_url, :notice=>'无效的购物车'
    else
      respond_to do |formart|
        formart.html
        formart.xml {render :xml=>@cart}
      end
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: '购物车成功创建.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: '购物车更新成功.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart=current_cart
    @cart.destroy
    session[:cart_id]=nil
    respond_to do |format|
      format.html { redirect_to carts_url, notice: '购物车删除成功.' }
      format.xml {head :ok}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_cart
    #   begin
    #     @cart = Cart.find(params[:id])
    #   rescue ActiveRecord::RecordNotFound
    #     logger.error "无效的购物车请求 #{:param[:id]}"
    #     redirect_to store_url, :notice=>'无效的购物车'
    #   else
    #     respond_to do |formart|
    #       formart.html
    #       formart.xml {render :xml=>@cart}
    #     end
    #   end
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:id)
    end
end
