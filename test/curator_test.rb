require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
require 'pry'

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"  }
    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941" }
    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967" }
    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962" }
    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France" }
    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States" }
    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States" }
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_empty_artists
    assert_equal [], @curator.artists
  end

  def test_it_starts_with_empty_photographs
    assert_equal [], @curator.photographs
  end

  def test_it_adds_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal 2, @curator.photographs.count
    assert_instance_of Photograph, @curator.photographs.first
    assert_instance_of Photograph, @curator.photographs.last
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  def test_it_adds_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal 2, @curator.artists.count
    assert_instance_of Artist, @curator.artists.first
    assert_instance_of Artist, @curator.artists.last
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_finds_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    henri = @curator.find_artist_by_id("1")

    assert_instance_of Artist, henri
    assert_equal "Henri Cartier-Bresson", henri.name
  end

  def test_it_finds_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    moonrise = @curator.find_photograph_by_id("2")

    assert_instance_of Photograph, moonrise
    assert_equal "Moonrise, Hernandez", moonrise.name
  end

  def test_it_finds_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id("3")
    photo3 = @curator.find_photograph_by_id("3")
    photo4 = @curator.find_photograph_by_id("4")

    assert_equal [photo3, photo4], @curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_finds_artists_with_multiple_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id("3")

    assert_equal [diane_arbus], @curator.artists_with_multiple_photographs
    assert_equal 1, @curator.artists_with_multiple_photographs.count
  end

  def test_it_finds_photographs_by_artist_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    photo1 = @curator.find_photograph_by_id("1")
    photo2 = @curator.find_photograph_by_id("2")
    photo3 = @curator.find_photograph_by_id("3")
    photo4 = @curator.find_photograph_by_id("4")

    assert_equal [photo2, photo3, photo4], @curator.photographs_taken_by_artist_from("United States")
    assert_equal [photo1], @curator.photographs_taken_by_artist_from("France")
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_loads_photographs
  end

  def test_it_loads_artists
  end 

end
