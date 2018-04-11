class Order < ApplicationRecord
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true
  before_create :generate_token

  belongs_to :user
  has_many :product_lists

  def generate_token
    self.token = SecureRandom.uuid
  end

  def pay!
    self.is_paid = true
  end

  def set_payment_method_with(method)
    self.payment_method = method
  end
end
