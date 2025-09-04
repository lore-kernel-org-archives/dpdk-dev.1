Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05480CA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 21:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B73B427DD;
	Thu,  4 Sep 2025 23:25:43 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 64E27427D1
 for <dev@dpdk.org>; Thu,  4 Sep 2025 23:25:42 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24b1622788dso11608295ad.2
 for <dev@dpdk.org>; Thu, 04 Sep 2025 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757021141; x=1757625941; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4bfLKEMWfi0qIClFga0Ei8km5kd1UqunakPvgwE69VY=;
 b=LG+KHSDf8+XiVCGQBI7pHUd0m2+7gTKuRGskDreWyPem5+5P+yluXU5WrKoL95datp
 lS05ekapN9jF5wt9lNSPz4roVwpqsP5jw94v3BaZyx/cAb4ylMshyyjKawtgFUb5ZI4b
 +RC09cOIA8tDZBpBblK9dgp7z6X7P70A+jTpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757021141; x=1757625941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bfLKEMWfi0qIClFga0Ei8km5kd1UqunakPvgwE69VY=;
 b=P2UIl5WKuRuhwTX0wVt3PJN9eIB0a/qUDYmdlndXT0wELVhyg/0maeGmfSo4tG+Nc4
 ohIuhRTBLIEsDqJFJzw0dHu5low6ZYvIedt8mA1C/J9ONVEl9UAZ0IbFsb7V1wZwq0+m
 ypidXm8jDcjdw9Ca2SlJC4ua6BQrI1cnNKZtpzzVSSm8stKP+6ZPUHTGEKnR0R1baO2P
 alA4jd9rzJu89qKcDVV2a37JkFqYZ8v0Qmc34XtYk+5/h5JLj7v8z2T/2AVjoxDela8G
 yKeZ9HCRpIgkoM1EUQ11IpIKc7Hkd0jttPLT/+urzTgyeJaJo50EuIgh8m7llw0E+0xo
 9bug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP2Ghb68mXZY8sbhFfgrV8ApVx50hc9xYSqF3iG4DTwr/kbLeEgmGpne0eeD7kuVmecQY=@dpdk.org
X-Gm-Message-State: AOJu0YxN7gcaRwvvrwvQrBKFBfx6RPrNNMSMuS+DLpzKp2xVRBcEbAuw
 OT/BnUEGLDVlLRDQBxqtHDxnZFKi5mRmWX7feOA9j821W8nunLUpLuI4/VB/J3phnwFPrqEWgjG
 E5Dru/dJ0aoAHshSYQoSW6lygD+PKM2o0wJFlDzN2FA==
X-Gm-Gg: ASbGnctPXRwxDoYwt3AVv69jyKhqL1UPtciySJAftMUsY+4msWIy3Za3hXP1L0+nLfH
 bn3yR0PvVPY42x3EbhqK0lcdBN5v/1kHmPVNsGN2ta3ve515h+uD6hJ7ua6bjNGcllTZ44Nxtng
 dweCoKfP5qdN/yJGoZZqAhULgAZf7C2JOwntDsrBHOlAPRyuhKH662QWVj1ZxqwPSqkWapvqSlt
 KfVGBJNTgLW3vr15my4CY2exfHCjRl2+JJW0kQShRbQvCWzIy4=
X-Google-Smtp-Source: AGHT+IEZOOmkGEDZEhpx5/o6cRVeh6jUrOkx6pZ9UHKpY/v96Cv9O2hdVuGlw7TCdT+wKCmSTWHnRI/hRzCG2/d9LXg=
X-Received: by 2002:a17:903:98f:b0:24c:cb6b:105b with SMTP id
 d9443c01a7336-24ccb6b138cmr43386695ad.25.1757021141478; Thu, 04 Sep 2025
 14:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
 <20250903180414.83001-2-abailey@iol.unh.edu>
 <175699757148.86363.18113785073209751856.luca.vizzarro@arm.com>
In-Reply-To: <175699757148.86363.18113785073209751856.luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 4 Sep 2025 17:18:52 -0400
X-Gm-Features: Ac12FXzeNcOKTtTud46vGIJpmMboVe2qHGQsb4JEXRWlyrhif7bm3UxTsf1tWEQ
Message-ID: <CAJvnSUAZbF6JmGqMVo7dgOwxv=TOPKuZSix-9n4phHZ=vr9Chg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am
Content-Type: multipart/alternative; boundary="00000000000000419f063e005dc6"
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

--00000000000000419f063e005dc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:16=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> On Wed, Sep 03, 2025 at 02:04:12PM +0000, Andrew Bailey wrote:
> > diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> > index ad8cb273dc..4d9caceb37 100644
> > --- a/dts/framework/remote_session/testpmd_shell.py
> > +++ b/dts/framework/remote_session/testpmd_shell.py
> > @@ -19,7 +19,7 @@
> >  import time
> >  from collections.abc import Callable, MutableSet
> >  from dataclasses import dataclass, field
> > -from enum import Flag, auto
> > +from enum import Enum, Flag, auto
> >  from os import environ
> >  from pathlib import PurePath
> >  from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal,
> ParamSpec, Tuple, TypeAlias
> > @@ -344,6 +344,13 @@ def make_parser(cls) -> ParserFn:
> >          )
> >
> >
> > +class RxTxArgFlag(Enum):
>
> this could be StrEnum given the values used. Moreover, is it a
> flag? Looks like a regular enum to me.
>

I was wondering the same but no, by my understanding it's currently an enum
or StrEnum and I can't see us adding additional attributes in the future so
that won't be changing.

--00000000000000419f063e005dc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 4, =
2025 at 11:16=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@=
arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Wed, Sep 03, 2025 at 02:04:12PM +0000, And=
rew Bailey wrote:<br>
&gt; diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/frame=
work/remote_session/testpmd_shell.py<br>
&gt; index ad8cb273dc..4d9caceb37 100644<br>
&gt; --- a/dts/framework/remote_session/testpmd_shell.py<br>
&gt; +++ b/dts/framework/remote_session/testpmd_shell.py<br>
&gt; @@ -19,7 +19,7 @@<br>
&gt;=C2=A0 import time<br>
&gt;=C2=A0 from collections.abc import Callable, MutableSet<br>
&gt;=C2=A0 from dataclasses import dataclass, field<br>
&gt; -from enum import Flag, auto<br>
&gt; +from enum import Enum, Flag, auto<br>
&gt;=C2=A0 from os import environ<br>
&gt;=C2=A0 from pathlib import PurePath<br>
&gt;=C2=A0 from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Li=
teral, ParamSpec, Tuple, TypeAlias<br>
&gt; @@ -344,6 +344,13 @@ def make_parser(cls) -&gt; ParserFn:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +class RxTxArgFlag(Enum):<br>
<br>
this could be StrEnum given the values used. Moreover, is it a<br>
flag? Looks like a regular enum to me.<br></blockquote><div><br></div><div>=
I was wondering the same but no, by my understanding it&#39;s currently an =
enum or StrEnum=C2=A0and I can&#39;t see us adding additional attributes in=
 the future so that won&#39;t be changing.</div><div>=C2=A0</div></div></di=
v>

--00000000000000419f063e005dc6--
