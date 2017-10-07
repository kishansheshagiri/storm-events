module EventsHelper
  def trim_number(number)
    i, f = number.to_i, number.to_f
    i == f ? i : f
  end
end
