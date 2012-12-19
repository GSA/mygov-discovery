class PagesController < ApplicationController
  
  def index
    @pages = Page.all
    respond_to do |format|
      format.json { render json: @pages, :callback => params[:callback] }
    end
  end

  def lookup
    @page = Page.find_or_initialize_by_url_hash(Page.hash_url(params[:url]))
    unless @page.persisted?
      @page.url = params[:url]
      @page.save
      @page.enqueue_scrape
    end
    respond_to do |format|
      format.json { render :json => @page.as_json(:related => true), :callback => params[:callback] }
    end
  end
  
  def show    
    @page = Page.find(params[:id])
    respond_to do |format|
      format.json { render json: @page.as_json(:related => true), :callback => params[:callback] }
    end
  end

  def new
    @page = Page.new    
    respond_to do |format|
      format.json { render json: @page }
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        format.json { render json: @page.as_json( :related => true ), status: :created, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.json { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity, :callback => params[:callback] }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content, :callback => params[:callback] }
    end
  end
end