module RavenHelper
  def raven_js
    # :nocov:
    "Raven.config('#{ENV['SENTRY_PUBLIC_DSN']}').install();".safe_join if Rails.env.production?
    # :nocov:
  end
end
