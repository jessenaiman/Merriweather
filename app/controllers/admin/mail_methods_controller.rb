#module Merriweather
  module Admin
    class MailMethodsController < ResourceController
      after_filter :initialize_mail_settings

      def testmail
        @mail_method = Merriweather::MailMethod.find(params[:id])
        if TestMailer.test_email(@mail_method, try_merriweather_current_user).deliver
          flash.notice = t('admin.mail_methods.testmail.delivery_success')
        else
          flash[:error] = t('admin.mail_methods.testmail.delivery_error')
        end
      rescue Exception => e
        flash[:error] = t('admin.mail_methods.testmail.error') % {:e => e}
      ensure
        respond_with(@mail_method) { |format| format.html { redirect_to :back } }
      end

      private
      def initialize_mail_settings
        Merriweather::Core::MailSettings.init
      end
    end
  end
#end
