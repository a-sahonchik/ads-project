namespace :publish do
  desc "Publish all approved advertisements."

  task :ads => :environment do
    ads = Advertisement.where(state: :approved)

    ads.each do |a|
      a.state = :published
      a.save
    end
  end
end
