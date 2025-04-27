extends Control


func set_score(new_score: int):
	$Score.text = "SCORE: "+str(new_score)


func set_lives(lives: int):
	$LivesLeft.text = "x "+str(lives)
