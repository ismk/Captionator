#!/usr/bin/ruby

# path = File.expand_path(File.join(File.dirname(__FILE__)))

output_folder = File.join(Dir.home,"Desktop","output_folder")
# org_folder = path + "/org_files"

# `mkdir -p #{Dir.home + "/" + output_folder} #{org_folder}`
# `mkdir -p #{Dir.home + "/" + output_folder}`

Dir.mkdir(output_folder) unless Dir.exist?(output_folder)

# files = Dir.glob("*.{srt,mp4}")
files = ARGV

# files.each do |file|
#   p "Renaming #{file}"
#   old_filename = file.dup
#   file.gsub!(/\s+/, '_')
#   file.gsub!(/['()]/, '')
#   p file
#   File.rename(path+"/"+old_filename, path+"/"+file)
# end

sliced = files.sort.each_slice(2).to_a

sliced.each do |sl|
  if sl.first[0..-5] == sl.last[0..-5]
    puts "#{sl.first} matched with its srt"
    puts "Commencing ffmpeg closed captioning command..."
    `/usr/local/bin/ffmpeg -i #{sl.first} -vf "subtitles=#{sl.last}:force_style='Fontsize=20,Borderstyle=3'" #{output_folder+"/"+sl.first.split("/").last}`
    # `mv #{sl.first} #{org_folder}`
    # `mv #{sl.last} #{org_folder}`
  else
    puts "#{sl.first} did not match with its srt file please check"
  end
end
