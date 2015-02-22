{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
module Main(main) where 

-- Main function
import Control.Monad(liftM,liftM2,when)
import Control.Monad.IO.Class(liftIO)
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.Text.Lazy as T
import Network.HTTP.Types.Status(forbidden403, notFound404)
import Network.Wai.Middleware.Static
import System.Environment(getArgs)
import Web.Scotty
import Network.HTTP.Base
import Text.Regex
import Text.JSON.Generic
import Network.HTTP.Conduit

--import Api

data Geolocloc = Geolocloc
    { lat :: Double
    , lng :: Double
    } deriving(Show,Data,Typeable)

data Geolocgeometry = Geolocgeometry
    { location :: Geolocloc
    } deriving(Show,Data,Typeable)

data Geolocjson = Geolocjson
    { geometry :: Geolocgeometry
    } deriving(Show,Data,Typeable)

data Geolocresult = Geolocresult
    { results :: [Geolocjson]
    } deriving(Show,Data,Typeable)

googleApiKey :: String
googleApiKey = "AIzaSyDxQZG6uDB3BWSXmMGdmto8mJqN-P5Zg-Q"

nearbyUrl :: String -> String
nearbyUrl location = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
                  ++ "key=" ++ googleApiKey
                  ++ "&location=" ++ location
                  ++ "&rankby=distance"
                  ++ "&name=" ++ urlEncode "planned parenthood"

getLocation :: String -> String 
getLocation loc = "https://maps.googleapis.com/maps/api/geocode/json?"
                ++ "address=" ++ urlEncode loc
                ++ "&key" ++ googleApiKey

directionsUrl :: String -> String -> String
directionsUrl orig dest = "https://maps.googleapis.com/maps/api/directions/json?"
                       ++ "origin=" ++ urlEncode orig
                       ++ "&destination=" ++ urlEncode dest

getNearbyClinics :: String -> IO C.ByteString
getNearbyClinics loc =
    case matchRegex (mkRegex "([0-9.-]+) ([0-9.-]+)") loc of
        Just [slat,slong] -> simpleHttp $ nearbyUrl $ slat ++ "," ++ slong
        Nothing           -> do res <- simpleHttp $ getLocation loc
                                let geoloc = decodeJSON $ C.unpack res
                                    Geolocresult jsn = geoloc
                                    Geolocjson (Geolocgeometry (Geolocloc lat lng)) = head jsn
                                simpleHttp $ nearbyUrl $ show lat ++ "," ++ show lng

-- Main loop
mainloop :: IO()
mainloop = scotty 3000 $ do
        middleware $ staticPolicy (noDots >-> addBase "static")
        get "/" $ file "static/index.html" 
        get "/clinics" $ undefined
            
--       get "/clinics" $
--           param "location" >>= getLoc >>= getClinics   
--       get "/map" $
--           param "clinic" >>= displayRoute 

-- Entry Point
main :: IO()
main = do 
    mainloop
