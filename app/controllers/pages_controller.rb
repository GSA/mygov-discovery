class PagesController < ApplicationController
  
  def index
    unless params[:url]
      render :json => {:status => "Error", :message => "url parameter required"}, :status => 400, :callback => params[:callback]
    else
      @page = Page.find_or_create_by_url_hash(Page.hash_url(params[:url]), :url => params[:url])
      render :json => @page.as_json(:related => true), :callback => params[:callback]
    end
  end
  
  def show    
    @page = Page.find_by_id(params[:id])
    if @page
      render :json => @page.as_json(:related => true), :callback => params[:callback]
    else
      render :json => { :status => "Error", :message => "Could not find page with id=#{params[:id]}."}, :status => 404
    end
  end

  def update
    @page = Page.find(params[:id])
    if params[:rating]      
      #todo: is there a better way to do this without running into mass assignment issues on user_id?
      rating = Rating.where(:user_id => @current_user.id, :page_id => @page.id).first
      if rating.nil?
        rating = Rating.new
        rating.page_id = @page.id
        rating.user_id = @current_user.id
      end
      rating.value = params[:rating]
      if !rating.save
        respond_to do |format|
           format.json { render json: rating.errors, status: :unprocessable_entity, :callback => params[:callback] }        
        end
        return
      end
    end
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.json { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity, :callback => params[:callback] }
      end
    end
  end

  def no_js
    url = request.referer || params[:url]
    if url
      @page = Page.find_or_initialize_by_url_hash(Page.hash_url(url))
      unless @page.persisted?
        @page.url = url
        @page.save
        @page.enqueue_scrape
      end
    end
  end  
end