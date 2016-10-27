// A collection of methods that take application state and apply it to the DOM

var RenderFactory = function(Elements) {
  function messageList(list) {
    var $newMessages = list.map(function(message) {
      return $("<li>").text(message);
    });

    var $newMessageList = $("<ul>").html($newMessages);

    Elements.$messageList.html($newMessageList);
  }

  function messageForm(message) {
    Elements.$messageField.val(message);
  }

  return {
    messageList: messageList,
    messageForm: messageForm
  }
};
