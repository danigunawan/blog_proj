class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
end

  def full_name
    "#{first_name} #{last_name}"
  end
