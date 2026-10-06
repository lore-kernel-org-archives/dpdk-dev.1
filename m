Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A787ECA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 19:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA3940268;
	Tue,  6 Oct 2026 21:48:56 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 949FD40151
 for <dev@dpdk.org>; Tue,  6 Oct 2026 21:48:55 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53397325663so29809961cf.1
 for <dev@dpdk.org>; Tue, 06 Oct 2026 12:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791316135; cv=none;
 d=google.com; s=arc-20260327;
 b=MPcecO4P9WPoF8QKOr5ga78HEa6sZwaTABhazPs32oeKFmuaxlFa+8Ml5GuvjICmci
 C2p5+naVe6qkOQV9vxE/JV8mkv77F0/o75ehTMpT8KbwMu+/dSmSGLc8x4SdC85vtyXC
 xeUJyHBEkBXqvQxBWzSYhfqwnqyesF1IdXgig48TbsSGgGIF6SKUM3WqyyAE4JrhC97U
 Buu+rUDQRqnqRfTyGV8dTjudMwYWa3PYmhrgZvxswxTW/22BkJJsBDx1j/qQvrLaczED
 S9lljQqT+3AFs0T0UtUJD1Ubhb+RtEaObDMj20rzkRU9xocaBjrIxowZSkmtcV0kWAEU
 O/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=gyaDGDoG+LLu7sZC27WpmVXVTZJ7VF2NmlNynSIi3do=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=RtnMMYje+c61N194QxdnJgLsTMFZXaAKbS1EnNQd/+iR5VZbjqeFZP68a5D7cah7Jo
 /aFc5qDkMNdECKghWXZLHLG5EGl/bhg5Jq91xsCuLlZSfQOnUkkGWWWP5uDzm+niEkBe
 hCF5iSHiVuOwZqZ12fKbde5FvndbXN7vsaRGNGJGy5JUGBfX/Gs4PGLYWo/dMOBIGiC8
 tdw7LogBc3ByqspWT2JNQRTDGF7X65rVB9vAuVP83EhRpxOogsSA5tazeu3gfpAg5fCl
 2Px7FZ/ie05ionGdWoEag70sMY3Yy9ZzIIB8V6Il9vUWvZ6ErcRwb3mceC/cxU6Tq3Ok
 BITg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1791316135; x=1791920935; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gyaDGDoG+LLu7sZC27WpmVXVTZJ7VF2NmlNynSIi3do=;
 b=RIpNoxOc0FTODveEp3KgVAGuZeMg8usl+nO55ojP/nRnxPK8Sc76ybG/9NB10F3S5/
 3ela6vnYx4NHMUB1ovlRcP9l6G01vsPyNT8H2eJHdoMsj4CoElvmq3ZvHPbkrG/N9AQl
 Qxw9zfI+RW5sHmIWPo1Z4l02Z0HvIZZBiMo1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791316135; x=1791920935;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gyaDGDoG+LLu7sZC27WpmVXVTZJ7VF2NmlNynSIi3do=;
 b=0zbVw7v8tKrOgTmF2gO37cd+2OkRrDCEXbdt/3Ku6DtA55NuiipEN/WP7RNd0FsQUF
 vCtBdyO3j/pwRVv36f0sEc8MC0GfvOAKfCkUqMheUCrFO6cYPUEEdp4QatSPtL/Bh/ow
 BZWFBe9vWGrj+21t/j+11ssne2aa1hvmsIIeFuOuDsPkpaXjygXa2eAbZ5Str2lnuAYJ
 1Aurlbisn8KkhjOBJVl5GkudGE4Epq+pJvIXYx/XZYeu73yVIUhuAh3DDLjR5q7yHOiG
 /3uJY6IWY37covdS+QFcVIi7V9CA5LYRZEyELOET8BCPmSC0yTouYz4nQ4ZAr3/Xjlq2
 XfzA==
X-Gm-Message-State: AFuF++nNDEp7i2uX+Esg5Kf1rd1y2kMj0mMaYiLZpOd9KdzXqBRCTGOQ
 Oe5VC94S0SjYkmbpYtedcB5XmzqivdpI92VqATtKlW8rNLZHJUWCeczmScP2GRZgX3nMp2Vnpog
 T04ndPXrUI1I8W0mGh/2FlKqXxkEWoDZAzDAEYZR0WJfu9IDbSlT74lTJWg==
X-Gm-Gg: AYBFou3NWi4E/SiY5xxaBZgZmfrYMliQd0vgQWh21PMww56KStQrwzuEOdevF9Hvr39
 WYwOiCyGuYcXW3z/MAfMjfTLbit5YYLpXgJX0hpJTsBBK2LulZXSZ2PHsoIkR+5jz+1rj2fZHSG
 Ea1YctYZqv11m11yHmWTn7i8nxORnTl9miMLT8hg+YOY8q2mbyrjuKhfEKaunDn7pKvlvwlSHRh
 HfvXBbUhbq44ngvrdVdE2Qyzvmd6nTKmpaz+Ie/PbrMmvfipP4KClMZmg0fm9Bz8MuhXvvFtP0k
 mkGDGXtCfOJJxIdUs1hFgyBvtLBZA9vFXDOp6azIBNRy6j1hIIUF40yt+ZXl7PbJSaLtNU22hId
 pOyoDI6e4uaQAgONMp/6wQjngaqrKd7NkCCdCQ+aQRTu5P/ZwDJasEfsQh/8xgTGuHcakdnlvrh
 XGHBR9H1wvkVF6S6vaT9hc+STrOqgYX8SmDFL3SpWA1LgXrIJNSPgiFA==
X-Received: by 2002:a05:622a:6f17:10b0:535:6cc1:5890 with SMTP id
 d75a77b69052e-5356cc15e62mr27655891cf.51.1791316134481; Tue, 06 Oct 2026
 12:48:54 -0700 (PDT)
MIME-Version: 1.0
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 6 Oct 2026 15:48:18 -0400
X-Gm-Features: AclHuK9IF3zG_dRbeMUVM-wODOAF_bpSRvAjM_8QHroR9WD_ssrCvTkUz_nYK7Q
Message-ID: <CAKYPG+z4WHdiZ29Ai3MMvF0eWw3tnVWxLUcbWAWbx_t+e=764w@mail.gmail.com>
Subject: Agentic DTS Tool
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e062f8065d31495a"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000e062f8065d31495a
Content-Type: text/plain; charset="UTF-8"

Hi all,

My name is Koushik Bhargav Nimoji, with the UNH-IOL. I would like to
introduce an opportunity for an agentic development tool catered to the
DPDK project with a focus on minimizing token costs. This is a project that
I have created myself In my own free time. I'm sharing this technical brief
to see if there is any interest in the community for further development.

========================================================================

Overview: DTS-Helper is an agentic development tool, built to accelerate
developer workflows through a custom RAG pipeline and automated dual-agent
validation loop. By eliminating brute-force LLM codebase crawls and context
bloating, token costs are reduced.

Advantages:

- Cost-efficient: Removes the need for an agent to crawl the codebase which
fills the context window and is a token-heavy approach.
- Deterministic: Provides deterministic code indexing and retrieval,
opposed to manual agentic code searching.
- Code quality assurance: Unlike AI tools that dump untested code into a
workspace, DTS-Helper uses a secondary validation agent to assess changes
and provide a new perspective to catch logical flaws and syntax errors.
- Seamless Integration: DTS-Helper fits into the DPDK workflow as a
development assistant, as the output format of any changes is a patch file
located in the output directory


Capabilities:

- Pulls the DPDK repo, then chunks and stores DTS code into a local
ChromaDB vector store

- The user can then ask the tool a specific question about the codebase, to
which the tool can query the vector store to gain context behind the
question before answering

- The user can also request a code change, to which a temporary workspace
is created. The agent then makes informed code changes in that temporary
workspace.

- Once the development agent is finished, a validation agent reviews the
changes. If the changes are invalid, the validation agent sends feedback to
the development agent on what specifically to fix. If the changes are
valid, a patch file is then created and placed in the output directory.


Next Steps:

- Expanding vector store to hold the DPDK codebase for full-repo coverage
or DTS test plans for testsuite migrations.

- Provide the tool with a concrete skills file that contains coding
conventions, etc.

- Simplify user configuration for AI providers/models

- In development: Enable the validation agent to run the
dts-check-format.sh script


Repository: https://github.com/Koush1/agentic-dts

The readme in the repository contains a workflow diagram of the tool.

========================================================================


Please reach out with any comments or thoughts on this, and any feedback
would be greatly appreciated.


Best,

Koushik Bhargav Nimoji

--000000000000e062f8065d31495a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>My name is Koushik Bhargav Nimo=
ji, with the UNH-IOL. I would like to introduce an opportunity for an agent=
ic development tool catered to the DPDK project with a focus on minimizing =
token costs.<span style=3D"background-color:transparent">=C2=A0</span><span=
 style=3D"background-color:transparent">This is a project that I have creat=
ed myself In my own free time. I&#39;m sharing this technical brief to see =
if there is any interest in the community for further development.</span></=
div><div><span style=3D"background-color:transparent"><br></span></div><div=
><span style=3D"background-color:transparent">=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></div><div><span style=3D"bac=
kground-color:transparent"><br></span></div><div><span id=3D"m_766266113442=
6071421gmail-docs-internal-guid-e52dff61-7fff-8628-003f-69f126263d13"><span=
 style=3D"font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap"=
>Overview:</span><span style=3D"font-family:Arial,sans-serif;color:rgb(0,0,=
0);background-color:transparent;font-variant:normal;vertical-align:baseline=
;white-space:pre-wrap"> DTS-Helper is an agentic development tool, built to=
 accelerate developer workflows through a custom RAG pipeline and automated=
 dual-agent validation loop. By eliminating brute-force LLM codebase crawls=
 and context bloating, token costs are reduced.</span></span></div><div><sp=
an style=3D"font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre-wra=
p"><br></span></div><div><span id=3D"m_7662661134426071421gmail-docs-intern=
al-guid-5fdd0e8c-7fff-dd84-54e5-37111b2c2e97"><p dir=3D"ltr" style=3D"line-=
height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant:no=
rmal;vertical-align:baseline;white-space:pre-wrap">Advantages:</span></p><p=
 style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
background-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-serif;=
white-space:pre-wrap">- Cost-efficient: Removes the need for an agent to cr=
awl the codebase which fills the context window and is a token-heavy approa=
ch.</span><br><span style=3D"background-color:transparent;color:rgb(0,0,0);=
font-family:Arial,sans-serif;white-space:pre-wrap">- Deterministic: Provide=
s deterministic code indexing and retrieval, opposed to manual agentic code=
 searching.</span><br><span style=3D"background-color:transparent;color:rgb=
(0,0,0);font-family:Arial,sans-serif;white-space:pre-wrap">- Code quality a=
ssurance: Unlike AI tools that dump untested code into a workspace, DTS-Hel=
per uses a secondary validation agent to assess changes and provide a new p=
erspective to catch logical flaws and syntax errors.</span><br><span style=
=3D"background-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-se=
rif;white-space:pre-wrap">- Seamless Integration: DTS-Helper fits into the =
DPDK workflow as a development assistant, as the output format of any chang=
es is a patch file located in the output directory</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
background-color:transparent;white-space:pre-wrap;color:rgb(0,0,0);font-fam=
ily:Arial,sans-serif"><br></span></p><p dir=3D"ltr" style=3D"line-height:1.=
8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-s=
erif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;vert=
ical-align:baseline;white-space:pre-wrap">Capabilities:</span></p><p dir=3D=
"ltr" style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"background-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-s=
erif;white-space:pre-wrap">- Pulls the DPDK repo, then chunks and stores DT=
S code into a local ChromaDB vector store</span></p><p dir=3D"ltr" style=3D=
"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"backgroun=
d-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-serif;white-spa=
ce:pre-wrap">- The user can then ask the tool a specific question about the=
 codebase, to which the tool can query the vector store to gain context beh=
ind the question before answering</span></p><p dir=3D"ltr" style=3D"line-he=
ight:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"background-color:=
transparent;color:rgb(0,0,0);font-family:Arial,sans-serif;white-space:pre-w=
rap">- The user can also request a code change, to which a temporary worksp=
ace is created. The agent then makes informed code changes in that temporar=
y workspace.</span></p><p dir=3D"ltr" style=3D"line-height:1.8;margin-top:0=
pt;margin-bottom:0pt"><span style=3D"background-color:transparent;color:rgb=
(0,0,0);font-family:Arial,sans-serif;white-space:pre-wrap">- Once the devel=
opment agent is finished, a validation agent reviews the changes. If the ch=
anges are invalid, the validation agent sends feedback to the development a=
gent on what specifically to fix. If the changes are valid, a patch file is=
 then created and placed in the output directory.</span></p><p dir=3D"ltr" =
style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"b=
ackground-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-serif;w=
hite-space:pre-wrap"><br></span></p><p dir=3D"ltr" style=3D"line-height:1.8=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;verti=
cal-align:baseline;white-space:pre-wrap">Next Steps:</span></p><p dir=3D"lt=
r" style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"background-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-se=
rif;white-space:pre-wrap">- Expanding vector store to hold the DPDK codebas=
e for full-repo coverage or DTS test plans for testsuite migrations.</span>=
</p><p dir=3D"ltr" style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"background-color:transparent;color:rgb(0,0,0);font-family=
:Arial,sans-serif;white-space:pre-wrap">- Provide the tool with a concrete =
skills file that contains coding conventions, etc.</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
background-color:transparent;color:rgb(0,0,0);font-family:Arial,sans-serif;=
white-space:pre-wrap">- Simplify user configuration for AI providers/models=
</span></p><p dir=3D"ltr" style=3D"line-height:1.8;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"background-color:transparent;color:rgb(0,0,0);font=
-family:Arial,sans-serif;white-space:pre-wrap">- In development: Enable the=
 validation agent to run the dts-check-format.sh script</span></p><p dir=3D=
"ltr" style=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span id=
=3D"m_7662661134426071421gmail-docs-internal-guid-36179e55-7fff-4c09-81f9-1=
5c2aaad2f81"><br></span></p><p dir=3D"ltr" style=3D"line-height:1.8;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-serif;colo=
r:rgb(0,0,0);background-color:transparent;font-variant:normal;vertical-alig=
n:baseline;white-space:pre-wrap">Repository: </span><a href=3D"https://gith=
ub.com/Koush1/agentic-dts" target=3D"_blank" style=3D"text-decoration:none"=
><span style=3D"font-family:Arial,sans-serif;background-color:transparent;f=
ont-variant:normal;text-decoration:underline;vertical-align:baseline;white-=
space:pre-wrap">https://github.com/Koush1/agentic-dts</span></a></p><p styl=
e=3D"line-height:1.8;margin-top:0pt;margin-bottom:0pt"><span style=3D"backg=
round-color:transparent">The readme in the repository contains a</span>=C2=
=A0workflow diagram of the tool.</p><p dir=3D"ltr" style=3D"line-height:1.8=
;margin-top:0pt;margin-bottom:0pt">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</p><p dir=3D"ltr" style=3D"line-height:1.8;marg=
in-top:0pt;margin-bottom:0pt"><br></p><p style=3D"line-height:1.8;margin-to=
p:0pt;margin-bottom:0pt">Please reach out with any comments or thoughts on =
this, and any feedback would be greatly appreciated.=C2=A0</p><p style=3D"l=
ine-height:1.8;margin-top:0pt;margin-bottom:0pt"><br></p><p style=3D"line-h=
eight:1.8;margin-top:0pt;margin-bottom:0pt">Best,</p><p style=3D"line-heigh=
t:1.8;margin-top:0pt;margin-bottom:0pt">Koushik Bhargav Nimoji</p></span></=
div></div>

--000000000000e062f8065d31495a--
