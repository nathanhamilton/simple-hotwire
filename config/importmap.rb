pin_all_from "app/assets/javascripts"

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'vendor/javascript'
pin_all_from 'assets/controllers'
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"
pin "jquery-ui-dist", to: "https://ga.jspm.io/npm:jquery-ui-dist@1.13.1/jquery-ui.js"
