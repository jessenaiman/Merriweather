require 'spec_helper'

describe Merriweather::OrdersController do
  after do
    Merriweather::OrdersController.clear_overrides!
  end

  context "extension testing" do
    context "update" do

      context "specify symbol for handler instead of Proc" do
        before do
          @order = create(:order)
          Merriweather::OrdersController.class_eval do
            respond_override({:update => {:html => {:success => :success_method}}})

            private

            def success_method
              render :text => 'success!!!'
            end
          end
        end
        describe "POST" do
          it "has value success" do
            Merriweather_put :update, {}, {:order_id => @order.id}
            response.should be_success
            assert (response.body =~ /success!!!/)
          end
        end
      end

      context "render" do
        before do
          @order = create(:order)
          Merriweather::OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { render(:text => 'success!!!') }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            Merriweather_put :update, {}, {:order_id => @order.id}
            response.should be_success
            assert (response.body =~ /success!!!/)
          end
        end
      end

      context "redirect" do
        before do
          @order = create(:order)
          Merriweather::OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { redirect_to(Merriweather::Order.first) }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            Merriweather_put :update, {}, {:order_id => @order.id}
            response.should be_redirect
          end
        end
      end

      context "validation error" do
        before do
          @order = create(:order)
          Merriweather::Order.update_all :state => 'address'
          Merriweather::OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { render(:text => 'success!!!') }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            Merriweather_put :update, {:order => {:email => ''}}, {:order_id => @order.id}
            response.should be_success
            assert (response.body =~ /failure!!!/)
          end
        end
      end

      context 'A different controllers respond_override. Regression test for #1301' do
        before do
          @order = create(:order)
          Merriweather::Admin::OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { render(:text => 'success!!!') }}}})
          end
        end
        describe "POST" do
          it "should not effect the wrong controller" do
            Merriweather::Responder.should_not_receive(:call)
            Merriweather_put :update, {}, {:order_id => @order.id}
            response.should redirect_to(Merriweather.cart_path)
          end
        end
      end

    end
  end

end
