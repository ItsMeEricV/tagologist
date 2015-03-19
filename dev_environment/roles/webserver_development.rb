name "webserver_development"
description "development webserver"
run_list  "recipe[apt]",
          "recipe[build-essential::default]",
          "recipe[nginx]",
          "recipe[rbenv::default]",
          "recipe[rbenv::ruby_build]",
          "recipe[rails-config]",
          "recipe[rails-config::webserver_config]"
