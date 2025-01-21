class DeletionSchedule
    include Sidekiq::Worker
  def perform(post_id)
    post = Post.find(post_id)
    post.destroy
  end
end
