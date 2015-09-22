module AdminHelper
	def product_list
		arr = []; arr << ['PLEASE SELECT', '']
		Product.where(restaurant_id: params[:id]).collect{|l| arr << [l.name, l.id]}
		arr
	end
end
