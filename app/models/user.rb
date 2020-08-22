class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries #一覧表示に必要

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
