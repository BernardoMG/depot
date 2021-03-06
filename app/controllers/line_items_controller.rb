class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :decrement]
  before_action :set_line_item, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_line_item

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_index_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
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
    if @line_item.quantity > 1
      @line_item.update_attributes(quantity: @line_item.quantity - 1)
      respond_to do |format|
        format.html { redirect_to @line_item.cart, notice: 'Item Removed' }
        format.xml  { head :no_content }
      end
    else
      @line_item.destroy
      respond_to do |format|
        if @line_item.cart.line_items.empty?
          format.html { redirect_to store_index_url, notice: 'Your cart is empty' }
        else
          format.html { redirect_to @line_item.cart, notice: 'Item Removed' }
        end
        format.xml { head :ok }
      end
    end
  end

  # DECREMENT /line_items/1
  # DECREMENT /line_items/1.json
  def decrement
    @line_item = @cart.decrement_line_item_quantity(params[:id])

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url, notice: 'Line item was successfully updated.' }
        format.js   { @current_item = @line_item }
        format.json { render :show, status: :ok, location: @line_item }
      else
       format.html { render action: 'edit' }
       format.js   { @current_item = @line_item }
       format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet
  def line_item_params
    params.require(:line_item).permit(:product_id)
  end

  # Attempt to access invalid line
  def invalid_line_item
    logger.error "Attempt to access invalid line item #{params[:id]}"
    redirect_to line_items_url, notice: 'Invalid line item'
  end
end
