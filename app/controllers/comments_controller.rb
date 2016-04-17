class CommentsController < ApplicationController

  def new
    @text = "Comment New"
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post)
      flash[:success] = "Successly Created Comment"
    else
      redirect_to post_path(@comment.post)
      flash["alert-danger"] = @comment.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def edit
    @text = "Comment Edit"
    @comment = Comment.find(params[:id])
    check_authorization(@comment)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update comment_params
      redirect_to post_path(@comment.post)
      flash[:success] = "Successly Updated Comment"
    else
      redirect_to edit_comment_path(@comment)
      flash["alert-danger"] = @comment.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if check_authorization(@comment)
      @post = @comment.post
      @comment.destroy
      redirect_to post_path(@post)
      flash[:success] = "Successly DESTROYED Comment"
    end
  end

  private
  #def comment_params
  #  params.require(:comment).permit(:content, :user_id, :post_id) if params[:comment]
  #end


  def comment_params
    if params[:comment]
      params[:comment][:user_id] = current_user.id
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
  end

  def check_authorization(comment)
    unless comment.user == current_user #same as: if @comment.user != current_user
      redirect_to post_path(@post)
      flash[:alert] = "Not Authorized"
      return false
    else
      return true
    end
  end


end
