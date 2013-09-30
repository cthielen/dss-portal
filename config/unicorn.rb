root = "/home/deployer/apps/dss-portal/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.dssportal.sock"
worker_processes 8
timeout 35
