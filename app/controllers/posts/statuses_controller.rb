class Posts::StatusesController < ApplicationController
  before_action :set_posts_status, only: [:show, :edit, :update, :destroy]

  # GET /posts/statuses
  # GET /posts/statuses.json
  def index
    @posts_statuses = Posts::Status.all
  end

  # GET /posts/statuses/1
  # GET /posts/statuses/1.json
  def show
  end

  # GET /posts/statuses/new
  def new
    @posts_status = Posts::Status.new
  end

  # GET /posts/statuses/1/edit
  def edit
  end

  # POST /posts/statuses
  # POST /posts/statuses.json
  def create
    @posts_status = Posts::Status.new(posts_status_params)

    respond_to do |format|
      if @posts_status.save
        format.html { redirect_to @posts_status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @posts_status }
      else
        format.html { render :new }
        format.json { render json: @posts_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/statuses/1
  # PATCH/PUT /posts/statuses/1.json
  def update
    respond_to do |format|
      if @posts_status.update(posts_status_params)
        format.html { redirect_to @posts_status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @posts_status }
      else
        format.html { render :edit }
        format.json { render json: @posts_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/statuses/1
  # DELETE /posts/statuses/1.json
  def destroy
    @posts_status.destroy
    respond_to do |format|
      format.html { redirect_to posts_statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posts_status
      @posts_status = Posts::Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posts_status_params
      params.require(:posts_status).permit(:name)
    end
end
