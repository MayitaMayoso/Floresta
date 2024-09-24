#include "Component.h"

std::string Component::GetId()
{
	return mId;
}

Component* Component::GetParent()
{
	return mParent;
}

std::vector<Component*>& Component::GetChildren()
{
	return mChildren;
}

Component* Component::GetChild(const std::string& childId)
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

void Component::SetPosition(raylib::Vector3 position)
{
	mPosition = position;
}

raylib::Vector3 Component::GetPosition()
{
	return mPosition;
}