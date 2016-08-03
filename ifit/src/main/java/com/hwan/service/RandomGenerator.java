package com.hwan.service;

import java.math.BigInteger;
import java.security.SecureRandom;

import org.springframework.stereotype.Service;

@Service
public class RandomGenerator {

	private SecureRandom random = new SecureRandom();

	  public String nextSessionId() {
	    return new BigInteger(70, random).toString(32);
	  }
}
