package com.mae.demo.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.mae.demo.Logic.*;

@RestController
@RequestMapping("/frontend")
public class FrontEndController {
	
	
	private final ServiceHandler serviceHandler;
	
	@Autowired
    public FrontEndController(ServiceHandler serviceHandler) {
       this.serviceHandler = serviceHandler;
    }

	@GetMapping("/data")
	public List<User> sendData(){
		return serviceHandler.getAllLogins();
		
	}
	
	@PostMapping("/login")
	public boolean checkData(@RequestBody User user) {
		if(serviceHandler.checkLogin(user)) return true;
		return false;
	}
	
	@PostMapping("/register")
	public boolean register(@RequestBody User user) {
		try {
			if(serviceHandler.checkRegister(user))
				return true;
		}catch(DoubleIdException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@GetMapping("/messages")
    public List<Chat> getMessages(@RequestParam String id) {
        User user = serviceHandler.findById(id);
        if (user != null) {
            return user.getChats();
        } else {
            return List.of();
        }
    }

    @PostMapping("/receiveMessage")
    public boolean receiveMessage(@RequestParam String message, @RequestParam String senderId, @RequestParam String receiverId) {
        User sender = serviceHandler.findById(senderId);
        User receiver = serviceHandler.findById(receiverId);
        
        if(sender != null && receiver != null) {
        	return serviceHandler.sendMessage(senderId, receiverId, message);
        }else {
        	return false;
        }
    }
    
    @GetMapping("/friendsList")
    public List<User> getFriendsList(@RequestParam String id){
    	User user = serviceHandler.findById(id);
    	if (user != null) {
            return user.getFriendsList();
        } else {
            return List.of();
        }
    	
    }
    
    @PostMapping("/addFriend")
    public boolean addFriend(@RequestParam String userId, @RequestParam String friendId) {
        return serviceHandler.addFriend(userId, friendId);
    }
    
    @PostMapping("/removeFriend")
    public boolean removeFriend(@RequestParam String userId, @RequestParam String friendId) {
    	return serviceHandler.removeFriend(userId, friendId);
    }
	
}
