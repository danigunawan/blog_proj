class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  def like_for(user)
    likes.find_by_user_id(user)
  end

end
