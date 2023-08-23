# # Questão 1

file_content = File.read('resolution/dados_input.rb')
file_binding = binding
file_binding.eval(file_content)

def solucao(arg)
  format_dados = arg.map do |item|
    name = if item[:name].to_s.length < 11
             item[:name].to_s.ljust(11)
           else
             item[:name].to_s[0, 11]
           end

    cpf = if item[:cpf].to_s.length < 11
            item[:cpf].to_s.ljust(11)
          else
            item[:cpf].to_s[0, 11]
          end

    state = if item[:state].to_s.length < 11
              item[:state].to_s.ljust(11)
            else
              item[:state].to_s[0, 11]
            end

    value = if item[:value].to_s.length < 11
              item[:value].to_s.ljust(11)
            else
              item[:value].to_s[0, 11]
            end
    "#{name}#{cpf}#{state}#{value}"
  end
  puts format_dados.join("\n")
end
solucao(file_binding.eval(file_content))
