package com.gopivotal.dflick.controller;

import java.util.Date;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType; 
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.gopivotal.dflick.model.TweetData;

@RestController
@RequestMapping(value="/input")
public class InputController {

	private static final int MIN = 1; 
	private static final int MAX = 5; 
	
	@Autowired 
	AmqpTemplate amqpTemplate;
	
    @RequestMapping(method = RequestMethod.POST,  produces=MediaType.APPLICATION_JSON_VALUE,  consumes=MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.CREATED)
    public TweetData stream(@RequestBody TweetData data) {
    	amqpTemplate.convertAndSend(data);
    	return data;
    }

    @RequestMapping(method = RequestMethod.GET,  produces=MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.CREATED)
    public TweetData test() {
    	TweetData tweet = new TweetData();
    	tweet.setSentiment(4);
    	tweet.setTweet("Das ist ein test");
    	tweet.setCreatedAt((new Date()).toString());
    	amqpTemplate.convertAndSend(getRandomVersion(),tweet);
    	return tweet;
    }
    
    private String getRandomVersion(){
    	return "v"+String.valueOf(MIN + (int)(Math.random() * ((MAX - MIN) + 1)));
    }
}