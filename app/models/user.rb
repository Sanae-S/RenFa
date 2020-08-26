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

  def User.search(search, user_or_post_image, how_search)
    if user_or_post_image == "1"
      if how_search == "1"
        #あいまい検索
              User.where(['name LIKE ?', "%#{search}%"])
      elsif how_search == "2"
        #後方一致検索
              User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "3"
        #前方一致検索
              User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "4"
        #完全一致検索
              User.where(['name LIKE ?', "#{search}"])
      else
              User.all
      end
    end
  end
end
