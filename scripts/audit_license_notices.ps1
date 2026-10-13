# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
param([string]$RepositoryRoot=(Split-Path $PSScriptRoot -Parent),[string]$ReportPath)
$ErrorActionPreference='Stop'
$identifier='LicenseRef-Sovereign-Leviathan-SL-AGPL3-001'
$encoding=[Text.UTF8Encoding]::new($false,$true)
$sourceExtensions=@('.py','.rs','.go','.hs','.dfy','.c','.swift','.lean','.asm','.h','.a68','.ads','.m','.metal','.adb','.sml','.thy','.cu','.sh','.occ','.ml','.pas','.jl','.s','.va','.lua','.rpgle','.apl','.b','.bqn','.dl','.cpp','.wat','.js','.mjs','.ts','.mod','.def','.kl','.ua','.isa','.fnl','.scala','.agda','.vhd','.v','.sql','.exs','.fst','.cs','.cbl','.cob','.pli','.zig','.lisp','.lhs','.unl','.fut','.ecl','.haskell','.nasm','.circom','.ps1','.qflow','.qrisp','.qs','.lgt','.l','.k','.mm','.mlw','.a86','.ebnf','.cuh','.bas','.basic','.vb')
$records=@()
$sourceExtensions+=@('.idr','.ipkg','.cjs','.glsl')
$sourceExtensions+=@('.hpp','.sbt','.erl','.gpr','.mli','.fsl','.mxml','.html','.xml','.xsl','.xslt','.xsd','.svg','.css')
foreach($path in @(git -C $RepositoryRoot ls-files --cached --others --exclude-standard|Sort-Object -Unique)){
 $file=Join-Path $RepositoryRoot $path
 if(-not(Test-Path -LiteralPath $file -PathType Leaf)){continue}
 $raw=[IO.File]::ReadAllBytes($file)
 $extension=[IO.Path]::GetExtension($path).ToLowerInvariant()
 $name=[IO.Path]::GetFileName($path)
 $source=$extension -in $sourceExtensions -or $name -match '^(Makefile|Dockerfile(?:\..*)?|go\.mod|CMakeLists\.txt)$'
 $text=$null
 if(-not($raw -contains 0)){try{$text=$encoding.GetString($raw).TrimStart([char]0xfeff)}catch{}}
 $head=if($null -ne $text){($text -split '\r?\n'|Select-Object -First 40)-join "`n"}else{''}
 $pattern='(?m)^\s*(?:(?:#|//|--|;+|%|\*|\*>|\u235d|/\*|<!--|\(\*|!|/)\s*)?SPDX-License-Identifier:\s*'+[regex]::Escape($identifier)+'(?:\s|$)'
 $header=[regex]::IsMatch($head,$pattern)
 $sidecar=$false
 if(Test-Path -LiteralPath ($file+'.license')){
  $notice=[IO.File]::ReadAllText($file+'.license')
  $sidecar=$notice -match $pattern
 }
 $status=if($header){'in-file-spdx'}elseif($sidecar -and -not $source){'adjacent-spdx'}else{'missing-required-header'}
 $records += [pscustomobject]@{path=$path;source=$source;status=$status;sha256=(Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant()}
}
$failures=@($records|Where-Object status -eq 'missing-required-header')
$result=[ordered]@{revision=(git -C $RepositoryRoot rev-parse HEAD).Trim();files=$records.Count;source_files=@($records|Where-Object source).Count;missing_required_headers=$failures.Count;records=$records}
if($ReportPath){$result|ConvertTo-Json -Depth 5|Set-Content -LiteralPath $ReportPath -Encoding utf8}
Write-Output ('Files: '+$records.Count+'; source files: '+$result.source_files+'; missing required headers: '+$failures.Count)
if($failures.Count){$failures|Select-Object path,source|Format-Table;exit 1}
