{-# LANGUAGE OverloadedStrings #-}
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

import Api

-- getClinics :: IO String -> IO String
-- Main loop
mainloop :: IO()
mainloop = scotty 3000 $ do
        middleware $ staticPolicy (noDots >-> addBase "static")
        get "/" $ file "static/index.html" 

--       get "/clinics" $
--           param "location" >>= getLoc >>= getClinics   
--       get "/map" $
--           param "clinic" >>= displayRoute 

-- Entry Point
main :: IO()
main = do 
    mainloop
