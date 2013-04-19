class UserData
  @current_msisdn_number = 80
  @current_ES_msisdn_number = 30
  @current_email_number = 5
  @email_domain_based_in_time = '' + (Time.now.to_i.to_s) + '.example.com'
  @used_email_list = []
  @used_msisdn_list = []
  class << self
    attr_accessor :current_email_number
    attr_accessor :current_msisdn_number
    attr_accessor :current_ES_msisdn_number
    attr_accessor :email_domain_based_in_time
    attr_accessor :used_email_list
    attr_accessor :used_msisdn_list
  end
  def initialize
    @usual_password = 'Victor123'
    @usual_msisdn_1 = '+44778545659964'
    @usual_msisdn_2 = '+44778545659961'
    @usual_msisdn_3 = '+44778545659966'
    @usual_msisdn_4 = '+44778545659963'
    @usual_msisdn_5 =  '+44778545659968'
    @usual_msisdn_base = '+447000000000'
    @usual_email_username_base = 'test_loginapp_'
    @usual_email_domain = '008.example.com'
    @PT_msisdn_1 = '+351910859349'
    @PT_number_1 = '910859349'
    @PT_password_1 = '87904231'
    @NL_msisdn_1 = '31655200181'
    @NL_password_1 = 'vodafone01'
    @DE_msisdn_1 = '497589024941'
    @DE_username_1 = 'devsaml2'
    @DE_password_1 = 'devsaml2'
    @ES_msisdn_1 = '+34600000023'
    @ES_password_1 = '1212'
    @ES_msisdn_base = '+34600000'

    self.class.used_msisdn_list.push(@usual_msisdn_1)
#    self.class.used_msisdn_list.push(@usual_msisdn_2)
    self.class.used_msisdn_list.push(@usual_msisdn_3)
    self.class.used_msisdn_list.push(@usual_msisdn_4)
    self.class.used_msisdn_list.push(@usual_msisdn_5)
    self.class.used_msisdn_list.push(@PT_msisdn_1)
    self.class.used_msisdn_list.push(@NL_msisdn_1)
    self.class.used_msisdn_list.push(@DE_msisdn_1)
    self.class.used_msisdn_list.push(@ES_msisdn_1)
  end

  def get_current_email
    return @usual_email_username_base + self.class.current_email_number.to_s + '@' + self.class.email_domain_based_in_time
  end

  def generate_next_email
    self.class.current_email_number += 1
    e = get_current_email
    self.class.used_email_list.push(e)
    return e
  end

  def get_current_msisdn
    num = self.class.current_msisdn_number.to_s
    return @usual_msisdn_base.to_s + '0'*(3-num.length) + num
  end

  def generate_next_msisdn
    self.class.current_msisdn_number += 1
    m = get_current_msisdn
    self.class.used_msisdn_list.push(m)
    return m
  end

  def get_current_ES_msisdn
    num = self.class.current_ES_msisdn_number.to_s
    return @ES_msisdn_base.to_s + '0'*(3-num.length) + num
  end

  def generate_next_ES_msisdn
    self.class.current_ES_msisdn_number += 1
    m = get_current_ES_msisdn
    self.class.used_msisdn_list.push(m)
    return m
  end

  def get_email(email)
    if email == 'next_email'
      return generate_next_email
    elsif email == 'current_email'
      puts 'get_current_email='+get_current_email
      return get_current_email
    end
    return email
  end

  def get_msisdn(msisdn)
      if msisdn == 'next_msisdn'
        return generate_next_msisdn
      elsif msisdn == 'current_msisdn'
        return get_current_msisdn
      elsif msisdn == 'usual_msisdn_1'
        return @usual_msisdn_1
      elsif msisdn == 'usual_msisdn_2'
        return @usual_msisdn_2
      elsif msisdn == 'usual_msisdn_3'
        return @usual_msisdn_3
      elsif msisdn == 'usual_msisdn_4'
        return @usual_msisdn_4
      elsif msisdn == 'usual_msisdn_5'
        return @usual_msisdn_5
      elsif msisdn == 'PT_msisdn_1'
        return @PT_msisdn_1
      elsif msisdn == 'PT_number_1'
        return @PT_number_1
      elsif msisdn == 'NL_msisdn_1'
        return @NL_msisdn_1
      elsif msisdn == 'DE_msisdn_1'
        return @DE_msisdn_1
      elsif msisdn == 'DE_username_1'
        return @DE_username_1
      elsif msisdn == 'ES_msisdn_1'
        return @ES_msisdn_1
      elsif msisdn == 'current_ES_msisdn'
        return get_current_ES_msisdn
      end
      return msisdn
  end

  def get_password(password)
    if password == 'usual_password'
      return @usual_password
    elsif password == 'PT_password_1'
      return @PT_password_1
    elsif password == 'NL_password_1'
      return @NL_password_1
    elsif password == 'DE_password_1'
      return @DE_password_1
    elsif password == 'ES_password_1'
      return @ES_password_1
    end
    return password
  end

  def get_used_emails
    return self.class.used_email_list;
  end

  def get_used_msisdns
    return self.class.used_msisdn_list
  end

end