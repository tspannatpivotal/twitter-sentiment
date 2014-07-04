package com.gopivotal.dflick.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.gopivotal.dflick.model.TweetData;

@Component
public class TweetImportListener {

	@Resource
	@Qualifier("map")
	private HashMap<Integer,TweetData> map;
	
	public void onMessage(TweetData td) {
		map.put(map.size(),td);
	}

}
