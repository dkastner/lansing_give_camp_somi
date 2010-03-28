class EventVolunteer < ActiveRecord::Base
	belongs_to :event
	belongs_to :user

  validate :prevent_signup_for_past_event
  validates_uniqueness_of :user_id, :context => :event_id

  accepts_nested_attributes_for :user

private
  def prevent_signup_for_past_event
    if event.past?
      errors.add(:event, :message => "cannot sign up for a past event")
    end
  end
end
