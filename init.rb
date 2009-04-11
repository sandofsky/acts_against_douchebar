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
  
  # Thank wikipedia: http://en.wikipedia.org/wiki/Framekiller
  @@douchbar_breakout_text = <<-END
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head><script type="text/javascript">top.location.href = self.location.href</script></head>
  <body>We are now redirecting you to the full quality site.</body>
</html>
  END
  
  def acts_against_douchbar_filter
    if request.referer =~ %r{http://digg.com/\w{1,8}/*(\?.*)?$}
      render :text => (@@douchbar_filter_message == :frame_killer ? @@douchbar_breakout_text : @@douchbar_filter_message)
      return false
    else
      return true
    end
  end
end