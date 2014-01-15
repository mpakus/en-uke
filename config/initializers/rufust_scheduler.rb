require 'rufus-scheduler'

if Rails.env.production?
  scheduler = Rufus::Scheduler.new

  scheduler.every '1h' do
    Link.week_aging
  end
end

#scheduler.join