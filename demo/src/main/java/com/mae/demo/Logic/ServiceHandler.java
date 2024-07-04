package com.mae.demo.Logic;

import org.springframework.stereotype.Service;

@Service
public class ServiceHandler extends Handler{

	
	public boolean checkLogin(User request) {
		users.forEach(e-> System.out.println(e));
		
    	if(users.contains(request)) return true;
    	return false;
	}
	
	public boolean checkRegister(User request) throws DoubleIdException {
		
		if(users.stream().anyMatch(u -> u.getId().equals(request.getId())))
			throw new DoubleIdException("Eine Id darf nicht zweimal vorkommen!\n");
		
		
		if(!users.contains(request)) {
    		users.add(new User(request.getBenutzerName(),request.getPasswort(),request.getId()));
    		return true;
    	}
    	return false;
	}
	
	public User findByUsername(String username) {
        return users.stream()
            .filter(u -> u.getBenutzerName().equals(username))
            .findFirst()
            .orElse(null);
    }
	
	 public User findById(String id) {
	        return users.stream()
	            .filter(u -> u.getId().equals(id))
	            .findFirst()
	            .orElse(null);
	 }
	 
	 public boolean addFriend(String userId, String friendId) {
	        User user = findById(userId);
	        User friend = findById(friendId);

	        if (user != null && friend != null && !user.getFriendsList().contains(friend)) {
	            user.addFriend(friend);
	            return true;
	        }
	        return false;
	 }
	 
	 public boolean removeFriend(String userId, String friendId) {
		 User user = findById(userId);
		 User friend = findById(friendId);
		 
		 if (user != null && friend != null && user.getFriendsList().contains(friend)) {
	            user.removeFriend(friend);
	            return true;
	     }
	        return false;
	 }
	 
	 public boolean sendMessage(String userId, String receiverId, String message) {
		 User user = findById(userId);
		 User receiver = findById(receiverId);
		 boolean flag = user.getChats().stream().anyMatch(a -> a.getReceiverId().equals(receiverId));
		 
		 
		 
		 if(user != null && receiver != null) {
			 if(!flag)
				 user.addChat(receiverId);
			 
			 user.findChatWithId(receiverId).getMessageList().add(message);
			 return true;
		 }
		 return false;
		 
	 }
  
}
