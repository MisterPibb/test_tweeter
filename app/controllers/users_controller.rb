class UsersController < ApplicationController
  # def show
  #   variable_name = 0
  #   @universal_veriable_name = 0 #accessible in view and not just this def
  #
  #   @text = "Show"
  #   @post = Post.find(params[:id])
  #   # binding.pry # Stops code and continues in console/terminal
  # end
  def index
    @text = "User Index"

    @users = User.all.order(created_at: :desc)
  end
  # def new
  #   @text = "New"
  # end
  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     redirect_to post_path(@post)
  #   else
  #     redirect_to root_path
  #   end
  #
  # end
  #
  # def edit
  #   @text = "Edit"
  # end
  # def update
  #
  # end
  #
  # private
  # def post_params
  #   params.require(:post).permit(:content, :user_id) if params[:post]
  # end

end
