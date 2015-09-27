class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
	# if a cart is deleted the associated line items get deleted
end