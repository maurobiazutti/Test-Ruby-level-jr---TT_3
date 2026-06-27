require 'yaml'
require 'byebug'


file_content = File.read('resolution/dados_input.rb')
file_binding = binding
file_binding.eval(file_content)

############## Solução 3 ##################


require 'yaml'

def solucao(string_input, yaml_config_path)
  # 1. Carrega as configurações do YAML
  config = YAML.load_file(yaml_config_path)
  
  resultado = {}
  cursor = 0 # Ponteiro que indica onde começa o campo atual na string

  # 2. Itera sobre a estrutura do YAML para fatiar a string na ordem correta
  config.each do |campo, regras|
    length = regras['length'].to_i
    padding = regras['padding']

    # 3. Recorta o pedaço exato da string correspondente ao campo
    pedaco = string_input[cursor, length]
    
    # 4. Limpa o padding dependendo do tipo configurado
    if padding == 'zeroes'
      # Remove zeros à esquerda. Se o valor for todo de zeros (ex: "0000"), 
      # garante que retorne "0" ou uma string vazia conforme a regra de negócio.
      pedaco = pedaco.sub(/^0+/, '')
      pedaco = '0' if pedaco.empty? # Tratamento caso o valor original fosse 0
    else
      # 'spaces' ou qualquer outro padding padrão limpa os espaços das pontas
      pedaco = pedaco.strip
    end

    # 5. Alimenta o hash final usando a chave como Symbol (como pede o teste)
    resultado[campo.to_sym] = pedaco

    # 6. Avança o cursor para o início do próximo campo
    cursor += length
  end

  resultado
end