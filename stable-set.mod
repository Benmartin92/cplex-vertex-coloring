/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Ben
 * Creation Date: 2018 aug. 27 at 22:38:55
 *********************************************/

range numNodes = 1..5;

int adjMatrix[numNodes][numNodes] = ...;

dvar int+ stableSet[numNodes] in 0..1;

maximize
    sum (node in numNodes)
      stableSet[node];

subject to {
	forall (node1 in numNodes, node2 in numNodes)
		adjMatrix[node1][node2] * (stableSet[node1] *stableSet[node2]) <= 1;		
}