require_relative 'lib/cowrie'

=begin
	
	Gets top ten. Saves that in a file named: username/9-16-2020-username.json..
	Takes the output and makes it in a pie chart. saves pie chat as: 09-16-2020-username.png

=end

Cowrie::TopTen.top_username(File.join("cowrie_logs", "9-20-2020-cowrie.json"))