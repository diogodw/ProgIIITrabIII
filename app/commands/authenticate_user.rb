class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, senha)
    @email = email
    @senha = senha
  end

  def call
    JsonWebToken.encode(usuario_id: user.id) if user
  end

  private

  attr_accessor :email, :senha

  def user
    user = Usuario.find_by_email(email)
    return user if user && user.authenticate(senha)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end