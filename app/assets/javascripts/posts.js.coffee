($ ->
    submitForm = ->
        $("#new_post").submit()
        
    typingTimeout = null
    
    $("#post_content").keypress( -> 
        clearTimeout(typingTimeout) if typingTimeout?
        typingTimeout= setTimeout(submitForm, 2000)        
    )

    $("#post_content").keydown((event)->
        event.preventDefault() if event.which == 8 || event.which == 9
    )
)