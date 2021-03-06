class PostsController < ApplicationController

  def index
    @text = "Index"
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    variable_name = 0
    @universal_variable_name = 0 #accessible in view and not just this def

    @text = "Show"
    @post = Post.find(params[:id])
    @comments = @post.comments
    # binding.pry # Stops code and continues in console/terminal
  end

  def new
    @text = "New"
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
      flash[:success] = "Successly Created Post"
    else
      redirect_to new_post_path
      flash["alert-danger"] = @post.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def edit
    @text = "Edit"
    @post = Post.find(params[:id])
    check_authorization(@post)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
      redirect_to post_path(@post)
      flash[:success] = "Successly Updated Post"
    else
      redirect_to edit_post_path(@post)
      flash["alert-danger"] = @post.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def destroy
    if @post = Post.find(params[:id])
      check_authorization(@post)
      @post.destroy
      redirect_to root_path
      flash[:success] = "Successly DESTROYED Post"
    end
  end

  private
  def post_params
    if params[:post]
      params[:post][:user_id] = current_user.id
      params.require(:post).permit(:content, :user_id)
    end
  end

  def check_authorization(post)
    unless post.user == current_user #same as: if @post.user != current_user
      redirect_to root_path
      flash[:alert] = "Not Authorized"
      return false
    else
      return true
    end
  end

end
