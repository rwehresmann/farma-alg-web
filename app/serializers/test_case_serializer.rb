class TestCaseSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :input, :output
end
