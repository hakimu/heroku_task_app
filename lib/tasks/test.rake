require 'tasks/newrelic'
NewRelic::Agent.manual_start(:sync_startup => true)

task :demo do
   ::NewRelic::Agent.logger.debug("Running Rake task(s) in the #{Rails.env} environment")
  def adder(x,y)
    puts x + y
  end
  adder(50,5)
end