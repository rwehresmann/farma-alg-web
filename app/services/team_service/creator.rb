module TeamService
  class Creator
    def initialize(args = {})
      @user = args[:user]
      @team = Team.new(
        name: args[:name], 
        description: args[:description],
        password: args[:password],
        user: @user,
      )
    end

    def call
      @user.add_role(:teacher, @team) if @team.save
      
      @team
    end
  end
end
