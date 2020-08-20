class CommentsController < ApplicationController

  def create
    @post = PostImage.find(params[:post_image_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    #保存がされると、render :indexによって「app/views/comments/index.js.erb」を探す。
    if @comment.save
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_image_id, :user_id)
    end
end
