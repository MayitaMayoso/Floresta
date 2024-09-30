#include "Component.h"

#include <iostream>
#include <random>
#include <sstream>

namespace uuid
{
	static std::random_device rd;
	static std::mt19937 gen(rd());
	static std::uniform_int_distribution<> dis(0, 15);
	static std::uniform_int_distribution<> dis2(8, 11);

	static std::string generate_uuid_v4()
	{
		std::stringstream ss;
		int i;
		ss << std::hex;
		for (i = 0; i < 8; i++)
		{
			ss << dis(gen);
		}
		ss << "-";
		for (i = 0; i < 4; i++)
		{
			ss << dis(gen);
		}
		ss << "-4";
		for (i = 0; i < 3; i++)
		{
			ss << dis(gen);
		}
		ss << "-";
		ss << dis2(gen);
		for (i = 0; i < 3; i++)
		{
			ss << dis(gen);
		}
		ss << "-";
		for (i = 0; i < 12; i++)
		{
			ss << dis(gen);
		};
		return ss.str();
	}
} // namespace uuid

Component::Component():
	mId(uuid::generate_uuid_v4())
{
}

std::string Component::GetId() const
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