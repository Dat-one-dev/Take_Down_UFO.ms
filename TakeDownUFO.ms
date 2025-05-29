clear

// Load the image
gfx.drawImage file.loadImage("/usr/Bg.png")
rock = new Sprite ; Blast = new Sprite; UFO = new Sprite
gfx
rock.image = file.loadImage("/sys/pics/Rock.png")
UFO.image = file.loadImage("/sys/pics/UFO.png")
Blast.image = file.loadImage("/sys/pics/Burst.png")

UFO.x = 300;UFO.y = 500;UFO.scale = 2
Blast.x = UFO.x; Blast.y = UFO.y

initial_position = {"x": 960/2, "y": 100}
rock.x = initial_position.x
rock.y = initial_position.y

// Define the bounds
UFO.localBounds = new Bounds
UFO.localBounds.width = UFO.image.width
UFO.localBounds.height = UFO.image.height
rock.localBounds = new Bounds
rock.localBounds.width = rock.image.width
rock.localBounds.height = rock.image.height

// Add to scene
display(4).sprites.push rock
display(4).sprites.push UFO
UFO_health = 100
// Drag variables
isDragging = false
wasDragging = true
dragOffset = {"x": 0, "y": 0}

update = function()
	if UFO_health > 0 then
		dx = rnd * -25 + (UFO_health - 100)
		Blast.x = UFO.x
		UFO.x = UFO.x + dx
		if UFO.x >= 960 then
			UFO.x = 0
		else if UFO.x <= 0 then 
			UFO.x = 960
		end if
	end if
end function 


while true
	if UFO_health == 0 or UFO_health < 0 then
		print "UFO Succesfully taken down"
		display(4).sprites.remove UFO
		break 
	end if
	update()
	isDown = mouse.button
	if isDown and rock.contains(mouse) and not isDragging then
		isDragging = true
		dragOffset.x = mouse.x - rock.x
		dragOffset.y = mouse.y - rock.y
	end if
	
	if isDragging then
		rock.x = mouse.x - dragOffset.x
		rock.y = mouse.y - dragOffset.y
		
		if not isDown then 
			if UFO.contains(rock) then 
				print "UFO under attack"
				UFO_health = UFO_health - 10
				print "UFO Health: " + UFO_health
				isDragging = false
				rock.x = initial_position.x
				rock.y = initial_position.y
				display(4).sprites.push Blast
			else 
				isDragging = false
				rock.x = initial_position.x
				rock.y = initial_position.y
			end if
		end if
	end if
	
	yield
end while
