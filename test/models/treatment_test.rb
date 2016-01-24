require 'test_helper'

class TreatmentTest < ActiveSupport::TestCase
  def setup
    @treatment = Treatment.new(name: "Test Treatment")
  end

  test "should be valid with just a name" do
    assert @treatment.valid?
  end

  test "name must be present" do
    @treatment.name = "            "
    assert_not @treatment.valid?
  end

  test "courses should be required, an integer, and greater than 0" do
    @treatment.courses = nil
    assert_not @treatment.valid?
    @treatment.courses = "     "
    assert_not @treatment.valid?
    @treatment.courses = 0
    assert_not @treatment.valid?
    @treatment.courses = "asdf"
    assert_not @treatment.valid?
    @treatment.courses = 1.5
    assert_not @treatment.valid?
  end

  test "if courses is 1, min_/max_spacing_weeks is not required" do
    @treatment.courses = 1
    @treatment.min_spacing_weeks = nil
    @treatment.max_spacing_weeks = nil
    assert @treatment.valid?
  end

  test "if courses is great than 1, min_/max_spacing_weeks is required" do
    @treatment.courses = 2
    @treatment.min_spacing_weeks = nil
    @treatment.max_spacing_weeks = nil
    assert_not @treatment.valid?
  end

  test "if courses is 1, min_/max_spacing_weeks should not exist" do
    @treatment.courses = 1
    @treatment.min_spacing_weeks = 1
    @treatment.max_spacing_weeks = 2
    assert_not @treatment.valid?
  end

  test "min_/max_spacing_weeks should be required, an integer, and greater than 0" do
    @treatment.courses = 2
    @treatment.min_spacing_weeks = nil
    @treatment.max_spacing_weeks = 1
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 1
    @treatment.max_spacing_weeks = nil
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = nil
    @treatment.max_spacing_weeks = nil
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 0
    @treatment.max_spacing_weeks = 1
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 1
    @treatment.max_spacing_weeks = 0
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 0
    @treatment.max_spacing_weeks = 0
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 1.25
    @treatment.max_spacing_weeks = 1
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 1
    @treatment.max_spacing_weeks = 1.25
    assert_not @treatment.valid?
    @treatment.min_spacing_weeks = 1.25
    @treatment.max_spacing_weeks = 1.25
    assert_not @treatment.valid?
  end
end
