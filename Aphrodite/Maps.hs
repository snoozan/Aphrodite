{-# LANGUAGE DeriveGeneric #-}
module Maps where

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import GHC.Generics 

data Geolocloc = Geolocloc
    { lat :: Double
    , lng :: Double
    } deriving(Show,Generic)
instance FromJSON Geolocloc
instance ToJSON Geolocloc

data Geolocgeometry = Geolocgeometry
    { location :: Geolocloc
    } deriving(Show,Generic)
instance FromJSON Geolocgeometry
instance ToJSON Geolocgeometry

data Geolocjson = Geolocjson
    { geometry :: Geolocgeometry
    } deriving(Show,Generic)

instance FromJSON Geolocjson
instance ToJSON Geolocjson

data Geolocresult = Geolocresult
    { results :: [Geolocjson]
    } deriving(Show,Generic)

instance FromJSON Geolocresult
instance ToJSON Geolocresult



--(!) :: (JSON a) => JSObject JSValue -> String -> Result a
--(!) = flip valFromObj
--
--instance JSON Geolocloc where 
--
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        Geolocloc    <$>
--        obj ! "lat"  <*>
--        obj ! "long" 
--    readJSON _ = mzero
--
--instance JSON Geolocgeometry where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        Geolocgeometry  <$>
--        readJSON (obj ! "location")
--
--instance JSON Geolocjson where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        Geolocjson <$>
--        readJSON (obj ! "geometry")
--    readJSON _ = mzero
--
--instance JSON Geolocresult where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        Geolocresult <$>
--        readJSON (obj ! "results")
--    readJSON _ = mzero
--
--instance JSON NearbyResultPhotos where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        NearbyResultPhotos <$>
--        obj ! "height" <*>
--        obj ! "photo_reference" <*>
--        obj ! "width"
--    readJSON _ = mzero
--
--instance JSON NearbyResultOpenNow where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        NearbyResultOpenNow <$>
--        obj ! "open_now" 
--    readJSON _ = mzero
--
--instance JSON NearbyResultOpen where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        NearbyResultOpen <$>
--        readJSON (obj ! "opening_hours") 
--    readJSON _ = mzero
--
--instance JSON NearbyResultJson where 
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        NearbyResultJson <$>
--        readJSON (obj ! "geometry") <*>
--        obj ! "icon" <*>
--        obj ! "id" <*>
--        obj ! "name" <*>
--        readJSON (obj ! "opening_hours") <*>
--        readJSON (obj ! "photos")  <*>
--        obj ! "place_id" <*>
--        obj ! "reference" <*>
--        obj ! "vicinity" 
--    readJSON _ = mzero
--
--instance JSON NearbyResultLoc where
--    showJSON = undefined
--
--    readJSON (JSObject obj) =
--        NearbyResultLoc <$>
--        readJSON (obj ! "results")
--    readJSON _ = mzero
        
