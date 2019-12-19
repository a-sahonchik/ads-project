namespace :archive do
  desc "Archive all advertisements after 3 days in publication"

  task :ads => :environment do
    ads = Advertisement.where(state: :published)

    ads.each do |a|
      if (Time.now - 2.days > a.updated_at)
        a.state = :archived
        a.save
      end
    end
  end
end
