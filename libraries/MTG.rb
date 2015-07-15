# utility library for functions usable
# throughout the recipe namespace
# Author: Jeff LaPlante, 2014
#

# Module to mix in to Chef::Recipe class
module MTG 
  module_function

  ###########################################################################
  # Determine if this node is a production node based on it's chef_environment
  #
  def is_production?
    %w(prod production).include?(node.chef_environment)
  end

#############################################################################
# Open the Chef::Recipe class and mix in the library module
#
  class Chef::Recipe
    include MTG
  end
end
