// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery-ui-dist"

console.log(window.$)
console.log($.ui)
// Define a variable to check in inlined HTML script
window.importmapScriptsLoaded = true;