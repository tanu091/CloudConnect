Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "CloudConnect"
s.summary = "CloudConnect lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "1.0.5"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Ashish Awasthi" => "myemail.awasthi@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/awasthi027/cloudconnect"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/awasthi027/cloudconnect.git", 
             :tag => "#{s.version}" }

# 7
#s.framework = "UIKit"
#s.dependency = "Foundation"


# 8
s.source_files = "CloudConnect/**/*.{swift}"

# 9
#s.resources = "CloudConnect/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.4.2"

end
