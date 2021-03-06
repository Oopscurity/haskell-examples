  {-
    5*. Напишите функцию,  конструирующую список из заданных списков
    [A1,A2,...,An] и [B1,B2,...,Bn] следующим образом:
    
    (1) если A1=Bn и An=B1, то [A2,...,An-1,B2,...,Bn-1];
    (2) если A1=Bn и An/=B1, то [A2,...,An,B1,...,Bn-1];
    (3) если A1/=Bn и An=B1, то [A1,...,An-1,B2,...,Bn];
    (4) в противном случае [A1,...,An,B1,...,Bn].
  -}
  import Prelude hiding ( concat )

  -- Определяет, равны ли значения аргументов, с точностью 10^-6
  eq :: (Ord a, Fractional a) => a -> a -> Bool
  eq a b = abs (a - b) <= 10 ^^ -6

  {-
    Склеивает данные списки a и b одинаковых числовых типов
    в зависимости от соответствия условиям (1)-(4) (с. 5-8).
  -}
  concat :: (Ord a, Fractional a) => [a] -> [a] -> [a]
  concat a b | left && right     = tail (init a) ++ tail (init b) -- (1)
             | left && not right = tail a ++ init b               -- (2)
             | not left && right = init a ++ tail b               -- (3)
             | otherwise         = a ++ b                         -- (4)
            where
              left  = eq (head a) (last b)
              right = eq (head b) (last a)

  -- Неудачные тестовые примеры:

  -- (1)
  test1 = concat [1, 2] [2, 1]                                   == [] &&
          concat [1, 2, 3] [3, 2, 1]                             == [2, 2] &&
          concat [1.0, 2.0, 3.0] [3.0, 2.0, 1.0]                 == [2.0, 2.0] &&
          concat [0.99999999, 2.0, 3.0] [3.0, 2.0, 1.0000000001] == [2.0, 2.0]

  -- (2)
  test2 = concat [10, 11] [13, 10]                                  == [11, 13] &&
          concat [3, 4, 8, 9] [2, 5, 3]                             == [4, 8, 9, 2, 5] &&
          concat [2.99999998, 4.0, 8.0] [9.0, 2.0, 5.0, 3.00000001] == [4.0, 8.0, 9.0, 2.0, 5.0]

  -- (3)
  test3 = concat [1, 0] [0, 4, 5]                          == [1, 4, 5] &&
          concat [1.0, -0.00000004] [0.00000004, 4.0, 5.0] == [1.0, 4.0, 5.0] &&
          concat [10^10, 10^20, 10^30] [10^30 - 0.0000003, 10^40] == [10^10, 10^20, 10^40]

  -- (4)
  test4 = concat [0.1, 0.9] [0.2]    == [0.1, 0.9, 0.2] &&
          concat [15, 90, 1] [-4, 8] == [15, 90, 1, -4, 8] &&
          concat [1.999, 8.0, 1.3] [1.9991, 8.0, 1.29997] == [1.999, 8.0, 1.3, 1.9991, 8.0, 1.29997]

  test = test1 && test2 && test3 && test4
