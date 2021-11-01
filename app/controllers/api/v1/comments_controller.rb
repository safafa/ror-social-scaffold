class Api::V1::CommentsController < ApiController
    def index
        @comments = Post.find(params[:post_id]).comments
    end
end