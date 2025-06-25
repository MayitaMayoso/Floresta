#include "Vendaval.h"

void Vendaval::CreateEvent()
{
}

void Vendaval::UpdateEvent()
{
}

void Vendaval::RenderEvent()
{
}

void Vendaval::RenderScreenEvent()
{
	ImGui::ShowDemoWindow();
	DrawCircle(GetMousePosition().x, GetMousePosition().y, 10.f, RED);
}