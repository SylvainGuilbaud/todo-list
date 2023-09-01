Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="Namespace" Value="IRISAPP"/>
  <Default Name="app" Value="irisapp" />

  <Namespace Name="${Namespace}" Code="${Namespace}-CODE" Data="${Namespace}-DATA" Create="yes" Ensemble="1">

    <Configuration>
      <Database Name="${Namespace}-DATA" Dir="/usr/irissys/mgr/${app}/data" Create="yes" Resource="%DB_${Namespace}-DATA"/>
      <Database Name="${Namespace}-CODE" Dir="/usr/irissys/mgr/${app}/code" Create="yes" Resource="%DB_${Namespace}-CODE"/>
    </Configuration>
    <CSPApplication Url="/csp/${app}" Directory="${cspdir}${app}"  ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" AuthenticationMethods="32"
       
    />
  </Namespace>
  <Namespace Name="%ALL" Code="USER" Data="USER" Create="no" Ensemble="0">
    <Configuration>
      <ClassMapping From="${Namespace}-DATA" Package="common" />
    </Configuration>

  </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}
