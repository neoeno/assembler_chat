// A simple chat service that accepts messages and adds them to a list

function ChatServiceFactory() {
  var messageList = [];

  function submitMessage(message) {
    messageList.push(message);
  }

  function getMessageList() {
    return messageList;
  }

  return {
    submitMessage: submitMessage,
    getMessageList: getMessageList
  };
}
