def infix_to_rpn(expression)
  def precedence(operator)
    case operator
    when '+', '-' then 1
    when '*', '/' then 2
    else 0
    end
  end

  output = []
  stack = []

  tokens = expression.scan(/\d+|\+|\-|\*|\/|\(|\)/)

  tokens.each do |token|
    if token.match(/\d+/)
      output << token
    elsif token == '('
      stack << token
    elsif token == ')'
      while !stack.empty? && stack.last != '('
        output << stack.pop
      end
      stack.pop
    else
      while stack.any? && precedence(stack.last) >= precedence(token)
        output << stack.pop
      end
      stack << token
    end
  end

  while !stack.empty?
    output << stack.pop
  end

  return output
end

puts "Enter the mathematical expression: "
expression = gets.chomp
result = infix_to_rpn(expression)
puts result.join(' ')