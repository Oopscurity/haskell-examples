  -- Задание 2.8
  -- Напишите функцию,  которая по знаку арифметической  операции
  -- выводит её название. Например, "+" - сложение.

  -- прим. Лексема оператора может состоять из нескольких символов,
  --   поэтому тип аргумента - строка

  getOperatorName :: String -> String
  getOperatorName o = case (o) of
                          "+" -> "сложение"
                          "-" -> "вычитание"
                          "*" -> "умножение"
                          "/" -> "деление"
                          "^" -> "возведение в степень"
                          _   -> "неизвестный оператор"


  check :: (String, String) -> Bool
  check (o, r) = getOperatorName o == r

  test = all check [
             ("+", "сложение")
           , ("-", "вычитание")
           , ("*", "умножение")
           , ("/", "деление")
           , ("^", "возведение в степень")
           , ("?", "неизвестный оператор")
         ]
