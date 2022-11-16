module ApplicationHelper

  def date_select_params_to_date(name)
    begin
      Date.new(params["#{name}(1i)"].to_i, params["#{name}(2i)"].to_i, params["#{name}(3i)"].to_i)
    rescue
    end
  end
end
