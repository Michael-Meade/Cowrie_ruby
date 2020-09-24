require_relative 'lib/cowrie'
class TimeUtils < LogParser
	def initialize file, j = nil, event_id = "cowrie.login.success", id
		@file = file
		@j = j
		@event_id = event_id
		@id       = id
	end
	def event_id
		@event_id
	end
	def id
		@id
	end
	def action
		case id.to_s
		when "time"
			time
		when "date"
			date
		end
	end
	def time
		"%I:%M:%S %p"
	end
	def date
		"%A"
	end
	def date_time
		parse = File.readlines(file)
		h = {}
		count = 0
		parse.each do |line|
			line = JSON.parse(line)
			if line["eventid"] == event_id
				weekday = DateTime.parse( line["timestamp"] )
				if !h.key?(weekday.strftime(action))
					h[weekday.strftime("#{action}")] = 1
				else
					h[weekday.strftime("#{action}")] += 1
				end
			end
		end
		if File.exists?("#{id}.json")
			read = File.read("#{id}.json")
			j    = JSON.parse(read)
			out  = j.merge(h)
		end
		File.open("#{id}.json", 'w') { |f| f.write(JSON.generate(out)) }
	end
end


a = TimeUtils.new(File.join("cowrie_logs", "9-21-2020-cowrie.json"), "date")
puts a.date_time