//= require chat_service

describe("ChatService", function() {
  var ChatService;

  beforeEach(function() {
    ChatService = ChatServiceFactory();
  })

  describe(".getMessageList", function() {
    it("returns an empty list", function() {
      expect(ChatService.getMessageList()).toEqual([]);
    })
  });

  describe(".submitMessage", function() {
    it("adds a message to the message list", function() {
      var message = "hello!";
      ChatService.submitMessage(message);
      expect(ChatService.getMessageList()).toEqual([message]);
    });

    it("adds messages to the end of the message list", function() {
      var message1 = "hello 1";
      var message2 = "world 2"
      ChatService.submitMessage(message1);
      ChatService.submitMessage(message2);
      expect(ChatService.getMessageList()).toEqual([message1, message2]);
    })
  });

  describe(".replaceMessageList", function() {
    it("resets the message list to the given list", function() {
      var newMessageList = ["hello", "world"];
      ChatService.replaceMessageList(newMessageList);
      expect(ChatService.getMessageList()).toEqual(newMessageList);
    });
  });
});
