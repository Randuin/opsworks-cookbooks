node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping deploy::rails-restart application #{application} as it is not a Rails app")
    next
  end

  Chef::Log.debug("Pre compiling assets for #{application}")
  execute 'rake assets:precompile' do
    cwd deploy[:current_path]
    user 'root'
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => 'production'

    only_if do
      File.exists?(deploy[:current_path])
    end
  end
end
