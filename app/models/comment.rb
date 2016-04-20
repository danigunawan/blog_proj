class Comment < ActiveRecord::Base
  validates :body, presence: true, uniqueness: {message: "must be unique!"}
end
