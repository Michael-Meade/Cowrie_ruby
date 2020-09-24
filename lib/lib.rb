require_relative 'log_parser'
module Cowrie
	class Commands
		def self.all(file)
			# uses SaveCommands
			SaveCommands.new(File.join("cowrie_logs", file)).get_all
		end
		def self.get_links(file)
			# only get links
			SaveCommands.new(File.join("cowrie_logs", file)).get_links
		end
		def self.get_commands(file)
			# get only commands
			SaveCommands.new(File.join("cowrie_logs", file)).get_commands
		end

	end
end
module Cowrie
	class Graph
		def self.pie_chart(file)
			SaveFile.new(nil).pie_chart(file)
		end
	end
end
module Cowrie
	class Time
		def self.date(file)
			DateTimes.new(File.join("cowrie_logs", file)).date_stats
		end
		def self.time(file)
			DateTimes.new(File.join("cowrie_logs", file)).time_stats
		end
	end
end
module Cowrie
	class TopTen
		def self.success_both(file)
			# runs both both success and failed.
			Success.new(File.join("cowrie_logs", file)).both
		end
		def self.success_failed(file)
			# runs the failed method. 
			Success.new(File.join("cowrie_logs", file)).failed
		end
		def self.success_success(file)
			# runs the successful method
			Success.new(File.join("cowrie_logs", file)).success
		end
		def self.daily(file, j, event_id)
			# takes input ( j & event_id ) and adds them to a single json file 
			# with the date
			SaveFile.new(File.join("cowrie_logs", file), j, event_id).top_ten_daily
		end
		def self.top_ssh(file)
			SaveFile.new(File.join("cowrie_logs", file)).top_ssh_hash
		end
		def self.top_ssh_hash(file)
			SaveFile.new(File.join("cowrie_logs", file)).top_ssh_hash
		end
		def self.top_password(file)
			SaveFile.new(File.join("cowrie_logs", file)).top_password
		end
		def self.top_username(file)
			SaveFile.new(File.join("cowrie_logs", file)).top_username
		end
		def self.date_stats(file)
			SaveFile.new(File.join("cowrie_logs", file)).date_stats
		end
	end
end




=begin

Cowrie::Commands.all("cowrie-9-21-2020.json")
Cowrie::TopTen.success_both("cowrie.json")
Cowrie::TopTen.success_failed("cowrie.json")
Cowrie::TopTen.success_success("cowrie.json")
Cowrie::TopTen.daily("cowrie.json", "src_ip", "cowrie.login.success")
Cowrie::TopTen.top_ssh("cowrie.json")
Cowrie::TopTen.top_ssh_hash("cowrie.json"),

Cowrie::SaveCommands.all("cowrie.json")
Cowrie::SaveCommands.get_links("cowrie.json")
Cowrie::SaveCommands.get_commands("cowrie.json")



Cowrie::TopTen.daily("cowrie.json", "password", "cowrie.login.success")

Cowrie::TopTen.daily("cowrie.json", "username", "cowrie.login.success")
Cowrie::Graph.pie_chart("top_ten_daily_password.json")
#Cowrie::TopTen.success_both("cowrie_8-31-2020.json")
Cowrie::TopTen.success_both("cowrie.json")
Cowrie::TopTen.success_success("cowrie.json")

=end
