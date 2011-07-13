require 'rapide'
require 'time'

now = Time.now.to_i
message = ARGV[0]
number = ARGV[1]
puts "Sending #{message} to #{number}"
offline=false
if (File.exist?("/tmp/sms_status.txt")) then

   status =*open("/tmp/sms_status.txt")
   offline_til = status.find(Proc.new {"dummy:0"}){|line| line =~ /#{number}:/ }.gsub(/^[^:]*:/,'').to_i
   offline = offline_til > now
end
if (!offline) then
  Rapide.new.send(message, number); 
end
