#++
# Copyright (c) 2007-2012, merriweather Commerce, Inc. and other contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice,
#       this list of conditions and the following disclaimer in the documentation
#       and/or other materials provided with the distribution.
#     * Neither the name of the merriweather Commerce, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived from this
#       software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#--

require 'rails/all'
require 'rails/generators'
require 'state_machine'
require 'paperclip'
require 'kaminari'
require 'awesome_nested_set'
require 'acts_as_list'
require 'active_merchant'
require 'ransack'
require 'jquery-rails'
require 'deface'
require 'cancan'
require 'select2-rails'
require 'merriweather/money'
require 'rabl'

module Merriweather

  mattr_accessor :user_class

  def self.user_class
    if @@user_class.is_a?(Class)
      raise "Merriweather.user_class MUST be a String object, not a Class object."
    elsif @@user_class.is_a?(String)
      @@user_class.constantize
    end
  end

  module Core
  end

  # Used to configure Merriweather.
  #
  # Example:
  #
  #   Merriweather.config do |config|
  #     config.site_name = "An awesome Merriweather site"
  #   end
  #
  # This method is defined within the core gem on purpose.
  # Some people may only wish to use the Core part of Merriweather.
  def self.config(&block)
    yield(Merriweather::Config)
  end
end

require 'merriweather/core/ext/active_record'

require 'merriweather/core/delegate_belongs_to'

require 'merriweather/core/responder'
require 'merriweather/core/respond_with'
require 'merriweather/core/ssl_requirement'
require 'merriweather/core/store_helpers'
require 'merriweather/core/file_utilz'
require 'merriweather/core/calculated_adjustments'
require 'merriweather/core/current_order'
require 'merriweather/core/mail_settings'
require 'merriweather/core/mail_interceptor'
require 'merriweather/core/middleware/redirect_legacy_product_url'
require 'merriweather/core/middleware/seo_assist'
require 'merriweather/core/permalinks'
require 'merriweather/core/token_resource'
require 'merriweather/core/s3_support'

silence_warnings do
  require 'merriweather/core/authorize_net_cim_hack'
end

require 'merriweather/core/version'

require 'merriweather/core/engine'
require 'generators/merriweather/dummy/dummy_generator'

ActiveRecord::Base.class_eval do
  include Merriweather::Core::CalculatedAdjustments
  include CollectiveIdea::Acts::NestedSet
end

if defined?(ActionView)
  require 'awesome_nested_set/helper'
  ActionView::Base.class_eval do
    include CollectiveIdea::Acts::NestedSet::Helper
  end
end

ActiveSupport.on_load(:action_view) do
  include Merriweather::Core::StoreHelpers
end
