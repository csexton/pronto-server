# frozen_string_literal: true

require "bundler"
Bundler.require

ENV['PRONTO_GITHUB_ACCESS_TOKEN'] ||= ENV['GITHUB_ACCESS_TOKEN']
APP_ROOT = File.dirname(__FILE__)
VIEW_ROOT = APP_ROOT + "/views"

require_relative "models/repo"
require_relative "models/github_webhook_processor"
require_relative "models/github_admin"
require_relative "workers/review_worker"
require_relative "controllers/root_controller"
require_relative "controllers/webhook_controller"
require_relative "controllers/github_settings_controller"

