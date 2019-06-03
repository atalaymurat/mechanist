ready = ->
    window.initApp = ->
      $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable()

    document.addEventListener 'page:load', initApp

    $ initApp
$(document).ready ready
$(document).on 'turbolinks:load', ready
