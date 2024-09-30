#include "ComponentsManager.h"

#include <iostream>

void ComponentsManager::RegisterComponent(std::shared_ptr<Component> component)
{
	mComponents.try_emplace(component->GetId(), component);
	mCreateList.emplace_back(component->GetId());
}

void ComponentsManager::UnregisterComponent(std::shared_ptr<const Component> component)
{
	mDestroyList.emplace_back(component->GetId());
}

void ComponentsManager::UnregisterComponent(const std::string& componentId)
{
	mDestroyList.emplace_back(componentId);
}

void ComponentsManager::CreateEventCallback()
{
	for (const auto& componentId : mCreateList)
	{
		mComponents[componentId]->CreateEvent();
	}
	mCreateList.clear();
};

void ComponentsManager::DestroyEventCallback()
{
	for (const auto& componentId : mDestroyList)
	{
		mComponents[componentId]->DestroyEvent();
	}
	mDestroyList.clear();
};

void ComponentsManager::UpdateEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->UpdateEvent();
	}
};

void ComponentsManager::FixedUpdateEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->FixedUpdateEvent();
	}
};

void ComponentsManager::RenderEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->RenderEvent();
	}
};

void ComponentsManager::RenderScreenEventCallback()
{
	for (auto& [id, component] : mComponents)
	{
		component->RenderScreenEvent();
	}
};