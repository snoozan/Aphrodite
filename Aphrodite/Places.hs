{-# LANGUAGE DeriveDataTypeable #-}
module Places where

import Text.JSON.Generic

data PlacesResult = PlacesResult
    { results :: [PlaceDetails]
    } deriving(Show,Data,Typeable)
    
data PlaceDetails = PlaceDetails
    { opening_hours :: PlaceHours
    , formatted_address :: String
    , formatted_phone_numer :: String
    , permanently_closed :: Bool
    } deriving(Show,Data,Typeable)

data PlaceHours = PlaceHours
    { open_now :: Bool
    , periods :: [PlaceDays]
    } deriving(Show,Data,Typeable)

data PlaceDays = PlaceDays
    { open :: PlaceDayTime
    } deriving(Show,Data,Typeable)

data PlaceDayTime = PlaceDayTime
    { day :: Integer
    , time :: String
    } deriving(Show,Data,Typeable)
