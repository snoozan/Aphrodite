{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Template where

import Text.Blaze.Html.Renderer.Text ( renderHtml )
import Text.Hamlet                   ( shamlet )
import Data.Text.Lazy                ( Text )

renderIndex :: Text
renderIndex = renderHtml [shamlet|$newline always
    <html>
        <head>
        <title>Aphrodite
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,700italic,400,300,700' rel='stylesheet' type='text/css'>
        <link href="style.css" rel="stylesheet">
    <body class="home">
        <div class="container center">
            <h1 class="main-title">Aphrodite
            <h2>Women's Clinic Finder
            <form class="splash-form" action="results.html" method="GET">
                <div class="input-wrap">
                    <input class="location-box" name="location" type="text" placeholder="Search by Location">
                    <a class="location-trigger"><img class="gps-icon" src="img/location2.svg">
               <button type="submit">Go
               
            <p class="intro">Aphrodite hopes to help women in need of medical care, no matter what, find safe and verified health and wellness locations in their area.

    |]
