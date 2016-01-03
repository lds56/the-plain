module Jekyll

  class ListPage < Page
    def initialize(site, base, dir, val)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'list.html')
      self.data['val'] = val
    end
  end
  
  class CategoryPage < ListPage
    def initialize(site, base, dir, val)
      super(site, base, dir, val)

      self.data['type'] = 'category'

      # category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      # self.data['title'] = "#{category_title_prefix}#{category}"
    end
  end

  class TagPage < ListPage
    def initialize(site, base, dir, val)
      super(site, base, dir, val)

      self.data['type'] = 'tag'
      
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'list'
        dir = site.config['category_dir'] || 'categories'
        site.categories.each_key do |category|
          site.pages << CategoryPage.new(site, site.source, File.join(dir, category), category)
        end

        dir = site.config['tag_dir'] || 'tags'
        site.tags.each_key do |tag|
          site.pages << TagPage.new(site, site.source, File.join(dir, tag), tag)
        end
      end
    end
  end

end
