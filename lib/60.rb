File.open(ARGV[0], "r") do |infile|
  base = /(N[0-9]+W[0-9]+)/.match(File.basename(ARGV[0]))[0]
  (0..59).each do |lat|
    row1 = lat*60
    (0..59).each do |lon|
      col1 = lon * 60
      # this is the sub-square
      new_file =  "#{base}.#{'%02d' % lon}.#{'%02d' % lat}.json"
      File.open new_file, "w+" do |outfile| 
        outfile.puts "{ \"height\": ["
        comma = ","
        (0..59).each do |irow|
          pos = (row1 + irow)* 3600 + col1
          infile.pos = pos*6
          s = infile.read 60*6
          vals = s.split.map{|t| t.to_i}.map{|n| (n==32768)? 'null': n}
          comma = "" if irow == 59 
          outfile.puts "[#{vals.join ','}]#{comma}"
        end
        outfile.puts "]}"
      end
    end
  end
end
