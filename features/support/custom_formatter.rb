require 'cucumber/formatter/html'

class CustomFormatter < Cucumber::Formatter::Html

  def embed(src, mime_type, label)
    if /^image\/(png|gif|jpg|jpeg)/.match mime_type then
      embed_image(src, label)
    elsif /^text\/plain/.match mime_type then
      embed_link(src, label)
    elsif /^text\/html/.match mime_type then
      embed_link(src, label)
    end
  end


  def embed_text(src, label)
    id = "img_#{@img_id}"
    @img_id += 1
    @builder.div(:class => 'embed') do |pre|
      pre << %{<a href="" onclick="img=document.getElementById('#{id}'); img.style.display = (img.style.display == 'none' ? 'block' : 'none');return false">#{label}</a>
      <pre id="#{id}" style="display: none">#{src}</pre>}
    end
  end

  def embed_link(href, label)
    @builder.div(:class => 'embed') do |pre|
      pre << %{<a href="#{href}">#{label}</a>}
    end
  end

	def embed_image(src, label)
      id = "img_#{@img_id}"
      @img_id += 1
      @builder.div(:class => 'embed') do |pre|
        pre << %{<a href="" onclick="img=document.getElementById('#{id}'); img.style.display = (img.style.display == 'none' ? 'block' : 'none');return false">#{label}</a>
        <img id="#{id}" style="display: none" src="#{src}"/>}
      end
    end

  def before_steps(steps)
    @builder << '<ol style="display:none">'
  end

end
