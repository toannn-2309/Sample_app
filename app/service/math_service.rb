class MathService
  def initialize params
    @number_one = params[:number_one].to_i
    @number_two = params[:number_two].to_i
    @operator = params[:operator]
  end

  def perform
    check_condition_math
    do_math
  end

  private

  def check_condition_math
    # check some condition for math
  end

  def do_math
    @number_one.send operator, @number_two
  rescue NoMethodError
    operator
  end

  def operator
    case @operator
    when "Addition"
      :+
    when "Subtraction"
      :-
    when "Multiplication"
      :*
    when "Division"
      :/
    else
      "invalid operator"
    end
  end
end
