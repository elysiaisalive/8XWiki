# Contributing Code

- [Code Style](#code-style)
  - [If's and Switches](#ifs-and-switches)
  - [Variables](#variables)
  - [Enums and BitFlags](#enums-and-bitflags)
  - [Functions, Constructors and Script Organization](#functions-constructors-and-script-organization)
  
# Code Style
Although you don't explicitly <i>need</i> to follow these guidelines, I would very much appreciate it.

# If's and Switches
```GML
if ( condition ) {
    // Code
}

// I also prefer keeping not operators inside of the brackets.
if ( !condition ) {
  // Code
}
else {
  // More Code
}

switch( state ) {
  case 0:
    // Code
    break;
}
```

# Variables
I like to keep my multi-word variables camelCased, while my local variables snake cased.
```GML
foo = 0;
fooBar = 0;

var _local_variable = 0;
```

# Enums and BitFlags
Enums should always be uppercase, and use powers of 2 for each additional flag after the fourth.
```GML
enum STATE {
  IDLE,
  MOVING
}

// Bitflags
enum FLAG {
  FLAG1 = 1 << 0,
  FLAG2 = 2 << 0,
  FLAG3 = 3 << 0,
  FLAG4 = 4 << 0,
  FLAG5 = 8 << 0,
  FLAG6 = 16 << 0,
  //etc...
}
```

# Functions, Constructors and Script Organization
There are a few odd things I do to keep things organized.
```GML
// Functions that can be used anywhere and do not rely on any specific instances.
function global_scope_function() {};

// Constructor functions and Instance functions
static myFunction = function() {};
static func = function() {};

myFunction = function() {};
func = function() {};

// Function Arguments
function print_hello( required, _optional ) {};

// Constructors.
function cClass() constructor {};
```
