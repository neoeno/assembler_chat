//= require event_router

describe("EventRouter", function() {
  var eventRouter;

  beforeEach(function() {
    eventRouter = EventRouter("eventType", {
      returnsItsPayload: function(payload) { return payload; },
      returnsAString: function(payload) { return "aString"; }
    });
  });

  describe("sent an event it can handle", function() {
    it("calls the corresponding function", function() {
      expect(eventRouter({eventType: "returnsAString"})).toEqual("aString");
    });

    it("calls the corresponding function with the payload object", function() {
      var event = {eventType: "returnsItsPayload", payload: {hello: "world"}};
      expect(eventRouter(event)).toEqual(event.payload);
    });
  });

  describe("sent an event with an eventType it does not know about", function() {
    it("returns undefined", function() {
      var errorHandler = console.error;
      console.error = function() {}; // Silence console errors as we're expecting them
      expect(eventRouter({eventType: "notAnEvent"})).toEqual(undefined);
      console.error = errorHandler;
    });
  });

  describe("sent an event without the attribute we've been asked to switch on", function() {
    it("returns undefined", function() {
      var errorHandler = console.error;
      console.error = function() {}; // Silence console errors as we're expecting them
      expect(eventRouter({})).toEqual(undefined);
      console.error = errorHandler;
    });
  });
});
