CRenderTarget =
{
    m_pFamousResolution = -- from @https://github.com/XaskeL/MTA-CAnalystics-DB/blob/main/res.png
    {
        [ 2073600 ]     = "1920x1080";
        [ 1049088 ]     = "1366x768";
        [ 1310720 ]     = "1280x1024";
        [ 1440000 ]     = "1600x900";
        [ 1296000 ]     = "1440x900";
        [ 921600 ]      = "1280x720";
        [ 1044480 ]     = "1360x768";
        [ 1764000 ]     = "1680x1050";
        [ 786432 ]      = "1024x768";
        [ 480000 ]      = "800x600";
        [ 1024000 ]     = "1280x800";
        [ 1228800 ]     = "1280x960";
        [ 995328 ]      = "1152x864";
        [ 3686400 ]     = "2560x1440";
        [ 307200 ]      = "640x480";
        [ 1920000 ]     = "1600x1200";
        [ 1638400 ]     = "1600x1024";
        [ 2764800 ]     = "2560x1080";
        [ 768000 ]      = "1280x600";
        [ 1470000 ]     = "1400x1050";
        [ 1753856 ]     = "1768x992";
        [ 614400 ]      = "1024x600";
        [ 1555200 ]     = "1440x1080";
    };
    
	-- Получает приблизительный размер RT с нужными размерами в памяти.
	-- = number
    GetWeightFromSize       = function ( this, iWidth, iHeight )
        return ( iWidth * iHeight / 4 * 32 ) / 1024;
    end;
    
	-- Получает количество пикселей из занятой памяти созданным RT.
	-- = number
    GetPixelsFromWeight     = function ( this, iKiB )
		return ( ( iKiB * 4 ) / 32 ) * 1024;
    end;
    
	-- Извлекает известное разрешение iWidth*iHeight из таблицы. Если такового нет, высчитывает приблизительную длину.
	-- = string
    GetResolutionFromPixels = function ( this, iPixels )
        local sResolution = this.m_pFamousResolution [ iPixels ];
        
        if ( sResolution ) then
            return sResolution;
        end
        
        return "undefined: " .. tostring( math.sqrt( iPixels ) );
    end;
    
	-- Позволяет узнать, можно ли поместить указанный RT ( iWidth, iHeight ) в память.
	-- = bool
    IsCanPutInToRAM         = function ( this, iWidth, iHeight )
        return dxGetStatus()["VideoMemoryFreeForMTA"] > ( this:GetWeightFromSize( iWidth, iHeight ) / 1000 );
    end;
};

-- Пример:
--[[
local iKiB = CRenderTarget:GetWeightFromSize( 1920, 1080, true );

print( 'iKiB: ', iKiB ); -- iKiB: 16200

local iPixels = CRenderTarget:GetPixelsFromWeight( iKiB, false );

print( 'iPixels:', iPixels ); -- iPixels: 2073600

local sRes = CRenderTarget:GetResolutionFromPixels( iPixels );

print( 'sRes:', sRes );

print( "IsCanPutInToRAM:", tostring( CRenderTarget:IsCanPutInToRAM( 1920, 1080 ) ) );
--]]
