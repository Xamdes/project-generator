# To Run a Command go to location and type ./(command)
# Example:
# cd Commands
# ./create-solution.sh


cd ..
mkdir "$1.Solution"
cd ./$1.Solution/

mkdir Commands

cd ./Commands/

touch clear.sh
touch commit.sh
touch fresh.sh
touch run.sh
touch test.sh

echo "cd ..
rm -rf ./$1/bin/
rm -rf ./$1/obj/
rm -rf ./$1.Tests/bin/
rm -rf ./$1.Tests/obj/
./Commands/fresh.sh" > clear.sh

echo "cd ..
git add .
git-pair-commit -m \"\$1\"" > commit.sh

echo "cd ..
dotnet restore ./$1
dotnet build ./$1
dotnet restore ./$1.Tests/" > fresh.sh

echo "cd ../$1/
dotnet run" > run.sh

echo "cd ../$1.Tests/
dotnet test" > test.sh

chmod 755 *.sh

cd ..

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

cd ..
dotnet new mstest -lang "C#" -f "netcoreapp1.1" -n "$1.Tests"
# cd ./$1.Tests/
# dotnet add ./$1.Tests.csproj reference ..\\$1\\$1.csproj
