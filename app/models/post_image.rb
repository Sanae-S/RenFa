class PostImage < ApplicationRecord

	belongs_to :user
	attachment :image

	# introduction がそんざいしなければいけない
	validates :introduction, presence: true
	validate :image_exists?
	validates :animal_name, length: { minimum: 1 }

private
	def image_exists?
		errors.add(:image_id, ' must exists') unless image.present?
	end
end
