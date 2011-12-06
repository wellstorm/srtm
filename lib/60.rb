require 'optparse'
require 'fileutils'

FILE_COLS = 3601
options = {}
opts =OptionParser.new do |o|
  o.banner = "Usage: 60.rb [-o outdir] tilefiles..."
  o.on("-o", "--outdir path", "Directory in which to deposit the output files") do |v|
    options[:o] = v
  end
end

opts.parse!

outdir_base = options[:o] || "."

File.open(ARGV[0], "r") do |infile|
  base = /(N[0-9]+W[0-9]+)/.match(File.basename(ARGV[0]))[0]


  FileUtils.mkdir_p "#{outdir_base}/#{base}"

  # the hgt base name designates the lower left corner of the tile
  # W longitudes march from 59 mins downto 0
  (0..59).each do |lat|
    row1 = lat*60
    (0..59).each do |lon|
      col1 = lon * 60


      # this is the sub-square
      # extract subsquare of size 61x61
      # Since longitude minutes march down, make output file name reflect that
      new_file =  "#{outdir_base}/#{base}/#{base}.#{'%02d' % (59 - lon)}.#{'%02d' % lat}.json"

      File.open new_file, "w+" do |outfile| 
        outfile.puts "{ \"height\": ["
        comma = ","
        (0..(59+1)).each do |irow|
          pos = (row1 + irow)* FILE_COLS + col1
          infile.pos = pos*6
          s = infile.read (60+1)*6   
          vals = s.split.map{|t| t.to_i}.map{|n| (n==32768)? 'null': n}
          comma = "" if irow == (59+1) 
          outfile.puts "[#{vals.join ','}]#{comma}"
        end
        outfile.puts "]}"
      end
    end
  end
end
