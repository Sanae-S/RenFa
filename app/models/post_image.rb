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

  def save_tag(sent_tags)
    #selfはクラス内部で書かれる場合、そのクラスのインスタンス変数の参照に利用される。
    #.pluck:1つのモデルで使用されているテーブルから,指定したカラムの値の配列を、対応するデータ型で返す.
    #createで保存した投稿に紐付いているタグが存在する場合、「タグの名前を配列として」全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    #投稿に存在するタグから、送信されてきたタグを除いたタグ
    old_tags = current_tags - sent_tags
    #送信されてきたタグから、現在存在するタグを除いたタグ
    new_tags = sent_tags - current_tags

# 古いタグを削除
#post_image.tagsの配列から、Tag.find_byで検索して取得したtagを削除
    old_tags.each do |old|
      self.post_image_tags.delete Tag.find_by(tag_name: old)
    end

# 新しいタグをデータベースに保存
#find_or_create_byは、オブジェクトが存在する場合は取得、なければ作成
    new_tags.each do |new|
      new_post_image_tag = Tag.find_or_create_by(tag_name: new)
#self.tags.push(post_image_tag)と一緒の意味になり、push()とは配列の要素を追加する場合に使います。
      self.tags << new_post_image_tag
    end
  end


private
  def image_exists?
  	errors.add(:image_id, ' must exists') unless image.present?
	end
end
