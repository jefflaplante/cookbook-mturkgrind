MturkGrind Cookbook
=================
MturkGrind Chef Cookbook using Vagrant, Berkshelf, chef-spec, minitest-handler, and foodcritic.

Workflow
--------
1. Create a cookbook with berks. This task creates several sane default files for you and peforms a `git init` on the cookbook directory.
    - `berks cookbook new_application`
2. Make a spec directory and create `default_spec.rb` in the spec directory. Write the unit test to describe the cookbook.
    - `mkdir spec; vim spec/default_spec.rb` 
3. Make a directory for your minitests and create a default minitest file.
    - `mkdir -p files/default/test; vim files/default/test/default_test.rb`
4. Write your cookbook recipes and fill out your attribute files. Iterate on templates, files, etc - as is needed.
5. Update Berks file with any cookbooks your project requires.
6. Update Gemfile with any gems required for your project. Use bundler to install them. 
7. Setup Vagrantfile for testing your cookbook on a vm.
8. Create a github repo on http://github.disney.com/se-di-cookbooks and set it as your cookbook's upstream. Push to it.
9. Test converging your vm node with vagrant
    - `vagrant up` the first time, `vagrant provision` there after to converge again.
10. Lint your code with foodcritic. Fix any offenses in your code.
    - `foodcritic .` 
11. Run your unit tests. Fix recipes to meet your specs if you encounter any errors.
    - `rspec --color`
12. Commit often.
13. Update README.md - document your cookook.
14. Tag your releases and push to github.

Requirements & Setup
--------------------

### Gems
Install bundler (`gem install bundler`) and then run `bundle` to install the rest from the included Gemfile:  
    berkshelf    - Manage cookbook dependencies  
    chef-spec    - Unit test framework for cookbooks  
    foodcritic   - Cookbook linting tool  
    knife-block  - Knife plugin to manage multiple chef organizations and validators 

http://bundler.io/  
http://berkshelf.com/  
https://github.com/sethvargo/chefspec  
http://www.foodcritic.io/  
https://github.com/greenandsecure/knife-block  

### Software
    Vagrant      - VM management tool for fast cookbook prototyping.  
    VirtualBox   - Virtual machine software from Oracle.  
    rvm	         - Manage multiple ruby versions on your workstation with rvm.  

http://www.vagrantup.com/  
https://www.virtualbox.org/  
https://rvm.io/  

#### Boxes
https://confluence.disney.com/display/Vagrant/VirtualBox+Box+Directory  
http://files.vagrantup.com/precise64.box  

##### Build your own boxes
https://github.com/jedi4ever/veewee  
-or-  
http://www.packer.io/

### Cookbooks
To enable minitests after a chef run, include minitest-handler in your node run-list. Chef-handler is required by minitest-handler.
    minitest-handler  
    chef-handler   
  
https://github.com/btm/minitest-handler-cookbook  
https://github.com/opscode-cookbooks/chef_handler  

Vagrant Plugins
---------------
    `vagrant plugin install vagrant-berkshelf`  
    `vagrant plugin install vagrant-omnibus`  
    `vagrant plugin install vagrant-butcher`  

    The berkshelf plugin uploads cookbooks in your berks file up to the chef server when you 'vagrant provision'.  
    The omnibus plugin installs chef on the vagrant vm for you automatically when you `vagrant provision`.  
    The butcher plugin deletes the vm's client and node objects from the chef server when you destroy the vm with `vagrant destroy`.

    https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugin  
    https://github.com/berkshelf/vagrant-berkshelf  
    https://github.com/schisamo/vagrant-omnibus  
    https://github.com/cassianoleal/vagrant-butcher  

Testing
-------
Please review the pre-requisites in the Requirements & Setup section.  
1. **Write tests**  
2. Make your changes/patches/fixes, committing appropriately  
3. Run the tests:  
    - `bundle exec foodcritic -f any .`  
    - `bundle exec rspec`  
    - `bundle exec rubocop`  
    - `bundle exec kitchen test`  

  In detail:  
    - Foodcritic will catch any Chef-specific style errors  
    - RSpec will run the unit tests  
    - Rubocop will check for Ruby-specific style errors  
    - Test Kitchen will run and converge the recipes  


Learn
-----
Rspec - http://rspec.codeschool.com/
Unit Tests - http://sethvargo.com/20130113/unit-testing-chef-cookbooks/
Wrapper Cookbooks - http://www.opscode.com/blog/2013/12/03/doing-wrapper-cookbooks-right/  

### What are these tests and how do I use them?
chefspec - Write unit tests for your cookbooks. run rspec in cookbook directory to perform tests.  
minitest-handler - Write acceptance/integration tests to be run on the converged node.  

Contributing
------------
1. Fork the repository on Github.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using Github.

License and Authors
-------------------
Jeff LaPlante - jeff@jefflaplante.com

