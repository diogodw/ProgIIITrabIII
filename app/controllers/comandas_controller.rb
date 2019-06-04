class ComandasController < ApplicationController

	def index
		comandas = Comanda.order('created_at DESC');
		response = []
		comandas.each do |comanda|
			response.push(reverse(comanda))
		end
		render json: response,status: :ok
	end

	def show
		comanda = Comanda.find(params[:id])
		render json: reverse(comanda),status: :ok
	end
			
	def create
	#	render json: convert(comanda_params),status: :ok
	#end
		comanda = Comanda.new(convert(comanda_params))
		if comanda.save
			render json: reverse(comanda),status: :ok
		else
			render json: {status: 'ERROR', message:'comandas not saved', data:comanda.erros},status: :unprocessable_entity
		end
	end
			
	def destroy
		comanda = Comanda.find(params[:id])
		comanda.destroy
		render json: {"success":{"text":"comanda removida"}},status: :ok
	end

	def update
		comanda = Comanda.find(params[:id])
		if comanda.update_attributes(convert(comanda_params))
			render json: reverse(comanda),status: :ok
		else
			render json: {status: 'ERROR', message:'comandas not update', data:comanda.erros},status: :unprocessable_entity
		end
	end

	private
	def reverse(comanda)
		return {produtos: comanda.produtos, valortotal: comanda.valortotal, id: comanda.id, idusuario: comanda.usuario_id}
	end
		
	private 
	def convert(params)
		response = Hash.new
		response['produtos'] = params['produtos']
		response['valortotal'] = params['valortotal']
		response['usuario'] = Usuario.find(params['idusuario'])
		return response
	end

	private
	def comanda_params
		params.permit(:produtos, :valortotal, :idusuario)
	end

end