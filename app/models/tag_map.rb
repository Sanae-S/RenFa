class TagMap < ApplicationRecord
  belongs_to :post_image
  belongs_to :tag

 #2つの外部キーが存在することは絶対
  validates :post_image_id, presence: true
  validates :tag_id, presence: true
end
