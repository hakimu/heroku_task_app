# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

class QueueTimeDiagnostics
  def initialize(app)
    @app = app
  end
 
  def call(env)
    headers = env.keys.inject({}) do |memo, key|
      key = key.to_s
      memo[key] = env[key] if key.end_with?("START")
      memo
    end
 
    state = NewRelic::Agent::TransactionState.tl_get
    txn = state.current_transaction
 
    NewRelic::Agent.logger.debug "QueueTimeDiagnostics relevant headers: #{headers}"
    NewRelic::Agent.logger.debug "QueueTime Diagnostics now: #{Time.now.to_f}"
    NewRelic::Agent.logger.debug "QueueTime Diagnostics apdex_start: #{txn ? txn.apdex_start.to_f : 'unknown'}"
    @app.call(env)
  end
end

run Rails.application
