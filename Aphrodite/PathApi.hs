{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
module PathApi where

-- Imports
import Control.Monad(liftM, liftM2, when)
import Control.Monad.IO.Class(liftIO)
import Web.Scotty
import Text.Regex
import Text.JSON.Generic
import Network.HTTP.Base
import Network.HTTP.Conduit
import Network.HTTP.Types.Status(forbidden403, notFound404)
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.Text.Lazy as T
import Aphrodite
import qualified Maps as M



directionsUrl :: String -> String -> IO C.ByteString
directionsUrl orig dest = "https://www.google.com/maps/embed/v1/directions"
			++ "?key=" ++ googleAPIKey
			++ "&origin=" ++ urlEncode orig
			++ "&destination=" ++ urlEncode dest
			++ "&mode=transit"		--makes default mode of transportation 'transit'
-- | Takes in a JSON blob and returns the URL for the embeded map
--getRoute :: IO C.ByteString -> String
	--  .
	--  .
	--  .
	--  directionsUrl origCoor destCoor
-- <iframe
--   width="450"
--   height="250"
--   frameborder="0" style="border:0"
--   src="https://www.google.com/maps/embed/v1/search?key=API_KEY&q;=record+stores+in+Seattle">
-- </iframe>    
-- ^^^
-- This is the style that Sarah will be dealing with. SO all we need to do as far as directions goes is sending her back this string to do whatever she wants with. <<< Delete when finished. 

