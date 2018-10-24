# frozen_string_literal: true


class ReviewWorker
  include Sidekiq::Worker

  def perform(clone_url, branch)
    puts "Running for #{clone_url} on #{branch}"
    Repo.new(clone_url, branch).clone do |repo|

      formatters = [
        #Pronto::Formatter::GithubFormatter.new ,
        #Pronto::Formatter::GithubStatusFormatter.new
        Pronto::Formatter::TextFormatter.new
      ]
      Pronto.run('origin/master', '.', formatters)
    end
  end
end
