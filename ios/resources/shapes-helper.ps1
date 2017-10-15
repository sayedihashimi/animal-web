[cmdletbinding()]
param()

function Get-Fullpath{
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline = $true)]
        $path,

        $workingDir = ($pwd)
    )
    process{
        $fullPath = $path
        $oldPwd = $pwd

        Push-Location
        Set-Location $workingDir
        [Environment]::CurrentDirectory = $pwd
        $fullPath = ([System.IO.Path]::GetFullPath($path))
        
        Pop-Location
        [Environment]::CurrentDirectory = $oldPwd

        return $fullPath
    }
}

function FixShapeFilenames(){
    [cmdletbinding()]
    param(
        $folderPath = $pwd
    )

    $updates = @{
        'Slide1.png' = 'rectangle.png'
        'Slide2.png' = 'square.png'
        'Slide3.png' = 'triangle.png'
        'Slide4.png' = 'oval.png'
        'Slide5.png' = 'circle.png'
        'Slide6.png' = 'rhombus.png'
        'Slide7.png' = 'heart.png'
        'Slide8.png' = 'octogon.png'
        'Slide9.png' = 'star.png'
    }

    $folderFullpath = (Resolve-Path -Path $folderPath).Path
    foreach($key in $updates.Keys){
        $filepath = Join-Path -Path $folderFullpath -ChildPath $key
        'filepath: [{0}]' -f $filepath | Write-Host
        if(test-path $filepath){
            'in if' | Write-Host
            $newpath = join-path -Path $folderPath -ChildPath $updates[$key]
            Move-Item -Path $filepath -Destination $newpath
        }
        else {
            'in else' | Write-Host
        }
    }

$global:foo = $updates
#    Write-Host -Object $updates
}
<#
-rw-r--r--@ 1 sayedhashimi  staff  83010 Oct 14 16:34 circle.png
-rw-r--r--@ 1 sayedhashimi  staff  90627 Oct 14 16:34 heart.png
-rw-r--r--@ 1 sayedhashimi  staff  54434 Oct 14 16:34 octogon.png
-rw-r--r--@ 1 sayedhashimi  staff  76299 Oct 14 16:34 oval.png
-rw-r--r--@ 1 sayedhashimi  staff  44206 Oct 14 16:34 rectangle.png
-rw-r--r--@ 1 sayedhashimi  staff  60978 Oct 14 16:34 rhombus.png
-rw-r--r--@ 1 sayedhashimi  staff  45511 Oct 14 16:34 square.png
-rw-r--r--@ 1 sayedhashimi  staff  86659 Oct 14 16:34 star.png
-rw-r--r--@ 1 sayedhashimi  staff  69335 Oct 14 16:34 triangle.png
#>

FixShapeFilenames -folderPath .\shapes


