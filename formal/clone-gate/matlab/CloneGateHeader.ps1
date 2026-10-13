# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
[CmdletBinding()]
param(
 [Parameter(Mandatory)][string]$ChallengeFile,
 [Parameter(Mandatory)][string]$KeyFile,
 [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{32}$')][string]$ExpectedFingerprint,
 [Parameter(Mandatory)][string]$MatlabExe,
 [Parameter(Mandatory)][string]$IdrisBin,
 [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{40}$')][string]$PublisherThumbprint,
 [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{64}$')][string]$MatlabSha256,
 [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{64}$')][string]$IdrisSha256,
 [Parameter(Mandatory)][ValidatePattern('^[0-9a-fA-F]{64}$')][string]$MatlabFunctionSha256,
 [Parameter(Mandatory)][string]$MatlabTrustedRoot,
 [Parameter(Mandatory)][string]$GateTrustedRoot
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Assert-TrustedFile([string]$Path,[string]$Root) {
 $full=[IO.Path]::GetFullPath($Path)
 $rootFull=[IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar)
 if(-not $full.StartsWith($rootFull+[IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)){throw 'Path outside trusted root'}
 if(-not(Test-Path -LiteralPath $full -PathType Leaf)){throw 'File missing'}
 $item=Get-Item -LiteralPath $full
 while($item -and $item.FullName.Length -ge $rootFull.Length){
  if($item.Attributes -band [IO.FileAttributes]::ReparsePoint){throw 'Reparse points are not accepted'}
  $item=if($item.PSIsContainer){$item.Parent}else{$item.Directory}
 }
 return $full
}
function Assert-Signature([string]$Path) {
 $signature=Get-AuthenticodeSignature -LiteralPath $Path
 if($signature.Status -ne 'Valid' -or $signature.SignerCertificate.Thumbprint -ne $PublisherThumbprint){throw 'Publisher signature validation failed'}
}
function Assert-Hash([string]$Path,[string]$Expected) {
 if($Expected -eq ('0'*64) -or (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash -ne $Expected){throw 'Pinned hash mismatch'}
}
try {
 if(-not $IsWindows){throw 'This deployment launcher requires Windows PowerShell 7'}
 Assert-Signature $PSCommandPath
 $MatlabExe=Assert-TrustedFile $MatlabExe $MatlabTrustedRoot
 $IdrisBin=Assert-TrustedFile $IdrisBin $GateTrustedRoot
 $ChallengeFile=Assert-TrustedFile $ChallengeFile $GateTrustedRoot
 $KeyFile=Assert-TrustedFile $KeyFile $GateTrustedRoot
 $functionFile=Assert-TrustedFile (Join-Path $PSScriptRoot 'cloneGateMATLAB.m') $GateTrustedRoot
 Assert-Hash $MatlabExe $MatlabSha256
 Assert-Hash $IdrisBin $IdrisSha256
 Assert-Hash $functionFile $MatlabFunctionSha256
 # MATLAB's own publisher signs MATLAB; the owner signs the Idris executable.
 if((Get-AuthenticodeSignature -LiteralPath $MatlabExe).Status -ne 'Valid'){throw 'MATLAB signature invalid'}
 Assert-Signature $IdrisBin
 if([Diagnostics.Debugger]::IsAttached){throw 'Debugger attached'}
 function Quote-Matlab([string]$Value){return "'"+$Value.Replace("'","''")+"'"}
 $folder=Quote-Matlab $PSScriptRoot
 $pinnedFunction=Quote-Matlab $functionFile
 $arguments=@($ChallengeFile,$KeyFile,$ExpectedFingerprint,$IdrisBin)|ForEach-Object {Quote-Matlab $_}
 $statement="restoredefaultpath; cd($folder); addpath($folder); try; assert(strcmp(which('cloneGateMATLAB'),$pinnedFunction),'Unpinned MATLAB function'); ok=cloneGateMATLAB("+($arguments -join ',')+"); if ok; exit(0); else; exit(1); end; catch ME; fprintf(2,'%s\n',ME.message); exit(2); end"
 $start=[Diagnostics.ProcessStartInfo]::new()
 $start.FileName=$MatlabExe; $start.UseShellExecute=$false; $start.CreateNoWindow=$true
 $start.WorkingDirectory=$PSScriptRoot
 $start.ArgumentList.Add('-batch'); $start.ArgumentList.Add($statement)
 $start.ArgumentList.Add('-sd'); $start.ArgumentList.Add($PSScriptRoot)
 $start.ArgumentList.Add('-nojvm'); $start.ArgumentList.Add('-nodisplay'); $start.ArgumentList.Add('-nodesktop'); $start.ArgumentList.Add('-nosplash')
 $process=[Diagnostics.Process]::Start($start);$process.WaitForExit()
 $result=$process.ExitCode;$process.Dispose()
 if($result -in 0,1,2){exit $result}else{exit 4}
}catch {Write-Error $_ -ErrorAction Continue;exit 4}
