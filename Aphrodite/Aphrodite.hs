{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}

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
import Text.JSON.Generic
import Network.HTTP.Conduit
import Control.Monad.IO.Class
import qualified Maps as M
import qualified Places as P

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


getNearbyClinics :: String -> IO C.ByteString
getNearbyClinics loc =
    case matchRegex (mkRegex "([0-9.-]+) ([0-9.-]+)") loc of
        Just [slat,slong] -> simpleHttp $ nearbyUrl $ slat ++ "," ++ slong
        Nothing           -> do res <- simpleHttp $ getLocation loc
                                let geoloc = decodeJSON $ C.unpack res
                                    M.Geolocresult jsn = geoloc
                                    M.Geolocjson (M.Geolocgeometry (M.Geolocloc lat lng)) = head jsn
                                simpleHttp $ nearbyUrl $ show lat ++ "," ++ show lng
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
    

-- Main loop
mainloop :: IO ()
mainloop = scotty 3000 $ do
        middleware $ staticPolicy (noDots >-> addBase "static")
        get "/" $ file "static/index.html" 
        post "/clinics" $ do
           location <- param "location"             
           clinics <- liftIO $ getNearbyClinics location
           raw clinics
        post "/getDetails" $ do
           placeid <- param "placeid"
           clinicDetails <- liftIO $ getClinicInfo placeid
           raw clinicDetails

-- Entry Point
main :: IO ()
main = do 
    mainloop

