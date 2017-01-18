class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
    @cart=current_cart
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @cart=current_cart
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
    @cart=current_cart
  end

  # GET /line_items/1/edit
  def edit
    @cart=current_cart
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart=current_cart
    begin
      # store添加到购物车
      @product=Product.find(params[:product_id]);
    rescue ActiveRecord::RecordNotFound
      #购物车列表中添加时由于传递的param是line_item,所以用下面的方式获取
      begin
        @product=Product.find(line_item_params[:product_id]);
      rescue ActiveRecord::RecordNotFound
        logger.error '无效的购物车商品请求 #{line_item_params[:product_id]}'
        redirect_to line_items_path, :notice=>'没有对应的商品'
      end
    else
      # @line_item=@cart.line_item.build(:product=>product)
      @line_item=@cart.add_product(@product.id);
      respond_to do |format|
        if @line_item.save
          format.html{redirect_to(store_path,:notice => 'Line Item 创建成功')}
          format.xml{render :xml=>@line_item,:status => :created,:location => @line_item}
        else
          format.html{render :action => 'new'}
          format.xml{render :xml=>@line_item.errors,:status => :unprocessable_entity}
        end
      end
    end

  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: '购物车明细更新成功.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    # LineItem.find(params[:id]).destroy;
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: '购物车明细删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end
