class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages, :callback => params[:callback] }
    end
  end

  def lookup
    page = Page.new
    page.url = params[:url]
    @page = Page.find_by_url_hash( page.build_hash )
    
    if @page.nil? 
      status = 404 
    else 
      status = 200
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @page.as_json( :related => true ), :status => status, :callback => params[:callback] }
    end
  end
  
  # GET /pages/1
  # GET /pages/1.json
  def show
    require 'digest/md5'
    
    @page = Page.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page.as_json( :related => true ), :callback => params[:callback] }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity, :callback => params[:callback] }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content, :callback => params[:callback] }
    end
  end
end
