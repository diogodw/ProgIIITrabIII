class Comanda < ApplicationRecord
  belongs_to :usuario
  validates :produtos, presence: true
  validates :valortotal, presence: true
  validates :usuario_id, presence: true
end
