conversation = require('hubot-conversation');
switchBoard = null

scrumQuestions = [
     'What did you do yesterday?'
    ,'What will you do today?'
    ,'What is blocking or slowing your progress ?'    
]

scrumConfirmation =
'Ok, just to be sure.\n
*Yesterday*, you have done.\n
*Today*, you are doing.\n
*Blocking*, You need this to be solved.\n
\n
Is ok with you (yes or no)?'

scrumDone = 'All done, see ya tomorrow.'

scrumDoingItAgain = 'Alright, restarting from the top.'

scrumRestateYourAnswer = 'I do not understand please say yes or no.'

module.exports = (robot) ->

  switchBoard = new conversation(robot)
    
  robot.respond /scrum/i, (res) ->
        dialog = switchBoard.startDialog(res, 60000)
        askFirstQuestion res
        
askFirstQuestion = (res) ->
    dialog = switchBoard.talkingTo res.message.user.id
    res.send scrumQuestions[0]
    dialog.addChoice(/[^\s]/i, askSecondQuestion) 

askSecondQuestion = (res) ->
    dialog = switchBoard.talkingTo res.message.user.id
    res.send scrumQuestions[1]
    dialog.addChoice(/[^\s]/i, askThirdQuestion) 

askThirdQuestion = (res) ->
    dialog = switchBoard.talkingTo res.message.user.id
    res.send scrumQuestions[2]
    dialog.addChoice(/[^\s]/i, askConfirmation)

askConfirmation = (res) ->
    dialog = switchBoard.talkingTo res.message.user.id
    res.send scrumConfirmation
    dialog.addChoice(/yes/i, scrumCompleted)
    dialog.addChoice(/no/i, scrumRestart)
    dialog.addChoice(/(.*?)/i, scrumNotSure)

scrumCompleted = (res) ->
    res.send scrumDone

scrumRestart = (res) ->
    res.send scrumDoingItAgain
    askFirstQuestion res
        
scrumNotSure = (res) ->
    res.send scrumRestateYourAnswer
    askConfirmation res