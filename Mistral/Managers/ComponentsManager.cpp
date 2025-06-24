#include "ComponentsManager.h"

#include <map>
#include <vector>

#include "Components/Component.h"

static std::map<std::string, std::shared_ptr<Mistral::Component>, std::less<>> mComponents;
static std::vector<std::string> mCreateList;
static std::vector<std::string> mDestroyList;

void Mistral::Components::Create(std::shared_ptr<Component> component)
{
	mComponents.try_emplace(component->GetId(), component);
	mCreateList.emplace_back(component->GetId());
}

void Mistral::Components::Destroy(std::shared_ptr<const Component> component)
{
	mDestroyList.emplace_back(component->GetId());
}

void Mistral::Components::Destroy(const std::string& componentId)
{
	mDestroyList.emplace_back(componentId);
}

void Mistral::Components::CreateEventCallback()
{
	for (const auto& componentId : mCreateList)
	{
		mComponents[componentId]->CreateEvent();
	}
	mCreateList.clear();
};

void Mistral::Components::DestroyEventCallback()
{
	for (const auto& componentId : mDestroyList)
	{
		mComponents[componentId]->DestroyEvent();
	}
	mDestroyList.clear();
};

void Mistral::Components::UpdateEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->UpdateEvent();
	}
};

void Mistral::Components::FixedUpdateEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->FixedUpdateEvent();
	}
};

void Mistral::Components::RenderEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->RenderEvent();
	}
};

void Mistral::Components::RenderScreenEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->RenderScreenEvent();
	}
};