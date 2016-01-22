#!/usr/bin/ruby

output_folder = File.join(Dir.home,"Desktop","output_folder")

Dir.mkdir(output_folder) unless Dir.exist?(output_folder)
conv_report = []
nonconv_report = []

files = ARGV

sliced = files.sort.each_slice(2).to_a

sliced.each do |sl|
  if sl.first[0..-5] == sl.last[0..-5]
    puts "#{sl.first} matched with its srt"
    puts "Commencing ffmpeg closed captioning command..."
    `/usr/local/bin/ffmpeg -i #{sl.first} -vf "subtitles=#{sl.last}:force_style='Fontsize=20,Borderstyle=3'" #{output_folder+"/"+sl.first.split("/").last}`
    conv_report << File.basename(sl.first[0..-5])
  else
    puts "#{sl.first} did not match with its srt file please check"
    nonconv_report << File.basename(sl.first[0..-5])
  end
end

puts "########################## REPORT ########################"
puts "Total Files Dropped into: #{sliced.count}"
puts "Number of Files successfully captionized: #{conv_report.count}"
puts "Files successfully captionized #{conv_report}"
p "##################################################"
puts "Number of File that did not caption: #{nonconv_report.count}"
puts "Files that did not caption: #{nonconv_report}"
