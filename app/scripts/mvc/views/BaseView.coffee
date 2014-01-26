class __View.BaseView extends Monocle.View

    onBeforeRender: (method, elements...) ->
        [method, elements]

    onAfterRender: (method, elements...) ->
        @

    _html: (method, elements...) ->
        [method, elements] = @onBeforeRender method, elements...
        super method, elements...
        @onAfterRender method, elements...
        @

    _loadTemplateFrom: (url) ->
        unless Monocle.Templates[url]
            loader = if $$? then $$ else $
            response = loader.ajax
                            url: url
                            async: false
                            dataType: 'text'
                            error: -> console.error arguments
            response = response.responseText unless $$?
            Monocle.Templates[url] = response

        @template = Monocle.Templates[url]