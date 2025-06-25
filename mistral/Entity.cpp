#include "Entity.h"

#include <map>
#include <vector>

#include "Random.h"

Mistral::Entity::Entity():
	mId(GenerateUUID()),
	mParent(nullptr)
{
}

std::string Mistral::Entity::GetId() const
{
	return mId;
}

Mistral::Entity* Mistral::Entity::GetParent()
{
	return mParent;
}

std::vector<Mistral::Entity*>& Mistral::Entity::GetChildren()
{
	return mChildren;
}

Mistral::Entity* Mistral::Entity::GetChild(const std::string& childId)
{
	for (auto child : mChildren)
	{
		if (child->GetId() == childId)
		{
			return child;
		}
	}
	return nullptr;
}

void Mistral::Entity::SetPosition(Vec3 position)
{
	mPosition = position;
}

Vec3 Mistral::Entity::GetPosition()
{
	return mPosition;
}

static std::map<std::string, std::shared_ptr<Mistral::Entity>, std::less<>> mEntities;
static std::vector<std::string> mCreateList;
static std::vector<std::string> mDestroyList;

void Mistral::EntityCreate(std::shared_ptr<Entity> component)
{
	mEntities.try_emplace(component->GetId(), component);
	mCreateList.emplace_back(component->GetId());
}

void Mistral::EntityDestroy(std::shared_ptr<const Entity> component)
{
	mDestroyList.emplace_back(component->GetId());
}

void Mistral::EntityDestroy(const std::string& componentId)
{
	mDestroyList.emplace_back(componentId);
}

void Mistral::EntitiesCreateEventCallback()
{
	for (const auto& componentId : mCreateList)
	{
		mEntities[componentId]->CreateEvent();
	}
	mCreateList.clear();
}

void Mistral::EntitiesDestroyEventCallback()
{
	for (const auto& componentId : mDestroyList)
	{
		mEntities[componentId]->DestroyEvent();
	}
	mDestroyList.clear();
}

void Mistral::EntitiesUpdateEventCallback()
{
	for (auto& [id, component] : mEntities)
	{
		component->UpdateEvent();
	}
}

void Mistral::EntitiesFixedUpdateEventCallback()
{
	for (auto& [id, component] : mEntities)
	{
		component->FixedUpdateEvent();
	}
}

void Mistral::EntitiesRenderEventCallback()
{
	for (auto& [id, component] : mEntities)
	{
		component->RenderEvent();
	}
}

void Mistral::EntitiesRenderScreenEventCallback()
{
	for (auto& [id, component] : mEntities)
	{
		component->RenderScreenEvent();
	}
}