SOURCES=src/GenerationState.fs \
		src/CodeGenerator.fs \
		src/CodeRefactorer.fs \
		src/BehaviourChecker.fs \
		src/Evaluator.fs

REFS=-r:lib/FSharp.Compiler.dll \
	 -r:lib/FSharp.Compiler.CodeDom.dll \
	 -r:lib/FSharp.Refactor.dll
OPTS=--target:library --nologo --lib:lib

all: bin/Evaluator.exe

lib/Evaluator.dll: $(SOURCES) lib/FSharp.Refactor.dll
	fsharpc $(OPTS) $(REFS) -o:lib/Evaluator.dll $(SOURCES)

bin/Evaluator.exe: lib/Evaluator.dll src/EvaluatorCommandLine.fs
	fsharpc $(OPTS) $(REFS) --target:exe -o:bin/Evaluator.exe -r:lib/Evaluator.dll src/EvaluatorCommandLine.fs
