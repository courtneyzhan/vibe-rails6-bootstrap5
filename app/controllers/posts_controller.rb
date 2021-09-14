class PostsController < SecureController
  before_action :set_post, only: %i[ show edit update destroy ]
  
  skip_before_action :authenticate_user, :only => [:index, :show]
  
  # GET /posts or /posts.json
  def index
    the_posts = Post.all
    if current_user && current_user.is_admin?
      @posts = the_posts
    elsif current_user
      @posts = the_posts.where("user_id = ?", current_user.id)       
    else
      @posts = the_posts.where("posted_on >= ? and post_type != ?",  24.hours.ago, "Personal")
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new    
    if params[:post_type] == "Gratitude"
      @post.post_type = "Gratitude"
      @post.title = "What are you grateful for today?"
    elsif params[:post_type] == "Question"
      @post.post_type = "Question"      
      random_question = ["I can't imagine living without...", "What inspires you?", "What would you do if you knew you could not fail?", "What did you achieve today?"].sample
      @post.title = random_question
    else
      @post.post_type = "Personal"
    end
    
  end

  # GET /posts/1/edit
  def edit
    verify_owner_or_admin(@post)
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    verify_owner_or_admin(@post)
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    verify_owner_or_admin(@post)

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post).permit(:title, :content, :posted_on, :post_type)
      
      # params.fetch(:post, {:title, :content})
    end
end
