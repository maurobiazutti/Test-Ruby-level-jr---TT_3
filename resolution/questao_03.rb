require 'yaml'
require 'byebug'


file_content = File.read('resolution/dados_input.rb')
file_binding = binding
file_binding.eval(file_content)