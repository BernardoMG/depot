# Store controller
class StoreController < ApplicationController
  include SessionCount
  include CurrentCart
  before_action :set_cart, :increment_counter, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
