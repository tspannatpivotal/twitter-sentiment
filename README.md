twitter-sentiment
=================
Twitter sentiment analytics application

The application
===============
This application collects twitter tweets, does sentiment analytics and presents the results in an HTML5 user interface.
This application runs localy or on PCF. The app requires RabbitMQ.

This application consists of two application processes called twitter-feeder and twitter-visualizer. Twitter-Feeder gathers the data from Twitter and does sentiment analytics with the standford coreNLP library (http://nlp.stanford.edu/software/corenlp.shtml). In order to get better sentiment analytics results tweets in languages other than english are filtered. Twitter-feeder passes the data via RabbitMQ to the twitter-visualizer. The visualizer is the app you need to point your browser to.

Please, be aware that the number of tweets per hour allowed to gather from twitter with default credentials are limited.
Please, use your own twitter credentials. You get them here: https://apps.twitter.com/app/new
Configure your credentials in the oauth.properties file contained in twitter-feeder.

Getting started on PCF
======================
create a RabbitMQ service in the space you are going to push the application.

clone the repo
cd twitter-sentiment

cd twitter-feeder
mvn package

edit the manifest.yml and change the RabbitMQ service to the service you just created and change the name and host if desired.

execute: push 
This pushes twitter-feeder and twitter-visualizer to PCF.
It should take a moment because the standford coreNLP library is quite big.

Point you browser to the twitter-visualizer application.

![Alt text](/screenshot.png?raw=true "twitter-visualizer")


