{-# LANGUAGE DeriveDataTypeable #-}
module Maps where

import Text.JSON.Generic

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

data NearbyResultLoc = NearbyResultLoc
    { results :: [Geolocgeometry]
    } deriving(Show,Data,Typeable)

data NearbyResultPhotos = NearbyResultPhotos
    { height :: Integer
    , photo_reference :: String
    , width :: Integer
    } deriving(Show,Data,Typeable)

