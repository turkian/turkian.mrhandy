conversation = require('hubot-conversation');

scrumQuestions = [
     'What did you do yesterday?'
    ,'What will you do today?'
    ,'What is blocking or slowing your progress ?'    
]

module.exports = (robot) ->

  switchBoard = new conversation(robot)
    
  robot.respond /scrum/i, (res) ->
        dialog = switchBoard.startDialog(res)
        res.send scrumQuestions[0]
        dialog.addChoice(/[^\s]/i, (res) -> 
                         res.send scrumQuestions[1]
                         dialog.addChoice(/[^\s]/i, (res) ->
                            res.send scrumQuestions[2]
                            dialog.addChoice(/[^\s]/i, (res) ->
                                        res.send "All done"
                                        )
                            )
                        )