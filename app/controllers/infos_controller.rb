class InfosController < ApplicationController

	def contact_us
		@contact = Contact.create(name: params[:name],subject: params[:subject],description: params[:description])	
		if @contact.id != nil
			render :json => {
                    		:response_code => 200,
                    		:response_message => "Query submitted successfully"  ,
                    		:user => @contact.as_json(:only=>[:name,:subject,:description])                     
                            }
		else
			render :json => {
                            :response_code => 500,
                            :response_message => @contact.errors.messages.map{ |k,v| "#{k.capitalize.to_s.gsub('_',' ')} #{v.first}"}.join(', ')+"."                          
                            }

		end					
	end

	def about_us
	   @page = Info.find_by_page_name("About us")
	   if @page
		   render :json => {
	                       :response_code => 200,
	                       :response_message => "About us page info"  ,
	                       :description => @page.description
	                       }
	   else
	   	   render :json => {
                           :response_code => 500,
                           :response_message => "Page not found"                          
                           }
	   end
	end

	def terms_conditions
	   @page = Info.find_by_page_name("Policy")
	   if @page
		   	render :json => {
	                         :response_code => 200,
	                         :response_message => "Terms & Conditions"  ,
	                         :description => @page.description
	                        }
	   else
	   		render :json => {
                            :response_code => 500,
                            :response_message => "Page not found"                          
                            }
	   end
	end

	def subscription
		@page = Info.find_by_page_name("Subscription")
		if @page
			render :json => {
	                        :response_code => 200,
	                        :response_message => "Subscription"  ,
	                        :description => @page.description
	                        }
	   else
	   		render :json => {
                            :response_code => 500,
                            :response_message => "Page not found"                          
                            }
	   end
    end
end
