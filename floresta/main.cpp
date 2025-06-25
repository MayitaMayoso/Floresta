#include "game/Cube.h"
#include "Mistral.h"

int main()
{
	Mistral::StartApplication("Floresta", Vec2(1920.f, 1080.f), [] { Mistral::EntityCreate(std::make_shared<Cube>()); });

	return 0;
}