class Posts::CategoriesController < ApplicationController
  before_action :set_posts_category, only: [:show, :edit, :update, :destroy]

  # GET /posts/categories
  # GET /posts/categories.json
  def index
    @posts_categories = Posts::Category.all
  end

  # GET /posts/categories/1
  # GET /posts/categories/1.json
  def show
  end

  # GET /posts/categories/new
  def new
    @posts_category = Posts::Category.new
  end

  # GET /posts/categories/1/edit
  def edit
  end

  # POST /posts/categories
  # POST /posts/categories.json
  def create
    @posts_category = Posts::Category.new(posts_category_params)

    respond_to do |format|
      if @posts_category.save
        format.html { redirect_to @posts_category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @posts_category }
      else
        format.html { render :new }
        format.json { render json: @posts_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/categories/1
  # PATCH/PUT /posts/categories/1.json
  def update
    respond_to do |format|
      if @posts_category.update(posts_category_params)
        format.html { redirect_to @posts_category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @posts_category }
      else
        format.html { render :edit }
        format.json { render json: @posts_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/categories/1
  # DELETE /posts/categories/1.json
  def destroy
    @posts_category.destroy
    respond_to do |format|
      format.html { redirect_to posts_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posts_category
      @posts_category = Posts::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posts_category_params
      params.require(:posts_category).permit(:name)
    end
end
