Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2AFC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 15:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2087F40B9D;
	Fri, 21 Mar 2025 16:32:47 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9020640276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 16:32:45 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-6fed0620395so18515307b3.3
 for <dev@dpdk.org>; Fri, 21 Mar 2025 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1742571164; x=1743175964; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ac6H/vQNwqHNFby2qAF8FCf/RO2DbOj/4/IpoJ7O9Gk=;
 b=NPqB5IpEC2Ul/9vlEd9Ig/57170CRRkYUtihrmpjhPW272Ezx/j0cpwZBVHOfxrvrR
 JpOTz0KDJCDNM1fJKHDCZ9guA90HtNNQizfZ+4ZHrdTw5tkNl2lXBsI2LLhL4wFlAS3G
 lA3qjKrSpe3qVzJXJWwiu57OqGOKNXDmqdGt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742571164; x=1743175964;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ac6H/vQNwqHNFby2qAF8FCf/RO2DbOj/4/IpoJ7O9Gk=;
 b=kHsVNP3tYy76s05XhZ7ptJOxGx9J5VxKGX2EXRR2C04o71M3ZVrlZGvpbysB9Iyfz6
 YmKCDROWIX4UvqsEnJRj5qq+Pkl4/sC9nRM32ufWRp23Ear/jWB+CeyBHJPlDpbvfSxZ
 XstgXZWEi1IoabE/IYuOMESCSU5zjSpAGFySH5dLCAt1vsBEn4kE2eJmTTaeHoPqTRiU
 NpLylMCRCMZ1y/pJTZogq4fxxGYT6acckvM9ClaL1BgeXlh4FxIcs9kHi4exeMNUf0ev
 x/06tzJvjhqeIi0kqMosAgAusXMVmjKY1OWr266yf+2BzI6rplCOybQh/88CRFxVr2wK
 BueA==
X-Gm-Message-State: AOJu0YxCTmo3Ic0ywS50pEmNsJP3vrKiVWTfOQZD6qfWdwWsNfhdrVqL
 NuIuSt571dNDU46Yf5o/bru9Q8u6kJQ/yP13lKUNP2bIZPRBEXAtnXYEIWgsmMDJgKVZwTlRDd9
 /WvWpGb/eTugMJ5V0+BsPoNescitMfaDirFGzT6IB1JFLHUvvjS5CKQ==
X-Gm-Gg: ASbGncsp4PhMjW9oNIjDwDaklezZYXOhWTkBpfqkgT2bT11UcjKlIVPdzLTvLM+uFri
 KTii3Tyjt73a6s4DAccPeyNsUQVnp6pwg8ZRXuI/QlZyvlJ8WNIg6AFU5wN/hwhK/aeRV4e66OD
 v8IUNPmQq59HTIuSLxqvGH7yyIUg==
X-Google-Smtp-Source: AGHT+IGmUjhrRaZ5zKluexyCUC8eqa86JAWOFpOeLKLFlYokHvVm0MIfnS6g+2+V2QTcxymDZCQbauqrykASByPN0h8=
X-Received: by 2002:a05:690c:610e:b0:6fd:4521:f9d7 with SMTP id
 00721157ae682-700baccc839mr51297537b3.24.1742571164466; Fri, 21 Mar 2025
 08:32:44 -0700 (PDT)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Fri, 21 Mar 2025 10:32:33 -0500
X-Gm-Features: AQ5f1Jov-fGceBVpfpQ-qo0plSy_nh0EqchIIN_gyjohSu2zxARmt1p0C0mcUso
Message-ID: <CAKoDjhwRVix0LYoUHECm7=ty_ntjRpsrjG0ocVT82hjBJi5J-Q@mail.gmail.com>
Subject: DPDK Student Development
To: dev@dpdk.org
Cc: "O'Driscoll, Tim" <tim.odriscoll@intel.com>,
 Ian Jolliffe <ijolliff@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000411a090630dbf7df"
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

--000000000000411a090630dbf7df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good Morning (and Afternoon/Evening) DPDK Community,


Leadership on the DPDK project is currently exploring the option of
recruiting university students to begin advancing development of the tech
stack, particularly in several designated areas that we=E2=80=99ve agreed o=
n:
Hyperscaling/Cloud Testing, Security, Artificial Intelligence. There is
also room for coding development to support further expansion of Windows
support via the Microsoft Visual Compiler (MSVC).


DPDK, of course, has a longstanding working relationship with the
University of New Hampshire, and we have several additional universities
that joined in the past as Associate Members. This can serve as a starting
point.


That notwithstanding: if you are affiliated with a university and would
like to assist with this, or have suggestions about a collegiate
institution that might be interested in a formal partnership to effectuate
additional student development of the stack,  please reach out to myself
nsouthern@linuxfoundation.org, to our tech board rep Stephen Hemminger
stephen@networkplumber.org, and to our lead maintainer Thomas Monjalon
thomas@monjalon.net, to let us know.


Many thanks,


Nathan Southern

Nathan C. Southern, Senior Project Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--000000000000411a090630dbf7df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0px;font-stretch:normal;font-size:13px;=
line-height:normal;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:=
none;font-kerning:auto;font-variant-alternates:normal;font-variant-ligature=
s:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fe=
ature-settings:normal">Good Morning (and Afternoon/Evening) DPDK Community,=
</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;min-height:15px"><br></p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Leadership on the DPDK project is currently exploring the option of r=
ecruiting university students to begin advancing development of the tech st=
ack, particularly in several designated areas that we=E2=80=99ve agreed on:=
 Hyperscaling/Cloud Testing, Security, Artificial Intelligence. There is al=
so room for coding development to support further expansion of Windows supp=
ort via the Microsoft Visual Compiler (MSVC).</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;min-height:15px"><br></p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">DPDK, of course, has a longstanding working relationship with the Uni=
versity of New Hampshire, and we have several additional universities that =
joined in the past as Associate Members. This can serve as a starting point=
.</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;min-height:15px"><br></p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">That notwithstanding: if you are affiliated with a university and wou=
ld like to assist with this, or have suggestions about a collegiate institu=
tion that might be interested in a formal partnership to effectuate additio=
nal student development of the stack,<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 </span>please reach out to myself <a href=3D"mailto:nsouthern@=
linuxfoundation.org"><span style=3D"color:rgb(220,161,13)">nsouthern@linuxf=
oundation.org</span></a>, to our tech board rep Stephen Hemminger <a href=
=3D"mailto:stephen@networkplumber.org"><span style=3D"color:rgb(220,161,13)=
">stephen@networkplumber.org</span></a>, and to our lead maintainer Thomas =
Monjalon <a href=3D"mailto:thomas@monjalon.net"><span style=3D"color:rgb(22=
0,161,13)">thomas@monjalon.net</span></a>, to let us know.</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;min-height:15px"><br></p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Many thanks,</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;min-height:15px"><br></p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Nathan Southern</p>
<div><br></div><div><p style=3D"margin:0px;font-stretch:normal;font-size:13=
px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;font-size-adju=
st:none;font-kerning:auto;font-variant-alternates:normal;font-variant-ligat=
ures:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-feature-settings:normal">Nathan C. Southern, Senior Project Coordinator</p=
>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Data Plane Development Kit (DPDK)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">The Linux Foundation</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">248.835.4812 (mobile)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal;color:rgb(220,161,13)"><a href=3D"mailto:nsouthern@linuxfoundation.org=
">nsouthern@linuxfoundation.org</a></p></div></div>

--000000000000411a090630dbf7df--
