dotnet new mvc --auth SingleOrg -o IdentityWeb


cd IdentityWeb
dotnet add package Microsoft.Identity.Web
dotnet add package Microsoft.Identity.Web.UI
dotnet add package Microsoft.Identity.Web.MicrosoftGraph

dotnet dev-certs https