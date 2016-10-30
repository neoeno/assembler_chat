//= require event_router

describe("EventRouter", function() {
  var eventRouter;

  beforeEach(function() {
    eventRouter = EventRouter("eventType", {
      returnsItsArgument: function(obj) { return obj; },
      returnsAString: function(obj) { return "aString"; }
    });
  });

  describe("sent an event it can handle", function() {
    it("calls the corresponding function", function() {
      expect(eventRouter({eventType: "returnsAString"})).toEqual("aString");
    });

    it("calls the corresponding function with the event object", function() {
      var event = {eventType: "returnsItsArgument"};
      expect(eventRouter(event)).toEqual(event);
    });
  });

  describe("sent an event with an eventType it does not know about", function() {
    it("returns undefined", function() {
      expect(eventRouter({eventType: "notAnEvent"})).toEqual(undefined);
    });
  });

  describe("sent an event without the attribute we've been asked to switch on", function() {
    it("returns undefined", function() {
      expect(eventRouter({})).toEqual(undefined);
    });
  });
});
