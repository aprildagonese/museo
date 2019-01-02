require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Curator, Curator.new
  end

  def test_it_starts_with_empty_artists
    curator = Curator.new

    assert_equal [], curator.artists
  end

  def test_it_starts_with_empty_photographs
    curator = Curator.new

    assert_equal [], curator.photographs
  end

end
