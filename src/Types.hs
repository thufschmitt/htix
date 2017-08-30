module Types where

import Types.SetTheoretic

import qualified Types.Arrow as Arrow
import qualified Types.Intervals as Intervals

data T = T { arrows :: Arrow.T T
           , ints :: Intervals.T
           }
           deriving (Eq, Ord, Show)

map2 :: (Arrow.T T -> Arrow.T T -> Arrow.T T)
       -> (Intervals.T -> Intervals.T -> Intervals.T)
       -> T -> T -> T
map2 fA fI t1 t2 = T { arrows = fA (arrows t1) (arrows t2)
                     , ints = fI (ints t1) (ints t2)
                     }

instance SetTheoretic_ T where
  empty = T { arrows = empty
            , ints = empty
            }

  full = T { arrows = full
           , ints   = full
           }

  cup = map2 cup cup
  cap = map2 cap cap
  diff = map2 diff diff

instance SetTheoretic T where
  sub t1 t2 =
    sub (arrows t1) (arrows t2) &&
    sub (ints t1) (ints t2)
