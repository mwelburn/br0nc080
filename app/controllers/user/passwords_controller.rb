class User
  class Private
    class RegistrationsController < Devise::RegistrationsController

    end
  end

  class Private
    class SessionsController < Devise::SessionsController

    end
  end

  class Private
    class PasswordsController < Devise::PasswordsController
      
    end
  end
end
