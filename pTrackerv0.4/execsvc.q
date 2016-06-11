/load pubsub functionality.
\l u2.q

.z.ws:{0N!`ConnectingToExecSvc; value -9!x}

// table and upd definitions
executionTbl:([] date:`date$();time:`time$();account:`$();sym:`$();trader:`$();side:`$();qty:`int$();execPrice:`float$());


//.z.pc: {}

//Connect to pnl service.
//h:hopen 5011;

enterTrade:{[dat]
	tmp:.z.D,.z.t;
	0N!dat;
	tmp2:4#dat;	
	acc:`$tmp2 0;
	sym:`$tmp2 1;
	trd:`$tmp2 2;
	side:`$tmp2 3;	
	qty:`int$dat 4;
	price:dat 5;

	`executionTbl insert tmp,acc,sym,trd,side,qty,price;	
/call prExec in pnl.q
	0N!tmp,acc,sym,trd,side,qty,price;	
	/neg[h] (`prExec;`account`sym`trader`side`qty`execPrice!acc,sym,trd,side,qty,price);
	.u.pubExec[`executionTbl ;`account`sym`trader`side`qty`execPrice!acc,sym,trd,side,qty,price ];
	}

\p 5013

.u.init[];

\

/execDat1:`account`sym`trader`side`qty`execPrice!(`acc1;`GOOG;`trader1;`B;100;50.0)

// define upd function
// this is the function invoked when the publisher pushes data to it
upd:{[tabname;tabdata] show tabname; show tabdata}

// open a handle to the publisher
h:@[hopen;`::6812;{-2"Failed to open connection to publisher on port 6812: ",
                     x,". Please ensure publisher is running";
                     exit 1}]

// subscribe to the required data
// .u.sub[tablename; list of instruments]
// ` is wildcard for all
h(`.u.sub;`;`)

\
Could also do (for example)

Subscribe to 10 syms of meter data:
h(`.u.sub;`meter;`long$til 10)

Add subscriptions
h(`.u.add;`meter;20 21 22j)
