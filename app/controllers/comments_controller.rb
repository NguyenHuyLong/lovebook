class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "flash.danger.cannot_update"
      redirect_to @comment.review
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "flash.danger.cannot_delete"
      redirect_to @comment.review
    end
  end

  private
  def comment_params
    params.require(:comment).permit :review_id, :user_id, :content
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "flash.danger.comment_not_found"
    end
  end
end
