{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}

-- Main function
import Web.Scotty
import Control.Monad(liftM,liftM2,when)
import Control.Monad.IO.Class(liftIO)
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.Text.Lazy as T
import Network.HTTP.Types.Status(forbidden403, notFound404)
import Network.Wai.Middleware.Static
import Network.HTTP.Base
import Text.Regex
import Data.Aeson
import Network.HTTP.Conduit
import Control.Monad.IO.Class
import qualified Maps as M
import qualified Places as P
import qualified Nearby as N

import Template

--import Api

googleApiKey :: String
googleApiKey = ""

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

getGPSCoor :: String -> Maybe [String]
getGPSCoor reg =  matchRegex (mkRegex "([0-9.-]+) ([0-9.-]+)") reg

getNearbyClinics :: String -> IO C.ByteString
getNearbyClinics loc =
    case getGPSCoor loc of
        Just [slat,slong] -> simpleHttp $ nearbyUrl $ slat ++ "," ++ slong
        Nothing           -> do res <- simpleHttp $ getLocation loc
                                case decode (res) of
                                    Just (M.Geolocresult jsn) ->
                                        let (M.Geolocjson (M.Geolocgeometry (M.Geolocloc lat lng))) = head jsn
                                        in simpleHttp $ nearbyUrl $ show lat ++ "," ++ show lng
                                    Nothing -> return "Shit broke man"

placeUrl :: String -> String
placeUrl place = "https://maps.googleapis.com/maps/api/place/details/json?"
                ++ "placeid=" ++ urlEncode place
                ++ "&key;=" ++ urlEncode googleApiKey 

getClinicInfo :: String -> IO C.ByteString
getClinicInfo placeid = do result <- simpleHttp $ placeUrl placeid    
                           --let placeinfo = decodeJSON $ C.unpack result
                           --    P.PlacesResult (dets:_) = placeinfo
                           --    P.PlaceDetails
                           --        { opening_hours = PlaceHours open pers
                           --        , formatted_address = addr
                           --        , formatted_phone_number = numb
                           --        , permanently_closed = clsd
                           --        } = dets
                           --    days = encodeJSON pers
                           return result


directionsUrl :: String -> String -> String
directionsUrl orig dest = "https://maps.googleapis.com/maps/api/directions/json?"
                        ++ "Directions"
                        ++ "&key=" ++ googleApiKey
                        ++ "origin=" ++ urlEncode orig
                        ++ "&destination=" ++ urlEncode dest
                        ++ "&mode=transit"

getRouteFromStr :: Maybe [String] -> Maybe [String] -> IO C.ByteString
getRouteFromStr (Just [lat1,lng1]) (Just [lat2,lng2]) = do 
                            res <- simpleHttp $ directionsUrl geoStr1 geoStr2
                            return res
                                where geoStr1 = lat1 ++ "," ++ lng1
                                      geoStr2 = lat2 ++ "," ++ lng2


-- Main loop
mainloop :: IO ()
mainloop = scotty 3000 $ do
        middleware $ staticPolicy (noDots >-> addBase "static")
        get "/" (html renderIndex)
        get "/clinics/" $ do
           location <- param "location"             
           clinics <- liftIO $ getNearbyClinics location
           html $ renderResults clinics
        post "/getDetails" $ do
           placeid <- param "placeid"
           clinicDetails <- liftIO $ getClinicInfo placeid
           raw clinicDetails
        get "/getDirections" $ do
           start <- param "start"
           end <- param "end"
           route <- liftIO (getRouteFromStr (getGPSCoor start) (getGPSCoor end))
           raw route
-- Entry Point
main :: IO ()
main = do 
    mainloop

