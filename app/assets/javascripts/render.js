// A collection of methods that take application state and apply it to the DOM

var RenderFactory = function(Elements) {
  function messageList(list) {
    var $newMessages = list.map(function(message) {
      var $username = $("<span class='test-message-username'>").text(message.username);
      var $body = $("<span class='test-message-body'>").text(message.body);
      var $listItem = $("<li class='test-message'>");
      $listItem.append($username);
      $listItem.append($body);
      return $listItem;
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
