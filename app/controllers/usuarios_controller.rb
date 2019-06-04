class UsuariosController < ApplicationController

	def index
		usuarios = Usuario.order('created_at DESC');
		render json: usuarios,status: :ok
	end

	def show
		usuario = Usuario.find(params[:id])
		render json: usuario,status: :ok
	end
			
	def create
		usuario = Usuario.new(usuario_params)
		if usuario.save
			render json: usuario,status: :ok
		else
			render json: {status: 'ERROR', message:'usuarios not saved', data:usuario.erros},status: :unprocessable_entity
		end
	end
			
	def destroy
		usuario = Usuario.find(params[:id])
		usuario.destroy
		render json: {success:{text:"usuário removido"}},status: :ok
	end

	def deleteByEmail
		begin
			usuario = Usuario.where(:email => usuario_params['email'])
			if usuario != nil then
				usuario.first.destroy
			end
			render json: {success:{text:"usuário removido"}},status: :ok
		rescue ActiveRecord::InvalidForeignKey
			render json: {success:{text:"usuário contem comandas, impossivel de excluir"}},status: :ok
		end
	end
			
	def update
		usuario = Usuario.find(params[:id])
		if usuario.update_attributes(usuario_params)
			render json: {email:usuario.email, senha:usuario.senha},status: :ok
		else
			render json: {status: 'ERROR', message:'usuarios not update', data:usuario.erros},status: :unprocessable_entity
		end
	end
		
	private
	def usuario_params
		params.permit(:email, :senha)
	end

end