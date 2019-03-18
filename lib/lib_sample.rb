module LibSample
  if defined?(Rails)
    require 'lib_sample/engine'
  else
    require 'lib_sample/hola_mundo'
  end
end
