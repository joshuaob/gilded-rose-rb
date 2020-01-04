class GildedRose
  def initialize(items)
    @items = items
  end

  def update
    @items.each do |item|
      item.update_sell_in
      item.update_quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Basic < Item
  def update_quality
    if quality < 50
      sell_in < 0 ? self.quality -= 2 : self.quality -= 1
    end 
    self.quality = 0 if quality < 0
  end

  def update_sell_in
    self.sell_in = sell_in - 1
  end
end

class Legendary < Item
  def update_quality
  end

  def update_sell_in
    self.sell_in = sell_in - 1
  end
end

class BackStagePass < Item
  def update_quality
    if quality < 50
      self.quality = quality + 1

      if name == 'Backstage passes to a TAFKAL80ETC concert'
        if sell_in < 11
          if quality < 50
            self.quality = quality + 1
          end
        end
        if sell_in < 6
          if quality < 50
            self.quality = quality + 1
          end
        end
      end
    end

    if sell_in < 0
      if name != 'Aged Brie'
        if name != 'Backstage passes to a TAFKAL80ETC concert'
          if quality > 0
            if name != 'Sulfuras, Hand of Ragnaros'
              self.quality = quality - 1
            end
          end
        else
          self.quality = quality - quality
        end
      end
    end
  end

  def update_sell_in
    self.sell_in = sell_in - 1
  end
end

class Conjured < Item
  def update_quality
    if quality < 50
      sell_in < 0 ? self.quality -= 4 : self.quality -= 2
    end
    self.quality = 0 if quality < 0
  end

  def update_sell_in
    self.sell_in = sell_in - 1
  end
end
