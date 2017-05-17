class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_comment, only: [:update, :destroy]

  def create
    @comment = current_user.comments.new comment_params
    unless @comment.save
      flash[:danger] = t "cannot_create_comment"
    end
    redirect_to @comment.review.book
  end

  def update
    unless @comment.update_attributes comment_params
      flash[:danger] = t "flash.danger.cannot_update_comment"
    end
    redirect_to @comment.review.book
  end

  def destroy
    unless @comment.destroy
      flash[:danger] = t "flash.danger.cannot_delete_comment"
    end
    respond_to do |format|
      format.html {redirect_to @comment}
      format.js
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
