class Posts::InvitesController < ApplicationController
  before_action :set_posts_invite, only: [:show, :edit, :update, :destroy]

  # GET /posts/invites
  # GET /posts/invites.json
  def index
    @posts_invites = Posts::Invite.all
  end

  # GET /posts/invites/1
  # GET /posts/invites/1.json
  def show
  end

  # GET /posts/invites/new
  def new
    @posts_invite = Posts::Invite.new
  end

  # GET /posts/invites/1/edit
  def edit
  end

  # POST /posts/invites
  # POST /posts/invites.json
  def create
    @posts_invite = Posts::Invite.new(posts_invite_params)

    respond_to do |format|
      if @posts_invite.save
        format.html { redirect_to @posts_invite, notice: 'Invite was successfully created.' }
        format.json { render :show, status: :created, location: @posts_invite }
      else
        format.html { render :new }
        format.json { render json: @posts_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/invites/1
  # PATCH/PUT /posts/invites/1.json
  def update
    respond_to do |format|
      if @posts_invite.update(posts_invite_params)
        format.html { redirect_to @posts_invite, notice: 'Invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @posts_invite }
      else
        format.html { render :edit }
        format.json { render json: @posts_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/invites/1
  # DELETE /posts/invites/1.json
  def destroy
    @posts_invite.destroy
    respond_to do |format|
      format.html { redirect_to posts_invites_url, notice: 'Invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posts_invite
      @posts_invite = Posts::Invite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posts_invite_params
      params.require(:posts_invite).permit(:accepted_by, :post_id, :invite_status_id)
    end
end
