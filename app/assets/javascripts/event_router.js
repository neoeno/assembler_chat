// A utility to route events to functions based on a given key

function EventRouter(typeAttribute, handlers) {
  return function (eventObject) {
    if (!eventObject[typeAttribute]) {
      console.error("Event", eventObject, "did not have typeAttribute key", typeAttribute);
      return;
    }

    if (!handlers[eventObject[typeAttribute]]) {
      console.error("Could not handle event of type", eventObject[typeAttribute]);
      return;
    }

    return handlers[eventObject[typeAttribute]](eventObject.payload);
  }
}
