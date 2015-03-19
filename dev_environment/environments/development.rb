name "development"
description "development environment"
default_attributes node: {
  webserver_template: "webserver_development.erb"
}