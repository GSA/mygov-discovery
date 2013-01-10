class AddTrailingPeriodToHostname < ActiveRecord::Migration
  def up
    Domain.all.each do |domain|
      domain.hostname_reversed = domain.hostname_reversed + '.'
      domain.save
    end
  end
  
  def down
    Domain.all.each do |domain|
      domain.hostname_reversed = domain.hostname_reversed[0..-2]
      domain.save
    end  
  end
  
end
