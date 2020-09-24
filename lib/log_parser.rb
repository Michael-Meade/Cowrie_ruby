require 'json'
require 'gruff'
require 'date'
require 'time'
require 'fileutils'


class LogParser
	def initialize file, j = nil, event_id = nil
		@file = file
		@j = j
		@event_id = event_id
	end
	def event_id
		@event_id
	end
	def j
		@j 
	end
	def file
		@file
	end
	
	def top_ten
		parse = File.readlines(file)
		h = {}
		parse.each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "#{event_id}"
				if not line["#{j}"].nil?
					if h.key?(line["#{j}"])
						h[line["#{j}"]] += 1
					else
						h[line["#{j}"]] = 1
					end
				end
			end
		end
	# sorts the keys and only gets the top 10
	h = h.sort_by{|k,v| -v}.first(10).to_h
	end
end
class SaveCommands < LogParser
	def get_links
		# This method will get all the links 
		# and save it into array
		h = []
		parse = File.readlines(file)
		parse.each do |line|
			line = JSON.parse(line)
			if line.key?("url")
				h |= [line["url"]]
			end
		end
	h
	end
	def get_commands
		# This method will get all the
		# commands and save it as array
		h = []
		parse = File.readlines(file)
		parse.each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "cowrie.command.input"
				if line.key?("input")
					h |= [line["input"]]
				end
			end
		end
	h
	end
	def get_all
		# This combines both the get_commands & 
		# get link method and takes the array and creates 
		# a hash.
		h = {} 
		links = get_links
		cmds  = get_commands
		[[ get_commands, "cmds" ] , [ get_links, "links" ]].each do |l|
			h[l[1]] = l[0]
		end
	time = Time.new
	File.open("commands-#{time.strftime("%m-%d-%Y")}.json", 'a') { |f| f.write(JSON.generate(h)) }
	end
end
class Success < LogParser
	def both
		g = Gruff::Pie.new(1000)
		g.hide_labels_less_than = 1
		g.title = "SSH Login Success Rate"
		# the failed and sucess methods are ran so
		# we can use the files they created later on.
		failed
		success
		time = Time.new
		data = []
		[["failed", "failed-#{time.strftime("%m-%d-%Y")}.json"], ["success", "success-#{time.strftime("%m-%d-%Y")}.json"]].each do |file|
			read = File.read(file[1])
			j    = JSON.parse(read)
			data << [file[0], j[time.strftime("%m-%d-%Y")][1].count]
	    end
	   data.each do |d|
	   	g.data(d[0], d[1])
	   end
	   g.write("Test.png")
	end
	def failed
		# Counts how many failed attempts there was
		h = {}
		a = []
		total_count = 0
		File.readlines(file).each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "cowrie.login.failed"
				if (line.key?("username") && line.key?("password"))
					a << [line["username"], line["password"]]
				end
			end
		end
	time = Time.new
	h[time.strftime("%m-%d-%Y")] = ["failed", a]
	File.open("failed-#{time.strftime("%m-%d-%Y")}.json", 'w') { |f| f.write(JSON.generate(h)) }
	end
	def success
		# Counts how many succesful attempts there was.
		h = {}
		a = []
		total_count = 0
		File.readlines(file).each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "cowrie.login.success"
				if (line.key?("username") && line.key?("password"))
					a << [line["username"], line["password"]]
				end
			end
		end
	time = Time.new
	# the key of the hash is todays date
	h[time.strftime("%m-%d-%Y")] = ["success", a]
	File.open("success-#{time.strftime("%m-%d-%Y")}.json", 'w') { |f| f.write(JSON.generate(h)) }
	end
end
class Utils
	def initialize file
		@file = file
	end
end
class DateTimes < LogParser
	def date_stats
		parse = File.readlines(file)
		h = {}
		count = 0
		parse.each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "cowrie.login.success"
				weekday = Date.parse( line["timestamp"] )
				if !h.key?(weekday.strftime('%A'))
					h[weekday.strftime('%A')] = 0
				else
					h[weekday.strftime('%A')] += 1
				end
			end
		end
		if File.exists?("dates.json")
			read = File.read("dates.json")
			j    = JSON.parse(read)
			out  = j.merge(h)
		end
		File.open("dates.json", 'w') { |f| f.write(JSON.generate(out)) }
	end
	def time_stats
		puts file
		parse = File.readlines(file)
		h = {}
		count = 0
		parse.each do |line|
			line = JSON.parse(line)
			if line["eventid"] == "cowrie.login.success"
				weekday = Date.parse( line["timestamp"] )
				if !h.key?(weekday.strftime("%I:%M:%S %p"))
					h[weekday.strftime("%I:%M:%S %p")] = 0
				else
					h[weekday.strftime("%I:%M:%S %p")] += 1
				end
			end
		end
		if File.exists?("time.json")
			read = File.read("time.json")
			j    = JSON.parse(read)
			out  = j.merge(h)
		end
		File.open("time.json", 'w') { |f| f.write(JSON.generate(out)) }
	end
end
class SaveFile < LogParser
	def top_ten_daily
		# This method is job is to get the top ten
		# it will save the output like top_ten_dailiy_password.json
		out = {}
		FileUtils.mkdir_p "#{j}"
		if !File.exists?("top_ten_daily_#{j}.json")
			File.open("top_ten_daily_#{j}.json", "a")
		end
		time = Time.new
		if File.read("top_ten_daily_#{j}.json").empty?
			f = File.open("top_ten_daily_#{j}.json", "a")
			out["#{time.strftime("%m-%d-%Y")}"] = [top_ten]
			File.open(File.join(j, "top_ten_daily_#{j}.json"), 'w') { |f| f.write(JSON.generate(out)) }
		else
			file = File.read(File.join(j, "top_ten_daily_password.json"))
			json = JSON.parse(file)
			json["#{time.strftime("%m-%d-%Y")}"] = [j, top_ten]
			File.open(File.join(j, "top_ten_daily_#{j}.json"), 'w') { |f| f.write(JSON.generate(json)) }
		end
	end
	def top_username(event_id = "cowrie.login.success")
		FileUtils.mkdir_p "username"
		# gets todays top password. Unlike the top_ten_daily it will not save all the information
		# in one file
		time = Time.new
		json = LogParser.new(file, "username", event_id).top_ten
		File.open(File.join("username",     "#{time.strftime("%m-%d-%Y")}-username.json"), 'w') { |f| f.write(JSON.generate(json)) }
		pie_chart2(File.join("username",    "#{time.strftime("%m-%d-%Y")}-username.json"), "Top Username")

	end
	def top_password(event_id = "cowrie.login.success")
		FileUtils.mkdir_p "password"
		# gets todays top password. Unlike the top_ten_daily it will not save all the information
		# in one file
		time = Time.new
		json = LogParser.new(file, "password", event_id).top_ten
		File.open(File.join("password",     "#{time.strftime("%m-%d-%Y")}-password.json"), 'w') { |f| f.write(JSON.generate(json)) }
		pie_chart2(File.join("password",    "#{time.strftime("%m-%d-%Y")}-password.json"), "Top Password")
	end
	def top_ssh_hash
		out = {}
		time = Time.new
		File.readlines(file).each do |line|
			line = JSON.parse(line)
			if line.key?("hassh")
				if !out.key?(line["hassh"])
					out[line["hassh"]] = 1
				else
					out[line["hassh"]] = out[line["hassh"]] += 1
				end
			end
		end
	time = Time.new
	File.open("hash_ssh-#{time.strftime("%m-%d-%Y")}.json", 'w') { |f| f.write(JSON.generate(out)) }
	
	end
	def pie_chart2(file_read, type)
		time = Time.new
		g = Gruff::Pie.new(1000)
	    #g.text_offset_percentage = 0.40
	    g.hide_labels_less_than = 1
	    read  = File.read(file_read)
	    j = JSON.parse(read)
	    #.sort_by{|k,v| -v}.first(10).to_h
	    g.title = "#{type}"
	    j.each do |data|
	    	g.data(data[0], data[1])
	    end
	    g.write("#{time.strftime("%m-%d-%Y")}-#{type}.png")
	end
	def bar_chart(file_read, title)
		time = Time.new
		g = Gruff::Bar.new(1000)
		g.title = title
		j = JSON.parse(File.read(file_read))
		j.each do |data|
			g.data(data[0], data[1])
		end
		g.write("#{time.strftime("%m-%d-%Y")}-#{title.gsub(" ", "-")}.png")
	end
	def pie_chart(file_read)
	    g = Gruff::Pie.new(1000)
	    #g.text_offset_percentage = 0.40
	    g.hide_labels_less_than = 1
	    read  = File.read(file_read)
	    j = JSON.parse(read)
	    j.each do |key, value|
	    	date = key
	    	type = value[0]
	    g.title = "#{type} - #{date}"
	    @type = type
	    end
	    j.each do |value|
	    	value[1][1].to_h.each do |key, value|
	    		g.data(key, value)
	    	end
	    end
	    time = Time.new
	    g.write("#{time.strftime("%m-%d-%Y")}-#{@type}.png")
	end

end
#SaveFile.new("cowrie.json.2020-08-19").pie_chart("top_ten_daily_src_ip.json")
#Succcess.new("cowrie.json.2020-08-19")
#s = SaveFile.new("cowrie.json.2020-08-19")
#a = SaveFile.new("cowrie.json.2020-08-19", "src_ip", "cowrie.login.success")
#puts a.top_ten_daily
#SaveFile.new("cowrie.json").top_ssh_hash
#a = SaveCommands.new("cowrie.json.2020-08-19")
#a.get_all