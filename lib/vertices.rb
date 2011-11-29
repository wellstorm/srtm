

hgt_dir = File.dirname __FILE__




if $0 == __FILE__
  options = {}
  opts =OptionParser.new do |o|
    o.banner = "Usage: vertices [options]"
    o.on("-r", "--url url", "URL of the scout ticket") do |v|
      options[:url] = v
    end
    o.on("-u", "--username USER", "HTTP user name (optional)") do |v|
      options[:user_name] = v
    end
    o.on("-p", "--password PASS", "HTTP password (optional)") do |v|
      options[:password] = v
    end
    o.on("-o", "--out OUTDIR", "Output directory where we will save these files") do |v|
      options[:dir] = v
    end
    o.on_tail("-h", "--help", "Show this message") do
      puts o
      exit
    end
  end
  opts.parse!
  if ( !options[:url] )
    puts(opts.help)
    exit 1
  end
  run_download options
end

