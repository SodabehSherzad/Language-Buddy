package com.mae.demo.Logic;

import java.util.ArrayList;
import java.util.List;

public class Chat {
    private String senderId;
    private String receiverId;
    private List<String> messageList = new ArrayList<>();
    
    public Chat(String senderId, String receiverId) {
    	this.senderId = senderId;
    	this.receiverId = receiverId;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }
    
    public List<String> getMessageList() {
		return messageList;
	}
	
}