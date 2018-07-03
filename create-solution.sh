# To Run a Command go to location and type ./(command)
# Example:
# cd Commands
# ./create-solution.sh


cd ..
mkdir "$1.Solution"
cd ./$1.Solution/

touch clear.sh
touch commit.sh
touch fresh.sh
touch run.sh

echo "rm -rf ./$1/bin/
rm -rf ./$1/obj/
./fresh.sh" > clear.sh

echo "git add .
git-pair-commit -m \"\$1\"" > commit.sh

echo "dotnet restore ./$1
dotnet build ./$1" > fresh.sh

echo "cd $1/
dotnet run" > run.sh

chmod 755 ./clear.sh
chmod 755 ./commit.sh
chmod 755 ./fresh.sh
chmod 755 ./run.sh

touch README.md
dotnet new mvc -lang "C#" -f "netcoreapp1.1" -n "$1"
cd ./$1/
dotnet add "$1.csproj" package Microsoft.AspNetCore.Http -v 1.1.2
dotnet add "$1.csproj" package Microsoft.AspNetCore.Mvc -v 1.1.3
dotnet add "$1.csproj" package Microsoft.AspNetCore.StaticFiles -v 1.1.3
dotnet restore
mkdir Models
touch ./Controllers/HomeController.cs
touch ./Models/Template.cs
