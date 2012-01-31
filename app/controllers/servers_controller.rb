class ServersController < ApplicationController
  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers }
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new
    1.times { @server.tags.build }
    @tags = Tag.all
    @tags_selected = [] 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
    @tags_selected = @server.tags
    @tags = Tag.all
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])
    @server.tags = params[:tag_ids].map { |id| Tag.find(id) }

    respond_to do |format|
      if @server.save
        format.html { redirect_to servers_path, notice: 'Server was successfully created.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: "new" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :ok }
    end
  end

  def search_servers
    #@tags_selected = ( params[:tag_ids].map { |id| Tag.find(id) } ) || []
    @servers = Server.find_by_tag(params[:logic], params[:tag_names]) || Server.all

    respond_to do |format|
      format.json { render json: @servers }
    end
  end


  def search_tags
    @server = Server.find_by_name(params[:name])
    @tags = @server.tags

    respond_to do |format|
      format.json { render json: @tags }
    end
  end

end
