package com.mae.demo.Logic;

import java.util.*;
import java.util.Objects;
import java.util.UUID;

public class User {
	private String benutzerName;
	private String passwort;
	private String id;
	private List<Chat> chats = new ArrayList<>();
	
	private List<User> friendsList = new ArrayList<>();
	
	public User(String benutzerName, String passwort, String id) {
		this.id = id;
		this.benutzerName = benutzerName;
		this.passwort = passwort;
	}
	
	public String getBenutzerName() {
		return benutzerName;
	}
	public void setBenutzerName(String benutzerName) {
		this.benutzerName = benutzerName;
	}
	public String getPasswort() {
		return passwort;
	}
	public void setPasswort(String passwort) {
		this.passwort = passwort;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public List<User> getFriendsList() {
		return friendsList;
	}
	
	public List<Chat> getChats() {
		return chats;
	}
	
	public void addFriend(User user) {
		friendsList.add(user);
	}
	
	public void removeFriend(User user) {
		friendsList.remove(user);
	}
	
	public void addChat(String receiverId) {
		ChatFactory.addChatToUser(this, receiverId);
	}
	
	public Chat findChatWithId(String receiverId){
		return chats.stream().filter(e -> e.getReceiverId() == receiverId && e.getSenderId() == id).findFirst().orElse(null);
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(benutzerName, id, passwort);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(benutzerName, other.benutzerName) && Objects.equals(id, other.id)
				 && Objects.equals(passwort, other.passwort);
	}

	@Override
	public String toString() {
		return benutzerName + " " + passwort + " " + id;
	}
	
}
