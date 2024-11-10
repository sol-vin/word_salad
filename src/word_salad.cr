class WordSalad(N)
  DEFAULT_SIZE = 3
  alias Default = WordSalad(DEFAULT_SIZE)
  @current : StaticArray(UInt32, N) = StaticArray(UInt32, N).new(0_u32)

  def next : String
    words = [] of String
    N.times do |n|
      words << WordSalad::Resources.words[@current[(N-1)-n]]
    end

    @current[0] += 1
    x = 0
    while @current[x] >= WordSalad::Resources.words.size && x < N
      @current[x] = 0
      raise "Overflow" if x+1 >= N
      @current[x+1] += 1
      x += 1
    end

    words.join(".")
  end

  def random
    words = [] of String
    N.times do |n|
      words << WordSalad::Resources.words[rand(WordSalad::Resources.words.size)]
    end
    words.join(".")
  end
end

module WordSalad::Resources
  VERSION = "0.1.0"

  class_getter words = [] of String

  def self.load
    load_from("./rsrc/words.txt")
  end

  def self.load_from(path : String)
    File.open("./rsrc/words.txt", "r") do |f|
      @@words = f.gets_to_end.lines
    end
  end

  def self.load_from(path : Path)
    load_from(path.to_s)
  end
end

WordSalad::Resources.load
puts "WordSalad(#{WordSalad::DEFAULT_SIZE}) - Total ID Space: #{WordSalad::Resources.words.size.to_u64**WordSalad::DEFAULT_SIZE}"

w = WordSalad::Default.new

puts w.random
puts w.random
puts w.random
puts w.random
puts w.random



