class Link < ActiveRecord::Base
  belongs_to :user

  scope :ordered, ->{ order('created_at DESC') }
  scope :living,  ->{ where('state != 10') }

  state_machine initial: :pending do
    state :pending,  value: 0
    state :keeped,   value: 5
    state :garbage,  value: 10
    event :keep do
      transition pending: :keeped
    end
    event :unkeep do
      transition keeped: :pending
    end
    event :to_garbage do
      transition pending: :garbage, keeped: :garbage
    end
  end

  # Put into garbage all old links
  def self.week_aging
    Link.where('created_at < ?', 1.week.ago).with_state(:pending).find_each do |link|
      link.to_garbage
      link.save
    end
  end

end
