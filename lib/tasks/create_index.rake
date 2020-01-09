namespace :elastic_index do
  task :create_index => :environment do
    Advertisement.__elasticsearch__.create_index!
    Advertisement.import force: true
  end
end

Rake::Task['db:seed'].enhance do
  Rake::Task['elastic_index:create_index'].invoke
end
