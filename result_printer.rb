class ResultPrinter
   def initialize
      @status_image = []
      current_path = File.dirname(__FILE__)
      counter = 0

      while counter <= 7 do
         file_name = current_path + "/image/#{counter}.txt"
         begin
            f = File.new(file_name, "r:UTF-8")
            @status_image << f.read
            f.close
         rescue Errno::ENOENT
            @status_image << "\n [ изображение не найдено ]"
         end
         counter +=1
      end
   end


  def print_status(game)
    cls()
    puts "\nСлово "+ get_word_for_print(game.letters, game.good_letters)
    puts "Ошибки (#{game.errors_count}): #{game.bad_letters.join(", ")}"
    print_viselitsa(game.errors_count)

    case game.status
    when -1
      puts "Вы проиграли"
      puts "Загаданное слово: #{game.letters.join("")}"
    when 1 then puts "Прздравляем! Вы выиграли"
    when 0 then puts "У вас осталось попыток: #{7-game.errors_count}"
    end

  end

  def get_word_for_print(letters, good_letters)
    result = ""
    for letter in letters do
        if good_letters.include? letter
          result += letter + " "
        else
          result += "__"
        end
    end
    return result
  end


  def cls
    system "clear" or system "cls"
  end

  def print_viselitsa(errors)
     puts @status_image[errors]
  end

end
