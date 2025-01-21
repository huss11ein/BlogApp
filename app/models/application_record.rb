class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

    def is_author?(user)
        user_id == user.id
    end
end
