class KBank < Bank
  def enter_login_page
    @session.visit('https://online.kasikornbankgroup.com/K-Online/')
  end

  def login
    @session.fill_in('userName', with: @username)
    @session.fill_in('password', with: @password)
    @session.click_button('เข้าสู่ระบบ')
  end

  def enter_summary_page
    @session.visit('https://ebank.kasikornbankgroup.com/retail/cashmanagement/inquiry/AccountSummary.do?action=list_domain2')
  end

  def find_balance
    @balance = @session.all('td.bodycopy_normal').last.text.to_f
  end
end
