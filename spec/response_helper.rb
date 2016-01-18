module ResponseHelper
  def jsonp_response(data, callback)
    "/**/#{callback}(#{data.to_json})"
  end
end
