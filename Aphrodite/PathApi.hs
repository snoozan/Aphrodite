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
directionsUrl orig dest = "https://maps.googleapis.com/maps/api/directions/json?"
			++ "origin=" ++ urlEncode orig
			++ "&destination=" ++ urlEncode dest
			++ "&mode=transit"			--makes default mode of transportation 'transit'
			++ "&key=" ++ googleAPIKey

-- | only returns a single route
getRoute :: M.Geolocloc -> M.Geolocloc -> IO C.ByteString
getRoute orig dest = (orig lat1 lng1) (dest lat2 lng2)
		res <- simpleHttp $ directionsURL geoStr1 geoStr2
		where geoStr1 = show lat1 ++ "," ++ show lng1
		      geoStr2 = show lat2 ++ "," ++ show lng2

