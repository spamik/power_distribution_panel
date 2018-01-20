# Power distribution panel

Distribution panel for low voltage DC.

## Description
Panel has 5 "sockets" (banana plug pair). Each socket has own switch, LED indicator and fuse. Panel has also one central fuse. Ratings: PCB should be working fine up to 60V and 10A. It also depends on plugs, switches and components on PCB.

## PCB
In repository is source file for SprintLayout PCB editor. Also there is gerber export with excelon drilling data (should be named for seeed fusion). For PCB completion is needed: terminal blocks (10x flat type, 1x normal), 6 LEDs, 6 resistors (resistor params depend on desired voltage and LED params), 6 fuse holders.

## Box model
There are also STL files (and OpenSCAD source files) for box. Model is 3D printable (preffered PETG for box, front plate can be printed from ABS also fine). Box consist from front plate (plate with plugs, switches, etc), chassis and front box which locks everything in place. Chassis doesn't have back side, instead there are mounting holes (for screw mount to 38mm pitch "pegboard"). But it can be easily modified. Front box is lockes by 4 M3 screws and nuts.

## Assembly
- solder components on PCB (for LED soldering is better push LED in front plate and solder them in that position)
- mount switches and banana plugs into front plate
- attach wires to terminal blocks on PCB
- mount front plate on PCB (push it on LEDs)
- attach wires to switches and banana plugs
- insert desired fuses into fuse holders
- attach wires for input power to terminal block on pcb (take wires through hole in chassis)
- press 4 M3 nuts in prepared holes in chassis
- push front plate with PCB into chassis (groove in chassis should fit and support PCB)
- push front box over front plate and lock it with 4 M3 screws
