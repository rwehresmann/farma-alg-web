module ClassRoom
  class EnrollmentPolicy < ApplicationPolicy
    def create?
      @record.password == @record.received_password      
    end
  end
end
