# Bad Assembler Interpreter

An ad hoc, informally-specified, bug-ridden, slow implementation of half of x86 Assembler.

We're relying a lot on the good work of [RLTK](https://github.com/chriswailes/RLTK) here.
It's worth referring to that documentation before doing any work here.

There are three parts to this:

1. `Assembler::Lexer`: Converts strings into tokens (e.g. "mov ax, 5d" to [COMMAND mov], [REGISTER ax], [LIST_SEPARATOR], [NUMBER 5])
2. `Assembler::Parser`: Converts the above into coherent expressions (e.g. the above into STATEMENT ["MOV", "AX", 5])
3. `Assembler::Executor`: Which takes the above and executes it over a state object. It delegates to classes responsible for actually executing an individual command, e.g. `Assembler::Command::Mov`

Then there's `Assembler::Interpreter` which acts as a façade to the whole thing.
You might well consider reading that first.
