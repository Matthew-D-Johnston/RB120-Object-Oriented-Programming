##### RB120 - Object Oriented Programming > Debugging > You've Got Mail!

---

## You've Got Mail!

Can you decipher and fix the error that the following code produces?

```ruby
class Mail
  def to_s
    "#{self.class}"
  end
end

class Email < Mail
  attr_accessor :subject, :body
  
  def initialize(subject, body)
    @subject = subject
    @body = body
  end
end

class Postcard < Mail
  attr_reader :text

  def initialize(text)
    @text = text
  end
end

module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send(destination, mail)
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class CommunicationsProvider
  attr_reader :name, :account_number

  def initialize(name, account_number=nil)
    @name = name
    @account_number = account_number
  end
end

class EmailService < CommunicationsProvider
  include Mailing

  attr_accessor :email_address, :mailbox

  def initialize(name, account_number, email_address)
    super(name, account_number)
    @email_address = email_address
    @mailbox = []
  end

  def empty_inbox
    self.mailbox = []
  end
end

class TelephoneService < CommunicationsProvider
  def initialize(name, account_number, phone_number)
    super(name, account_number)
    @phone_number = phone_number
  end
end

class PostalService < CommunicationsProvider
  attr_accessor :street_address, :mailbox

  def initialize(name, street_address)
    super(name)
    @street_address = street_address
    @mailbox = []
  end

  def change_address(new_address)
    self.street_address = new_address
  end
end

rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
johns_phone_service = TelephoneService.new('John', 122, '555-232-1121')
johns_postal_service = PostalService.new('John', '47 Sunshine Ave.')
ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

puts johns_postal_service.send(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)
```

**Analysis of the Problem:**  

When we run the code, we get the following error message:

```
you_got_mail.rb:93:in `<main>': undefined method `860 Blackbird Ln.' for #<PostalService:0x00007fbf7b8aa600> (NoMethodError)
```

While the message seems a bit ambiguous, treating `860 Blackbird Ln.` as the `undefined method`, my hunch is that the problem originates with the `send` method call on `johns_postal_service`. When examining the `PostalService` class we see that there is no `send` method within that class, nor is there a `send` method in the `CommunicationsProvider` super class from which the `PostalService` class inherits.  

**My Solution:**  

However, there is a `send` method in the `Mailing` module. We could do a mixin with the `CommunicationsProvider` super class, adding the line `include Mailing` within the class definition.

```ruby
class CommunicationsProvider
  attr_reader :name, :account_number
  
  include Mailing						# <= added this line.

  def initialize(name, account_number=nil)
    @name = name
    @account_number = account_number
  end
end
```

Now when we run the code we get the following output printed to the screen,

```
Sending Postcard from John to: 860 Blackbird Ln.
```

which is what we expected.

---

**Launch School's Solution:**  

```ruby
module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send_mail(destination, mail)
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class PostalService < CommunicationsProvider
  include Mailing

  # code omitted
end

puts johns_postal_service.send_mail(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
#=> Sending Postcard from John to: 860 Blackbird Ln.
```

###### Discussion  

This is a case of accidental method overriding.  

On line 91, we intended to call `Mailing#send`, but since we forgot to `include Mailing` in `PostalService`, this does not happen. Why does Ruby not complain that there is no method `send`? First it looks for `send` on the method lookup path, and it actually finds a method with this name in the `Object` class. So it calls `Object#send`, which expects a method name as the first argument. Since the first argument we provide, `'860 Blackbird Ln.'`, is not the name of any method, we get an error.  

In order to avoid overriding `Object#send`, we should rename our `Mailing#send` method to something unique, as seen in the solution above.  

You may wish to review the chapter on Accidental Method Overriding in Launch School's Object Oriented Programming book. Note that you don't need to memorize the `Object#send` method, or try to keep in mind all other methods that `Object` implements. Just be aware that you may encounter code like this in the wild and take caution not to accidentally override built-in methods.