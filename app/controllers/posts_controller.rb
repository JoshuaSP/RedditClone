class PostsController < ApplicationController
  include Findable

  def new
    # @sub = Sub.find(params[:sub_id])
    # @post = @sub.posts.new
    @post = Post.new
    @post.subs << Sub.find(params[:sub_id])
    # fail
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:messages] = ["Post created successfully"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @post = Post.new
      @post.subs << Sub.find(params[:sub_id])
      render :new
    end
  end

  def show
  end

  def edit
    if @post.author != current_user
      flash[:errors] = ["You can't edit that post"]
      redirect_to sub_url(@post.subs.first)
    end
  end

  def update
    if @post.update(post_params)
      flash[:message] = ["Post updated successfully"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :sub_ids => [])
  end
end
