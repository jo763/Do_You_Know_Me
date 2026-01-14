extends Node2D

var questionList:Array = []
var askedQuestions:Array = []
var questioned_asked:String
var playerNum:int
var player:String
var second_player:String
var third_player:String
var playersLeft:Array

@onready var file:String = "res://questions.txt"
@onready var fileMultiPeople:String = "res://questionsMultiPeople.txt"

func _ready():
	playerNum = 0
	questionList = load_questions()

func load_questions():
	var loadedQuestions:Array = []
	var sourceFile = FileAccess.open(file, FileAccess.READ)
	if sourceFile == null:
		push_error("Failed to open questions file!")
	while not sourceFile.eof_reached():
		var line = sourceFile.get_line()
		loadedQuestions.append(line)
	sourceFile.close()
	if len(GLOBAL.player_names) > 2:
		sourceFile = FileAccess.open(fileMultiPeople, FileAccess.READ)
		while not sourceFile.eof_reached():
			var line = sourceFile.get_line()
			loadedQuestions.append(line)
		sourceFile.close()
	return loadedQuestions
	
func randomiseQuestion():
	randomize()
	questioned_asked = questionList [randi() % questionList.size()]
	return questioned_asked

func nextPlayer(player_names):
	player = player_names[playerNum]
	return player

func otherPlayers(player_names):
	playersLeft = GLOBAL.player_names.duplicate()
	playersLeft.erase(player)
	randomize()
	print("playersLeft: ", playersLeft)
	second_player = playersLeft[randi() % playersLeft.size()]
	playersLeft.erase(second_player)
	if len(GLOBAL.player_names) > 2: 
		third_player = playersLeft[randi() % playersLeft.size()]

func form_question( player_names):
	var selectedName = nextPlayer(player_names)
	var completeQuestion
	if len(askedQuestions) >= (len(questionList)-1):
		$Background/RichTextLabel.text = "Sorry, that's all the questions folk!"
		$Background/NextButton.visible = false
	else:
		while true:
			var selectedQuestion = randomiseQuestion()
			completeQuestion = selectedQuestion.format({"name" : selectedName})
			otherPlayers(GLOBAL.player_names)
			completeQuestion = completeQuestion.format({"x" : second_player})
			completeQuestion = completeQuestion.format({"y" : third_player})
			
			if selectedQuestion in askedQuestions:
				continue
			else:
				askedQuestions.append(selectedQuestion)
				break
		
		print(completeQuestion)
		$Background/RichTextLabel.text = completeQuestion

func _next_question():
	form_question(GLOBAL.player_names)
	playerNum +=1
	if playerNum == GLOBAL.player_names.size():
		playerNum = 0
