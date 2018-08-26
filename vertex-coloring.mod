/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Benjamin Martin Seregi <seregi@kth.se>
 * Creation Date: 2018 aug. 26 at 22:40:35
 *********************************************/

range numNodes = 1..5;
range numColors = 1..10;

int adjMatrix[numNodes][numNodes] = ...;

dvar int+ colorUsed[numColors];
dvar int+ colorUsedAtNode[numNodes][numColors];

minimize
    sum (color in numColors)
      colorUsed[color];
subject to {
    forall (node in numNodes) {
      ctEveryNodeHasExactlyOneColor:
        sum (color in numColors)
          colorUsedAtNode[node][color] == 1;
      ctColorUsed:
        forall (color in numColors)
          colorUsedAtNode[node][color] <= colorUsed[color];
    }
    ctNoAdjacentNodesHaveTheSameColor:
        forall (u in numNodes, v in numNodes) {
            forall (color in numColors)
              adjMatrix[u][v]*
              (colorUsedAtNode[u][color] + colorUsedAtNode[v][color]) <= 1;
        }
}

execute DISPLAY {
 	var chromaticNumber = 0;
 	for (var color in colorUsed)
 		if (colorUsed[color] > 0)
 			chromaticNumber += 1;  
   	writeln("Chromatic number: ", chromaticNumber);
}
