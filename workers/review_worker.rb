# frozen_string_literal: true


class ReviewWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(clone_url, branch)
    puts "Running for #{clone_url} on #{branch}"
    Repo.new(clone_url, branch).clone do |repo|

      formatters = [
        Pronto::Formatter::GithubPullRequestReviewFormatter.new,
        Pronto::Formatter::TextFormatter.new,
      ]
      Pronto.run('origin/master', '.', formatters)
    end
  end
end
