class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post_image
  validates :content, presence: true
  
end
