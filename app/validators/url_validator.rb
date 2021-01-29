class UrlValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        record.errors.add(attribute, message: options[:message] || "must be a valid url") unless url_valid?(value)
    end

    def url_valid?(url)
        url =~ /^#{URI::regexp}$/
    end
end
