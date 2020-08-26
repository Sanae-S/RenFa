class PostImagesController < ApplicationController

  before_action :set_categories, only: [:index, :new, :edit, :create,:update]

  def new
    @post_image = PostImage.new
    @tag_list = Tag.all
  end

  def create
    @post_image = PostImage.new(post_image_params)
    #.split(nil)：送信されてきた値を、スペースで区切って配列化する
    tag_list = params[:post_image][:tag_name].split(/[[:blank:]]+/)
    @post_image.user_id = current_user.id
     if @post_image.save
      #取得したタグの配列をデータベースに保存
        @post_image.save_tag(tag_list)
       redirect_to post_images_path
     else
       render :new
     end
  end

  def index
    @post_images = PostImage.order("id DESC").page(params[:page]).per(5)
    @categories = Category.all
    @tag_list = Tag.all  #ビューでタグ一覧を表示するために全取得。
  end

  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @comment = Comment.new
    @comments = @post_image.comments
    @post_image_tags = @post_image.tags    #その投稿に紐付けられているタグの取得
  end

  def edit
    @post_image = PostImage.find(params[:id])
    @tag_list = @post_image.tags.pluck(:tag_name).split(/[[:blank:]]+/)
    @tag_lists = Tag.all
  end

  def update
    @post_image = PostImage.find(params[:id])
    tag_list = params[:post_image][:tag_name].split(/[[:blank:]]+/)
      if @post_image.update(post_image_params)
         @post_image.save_tag(tag_list)
         redirect_to post_image_path(@post_image)
      else
        render :edit
      end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to root
  end

  def category
    # Categoryのデータベースから一致するidを取得
    @category = Category.find(params[:category_id])
    # category_idと紐づく投稿を取得,5件でページネーション
    @category_items = @category.post_images.page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def search
    @tag_list = Tag.all.page(params[:page]).per(5)  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @post_images = @tag.post_images.all   #クリックしたタグに紐付けられた投稿を全て表示
    # @post_image_tags = @post_image.tags
  end


  private #複数画像をアップするために配列にする。, :images[]
  def post_image_params
    params.require(:post_image).permit(:animal_name, :image, :introduction, :category_id)
  end

  def set_categories
    @categories = Category.all
  end
end
