module Constraints
  class BackofficeSubdomain
    def self.matches?(request)
      request.subdomain == 'backoffice'
    end
  end
end
