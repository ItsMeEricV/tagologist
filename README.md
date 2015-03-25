Tagologist
==============

A simple web app to retrieve the source code of a remote HTML page, calculate statistics of its tag usage, and provide highlighting of the tags

[**Live demo**](http://tagologist.ericvierhaus.com)

A full local Vagrant dev environment is included

Ingredients
--------------

- *Application*
  - Rails 4
  - [Faraday](https://github.com/lostisland/faraday)
  - Bootstrap 3
- *Testing*
  - Rspec
  - VCR
  - Guard
- *Development and Ops*
  - Vagrant
  - Capistrano

Files of interest
-------------

- **Application**
  - [tag_map_controller](https://github.com/ejvaudio/tagologist/blob/master/code/app/controllers/tag_map_controller.rb): Controller that retrieves the source code, calls helper analysis functions, and activates the view
  - [tagger](https://github.com/ejvaudio/tagologist/blob/master/code/lib/tagger.rb): Helper functions to analyze and decorate the source code
  - [Views](https://github.com/ejvaudio/tagologist/tree/master/code/app/views/tag_map): View files that display the source code and summary table
- **Testing**
  - [unit tests](https://github.com/ejvaudio/tagologist/blob/master/code/spec/modules/tagger_spec.rb)
  - [controller tests](https://github.com/ejvaudio/tagologist/blob/master/code/spec/controllers/tag_map_controller_spec.rb)

Running locally
--------------

- Install the [ChefDK](https://downloads.chef.io/chef-dk/)
- Install the vagrant-berkshelf plugin: `vagrant plugin install vagrant-berkshelf`
- Clone the repository: `git clone https://github.com/ejvaudio/tagologist.git`
- `cd tagologist/dev_environment`
- `vagrant up`