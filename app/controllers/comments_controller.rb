class CommentsController < ApplicationController
  
  #allow user to create rating by POSTing to /pages/1/comments
  def create
    @comment = Comment.new
    @comment.page_id = params[:page_id]
    @comment.body = params[:comment]
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment.as_json, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @comments = Comment.where :page_id => params[:page_id]
    respond_to do |format|
      format.json { render json: @comments, :callback => params[:callback] }
    end
  end
  
end