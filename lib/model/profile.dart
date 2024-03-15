class Profile{
    static String? username;
    static String? uid;
    static String? Email;

    static void setUsername(String newName) {
        username = newName;
    }
    static void setUid(String newUid) {
        uid = newUid;
    }
    static void setEmail(String newEmail) {
        Email = newEmail;
    }

}
class ChatProfile{
    static String? Chatid;
    static String? admin;
    static void setChatid(String newID) {Chatid = newID;}
    static void setadmin(String newID) {Chatid = newID;}

}