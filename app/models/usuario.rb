class Usuario < ApplicationRecord
  validates :email, presence: true
  validates_format_of :email, :with => /@/
  validates :senha, presence: true
end
