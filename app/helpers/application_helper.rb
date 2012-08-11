module ApplicationHelper
  def conditional_html(&block)
    lang = I18n.locale
    html = <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]>    <html lang="#{lang}" class="ie ie6"> <![endif]-->
      <!--[if IE 7 ]>       <html lang="#{lang}" class="ie ie7"> <![endif]-->
      <!--[if IE 8 ]>       <html lang="#{lang}" class="ie ie8"> <![endif]-->
      <!--[if IE 9 ]>       <html lang="#{lang}" class="ie ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}"> <!--<![endif]-->
      <!--[if lt IE 9]>
      <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
      <![endif]-->  
    HTML
    html += capture( &block ) << "\n</html>".html_safe if block_given?
    html.html_safe
  end
end
