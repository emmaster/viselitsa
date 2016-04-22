class Game

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors_count = 0
    @bad_letters = []
    @good_letters = []
    @status = 0 #0 в процессе, -1 проигрыш, 1 выигрыш
  end


  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Вы не ввели слово для игры"
    end
    return slovo.split("")
  end

  #1. ввод из консоли
  #2. изменение состояния игры
  def ask_next_letter
    puts "введите следубщую букву\n"
    letter = ""
    while letter == "" do
      letter = UnicodeUtils.upcase(STDIN.gets.chomp)
    end
    make_next_step(letter)
  end

  def make_next_step(letter)
    return nil unless @status == 0 #защитились от неправильного использования класса
    if @good_letters.include?(letter) || @bad_letters.include?(letter)
      return nil
    end

    if @letters.include?(letter) || (letter == "ё" && @letters.include?("е")) || (letter == "е" && @letters.include?("ё")) || (letter == "и" && @letters.include?("й")) || (letter == "й" && @letters.include?("и"))
      if letter == "ё" && @letters.include?("е")
        @good_letters << "е"
      elsif letter == "е" && @letters.include?("ё")
        @good_letters << "ё"
      elsif letter == "и" && @letters.include?("й")
        @good_letters << "й"
      elsif letter == "й" && @letters.include?("и")
        @good_letters << "и"
      else
        @good_letters << letter
      end

      if @good_letters.uniq.sort == @letters.uniq.sort
        @status = 1
      end
    else
      @bad_letters << letter
      @errors_count += 1
      @status = -1 if @errors_count >=7
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def errors_count
    @errors_count
  end

  def status
    @status
  end

end
