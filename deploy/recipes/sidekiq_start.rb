node[:deploy].each do |application, deploy|
  if deploy[:sidekiq]
    workers = node[:sidekiq][application].to_hash.reject {|k,v| k.to_s =~ /restart_command|syslog/ }

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
