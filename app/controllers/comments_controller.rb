class CommentsController < ApplicationController
    before_action :retrieve_post, only: [:create,:index]
    before_action :retrieve_comment, only: [:update, :destroy]
    before_action :authorize_request
    def index
        if @post
          comments = @post.comments.order(created_at: :desc)
          if not @comments
              return render json: {message: 'No comments for that post'}
          end
          render json: comments, status: :ok
        else
          render json: { error: "Post not found" }, status: :not_found
        end
    end

    def create
        if not @post
           return render json: { error: "Post not found" }, status: :not_found
        end
        comment = @post.comments.create(content: comment_params[:content], user_id: current_user.id)
        if comment.save
          render json: post_with_comments_and_tags(@post), status: :created
        else
          render json: comment.errors, status: :unprocessable_entity
        end
    end

    def update

        if @comment.is_author?(current_user)
          if @comment.update(comment_params)
            render json: post_with_comments_and_tags(@comment.post), status: :ok
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Not authorized to update this comment" }, status: :forbidden
        end
    end

    def destroy
        if @comment.is_author?(current_user)
          @comment.destroy
          render json: { message: "Comment deleted successfully" }, status: :ok
        else
          render json: { error: "Not authorized to delete this comment" }, status: :forbidden
        end
    end

    private

    def retrieve_comment
        @comment = Comment.find(params[:id].to_i)
    end

     def retrieve_post
        @post = Post.find(params[:post_id].to_i)
     end

    def comment_params
        params.require(:comment).permit(:content)
    end
    def post_with_comments_and_tags(post)
      {
        id: post.id,
        body: post.body,
        created_at: post.created_at,
        updated_at: post.updated_at,
        comments: post.comments.order(created_at: :asc).map do |comment|
          {
            id: comment.id,
            content: comment.content,
            user_id: comment.user_id,
            created_at: comment.created_at,
            updated_at: comment.updated_at
          }
        end,
        tags: post.tags.map do |tag|
          {
            id: tag.id,
            tage_name: tag.tage_name
          }
        end
      }
    end
end
