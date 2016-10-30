// A simple chat service that accepts messages and adds them to a list

function ChatServiceFactory() {
  var messageList = [];

  function submitMessage(message) {
    messageList.push(message);
  }

  function replaceMessageList(messages) {
    messageList = messages;
  }

  function getMessageList() {
    return messageList;
  }

  return {
    submitMessage: submitMessage,
    getMessageList: getMessageList,
    replaceMessageList: replaceMessageList
  };
}
