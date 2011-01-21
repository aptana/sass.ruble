require 'ruble'

template "SASS Template" do |t|
  t.filetype = "*.sass"
  t.invoke do |context|
    ENV['TM_DATE'] = Time.now.strftime("%Y-%m-%d")
    raw_contents = IO.read("#{ENV['TM_BUNDLE_SUPPORT']}/../templates/template.sass")
    raw_contents.gsub(/\$\{([^}]*)\}/) {|match| ENV[match[2..-2]] }
 end
end