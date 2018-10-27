# frozen_string_literal: true

class GithubWebhookProcessor
  def initialize(body)
    @body = body
  end

  def pull_request
    repo = json.dig("pull_request", "head", "repo", "full_name")
    branch = json.dig("pull_request", "head", "ref")
    clone_url = json.dig("pull_request", "head", "repo", "clone_url")

    puts "Queued up build for #{repo} #{branch}"

    ReviewWorker.perform_async(clone_url, branch)
  end

  def valid_signature?(hub_signature)
    Rack::Utils.secure_compare(signature, hub_signature)
  end

private

  def signature
    "sha1=#{sha1}"
  end

  def sha1
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GITHUB_WEBHOOK_SECRET'], @body)
  end

  def json
    @json ||= JSON.parse(@body)
  end
end
