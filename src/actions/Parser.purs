module Actions.Parser where

import Prelude (($), (*>))
import Control.Alt ((<|>))
import Control.Apply (lift2)
import Control.Lazy (fix)
import Data.List (singleton)
import Data.Semigroup (append)
import Data.String.CodeUnits as CU
import Data.Traversable(class Foldable, foldMap)
import Global (readFloat)
import Text.Parsing.StringParser (Parser, runParser)
import Text.Parsing.StringParser.CodePoints (anyDigit, anyLetter, char, 
                                             oneOf, skipSpaces, string)
import Text.Parsing.StringParser.Combinators (between, many, many1, sepEndBy)
import Helpers.Combinators ((...))
import Helpers.Unicode ((∘), (⊙))
import Models.Exp(Exp(..))

toString ∷ ∀ f. Foldable f ⇒ f Char → String
toString = foldMap CU.singleton

symbol ∷ Parser Char
symbol = oneOf ['!', '#', '$', '%', '&', '|', '*', '+', '-', '/',
                ':', '<', '=', '>', '?', '@', '^', '_', '~', '"']

parseAtom ∷ Parser Exp
parseAtom = lift2 atom car cdr
  where
     atom = Atom ... append
     car  = (toString ∘ singleton) ⊙ (anyLetter <|> symbol)
     cdr  = toString ⊙ (many $ anyLetter <|> anyDigit <|> symbol)

parseNum ∷ Parser Exp
parseNum = (Num ∘ readFloat ∘ toString) ⊙ (many1 $ char '.' <|> anyDigit)

parseLs ∷ Parser Exp
parseLs = parens $ Ls ⊙ (skipSpaces *> sepEndBy parseExp skipSpaces)
  where parens = between (string "(") (string ")")

parseExp ∷ Parser Exp
parseExp = fix \p -> skipSpaces *> (parseLs <|> parseAtom <|> parseNum)
