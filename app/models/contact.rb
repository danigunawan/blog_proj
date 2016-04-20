class Contact < ActiveRecord::Base

  validates :name, :subject, :email, :message, presence: true

end
