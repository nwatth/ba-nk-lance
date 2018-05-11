class Bank
  attr_reader :balance

  def initialize(username, password)
    @session = Capybara::Session.new(:poltergeist)

    @username = username
    @password = password

    config
  end

  def process!
    enter_login_page
    login
    enter_summary_page
    find_balance
    notify
    logout
  end

  def enter_login_page
  end

  def login
  end

  def enter_summary_page
  end

  def find_balance
  end

  def notify
  end

  def logout
    @session.driver.clear_cookies
    @session.driver.quit
  end

  def config
    @session.driver.options[:phantomjs] = Phantomjs.path
  end
end
