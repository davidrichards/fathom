require 'test_helper'

include Fathom

describe Entity do

  subject { Entity.new }

  it "can hydrate" do
    subject = Entity.hydrate(name: :name)
    assert subject
  end

  it "can hydrate from JSON" do
    json = JSON(test: :this)
    subject = Entity.from_json(json)
    assert subject
  end

  it "can hydrate from yaml" do
    yaml = YAML.dump(test: :this)
    subject = Entity.from_yaml(yaml)
    assert subject
  end

  it "can hydrate from a json file" do
    subject = Entity.from_file(simple_factor_json_filename)
    assert subject
  end

  it "can hydrate from a yaml file" do
    subject = Entity.from_file(simple_factor_yaml_filename)
    assert subject
    subject = Entity.from_file(simple_factor_yml_filename)
    assert subject
  end
end
