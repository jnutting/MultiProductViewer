Pod::Spec.new do |s|
  s.name = 'MultiProductViewer'
  s.version = '0.0.7'
  s.license = 'MIT'
  s.homepage = 'https://github.com/jnutting/MultiProductViewer'
  s.summary = 'In an iOS app, present a listing of other apps to users'
  s.description = <<-DESC
MultiProductViewer implements a GUI for displaying multiple App Store products in a scrolling list. By tapping on a product, the user is taken to a page where they can see more info about the app and purchase it, using SKStoreProductViewController.
DESC
  s.authors = 'Jack Nutting'
  s.social_media_url = 'https://mastodon.nu/@jacknutting'

  s.ios.deployment_target = '15.6'
  s.source = {
    :git => 'https://github.com/jnutting/MultiProductViewer.git',
    :tag => s.version.to_s
  }
  s.source_files = 'MultiProductViewer/TBTMultiProductViewController/*.{h,m}'
  s.resource_bundles = {
    'MultiProductViewer' => ['MultiProductViewer/TBTMultiProductImages.xcassets',
		  'MultiProductViewer/TBTMultiProductViewController/*.xib']
  }

  s.requires_arc = true
end
