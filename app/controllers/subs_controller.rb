class SubsController < ApplicationController
  include Findable

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      flash[:messages] = ["Sub created successfully"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      @sub = Sub.new
      render :new
    end
  end

  def edit
    if current_user != @sub.moderator
      flash[:errors] = ["Can't edit THAT sub!"]
      redirect_to subs_url
    end
  end

  def update
    if @sub.update(sub_params)
      flash[:messages] = ["Sub edited successfully"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      @sub = Sub.find(params[:id])
      render :edit
    end
  end

  def show
  end

  private

  def sub_params
    params.require(:sub).permit(:moderator_id, :name, :description)
  end
end
