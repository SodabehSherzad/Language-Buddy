package com.mae.demo.Logic;

import java.util.ArrayList;
import java.util.List;



public abstract class Handler {
	protected static List<User> users = new ArrayList<>();

    public List<User> getAllLogins() {
        return new ArrayList<>(users);
    }
	
}
