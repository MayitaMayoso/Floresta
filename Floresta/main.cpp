#include "Managers/ComponentsManager.h"
#include "Mistral.h"
#include "Game/Cube.h"

int main()
{
	Mistral::StartApplication("Floresta", Vec2(1280, 720), [] {
		Mistral::Components::Create(std::make_shared<Cube>());
	});

	return 0;
}