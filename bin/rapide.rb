require 'net/https'
require 'cgi'

class Rapide
  
  @con
  User_name='USER_NAME_HERE'
  Password='PASSWORD_HERE'
  Path='/servlet/HttpSendSMS' 
  OK_Response='S00001'

  def initialize
    @con=Net::HTTP.new('automate.rapide.co.uk',443)
    @con.use_ssl=true
    @con.verify_mode=OpenSSL::SSL::VERIFY_NONE
  end

  def send(message,number)
    escaped_message=CGI::escape(message)
    url="#{Path}\?username=#{User_name}&password=#{Password}&number=#{number}&message=#{escaped_message}"
      @con.get2(url) do |response|
      resp = response.body.strip!
      if (resp != OK_Response)
        raise "Unexpected Response from Rapide: #{resp}"
      else
        puts "Rapide sent #{message} to #{number}"
      end
    end
  end
end


#number="07876217756"
#message="hello chris"

#Rapide.new.send(message, number)



