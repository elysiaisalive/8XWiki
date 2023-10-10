# Contributing Code

- [Code Style](#code-style)
  - [If's and Switches](#ifs-and-switches)
  - [Variables](#variables)
  - [Enums and BitFlags](#enums-and-bitflags)
  - [Functions, Constructors and Script Organization](#functions-constructors-and-script-organization)
  
# Code Style
Although you don't explicitly <i>need</i> to follow these guidelines, I would very much appreciate it.

# If's AND OR Switches
```GML
if ( condition ) {
    // Code
}

// I like using ampersands and pipes for my AND OR, but you are also free to use the verbose AND OR.
if ( condition
&& conditionOther ) {
    // Code
}

if ( condition
|| conditionOther ) {
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

Generally, anything that takes up global namespace and is not intended to be interacted with by the user regularly, should be prefixed by two underscores. This ensures it will not show up in searches.
```GML
// We are probably going to use this
global.volume = 10;

// This is MOST likely never going to be touched, so lets do something different.
global.init_struct = {};

// You don't HAVE to do it this way, I know globalvars are a legacy/deprecated feature, but I really like them for readability and they are intentionally different looking.
globalvar __initStruct;
__initStruct = {};
// Something like this is totally valid.
__global.init_struct = {}; 
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
  FLAG3 = 4 << 0,
  FLAG4 = 8 << 0,
  FLAG5 = 16 << 0,
  FLAG6 = 32 << 0,
  //etc...
}
```

# Functions, Constructors and Script Organization
There are a few odd things I do to keep things organized.

Generally, script functions should be kept in their own separate files for readability reasons as well as it just makes it easier to debug and PR etc.
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
