execute 'rake assets:precompile' do
  cwd "#{node[:deploy_to]}/current"
  user 'root'
  command 'bundle exec rake assets:precompile'
  environment 'RAILS_ENV' => node[:environment_variables][:RAILS_ENV]
end