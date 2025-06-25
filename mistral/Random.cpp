#include "Random.h"

#include <random>
#include <sstream>

static std::random_device randomDevice;
static std::mt19937 randomGenerator(randomDevice());
static std::uniform_int_distribution hexDigitDistribution(0, 15);
static std::uniform_int_distribution variantDistribution(8, 11);

std::string GenerateUUID()
{
	std::stringstream uuidStream;
	uuidStream << std::hex;

	for (int index = 0; index < 8; index++)
	{
		uuidStream << hexDigitDistribution(randomGenerator);
	}

	uuidStream << "-";

	for (int index = 0; index < 4; index++)
	{
		uuidStream << hexDigitDistribution(randomGenerator);
	}

	uuidStream << "4";

	for (int index = 0; index < 3; index++)
	{
		uuidStream << hexDigitDistribution(randomGenerator);
	}

	uuidStream << "-";

	uuidStream << variantDistribution(randomGenerator);

	for (int index = 0; index < 3; index++)
	{
		uuidStream << hexDigitDistribution(randomGenerator);
	}

	uuidStream << "-";

	for (int index = 0; index < 12; index++)
	{
		uuidStream << hexDigitDistribution(randomGenerator);
	}

	return uuidStream.str();
}
