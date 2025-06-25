#pragma once

#include <string>
#include <vector>
#include <memory>

#include "Mistral.h"

namespace Mistral
{
	class Entity
	{
	  public:

		Entity();

		virtual ~Entity() = default;

		// Getters
		std::string GetId() const;

		Entity* GetParent();

		std::vector<Entity*>& GetChildren();

		Entity* GetChild(const std::string& childId);

		void SetPosition(Vec3 position);

		Vec3 GetPosition();

		// Events
		virtual void CreateEvent() {};

		virtual void DestroyEvent() {};

		virtual void UpdateEvent() {};

		virtual void FixedUpdateEvent() {};

		virtual void RenderEvent() {};

		virtual void RenderScreenEvent() {};

	  protected:

		std::string mId;
		Entity* mParent;
		std::vector<Entity*> mChildren;
		Vec3 mPosition;
	};

	// Entities management
	void EntityCreate(std::shared_ptr<Entity> component);

	void EntityDestroy(std::shared_ptr<const Entity> component);

	void EntityDestroy(const std::string& componentId);

	// Event callbacks
	void EntitiesCreateEventCallback();

	void EntitiesDestroyEventCallback();

	void EntitiesUpdateEventCallback();

	void EntitiesFixedUpdateEventCallback();

	void EntitiesRenderEventCallback();

	void EntitiesRenderScreenEventCallback();
};