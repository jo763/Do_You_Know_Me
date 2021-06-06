extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

 
var stories = [""]

var selectedName = "bob"
var selectedStory = "There once was a scrub named {name}, who hated {name}"
var completeStory = selectedStory.format({"name" : "test"})
var questionList = []
var questioned_asked
var playerNum
var player
#var player_names
#


onready var file = "res://questions.txt"

# Called when the node enters the scene tree for the first time.
func _ready():
	#player_names = ["Bob", "Rachel", "Jimmy"]
	playerNum = 0
	
	questionList = load_questions()
	print(questionList)
	pass # Replace with function body.

func load_questions():
	var loadedQuestions = []
	var sourceFile = File.new()
	sourceFile.open(file, File.READ)
	while not sourceFile.eof_reached():
		var line = sourceFile.get_line()
		loadedQuestions.append(line)
	sourceFile.close()
	return loadedQuestions
	#file.open(path)
	
	pass
	
func randomiseQuestion(questionList):
	randomize()
	questioned_asked = questionList [randi() % questionList.size()]
	#print(questioned_asked)
	return questioned_asked
	pass

func nextPlayer(player_names, playerNum):
	#print(player_names)
	player = player_names[playerNum]
	return player
	pass	

func form_question(questionList, player_names, playerNum):
	var selectedQuestion = randomiseQuestion(questionList)
	var selectedName = nextPlayer(player_names, playerNum)


	var completeQuestion = selectedQuestion.format({"name" : selectedName})
	print(completeQuestion)
	$Background/RichTextLabel.text = completeQuestion
	pass

func _next_question():
	#print(player_names)
	#print("next question")
	form_question(questionList, GLOBAL.player_names, playerNum)
	playerNum +=1
	if playerNum == GLOBAL.player_names.size():
		playerNum = 0
	pass # Replace with function body.
