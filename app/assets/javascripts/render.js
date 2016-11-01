// A collection of methods that take application state and apply it to the DOM

var RenderFactory = function(Elements) {
  function messageList(list) {
    var $newMessages = list.map(message);
    Elements.$messageList.html($newMessages);

    // Also scroll to the bottom of the list, otherwise new messages appear
    // 'below the fold'
    Elements.$messageList.scrollTop(Elements.$messageList.get(0).scrollHeight);
  }

  function message(message) {
    var $username = $("<span class='message__username test-message-username'>").text(message.username);
    var $body = $("<span class='message__body test-message-body'>").text(message.body);
    var $listItem = $("<li class='message test-message'>");
    $listItem.append($username);
    $listItem.append($body);
    return $listItem;
  }

  function messageForm(message) {
    Elements.$messageField.val(message);
  }

  function machineState(state) {
    Object.keys(state).forEach(function(register) {
      if (Elements.$machineState[register]) {
        Elements.$machineState[register].text(state[register].join(""));
      }
    });
  }

  return {
    messageList: messageList,
    messageForm: messageForm,
    machineState: machineState
  }
};
