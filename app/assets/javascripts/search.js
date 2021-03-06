document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")
  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "companies",
        header: "<strong>Companies</strong>",
      },
      {
        listLocation: "people",
        header: "<strong>People</strong>",
      }
    ],
    list: {
      onChooseEvent: function(){
        var url = $input.getSelectedItemData().url
        $input.val("")
        Turbolinks.visit(url)
      }
    
    }
  }
  $input.easyAutocomplete(options)
});
