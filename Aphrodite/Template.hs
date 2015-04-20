{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Template where

import Text.Blaze.Html.Renderer.Text ( renderHtml )
import Text.Hamlet                   ( shamlet )
import Data.Text.Lazy                ( Text )
import qualified Data.ByteString.Lazy.Char8 as C

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
            <form class="splash-form" action="/clinics/" method="GET">
                <div class="input-wrap">
                    <input class="location-box" name="location" type="text" placeholder="Search by Location">
                    <a class="location-trigger"><img class="gps-icon" src="img/location2.svg">
               <button type="submit">Go
               
            <p class="intro">Aphrodite hopes to help women in need of medical care, no matter what, find safe and verified health and wellness locations in their area.

    |]

--todo: make sure the json you recieve is non-escaped json
--iterate through and display cards
renderResults :: String -> Text
renderResults json = renderHtml [shamlet|$newline always
    <html>
        <head>
            <title>Search Results | Aphrodite
            <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,700italic,400,300,700' rel='stylesheet' type='text/css'>
            <link href="/style.css" rel="stylesheet">
        <body class="results">
            <nav class="top-bar">
                <a class="left" href="/"><img class="back-arrow" src="/img/arrow-left.svg">Back

                <span class="top-bar__title">Aphrodite
        
            <div class="container">
                <article class="card planned-p">
                    <h3 class="card__title">Hello
                    <div class="card__status">
                        <span class="open">Open
                    <hr>
                    <div class="card__content first">
                        <p>129 Clovercrest Dr.
                            <br>Rochester, NY 14618
                    <div class="card__content">
                        <ul>
                            <li>Mon: 8 am - 4 pm
                            <li>Tues: 8 am - 4 pm

    |]
