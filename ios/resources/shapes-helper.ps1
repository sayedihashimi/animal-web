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
        'Slide01.png' = 's01-rectangle.png'
        'Slide02.png' = 's01-square.png'
        'Slide03.png' = 's01-triangle.png'
        'Slide04.png' = 's01-oval.png'
        'Slide05.png' = 's01-circle.png'
        'Slide06.png' = 's01-rhombus.png'
        'Slide07.png' = 's01-heart.png'
        'Slide08.png' = 's01-octogon.png'
        'Slide09.png' = 's01-star.png'

        'Slide10.png' = 's02-rectangle.png'
        'Slide11.png' = 's02-square.png'
        'Slide12.png' = 's02-triangle.png'
        'Slide13.png' = 's02-oval.png'
        'Slide14.png' = 's02-circle.png'
        'Slide15.png' = 's02-rhombus.png'
        'Slide16.png' = 's02-heart.png'
        'Slide17.png' = 's02-octogon.png'
        'Slide18.png' = 's02-star.png'
    }

    $folderFullpath = (Resolve-Path -Path $folderPath).Path
    foreach($key in $updates.Keys){
        $filepath = Join-Path -Path $folderFullpath -ChildPath $key
        if(test-path $filepath){
            $newpath = join-path -Path $folderPath -ChildPath $updates[$key]
            Move-Item -Path $filepath -Destination $newpath -Force
        }
        else {
            'Did not find file: [{0}]' -f $filepath | Write-Warning
        }
    }
}

FixShapeFilenames -folderPath .\shapes


