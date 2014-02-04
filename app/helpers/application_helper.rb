module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
  	base_title = "Maia"
  	page_title.empty? ? 
  										base_title 
  									: "#{base_title} | #{page_title}"
	end

	def markdown(text)
  	options = {
    	filter_html:     true,
    	hard_wrap:       true, 
    	link_attributes: { rel: 'nofollow', target: "_blank" },
    	space_after_headers: true, 
    	fenced_code_blocks: true
  	}

    extensions = {
	    autolink:           true,
	    superscript:        true,
	  }

  	renderer = Redcarpet::Render::HTML.new(options)
  	markdown = Redcarpet::Markdown.new(renderer, extensions)

  	markdown.render(text).html_safe
  end
end
