package com.mae.demo.Logic;

public class ChatFactory {
	
	public static Chat createChat(String senderId, String receiverId) {
        return new Chat(senderId, receiverId);
    }

    public static void addChatToUser(User user, String receiverId) {
        Chat newChat = createChat(user.getId(), receiverId);
        user.getChats().add(newChat);
    }
}
