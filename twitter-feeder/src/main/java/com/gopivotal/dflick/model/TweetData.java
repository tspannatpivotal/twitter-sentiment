package com.gopivotal.dflick.model;

import java.io.Serializable;
import java.util.Date;

public class TweetData implements Serializable{
	public String tweet;
	public String createdAt;
	public int sentiment;

	public TweetData() {
		super();
	}
	
	public String getTweet() {
		return tweet;
	}
	public void setTweet(String tweet) {
		this.tweet = tweet;
	}
	public int getSentiment() {
		return sentiment;
	}
	public void setSentiment(int sentiment) {
		this.sentiment = sentiment;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getCreatedAt() {
		return createdAt;
	}

}
