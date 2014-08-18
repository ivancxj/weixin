module Grape
  module Formatter
    module Json
      class << self

        def call(object, env)
          # Jbuilder 返回的是string
          # 恢复到 grape 0.3.2的版本
          return object if object.is_a?(String)
          #return object.to_json if object.respond_to?(:to_json)
          MultiJson.dump(object)
        end

      end
    end
  end
end
