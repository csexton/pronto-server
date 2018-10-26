# frozen_string_literal: true

require 'rugged'

# Repo
#
# Service object for cloning a repo locally
#
class Repo
  def initialize(url, branch)
    @branch = branch
    @token = ENV.fetch('GITHUB_ACCESS_TOKEN')
    @url = url
  end

  def clone
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        Rugged::Repository.clone_at(@url, dir, options)
        yield self
      end
    end
  end

  def options
    {
      credentials: credentials,
      checkout_branch: @branch,
    }
  end

  def credentials
    Rugged::Credentials::UserPassword.new(username: @token, password: "")
  end
end
