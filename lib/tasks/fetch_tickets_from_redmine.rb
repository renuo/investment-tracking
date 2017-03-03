namespace :fetch_redmine_data do
  desc 'fetches every hour the data from Redmine'

  task mail_export: :environment do
    FetchJsonFromRedmine
  end
end
