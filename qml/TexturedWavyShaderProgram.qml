/****************************************************************************
**
** Copyright (C) 2015 QUIt Coding Ltd.
** Contact: info@quitcoding.com
**
** This file is part of Cinematic 3D, a Qt3D demo application.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt3D.Render 2.0

ShaderProgram {
    vertexShaderCode: "
    attribute highp vec4 vertexPosition;
    attribute highp vec3 vertexNormal;
    attribute highp vec2 vertexTexCoord;

    varying highp vec2 texCoord;
    varying highp float front;

    uniform highp mat4 mvp;
    uniform highp float wave;
    uniform highp float waviness;

    void main()
    {
        highp vec4 pos = vertexPosition;
        pos.z += sin(pos.x*0.3 + wave) * waviness;
        pos.z -= cos(pos.y*0.3 + wave) * waviness;
        front = step(0.0, vertexNormal.z);
        texCoord = vec2(vertexTexCoord.s, 1. - vertexTexCoord.t);
        gl_Position = mvp * pos;
    }
    "

    fragmentShaderCode: "
    varying highp vec2 texCoord;
    varying highp float front;

    uniform sampler2D coverTexture;

    void main()
    {
        highp vec4 color = front * texture2D(coverTexture, texCoord);
        gl_FragColor = vec4(color.rgb, 1.0);
    }
    "
}
