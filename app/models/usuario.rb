class Usuario < ApplicationRecord
	has_secure_password
  	validates :email, presence: true
  	validates_format_of :email, :with => /@/
  	validates :senha, presence: true
end
