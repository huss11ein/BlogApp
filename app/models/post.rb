class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :tags, dependent: :destroy
    validates_presence_of :user , :body , :title
    validate :exist_one_tag
    accepts_nested_attributes_for :tags
    after_commit :schedule_deletion, on: :create
  private

    def exist_one_tag
    if tags.empty? #assosiation with tags above make it visible here
      errors.add(:post, 'at least exist one tag')
    end
    end
    def schedule_deletion
DeletionSchedule.perform_in(1.minute, id)
    end




end
