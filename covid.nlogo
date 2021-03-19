;
;phase 1
;ui layout - done - Chirag
;blue depicts healthy - done - chirag
;red depicts infected - done - chirag
;green depicts recovered -tbd - daljeet
;white depicts dead - tbd - elias
;yellow depicts vaccinated - tbd - jeel
;
;notes - Chirag Mittal
;Make sure to add sliders, buttons etc as needed
;Link your code to the UI.
;Make sure to verify code by clicking the check button up.
;Try to create error free and maintain comments and indentation.
;Add globals and turtle properties whenever needed.
;Create a branch only. Try not to commit to the main branch directly.




;setup global variables
globals
[
  infected
  recovered
  dead
  immune?
  immuned
]



;setting up turtles
to setup
  clear-all
  reset-ticks
  create-turtles population
  [
    set shape "person"
    set color blue    ; blue meaning healthy


    setxy random-pxcor random-pycor
  ]

    ;infect
   ask n-of 4 turtles
  [

      set color red   ; red denotes infected

  ]

  set infected (count turtles with [color = red] / count turtles) * 100
  
  ; dead
  ask n-of 0 turtles
  [
    set color white ; white denotes dead
    
  ]
  
  set dead (count turtles with [color = white] / count turtles) * 100
  
end




to go
  tick
  ask turtles
  [
  forward random 4
  left random 10
  right random 10
  ]


  ;infect neighbours
  ask turtles with [color = red][

   ask other turtles in-radius 1
    [
    if random 100 < infected_probability
    [set color red ]

  ]
  ]
  set infected (count turtles with [color = red] / count turtles) * 100


  ;recover neighbours
  recover-infected
  set recovered (count turtles with [color = green] / count turtles) * 100
  set immuned (count turtles with [color = yellow] / count turtles) * 100

  if recovered = 100 OR immuned = 100 OR infected = 100 OR infected = 0
  [
    stop
  ]
end


to recover-infected ;;I -> R;recover neighbours
  if count turtles with [color = red] > 0 [
  ask n-of 1 turtles with [color = red]
  [
    if random 100 < recovery_efficiency
    [
      ifelse immunity = 1
      [
        set immune? true
        set color yellow
      ]
      [
        set color green
      ]
    ]
  ]
  ]
end

to dead-infected ; dead turtles
  if count turtles with [color = red] > 0[
    ask n-of 1 turtles with [color = red] [
      if random 100 > recovery_efficiency [
        if dead = 1 [
          set dead true
          set color white ]]]]
end
