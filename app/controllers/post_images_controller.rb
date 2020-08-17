class PostImagesController < ApplicationController

  def new
  	@post_image = PostImage.new
  end

  def create
  	@post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
     if @post_image.save
       redirect_to post_images_path
     else
   	  render :new
   	end
  end

  def index
  	@post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
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

  private #複数画像をアップするために配列にする。, :images[]
  def post_image_params
    params.require(:post_image).permit(:animal_name, :image, :introduction)
  end
end