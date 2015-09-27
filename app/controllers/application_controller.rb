class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def current_cart 
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
      # a new cart is created if a session id is not found, store the id of the created cart and return the new cart
     
    end
end