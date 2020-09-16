class Room < ApplicationRecord

  has_many :messages
  has_many :entries
  has_many :users, through: :entries #一覧表示に必要

end
