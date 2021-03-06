# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
# 
# Notifies a "restart Rails app <name> for custom env" resource.

define :application_yml_template do
  template "#{params[:deploy][:deploy_to]}/shared/config/application.yml" do
    source "application.yml.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env]

    only_if do
      File.exists?("#{params[:deploy][:deploy_to]}/shared/config")
    end
  end
end
