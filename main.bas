symbol oldLightValue = b4
symbol curLightValue = b5
symbol delta = b6
symbol threshold = b7
symbol isOn = b8

; detect light chagne to dark if significant change then activate 


symbol buzzer = B.2
symbol LED_STRIP = B.0
symbol LDR = B.4

let delta = 0
let oldLightValue = 0
let curLightValue = 0
let threshold = 30
let isOn = 0

main:
	readadc LDR,curLightValue ;
	gosub print
	if curLightValue < oldLightValue then ; its become darker
	{
		delta = curLightValue - oldLightValue 
		if delta > threshold then
		{
			goto activate 
		} else {
			goto cleanup
		}
		endif
	} else {
		goto cleanup
	}
	endif
	
cleanup:
	oldLightValue = curLightValue
	pause 1000
	goto main

activate:
	; turn on all the lights n buzzers
	; and then cleanup
	high LED_STRIP
	sound buzzer (100,100)
	isOn = 1
	goto cleanup
	
	
print:
	high 0
	return
