-----------------------------------------------------------------------------
--
-- Module      :  Graphics.Rendering.OpenGL.GL.FramebufferObjects.Attachments
-- Copyright   :
-- License     :  BSD3
--
-- Maintainer  :  Sven Panne <sven.panne@aedion.de>
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Graphics.Rendering.OpenGL.GL.FramebufferObjects.Attachments (
   FramebufferAttachment(..),

   maxColorAttachments,

   FramebufferAttachment(..),

   framebufferRenderbuffer, framebufferTexture1D, framebufferTexture2D,
   framebufferTexture3D, framebufferTextureLayer,

) where

import Data.Maybe (fromJust)
import Foreign.Marshal
import Graphics.Rendering.OpenGL.Raw.Core31

import Graphics.Rendering.OpenGL.GL.FramebufferObjects.FramebufferObjects
import Graphics.Rendering.OpenGL.GL.FramebufferObjects.RenderbufferObjects

import Graphics.Rendering.OpenGL.GL.BufferMode
import Graphics.Rendering.OpenGL.GL.PeekPoke
import Graphics.Rendering.OpenGL.GL.Texturing.Objects
import Graphics.Rendering.OpenGL.GL.Texturing.Specification
import Graphics.Rendering.OpenGL.GL.Texturing.TextureTarget
-----------------------------------------------------------------------------

data FramebufferObjectAttachment =
     ColorAttachment !GLuint
   | DepthAttachment
   | StencilAttachment
   | DepthStencilAttachment

marshalFramebufferObjectAttachment :: FramebufferObjectAttachment -> GLenum
marshalFramebufferObjectAttachment x = case x of
   ColorAttachment c -> if c >= maxColorAttachments
      then error $ "marshalFramebufferAttachment: index out of range" ++ show c
      else gl_COLOR_ATTACHMENT0 + fromIntegral c
   DepthAttachment -> gl_DEPTH_ATTACHMENT
   StencilAttachment -> gl_STENCIL_ATTACHMENT
   DepthStencilAttachment -> gl_DEPTH_STENCIL_ATTACHMENT

maxColorAttachments :: GLuint
maxColorAttachments = 16

-----------------------------------------------------------------------------

class FramebufferAttachment a where
   marshalAttachment :: a -> GLenum
instance FramebufferAttachment FramebufferObjectAttachment where
   marshalAttachment = marshalFramebufferObjectAttachment
instance FramebufferAttachment BufferMode where
   marshalAttachment = fromJust . marshalBufferMode


-----------------------------------------------------------------------------

framebufferRenderbuffer :: FramebufferTarget -> FramebufferObjectAttachment
   -> RenderbufferTarget -> RenderbufferObject -> IO ()
framebufferRenderbuffer fbt fba rbt (RenderbufferObject rboi) =
   glFramebufferRenderbuffer (marshalFramebufferTarget fbt)
      (marshalFramebufferObjectAttachment fba) (marshalRenderbufferTarget rbt) rboi

framebufferTexture1D :: FramebufferTarget -> FramebufferObjectAttachment
   -> TextureObject -> Level -> IO ()
framebufferTexture1D fbt fba (TextureObject t) l  = glFramebufferTexture1D
   (marshalFramebufferTarget fbt) (marshalFramebufferObjectAttachment fba)
      (marshalTextureTarget Texture1D) t l

framebufferTexture2D :: FramebufferTarget -> FramebufferObjectAttachment
   -> Maybe CubeMapTarget-> TextureObject -> Level -> IO ()
framebufferTexture2D fbt fba mcmt (TextureObject t) l = glFramebufferTexture2D
   (marshalFramebufferTarget fbt) (marshalFramebufferObjectAttachment fba)
      (maybe (marshalTextureTarget Texture2D) marshalCubeMapTarget mcmt) t l

framebufferTexture3D :: FramebufferTarget -> FramebufferObjectAttachment
   -> TextureObject -> Level -> GLint -> IO ()
framebufferTexture3D fbt fba (TextureObject t) le la = glFramebufferTexture3D
   (marshalFramebufferTarget fbt) (marshalFramebufferObjectAttachment fba)
      (marshalTextureTarget Texture1D) t le la

framebufferTextureLayer :: FramebufferTarget -> FramebufferObjectAttachment
   -> TextureObject -> Level -> GLint -> IO()
framebufferTextureLayer fbt fba (TextureObject t) le la =
   glFramebufferTextureLayer (marshalFramebufferTarget fbt)
      (marshalFramebufferObjectAttachment fba) t le la
