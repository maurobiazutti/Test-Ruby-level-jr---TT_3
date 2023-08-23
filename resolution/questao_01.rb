input = [
  {
    name: 'Maria Neusa de Aparecida',
    cpf: '97905796671',
    state: 'Sao Paulo',
    value: '1234'
  },
  {
    name: 'Ricardo Fontes',
    cpf: '44010762900',
    state: 'Rio Grande do Sul',
    value: '567'
  },
  {
    name: 'Rick',
    cpf: '88010762900',
    state: 'Rio',
    value: '157'
  }
]

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
  format_dados.join("\n")
end
puts solucao(input)
