submitForm = ->
    $("#new_post").submit()
$ ->
    $("#post_content").keypress( -> 
        clearTimeout(window.typingTimeout) if window.typingTimeout?
        window.typingTimeout= setTimeout(submitForm, 2000)        
    )
$ ->
    $("#post_content").keydown((event)->
        event.preventDefault() if event.which == 8 || event.which == 9
    )