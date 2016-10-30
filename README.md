# Assembler Chat

This is a chat app that also interprets inline assembler code and visusalises
the machine state alongside. Actually it doesn't do that last bit yet! But it
will within a few hours.

## Quickstart

```bash
bundle install

# Run the tests (rspec, cucumber, teaspoon)
./test.sh

# Run the server
rails s
open http://localhost:3000/
```

## Final thoughts

* The JS isn't exactly how I'd like it, and the unit test coverage is fairly low (though I believe almost all of it is covered by integration tests). This would benefit from:
  * Splitting up into components, possibly with React — thereby making it much more testable
  * Otherwise, setting up JSDOM to enable unit testing
* Would also like to integrate Babel and spend a bit of time cleaning it up along those lines, possibly extracting the jQuery dependency
* If this project got any bigger, we'd want to make the CSS architecture a bit smarter — I'd say this is adequate for now though. Any more generic utilities felt a bit overengineery.
* ActionCable isn't really there yet when it comes to testing. See [this notice](http://rspec.info/blog/2016/07/rspec-3-5-has-been-released/) from the RSpec team: "The other important feature of Rails 5 we wanted to discuss is ActionCable. Unfortunately RSpec is not able to provide a clean way of testing ActionCable at this time. Rails is working on a testing type for ActionCable slated for release as part of Rails 5.1. We'll be watching that closely and work something up when it's ready. In the mean time, we suggest you test ActionCable through a browser, in an integrated fashion." Shame! In any case, that's what I've done.
* Some of the cucumber end-to-end tests are prone to random failure. My least favourite problem. I attempted to resolve some of it by switching to auto-delaying capybara asserts wherever possible but even where I have it still fails sometimes.
* That said I'm fairly happy with the cucumber tests right now. I think in the past I've over-generalised the steps to the point it gave me a headache, and this time I've really waited 'til it's really causing pain before I generalise, and I think it's paid off.
* Reasonably happy with the data flow too. I hate rails apps where you can never tell where the data you're dealing with has come from — some from APIs, some from scraping your own DOM, some from random JSON blobs inserted in the views. Here we've managed to shove nearly all of it through ActionCable and it pays off in reduced complexity I think.
* The Assembly Interpreter is my best attempt a parser/executor yet! Which isn't saying much but I'm fairly pleased with it. It seems like writing the whole instruction set would be possible within roughly this architecture.
  * I'd like to get inline execution working too, where you can type stuff like: "So if we now execute `mov ax, 3d`..."
  * The testing story around this is a bit confused, and which bit should be tested is a tricky question. Do we test the lexer, parser, and interpreter separately for each type of statement? Or two more lightly and one more heavily, e.g. integration? Probably should have been the latter.
  * Also only supporting decimal numbers was a bit of a cop-out!
* The `MessageStore`... eh. Still not sure about that. It serves the purpose of keeping logic out of the ActionCable code where we can't easily test it.
  * Could it have gone in the `Message` model? Theoretically yes, but to me it seems a lot like presentation logic in places.
  * Could it have gone in a presenter or similar? Sort of... but it does more than that. Hmm.
  * Like I said, not sure of it.
* The JSON state storage is a bit nasty. Ideally we'd switch to postgres and use the JSON store.
