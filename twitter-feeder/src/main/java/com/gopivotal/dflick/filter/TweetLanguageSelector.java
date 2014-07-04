package com.gopivotal.dflick.filter;

import org.springframework.integration.core.MessageSelector;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.messaging.Message;

public class TweetLanguageSelector implements MessageSelector {

	@Override
	public boolean accept(Message<?> message) {
		if(((Tweet)message.getPayload()).getLanguageCode().equals("en"))
				return true;
		return false;
	}

}
