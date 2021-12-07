# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'SnapshotTesting'
end

target 'GuessTheMovie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GuessTheMovieTests

  target 'GuessTheMovieTests' do
    inherit! :search_paths
    testing_pods
  end

end
