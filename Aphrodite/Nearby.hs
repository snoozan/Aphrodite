{-# LANGUAGE DeriveGeneric #-}

module Nearby where

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import GHC.Generics 

data NearbyGeoLoc = NearbyGeoLoc
    { lat :: Double
    , lng :: Double
    } deriving (Show, Generic)

instance FromJSON NearbyGeoLoc
instance ToJSON NearbyGeoLoc

data NearbyGeo = NearbyGeo
    { location :: NearbyGeoLoc
    } deriving (Show, Generic)

instance FromJSON NearbyGeo
instance ToJSON NearbyGeo

data NearbyResultPhotos = NearbyResultPhotos
    { height :: Integer
    , photo_reference :: String
    , width :: Integer
    } deriving(Show,Generic)

instance FromJSON NearbyResultPhotos
instance ToJSON NearbyResultPhotos

data NearbyResultOpen = NearbyResultOpen
    { open_now :: Bool
    } deriving(Show,Generic)

instance FromJSON NearbyResultOpen
instance ToJSON NearbyResultOpen

data NearbyResultJson = NearbyResultJson
    { geometry :: NearbyGeo 
    , icon :: String
    , id   :: String
    , name :: String
    , opening_hours :: [NearbyResultOpen]
    , photos :: [NearbyResultPhotos]
    , place_id :: String
    , reference :: String
    , vicinity :: String
    }deriving(Show,Generic)

instance FromJSON NearbyResultJson
instance ToJSON NearbyResultJson

data NearbyResultLoc = NearbyResultLoc
    { results :: [NearbyResultJson]
    } deriving(Show,Generic)

instance FromJSON NearbyResultLoc 
instance ToJSON NearbyResultLoc
