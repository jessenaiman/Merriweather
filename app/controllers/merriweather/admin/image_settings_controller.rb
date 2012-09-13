module Merriweather
  module Admin
    class ImageSettingsController < Admin::BaseController
      def show
        styles = ActiveSupport::JSON.decode(Config[:attachment_styles])
        @styles_list = styles.collect { |k, v| k }.join(", ")
      end

      def edit
        @styles = ActiveSupport::JSON.decode(Config[:attachment_styles])
        @headers = ActiveSupport::JSON.decode(Config[:s3_headers])
      end

      def update
        update_styles(params)
        update_headers(params) if Config[:use_s3]

        Config.set(params[:preferences])
        update_paperclip_settings

        respond_to do |format|
          format.html {
            flash[:notice] = t(:image_settings_updated)
            redirect_to admin_image_settings_path
          }
        end
      end


      private

      def update_styles(params)
        params[:new_attachment_styles].each do |index, style|
          params[:attachment_styles][style[:name]] = style[:value] unless style[:value].empty?
        end if params[:new_attachment_styles].present?

        styles = params[:attachment_styles]

        Config[:attachment_styles] = ActiveSupport::JSON.encode(styles) unless styles.nil?
      end

      def update_headers(params)
        params[:new_s3_headers].each do |index, header|
          params[:s3_headers][header[:name]] = header[:value] unless header[:value].empty?
        end if params[:new_s3_headers].present?

        headers = params[:s3_headers]

        Config[:s3_headers] = ActiveSupport::JSON.encode(headers) unless headers.nil?
      end

      def update_paperclip_settings
        if Config[:use_s3]
          s3_creds = { :access_key_id => Config[:s3_access_key], :secret_access_key => Config[:s3_secret], :bucket => Config[:s3_bucket] }
          Image.attachment_definitions[:attachment][:storage] = :s3
          Image.attachment_definitions[:attachment][:s3_credentials] = s3_creds
          Image.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Config[:s3_headers])
          Image.attachment_definitions[:attachment][:bucket] = Config[:s3_bucket]
        else
          Image.attachment_definitions[:attachment].delete :storage
        end

        Image.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Config[:attachment_styles])
        Image.attachment_definitions[:attachment][:path] = Config[:attachment_path]
        Image.attachment_definitions[:attachment][:default_url] = Config[:attachment_default_url]
        Image.attachment_definitions[:attachment][:default_style] = Config[:attachment_default_style]
      end
    end
  end
end

