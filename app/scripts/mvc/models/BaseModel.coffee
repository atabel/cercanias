class __Model.BaseModel extends Monocle.Model

    @updateOrCreate: (attributes) ->
        model = @findBy 'id', attributes.id
        if model
            model.updateAttributes attributes
        else
            @create attributes
