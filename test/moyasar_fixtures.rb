require 'yaml'
require 'erb'
require 'ostruct'

module MoyasarFixtures
  # Return the path to the JSON fixtures directory
  def fixtures_dir
    File.join File.dirname(__FILE__), "fixtures"
  end

  # Return a filename for a JSON fixture
  def fixture_file(filename)
    File.join fixtures_dir, "#{filename}.yml"
  end

  # Return the contents of a fixture as a Hash
  def fixture_hash(filename, data: {})
    file = File.read fixture_file(filename)
    YAML.load render_erb(file, data)
  end
  
  def render_erb(file, data)
    namespace = OpenStruct.new(data)
    ERB.new(file).result(namespace.instance_eval { binding })
  end

end