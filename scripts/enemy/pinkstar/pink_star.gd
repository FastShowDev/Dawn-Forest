extends EnemyTemplate
class_name PinkStar

func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/item/consumable/health_potion.png",
			25, #Porcentage
			"Health",
			5, #Health value
			2 #Sell value
		],
		
		"Mana Potion": [
			"res://assets/item/consumable/mana_potion.png",
			15,
			"Mana",
			5,
			5
		],
		
		"Pink Star Mouth": [
			"res://assets/item/resource/pink_star/pink_star_mouth.png",
			47,
			"Resource",
			{},
			5
		],
		
		"Pink Star Bow": [
			"res://assets/item/equipment/pink_star_bow.png",
			1,
			"Weapon",
			{
				"Attack": 5
			},
			60
		],
		
		"Pink Star Belt": [
			"res://assets/item/equipment/pink_star_belt.png",
			3,
			"Equipament",
			{
				"Health": 5,
				"Mana": 5
			},
			40
		],
		
		"Pink Star Shield": [
			"res://assets/item/equipment/pink_star_shield.png",
			1,
			"Weapon",
			{
				"Health": 3,
				"Defense": 3,
			},
			75
		]
	}
	
