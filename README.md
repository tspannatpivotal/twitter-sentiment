twitter-sentiment
=================
Twitter sentiment analytics application

The application
===============
This application collects twitter tweets, does sentiment analytics and presents the results in an HTML5 user interface.
This application runs locally or on PCF. The app requires RabbitMQ.

This application consists of two application processes called twitter-feeder and twitter-visualizer. Twitter-Feeder gathers data from Twitter and does sentiment analytics with stanford coreNLP library (http://nlp.stanford.edu/software/corenlp.shtml). In order to get better sentiment analytic results tweets in languages other than english are filtered. Twitter-feeder passes the data via RabbitMQ to twitter-visualizer. The visualizer is the application you need to point your browser to.

Twitter Limitations
===================
Please, be aware that the number of tweets allowed to gather per hour from twitter is per default limited.
After the limit is reached no more tweets are gathered for some time.

Prerequisites
=============
Please, use your own twitter credentials. You get them here: https://apps.twitter.com/app/new
Configure your credentials in the oauth.properties file contained in twitter-feeder.

Change the Twitter query
========================
Edit spring-context.xml of twitter-feeder.

	<int-twitter:search-inbound-channel-adapter
		id="searchAdapter" channel="fromTwitter" query="#WorldCup"
		twitter-template="twitterTemplate">
		<int:poller fixed-rate="3000" max-messages-per-poll="5" />
	</int-twitter:search-inbound-channel-adapter>

Change the query from #WorldCup to what is desired.

Getting started on PCF
======================
create a RabbitMQ service in the space you are going to push the application.

clone the repo

cd twitter-sentiment

cd twitter-feeder

mvn package

cd twitter-visualizer

mvn package

edit the manifest.yml and change the RabbitMQ service to the service you just created and change the name and host if desired.

execute: push 
This pushes twitter-feeder and twitter-visualizer to PCF.
It should take a moment because the stanford coreNLP library is quite big.

Point you browser to the twitter-visualizer application.

![Alt text](/screenshot.png?raw=true "twitter-visualizer")


