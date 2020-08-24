class PostImage < ApplicationRecord

	belongs_to :user
	attachment :image
	has_many :comments, dependent: :destroy
	belongs_to :category
	#投稿が削除されると同時に投稿とTagの関係が削除される。
	has_many :tag_maps, dependent: :destroy
    has_many :tags, through: :tag_maps

	# introduction がそんざいしなければいけない
	validates :introduction, presence: true
	validate :image_exists?
	validates :animal_name, length: { minimum: 1 }

private
	def image_exists?
		errors.add(:image_id, ' must exists') unless image.present?
	end
end
