node[:deploy].each do |application, deploy|
  execute "update-crontab-#{application}" do
    cwd deploy[:current_path]

    user 'deploy'
    command "bundle exec whenever --set environment=#{deploy[:rails_env]} --update-crontab #{application}}"
    only_if "cd #{deploy[:current_path]} && bundle show whenever"
  end
end
