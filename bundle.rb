require 'java'
require 'radrails'

bundle 'Sass' do |bundle|
  bundle.author = 'Bob Aman'
  bundle.contact_email_rot_13 = 'obo@fcbexzbatre.pbz'
  bundle.description =  <<END
Template language for easily creating CSS; implemented in ruby.
END
  bundle.repository = 'http://github.com/aptana/sass-ruble.git'
  
  bundle.menu 'Sass' do |main_menu|
    main_menu.scope = ['source.sass', 'source.css']
    
    main_menu.menu 'Background' do |submenu|
      submenu.command 'background: color image repeat attachment position copy'
      submenu.separator
      submenu.command 'background-color: rgb'
      submenu.command 'background-color: rgba'
      submenu.command 'background-color: name'
      submenu.command 'background-color: transparent'
      submenu.separator
      submenu.command 'background-image: url'
      submenu.command 'background-image: none'
      submenu.separator
      submenu.command 'background-attachment: scroll/fixed'
      submenu.command 'background-position: position'
      submenu.command 'background-repeat: r/r-x/r-y/n-r'
    end
    main_menu.menu 'Border' do |submenu|
      submenu.command 'border: size style color copy'
      submenu.command 'border-top: size style color'
      submenu.command 'border-right: size style color'
      submenu.command 'border-bottom: size style color'
      submenu.command 'border-left: size style color'
      submenu.separator
      submenu.command 'border-width: size'
      submenu.command 'border-top-width: size'
      submenu.command 'border-right-width: size'
      submenu.command 'border-bottom-width: size'
      submenu.command 'border-left-width: size'
      submenu.separator
      submenu.command 'border-style: style'
      submenu.command 'border-top-style: style'
      submenu.command 'border-right-style: style'
      submenu.command 'border-bottom-style: style'
      submenu.command 'border-left-style: style'
      submenu.separator
      submenu.command 'border-color: color'
      submenu.command 'border-top-color: color'
      submenu.command 'border-right-color: color'
      submenu.command 'border-bottom-color: color'
      submenu.command 'border-left-color: color'
      submenu.separator
      submenu.command 'border-radius:'
    end
    main_menu.menu 'Cursor' do |submenu|
      submenu.command 'cursor: type'
      submenu.command 'cursor: url'
    end
    main_menu.menu 'Color' do |submenu|
      submenu.command 'color: hex'
      submenu.command 'color: rgb'
      submenu.command 'color: name'
    end
    main_menu.menu 'Display' do |submenu|
      submenu.command 'display: inline'
      submenu.command 'display: block'
      submenu.command 'display: common-types'
      submenu.command 'display: table-types'
    end
    main_menu.menu 'Font' do |submenu|
      submenu.command 'font: size font'
      submenu.command 'font: style variant weight size/line-height font-family'
      submenu.separator
      submenu.command 'font-family: family'
      submenu.command 'font-size: size'
      submenu.command 'font-style: normal/italic/oblique'
      submenu.command 'font-variant: normal/small-caps'
      submenu.command 'font-weight: weight'
    end
    main_menu.menu 'List Style' do |submenu|
      submenu.command 'list-style: type position image'
      submenu.command 'list-style-image: url'
      submenu.command 'list-style-position: pos'
      submenu.separator
      submenu.command 'list-style-type: marker'
      submenu.command 'list-style-type: numeric'
      submenu.command 'list-style-type: roman-alpha-greek'
      submenu.command 'list-style-type: asian'
      submenu.command 'list-style-type: other'
    end
    main_menu.menu 'Margin' do |submenu|
      submenu.command 'margin: T R B L'
      submenu.command 'margin: all'
      submenu.command 'margin: V H'
      submenu.separator
      submenu.command 'margin-top: length'
      submenu.command 'margin-right: length'
      submenu.command 'margin-bottom: length'
      submenu.command 'margin-left: length'
    end
    main_menu.menu 'Padding' do |submenu|
      submenu.command 'padding: T R B L'
      submenu.command 'padding: all'
      submenu.command 'padding: V H'
      submenu.separator
      submenu.command 'padding-top: length'
      submenu.command 'padding-right: length'
      submenu.command 'padding-bottom: length'
      submenu.command 'padding-left: length'
    end
    main_menu.menu 'Text' do |submenu|
      submenu.command 'text-align: left/center/right'
      submenu.command 'text-decoration: none/underline/overline/line-through/blink'
      submenu.command 'text-indent: length'
      submenu.separator
      submenu.command 'text-shadow: color-hex x y blur'
      submenu.command 'text-shadow: color-rgb x y blur'
      submenu.command 'text-shadow: none'
      submenu.separator
      submenu.command 'text-transform: capitalize/upper/lower'
      submenu.command 'text-transform: none'
    end
    main_menu.separator
    main_menu.menu 'Other' do |submenu|
      submenu.command 'Attribute Selector'
      submenu.command 'background-color: hex'
      submenu.command 'box-shadow:'
      submenu.command 'clear: value'
      submenu.command 'direction: ltr/rtl'
      submenu.command 'float: left/right/none'
      submenu.command 'letter-spacing: em'
      submenu.command 'letter-spacing: px'
      submenu.command 'marker-offset: length'
      submenu.command 'marker-offset: auto'
      submenu.command 'overflow: type'
      submenu.command 'position: type'
      submenu.command 'vertical-align: type'
      submenu.command 'visibility: type'
      submenu.command 'white-space: normal/pre/nowrap'
      submenu.command 'word-spacing: length'
      submenu.command 'word-spacing: normal'
      submenu.command 'z-index: index'
    end
    main_menu.command 'Compile SASS'
    main_menu.command 'Convert CSS to SASS'
    main_menu.command 'Insert Color...'
    main_menu.command 'Update Bundle'
  end
end

# Extend RadRails::Editor to add special ENV vars
module RadRails
  class Editor
    alias :pre_sass_env :to_env
    def to_env
      env_hash = pre_sass_env
      scopes = current_scope.split(' ')
      if scopes.include? "source.sass"
        env_hash['TM_COMMENT_START'] = "// "
        env_hash['TM_COMMENT_START_2'] = "/*"
      end
      env_hash
    end
  end
end