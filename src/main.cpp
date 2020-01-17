#include <iostream>
#ifdef  commandlineinterface_INCLUDED
#include <ArgumentList.h>
#include <Interpreter.h>
#endif //  commandlineinterface_INCLUDED
#ifdef commandhandler_INCLUDED
#include <CommandHandler.h>
#include <Command.h>
#endif // commandhandler_INCLUDED

#include <string>

class TestCommand : public Command
{
public:
	TestCommand()
		: Command("test")
	{}

	CommandStatus Run(ArgumentList& al) override
	{
		std::cout << "Test success." << std::endl;
		return CommandStatus::SUCCESS;
	}
};

int main()
{
#ifdef commandlineinterface_INCLUDED
#ifdef commandhandler_INCLUDED
	CommandHandler hCmd;
	hCmd.addCommand(new TestCommand);

	std::string input;
	std::getline(std::cin, input);

	hCmd.executeCommand(input.c_str());

#else
	std::cout << "Command Handler is missing. It must be included when building Zyniac" << std::endl;
#endif // commandhandler_INCLUDED
#else
	std::cout << "Command Interface is missing. It must be included when building Zyniac." << std::endl;
#endif // commandlineinterface_INCLUDED
}