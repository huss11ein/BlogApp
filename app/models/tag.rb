class Tag < ApplicationRecord
    #TODO Prevent from creating redundant tags and use the exist ones
    belongs_to :post
    validates_presence_of :tage_name
end
