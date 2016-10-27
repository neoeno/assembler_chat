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
  });
});
