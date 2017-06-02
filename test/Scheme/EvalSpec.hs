module Scheme.EvalSpec (main, spec, {-quickSpec-}) where

import Test.Hspec
import Test.QuickCheck
import Scheme.Eval
import Scheme.Env
import Scheme.Types
import Text.ParserCombinators.Parsec
import System.IO.Unsafe
import Data.Maybe
import Data.Array
import Data.Either
import Control.Monad
import Control.Monad.Except
import Numeric


right :: Either e a -> Maybe a
right = either (const Nothing) Just

onlyRight :: Either e a -> a
onlyRight = fromJust . right


main :: IO ()
main = hspec $ do
    describe "Unit Spec" spec
    --describe "QuickCheck Spec" quickSpec


spec :: Spec
spec = do
    describe "eval" $ do
        context "Bool" $ do
            it "Should evaluate a false boolean to false" $ do
                env <- nullEnv
                evaledFalse <- onlyRight <$> runExceptT (eval env (Bool False))
                let false = Bool False
                evaledFalse `shouldBe` false
            
            it "Should evaluate a true boolean to true" $ do
                env <- nullEnv
                evaledTrue <- onlyRight <$> runExceptT (eval env (Bool True))
                let true = Bool True
                evaledTrue `shouldBe` true
        
        context "String" $ do
            it "should evaluate a string as itself" $ do
                env <- nullEnv
                let st = String "This is a string."
                evaledString <- onlyRight <$> runExceptT (eval env st)
                evaledString `shouldBe` st

--quickSpec :: Spec