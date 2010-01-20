require 'radrails'
require "sass_engine"

command 'Compile SASS' do |cmd|
  cmd.key_binding = 'M1+M2+r'
  cmd.scope = 'source.sass'
  cmd.output = :show_as_tooltip
  cmd.input = :document
  cmd.invoke do |context|
    SassEngine.new(ENV['TM_FILEPATH']).execute!
  end
end
