newtype NumPlayers = Num

data Board where 
  Grid  :: Num -> Maybe Num -> Board
  Hex   :: Num -> Maybe Num -> Board
  Tri   :: Num -> Maybe Num -> Board
  Graph :: [(Num, Num)] -> Board

newtype Game = NumPlayers -> [Piece] -> [Board] -> [Rule]

data Rule = StartRule | EndRule 


data Type = Circle | Square | Moon | Heart | Dart | Kite

data Player where
  P :: Num -> Player 
  T :: Num -> Player 
  Ally :: Player
  Enemy :: Player
  PAt :: Loc -> Player
  None :: Player
  All :: Player
  Mover :: Player
  NonMover :: Player
  Prev :: Player
  Next :: Player


data Action where 
  Add    :: Piece -> Loc -> Action 
  Hop    :: Loc -> Direction -> Loc -> Action 
  Leap   :: Loc -> Dir -> Loc -> Action 
  Move   :: Loc -> Loc -> Bool -> Bool -> Action 
  Pass   :: Action 
  Remove :: Piece -> Bool -> Action 
  Select :: Loc -> Action 
  Shoot  :: Piece -> Dir -> Action 
  Slide  :: Loc -> Dir -> Action 
  Step   :: Loc -> Dir -> Loc Action 
  Change :: Piece -> Piece -> Action 
  If     :: Bool -> Action -> Action -> Action
  XOf    :: Num -> [Action] -> Action
  Any    :: [Action] -> Action
  All    :: [Action] -> Action
  
  
data Settable = Score | Value | State | Var
  
data Effect where 
  Set :: Maybe Player -> Num -> Settable -> Effect 
  Add :: Piece -> Loc -> Effect 
  Remove :: Piece -> Bool -> Effect 
  Move :: Loc -> Loc -> Bool -> Bool -> Effect 
  Custodial :: Dir -> Maybe Num -> Effect 
  Sow :: Dir -> Loc -> Effect 
  MoveAgain :: Effect 
  Hide :: Loc -> Effect 
  Show :: Loc -> Effect 
  
data Piece where
  Piece :: Type -> Player -> Loc -> Piece 
  WhatAt :: Loc -> Piece 
  
data Num where 
  Lit        :: Int -> Num 
  State      :: Player -> Num 
  Value      :: Player -> Num 
  Score      :: Player -> Num 
  NumGroups  :: Player -> Num 
  PNumPieces :: Player -> Num 
  Var        :: Str -> Num 
  Random     :: Num -> Maybe Num -> Num
  Get        :: [Num] -> Num -> Num 
  Size       :: [a] -> Num 
  NumPlayers :: Num
  NumTurns   :: Num
  NumLegalMoves :: Num
  Add :: Num -> Num -> Num 
  Sub :: Num -> Num -> Num 
  Mul :: Num -> Num -> Num 
  Div :: Num -> Num -> Num 
  Mod :: Num -> Num -> Num 
  If  :: Bool -> Num -> Num -> Num 
  And :: Num -> Num -> Num 
  Or :: Num -> Num -> Num 
  Xor :: Num -> Num -> Num 
  Pow :: Num -> Num -> Num 
  Max :: Num -> Num -> Num 
  Min :: Num -> Num -> Num 
  Abs :: Num -> Num 
  Neg :: Num -> Num 
  Lg2 :: Num -> Num 
  SizeGroup :: Loc -> Num 
  LNumPieces :: Loc -> Num 
  
  
newtype Map = [(Obj, Obj)]

type Obj = Player | Loc | Int | Piece 


data End where 
  Score :: (Player -> Int) -> End 
  Cond  :: [(Bool -> Player)] -> End 

data Dir where 
  Orth :: Dir   
  Diag :: Dir   
  Adj  :: Dir 
  Left :: Dir 
  Right :: Dir 
  Up :: Dir 
  Down :: Dir 
  Leftward :: Dir 
  Rightward :: Dir 
  Upward :: Dir 
  Downward :: Dir 
  
  
  
  
  
  
  
  
  
  
  
  
  