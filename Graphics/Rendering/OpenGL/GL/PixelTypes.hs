-- #hide
--------------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Rendering.OpenGL.GL.PixelTypes
-- Copyright   :  (c) Sven Panne 2003
-- License     :  BSD-style (see the file libraries/OpenGL/LICENSE)
-- 
-- Maintainer  :  sven_panne@yahoo.com
-- Stability   :  provisional
-- Portability :  portable
--
-- This is a purely internal module for (un-)marshaling pixel-related types.
--
--------------------------------------------------------------------------------

module Graphics.Rendering.OpenGL.GL.PixelTypes (
   PixelFormat(..), marshalPixelFormat, unmarshalPixelFormat,
   PixelType(..), marshalPixelType, unmarshalPixelType
) where

import Graphics.Rendering.OpenGL.GL.BasicTypes ( GLenum )

--------------------------------------------------------------------------------

data PixelFormat =
     ColorIndex
   | StencilIndex
   | DepthComponent
   | Red
   | Green
   | Blue
   | Alpha
   | RGB
   | RGBA
   | Luminance
   | LuminanceAlpha
   | ABGR
   | BGR
   | BGRA
   | CMYK
   | CMYKA
   | FourTwoTwo
   | FourTwoTwoRev
   | FourTwoTwoAverage
   | FourTwoTwoRevAverage
   | YCBCR422
   deriving ( Eq, Ord, Show )

marshalPixelFormat :: PixelFormat -> GLenum
marshalPixelFormat x = case x of
   ColorIndex -> 0x1900
   StencilIndex -> 0x1901
   DepthComponent -> 0x1902
   Red -> 0x1903
   Green -> 0x1904
   Blue -> 0x1905
   Alpha -> 0x1906
   RGB -> 0x1907
   RGBA -> 0x1908
   Luminance -> 0x1909
   LuminanceAlpha -> 0x190a
   ABGR -> 0x8000
   BGR -> 0x80E0
   BGRA -> 0x80E1
   CMYK -> 0x800C
   CMYKA -> 0x800D
   FourTwoTwo -> 0x80CC
   FourTwoTwoRev -> 0x80CD
   FourTwoTwoAverage -> 0x80CE
   FourTwoTwoRevAverage -> 0x80CF
   YCBCR422 -> 0x85B9

unmarshalPixelFormat :: GLenum -> PixelFormat
unmarshalPixelFormat x
   | x == 0x1900 = ColorIndex
   | x == 0x1901 = StencilIndex
   | x == 0x1902 = DepthComponent
   | x == 0x1903 = Red
   | x == 0x1904 = Green
   | x == 0x1905 = Blue
   | x == 0x1906 = Alpha
   | x == 0x1907 = RGB
   | x == 0x1908 = RGBA
   | x == 0x1909 = Luminance
   | x == 0x190a = LuminanceAlpha
   | x == 0x8000 = ABGR
   | x == 0x80E0 = BGR
   | x == 0x80E1 = BGRA
   | x == 0x800C = CMYK
   | x == 0x800D = CMYKA
   | x == 0x80CC = FourTwoTwo
   | x == 0x80CD = FourTwoTwoRev
   | x == 0x80CE = FourTwoTwoAverage
   | x == 0x80CF = FourTwoTwoRevAverage
   | x == 0x85B9 = YCBCR422
   | otherwise = error ("unmarshalPixelFormat: illegal value " ++ show x)

--------------------------------------------------------------------------------

data PixelType =
     PixelBitmap
   | PixelByte
   | PixelUnsignedByte
   | PixelShort
   | PixelUnsignedShort
   | PixelInt
   | PixelUnsignedInt
   | PixelFloat
   | PixelUnsignedByte332
   | PixelUnsignedShort4444
   | PixelUnsignedShort5551
   | PixelUnsignedInt8888
   | PixelUnsignedInt1010102
   | PixelUnsignedByte233Rev
   | PixelUnsignedShort565
   | PixelUnsignedShort565Rev
   | PixelUnsignedShort4444Rev
   | PixelUnsignedShort1555Rev
   | PixelUnsignedInt8888Rev
   | PixelUnsignedInt2101010Rev
   | PixelUnsignedShort88
   | PixelUnsignedShort88Rev
   deriving ( Eq, Ord, Show )

marshalPixelType :: PixelType -> GLenum
marshalPixelType x = case x of
   PixelBitmap -> 0x1a00
   PixelByte -> 0x1400
   PixelUnsignedByte -> 0x1401
   PixelShort -> 0x1402
   PixelUnsignedShort -> 0x1403
   PixelInt -> 0x1404
   PixelUnsignedInt -> 0x1405
   PixelFloat -> 0x1406
   PixelUnsignedByte332 -> 0x8032
   PixelUnsignedShort4444 -> 0x8033
   PixelUnsignedShort5551 -> 0x8034
   PixelUnsignedInt8888 -> 0x8035
   PixelUnsignedInt1010102 -> 0x8036
   PixelUnsignedByte233Rev -> 0x8362
   PixelUnsignedShort565 -> 0x8363
   PixelUnsignedShort565Rev -> 0x8364
   PixelUnsignedShort4444Rev -> 0x8365
   PixelUnsignedShort1555Rev -> 0x8366
   PixelUnsignedInt8888Rev -> 0x8367
   PixelUnsignedInt2101010Rev -> 0x8368
   PixelUnsignedShort88 -> 0x85ba
   PixelUnsignedShort88Rev -> 0x85bb

unmarshalPixelType :: GLenum -> PixelType
unmarshalPixelType x
   | x == 0x1a00 = PixelBitmap
   | x == 0x1400 = PixelByte
   | x == 0x1401 = PixelUnsignedByte
   | x == 0x1402 = PixelShort
   | x == 0x1403 = PixelUnsignedShort
   | x == 0x1404 = PixelInt
   | x == 0x1405 = PixelUnsignedInt
   | x == 0x1406 = PixelFloat
   | x == 0x8032 = PixelUnsignedByte332
   | x == 0x8033 = PixelUnsignedShort4444
   | x == 0x8034 = PixelUnsignedShort5551
   | x == 0x8035 = PixelUnsignedInt8888
   | x == 0x8036 = PixelUnsignedInt1010102
   | x == 0x8362 = PixelUnsignedByte233Rev
   | x == 0x8363 = PixelUnsignedShort565
   | x == 0x8364 = PixelUnsignedShort565Rev
   | x == 0x8365 = PixelUnsignedShort4444Rev
   | x == 0x8366 = PixelUnsignedShort1555Rev
   | x == 0x8367 = PixelUnsignedInt8888Rev
   | x == 0x8368 = PixelUnsignedInt2101010Rev
   | x == 0x85ba = PixelUnsignedShort88
   | x == 0x85bb = PixelUnsignedShort88Rev
   | otherwise = error ("unmarshalPixelType: illegal value " ++ show x)