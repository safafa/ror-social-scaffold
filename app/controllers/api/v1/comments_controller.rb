class Api::V1::CommentsController < ApiController
  def index
    @comments = Post.find(params[:post_id]).comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      render json: { success: ['Comment posted'] }
    else
      render json: { errors: ['Comment failed '] }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
