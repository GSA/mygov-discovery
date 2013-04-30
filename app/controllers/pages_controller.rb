class PagesController < ApplicationController
  before_filter :limit_related, :only => [:index, :show]
  
  def index
    unless params[:url]
      render :json => {:status => "Error", :message => "url parameter required"}, :status => 400, :callback => params[:callback]
    else
      @page = Page.find_or_create_by_url_hash(Page.hash_url(params[:url]), :url => params[:url])
      if @page.persisted?
        render :json => @page.as_json(:related => @related_count, :tags => true), :callback => params[:callback]
      else
        render :json => {:status => "Error", :message => @page.all_full_messages.join(",")}, :status => 400, :callback => params[:callback]
      end
    end
  end
  
  def show    
    @page = Page.find_by_id(params[:id])
    if @page
      render :json => @page.as_json(:related => @related_count, :tags => true), :callback => params[:callback]
    else
      render :json => { :status => "Error", :message => "Could not a record of that page. Please check the URL and try again."}, :status => 404
    end
  end

  def no_js
    url = request.referer || params[:url]
    if url
      @page = Page.find_or_initialize_by_url_hash(Page.hash_url(url))
      unless @page.persisted?
        @page.url = url
        @page.save
      end
    end
  end
  
  private
  
  def limit_related
    @related_count = [(params[:related] || "2").to_i, 25].min
  end
end