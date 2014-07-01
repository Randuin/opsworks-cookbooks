node[:deploy].each do |application, deploy|
  if deploy[:application_type] == 'rails'
    application_yml_template do
      application application
      deploy deploy
      env node[:application_yml]
    end
  end
end
