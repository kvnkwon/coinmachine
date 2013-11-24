require 'pry'
class Register

  def initialize
    @quarter = 25
    @dime = 10
    @nickel = 5
    @penny = 1
    @amount_due = 0
    @given = 0
    @change_owed = 0
  end

  def get_amount
    puts 'What is the amount due?'
    @amount_due = gets.chomp
    if @amount_due.to_f <= 0 || @amount_due =~ /[a-zA-Z]|[^\d.]/
      puts "Invalid input. Please put a valid amount."
      get_amount
    else
      puts "Amount due: $#{sprintf('%.2f', @amount_due.to_f)}"
      given_amount
    end
  end

  def given_amount
    puts "What is the amount given?"
    @given = gets.chomp
    if @given.to_f <= 0 || @given =~ /[a-zA-Z]|[^\d.]/
      puts "Invalid input. Please put a valid amount."
      given_amount
    else
      puts "Amount given by customer: $#{sprintf('%.2f', @given.to_f)}"
      change_calculate
    end
  end

  def change_calculate
    if @given.to_f >= @amount_due.to_f
      @change_owed = @given.to_f - @amount_due.to_f
      @change_owed = sprintf('%.2f', @change_owed)
      change_split
      puts "=== Payment Summary ==="
      puts "Amount due: $#{sprintf('%.2f', @amount_due.to_f)}"
      puts "Amount given by customer: $#{sprintf('%.2f', @given.to_f)}"
      puts "The change due is $#{sprintf('%.2f', @change_owed)}"
      puts "You should issue:"
      which_change
    else
      @change_owed = @amount_due.to_f - @given.to_f
      puts "Customer still needs to pay $#{sprintf('%.2f', @change_owed)}!"
      change_calculate
    end
  end

  def change_split
    string_change = @change_owed.split('.')
    hash_change = {dollar: string_change[0].to_i, cents: string_change[1].to_i}
    quarters = hash_change[:cents].divmod @quarter
    dimes = quarters[1].divmod @dime
    nickels = dimes[1].divmod @nickel
    pennys = nickels[1].divmod @penny
    @dollar = hash_change[:dollar]
    @quarter = quarters[0]
    @dime = dimes[0]
    @nickel = nickels[0]
    @penny = pennys[0]
  end

  def which_change
    puts "#{@dollar} dollar(s)" if @dollar != 0
    puts "#{@quarter} quarter(s)" if @quarter != 0
    puts "#{@dime} dime(s)" if @dime != 0
    puts "#{@nickel} nickel(s)" if @nickel != 0
    puts "#{@penny} penny(s)" if @penny != 0
  end

end