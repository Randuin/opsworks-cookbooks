node[:deploy].each do |application, deploy|
  if deploy[:sidekiq]
    service "monit" do
      action :nothing
    end

    template "/etc/monit.d/sidekiq_#{application}.monitrc" do
      mode 0644
      source "sidekiq_monitrc.erb"

      variables({
        :deploy => deploy,
        :application => application
      })

      notifies :restart, "service[monit]"
    end
  end
end
