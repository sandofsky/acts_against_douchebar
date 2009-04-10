# Include hook code here
class ActionController::Base
  def self.acts_against_douchebar(options = {})
    @@douchbar_filter_message = options[:with] || <<-END
    &quot;Dear Digg,<br />
    Framing sites is bullshit.<br />
    <br />
    Your pal,
    <a href="http://daringfireball.net">--J.G.</a>&quot;
    END
    before_filter :acts_against_douchbar_filter
  end
  private
  def acts_against_douchbar_filter
    logger.info("Referrer: #{request.referer}")
    if request.referer =~ %r{http://digg.com/\w{1,8}/*(\?.*)?$}
      render :text => @@douchbar_filter_message
      return false
    else
      return true
    end
  end
end