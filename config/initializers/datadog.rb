require 'ddtrace'

Datadog.configure do |c|
  c.tracing.instrument :rails, service_name: 'zajel-production'
end