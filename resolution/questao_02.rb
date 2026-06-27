require 'yaml'
require 'byebug'


file_content = File.read('resolution/dados_input.rb')
file_binding = binding
file_binding.eval(file_content)

class HashesToString
  def initialize(arg)
    @hashes = arg
    @app_config = YAML.load_file('resolution/format_2.yml')
  end

  def hashes_to_string
    result_string = ''

    @hashes.each do |i|
      name  = i[:name]
      cpf   = i[:cpf]
      state = i[:state]
      value = i[:value]

      # NAME
      if @app_config.key? 'name'
        length = @app_config['name']['length'].to_i
        align = @app_config['name']['align']
        padding = @app_config['name']['padding'] == 'spaces' ? ' ' : '0'
        name_f = if align == 'left'
                   name[0...length].ljust(length, padding)
                 else
                   name.rjust(length, padding)
                 end
      end

      # CPF
      if @app_config.key? 'cpf'
        length = @app_config['cpf']['length'].to_i
        align = @app_config['cpf']['align']
        padding = @app_config['cpf']['padding'] == 'spaces' ? ' ' : '0'
        cpf_f = if align == 'left'
                  cpf[0...length].ljust(length, padding)
                else
                  cpf.rjust(length, padding)
                end
      end

      # STATE
      if @app_config.key? 'state'
        length = @app_config['state']['length'].to_i
        align = @app_config['state']['align']
        padding = @app_config['state']['padding'] == 'spaces' ? ' ' : '0'
        state_f = if align == 'left'
                    state[0...length].ljust(length, padding)
                  else
                    state.rjust(length, padding)
                  end
      end

      # VALUE
      if @app_config.key? 'value'
        length = @app_config['value']['length'].to_i
        align = @app_config['value']['align']
        padding = @app_config['value']['padding'] == 'spaces' ? ' ' : '0'
        value_f = if align == 'left'
                    value[0...length].ljust(length, padding)
                  else
                    value.rjust(length, padding)
                  end
      end

      result_string += "#{cpf_f}#{name_f}#{value_f}#{state_f} \n"
    end
    puts result_string
  end
end
formatter = HashesToString.new(file_binding.eval(file_content))
formatted_string = formatter.hashes_to_string
formatted_string

################### Solução 02 ###################

require 'yaml'

def solucao(arg, yaml_config_path)
  # 1. Carrega as configurações do arquivo YAML
  config = YAML.load_file(yaml_config_path)

  arg.map do |item|
    linha = ""

    # 2. Itera sobre as chaves do YAML para garantir a ordem configurada
    config.each do |campo, regras|
      # Garante que o valor vire string e busca do hash (suporta chave string ou symbol)
      valor = (item[campo.to_sym] || item[campo]).to_s

      length  = regras['length'].to_i
      align   = regras['align']
      padding = regras['padding'] == 'zeroes' ? '0' : ' '

      # 3. Trunca o valor se ele for maior que o permitido
      valor = valor[0...length]

      # 4. Aplica o alinhamento e o padding dinamicamente
      if align == 'right'
        valor = valor.rjust(length, padding)
      else
        valor = valor.ljust(length, padding)
      end

      # Junta o campo formatado na linha atual
      linha << valor
    end

    linha
  end.join("\n")
end


# Saida  format_1.yml
# 97905796671Maria Neusa de00001234
# 44010762900Ricardo Fontes00000567
# 80107290   Rick          00000157

# Saida  format_2.yml
# 0009790579667100001234Sao Paulo
# 0004401076290000000567Rio Grande do
# 0000008010729000000157Rio