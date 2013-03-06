minLength = 3 * 60 * 1000 
maxLength = 4 * 60 * 1000

($ ->
    submitForm = ->
        $("#new_post").submit()
        
    randomLength = ->
        Math.round(Math.random() * (maxLength - minLength)) + minLength
        
    typingTimeout = null
    creationTimeout = null
    
    $("#post_content").keypress( -> 
        $("div#overlay").fadeIn(250)
        creationTimeout = setTimeout(submitForm, randomLength()) if !creationTimeout?
        clearTimeout(typingTimeout) if typingTimeout?
        typingTimeout= setTimeout(submitForm, 2000)
    )

    $("#post_content").keydown((event)->
        event.preventDefault() if event.which in [8, 9, 37, 38, 39, 40]
    )
    
    
    $("div#overlay").css("height", $(document).height()).hide()
    
)