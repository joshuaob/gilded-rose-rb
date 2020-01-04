require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def test_foo
    items = [Basic.new('foo', 0, 0)]
    GildedRose.new(items).update()
    assert_equal 'foo', items[0].name
  end

  def test_item_decreases_in_quality_before_sell_by_date
    items = [Basic.new('foo', 1, 1)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end

  def test_item_decreases_in_quality_twice_as_fast_after_sell_by_date
    items = [Basic.new('foo', -1, 2)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end

  def test_item_quality_is_never_negative
    items = [Basic.new('foo', -111, 0)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end

  def test_aged_brie_increases_in_quality_with_age
    items = [BackStagePass.new('Aged Brie', 1, 1)]
    GildedRose.new(items).update()
    assert_equal 2, items[0].quality
  end

  def test_back_stage_pass_item_increases_in_quality_by_2_when_within_10_days_of_sell_by_date
    items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 9, 1)]
    GildedRose.new(items).update()
    assert_equal 3, items[0].quality
  end

  def test_back_stage_pass_item_increases_in_quality_by_3_when_within_5_days_of_sell_by_date
    items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', 4, 1)]
    GildedRose.new(items).update()
    assert_equal 4, items[0].quality
  end

  def test_back_stage_pass_item_quality_drops_to_zero_after_concert
    items = [BackStagePass.new('Backstage passes to a TAFKAL80ETC concert', -1, 50)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end

  def test_sulfuras_never_decreases_in_quality
    items = [Legendary.new('Sulfuras, Hand of Ragnaros', -10, 80)]
    GildedRose.new(items).update()
    assert_equal 80, items[0].quality
  end

  def test_conjured_items_decreases_in_quality_twice_as_fast_as_normal_items_before_sell_by_date
    items = [Conjured.new('Conjured', 1, 2)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end

  def test_conjured_items_decreases_in_quality_twice_as_fast_as_normal_items_after_sell_by_date
    items = [Conjured.new('Conjured', -1, 4)]
    GildedRose.new(items).update()
    assert_equal 0, items[0].quality
  end
end
