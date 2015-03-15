class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.parent_comment = params[:comment_id] ? Comment.find(params[:comment_id]) : nil
    @comment.post = params[:post_id] ? Post.find(params[:post_id]) : @comment.parent_comment.post
    if @comment.save
      flash[:messages] = ["Comment created"]
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      @comment = Comment.new
      @comment.post = Post.find(params[:post_id])
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:messages] = ["Comment updated"]
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
