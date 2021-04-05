class EditLock < ApplicationRecord
  belongs_to :lockable, polymorphic: true, touch: true
  belongs_to :locked_by, foreign_key: :user_id, class_name: 'User'
end
