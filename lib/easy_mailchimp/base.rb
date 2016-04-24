module EasyMailchimp
  class Base
    def initialize
      @config = ::EasyMailchimp.config
      @logger = ::EasyMailchimp::Logger.new(@config.logger)

      @gibbon = ::Gibbon::Request.new({
        api_key: @config.api_key,
        api_endpoint: endpoint,
        timeout: 60
      })
    end

    attr_reader :logger

    def create_member(list_id, info = {})
      email = info[:email] || ''
      first_name = info[:first_name] || ''
      last_name = info[:last_name] || ''

      begin
        @gibbon.lists(list_id).members.create({
          body:
          {
            email_address: email,
            status: 'subscribed',
            merge_fields: {FNAME: first_name, LNAME: last_name}
          }
        })
      rescue ::Gibbon::MailChimpError => ex
        logger.info("ERROR: #{ex.message} - #{ex.raw_body}", 'Mailchimp::Base#create_member')
        raise
      end
    end

    def get_list_name(list_id)
      list_map = {}

      lists = @gibbon.lists.retrieve['lists']
      lists.map { |hsh| list_map[hsh["id"]] = hsh["name"] }

      list_map.select { |k,v| k == list_id }.values.first
    rescue => ex
      logger.info("ERROR: #{ex.message}", 'Mailchimp::Base#get_list_name')
      raise
    end

    private
    def endpoint
      @config.api_endpoint.gsub('{{dc}}', datacenter_from(@config.api_key))
    end

    def datacenter_from(token)
      token.match(/\-([a-z\d]+)\z/)
      return $~[1] if $~

      ""
    end
  end
end

