class Order < ApplicationRecord
  belongs_to :customer
  has_many :payments
  has_many :purchases
  scope :is_active, -> { where(is_archived: false) }
  before_save :calculate_tax

  private

  def calculate_tax
    total_price = 0
    tax_price = 0
    # Get list of all the pusrchesed products
    products_list = purchases.pluck(:product_id)

    # check which tax group is applicable
    TaxGroup.all.map do |tax_group|
      if (tax_group.products - products_list).empty?
        tax_price += Product.find(tax_group.products).pluck(:price).sum * (tax_group.tax.percent / 100)
        products_list -= tax_group.products
      else
        tax_price += Product.find(tax_group.products).pluck(:price).sum * (tax_group.tax.percent / 100)
        products_list -= tax_group.products
      end
    end

    purchases.each do |purchase|
      total_price += purchase.quantity * purchase.product.price
    end
    self.total_price = total_price
    self.tax_price = tax_price
    self.net_price = self.total_price - self.tax_price
  end
end
