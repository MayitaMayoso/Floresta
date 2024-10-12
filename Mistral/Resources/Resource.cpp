#include "Resource.h"

std::filesystem::path Resource::GetPath()
{
	return mPath;
}

void Resource::SetPath(const std::filesystem::path& Path)
{
	mPath = Path;
}
