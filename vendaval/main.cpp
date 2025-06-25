#include "Vendaval.h"

int main()
{
	Mistral::StartApplication("Vendaval", Vec2(1920.f, 1080.f), [] { Mistral::EntityCreate(std::make_shared<Vendaval>()); });

	return 0;
}