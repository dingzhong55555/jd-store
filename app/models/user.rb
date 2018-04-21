class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :likes
  has_many :liked_products, through: :likes, source: :product

  def is_admin?
    is_admin
  end

  def like!(product)
    like = likes.new
    like.product = product
    like.save
  end
end
