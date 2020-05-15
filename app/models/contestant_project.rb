class ContestantProject <ApplicationRecord
  belongs_to :contestant, required: true
  belongs_to :project, required: true
end
