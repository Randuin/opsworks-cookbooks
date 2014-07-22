node[:deploy].each do |application, deploy|
  if deploy[:sidekiq]
    template "/etc/monit.d/sidekiq_#{application}.monitrc" do
      mode 0644
      source "sidekiq_monitrc.erb"

      variables({
        :deploy => deploy,
        :application => application
      })

      notifies :reload, resources(:service => "monit"), :immediately
    end
  end
end
