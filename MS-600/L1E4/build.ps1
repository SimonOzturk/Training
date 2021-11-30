dotnet new console -o GraphDaemon

cd graphdaemon
dotnet add package Microsoft.Identity.Client
dotnet add package Microsoft.Graph
dotnet add package Microsoft.Extensions.Configuration
dotnet add package Microsoft.Extensions.Configuration.FileExtensions
dotnet add package Microsoft.Extensions.Configuration.Json

dotnet dev-certs https --trust
dotnet build
dotnet run