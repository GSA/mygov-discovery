class PagesController < ApplicationController

  #before_filter :authenticate_user!
  
  # GET /pages
  # GET /pages.json
  def index
    render json: Page.all, :callback => params[:callback]
  end

  def lookup
    page = Page.new
    page.url = params[:url]
    @page = Page.find_by_url_hash( page.build_hash )
    
    if @page.nil?
      @page = Page.new
      @page.url = params[:url] 
      @page.enqueue_scrape
    end
    
    render :json => @page.as_json( :related => true ), :callback => params[:callback] #}
 
  end
  
  # GET /pages/1
  # GET /pages/1.json
  def show       
    render json: Page.find(params[:id]).as_json( :related => true ), :callback => params[:callback]
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    render json: Page.new
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    if @page.save
      render json: @page.as_json( :related => true ), status: :created, location: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
    
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(params[:page])
      head :no_content
    else
      render json: @page.errors, status: :unprocessable_entity, :callback => params[:callback]
    end
    
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    head :no_content
  end
  
end
