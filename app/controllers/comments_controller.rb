class CommentsController < ApplicationController
  
  #allow user to create rating by POSTing to /pages/1/comments
  def create
    @comment = Comment.new
    @comment.page_id = params[:page_id]
    @comment.user_id = @current_user.id
    @comment.body = params[:body]
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment.as_json, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    page = params[:page] || 1
    render :json => Comment.where(:page_id => params[:page_id]).paginate(:page => page).order("created_at DESC").as_json(), :callback => params[:callback]
  end

end