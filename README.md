## Whitespace stripper dance party!
Striptease is a very simple library for stripping leading and trailing whitespace
from model attributes.

### Installation:

**Rails:**

Add the following line to your `Gemfile`:
```rb
gem 'striptease'
```
Then run `bundle install` and you're ready to go.

### Usage:

Striptease includes a helper for `ActiveRecord` models that defines which attributes
are to be stripped, as well as an Rspec matcher to test that the attributes are indeed
being stripped as expected.

**AR Models:**

Just call `strip_whitespace` in your model class, passing one or more attributes
you want stripped of leading and trailing whitespace. Striptease does this in a
`before_validation` hook.

```rb
class SomeClass < ActiveRecord::Base
  strip_whitespace :foo, :bar
end
```

**Rspec:**

To make sure you are actually stripping whitespace from your attributes, just
use the `strip_whitespace_from` matcher in your unit tests:

```rb
describe SomeClass do
  it { should strip_whitespace_from(:foo) }
  it { should strip_whitespace_from(:bar) }
end
```

---

That's it! Dead simple whitespace stripping for AR model attributes.
