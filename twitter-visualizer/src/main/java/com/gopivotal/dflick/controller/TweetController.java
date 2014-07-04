package com.gopivotal.dflick.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gopivotal.dflick.model.TweetData;

@Controller
public class TweetController {

	@Resource
	@Qualifier("map")
	private HashMap<Integer,TweetData> map;

	@RequestMapping(value = "/")
	public String home(Model model) {
		return "WEB-INF/views/visualizer.jsp";
	}

	@RequestMapping(value = "/getTweet")
	public @ResponseBody
	TweetData search(@RequestParam ("key") Integer key) {
		TweetData tweet = null;
		
		if(map.containsKey(key))
			tweet = map.get(key);
		
		return tweet;
	}

	@RequestMapping(value = "/killApp")
	public @ResponseBody
	String kill() {
		System.exit(-1);
		return "Killed";

	}

}
