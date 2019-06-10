class UsuariosController < ApplicationController

	skip_before_action :authenticate_request, only: [:create], raise: false
	
	def index
		usuarios = Usuario.order('created_at DESC');
		response = []
		usuarios.each do |usuario|
			response.push(reverse(usuario))
		end
		render json: response,status: :ok
	end

	def show
		usuario = Usuario.find(params[:id])
		render json: reverse(usuario),status: :ok
	end
			
	def create
		usuario = Usuario.new(convert(usuario_params))
		if usuario.save
			render json: reverse(usuario),status: :ok
		else
			render json: {status: 'ERROR', message:'Dados incorretos', data:usuario},status: 400
		end
	end
			
	def destroy
		begin
			usuario = Usuario.find(params[:id])
			usuario.destroy
			render json: {success:{text:"usuário removido"}},status: :ok
		rescue ActiveRecord::InvalidForeignKey
			render json: {success:{text:"usuário contem comandas, impossivel de excluir"}},status: :ok
		end
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
			render json: {status: 'ERROR', message:'Dados incorretos', data:usuario.erros},status: 400
		end
	end
		
	private
	def reverse(usuario)
		return {email: usuario.email, senha: usuario.senha, id: usuario.id}
	end
		
	private 
	def convert(params)
		response = Hash.new
		response['email'] = params['email']
		response['senha'] = params['senha']
		response['password'] = params['senha']
		return response
	end

	private
	def usuario_params
		params.permit(:email, :senha)
	end

end