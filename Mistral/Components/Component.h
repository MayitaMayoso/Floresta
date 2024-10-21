#pragma once

#include <string>
#include <vector>

#include "Mistral.h"
#include "raylib-cpp.hpp"

namespace Mistral
{
	class Component
	{
	  public:

		Component();

		Component(const std::string& Type);

		// Getters
		std::string GetId() const;

		Component* GetParent();

		std::vector<Component*>& GetChildren();

		Component* GetChild(const std::string& childId);

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
		Component* mParent;
		std::vector<Component*> mChildren;
		Vec3 mPosition;
	};
}