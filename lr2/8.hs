  {-
    8. Напишите функцию, вычисляющую наименьшее из двух целых чисел,
    без использования функции if/then/else.
    
    Указание.

    min(a, b) = (a + b) / 2 - |a - b| / 2
    min(a, b) = (a + b) / 2 - sqrt ((a - b)^2) / 2
  -}

  min1 :: Fractional a => a -> a -> a
  min1 a b = (a + b) / 2 - abs (a - b) / 2

  min2 :: Floating a => a -> a -> a
  min2 a b = (a + b) / 2 - sqrt ((a - b) ^^ 2) / 2

  -- Неудачные тестовые примеры:

  -- Определяет, равны ли значения аргументов, с точностью 10^-6
  eq :: (Ord a, Fractional a) => a -> a -> Bool
  eq a b = abs (a - b) <= 10 ^^ (-6)

  -- Проверяет истинность приближеенных равенств с
  -- использованием данной функции f
  testCase f =
    eq (f 0 0)             0 &&
    eq (f 0 1)             0 &&
    eq (f 0.0 1.0)       0.0 &&
    eq (f (-5.0) 3.0) (-5.0) &&
    eq (f 0.000002 0.000003) 0.000002 &&
    eq (f (10 ^ 30) (10 ^ 30 - 0.000001)) (10 ^ 30 - 0.000001)

  test = testCase min1 && testCase min2
