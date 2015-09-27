class Product < ActiveRecord::Base
  default_scope { order('title') } 
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  #...


  # validation stuff...


  validates :title, :description, :image_url, :presence => true
  # :presence => true tells the validator to check that each of the named fields is
	# present and its contents are not empty.
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	# validate the price is a valid, positive number
  validates :title, :uniqueness => true
	# checks that the product has a unique title
	# validates :image_url, :format => {
	# :with => %r{\.(gif|jpg|png)$}i,
	# :message => 'must be a URL for GIF, JPG or PNG image.'

	# validate that the url is valid, format matches a field against a regular expression
  	# }
  validates :title, :length => {:minimum => 10}
  
  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end

