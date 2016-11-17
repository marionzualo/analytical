module Analytical
  module Modules
    class Intercom
      include Analytical::Modules::Base

      def initialize(options={})
        super
        @tracking_command_location = :body_append
      end

      # Intercom identification is being done through the intercom-rails gem

      def event(*args) # name, options, callback
        <<-JS.gsub(/^ {10}/, '')
          if (typeof(Intercom) !== 'undefined') {
            try {
              Intercom('trackEvent', name, options || {});
            }
            catch (e) {
              // temporary patch to prevent Intercom from throwing JS errors
            }
            setTimeout(function() {
              Intercom('update');
            }, 2000);
          }
        JS
      end
    end
  end
end
