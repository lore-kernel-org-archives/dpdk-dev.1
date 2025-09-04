Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A05CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19CB44278F;
	Thu,  4 Sep 2025 18:32:25 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1352940275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:32:24 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b47173749dbso797519a12.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757003543; x=1757608343; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OJ1GBiYl+LoRRdtskHYbAtGzNyCLpccL1yN8Wo/yHF0=;
 b=e8+EbYBe8aiZxCtpx0ybA4wVaoW9k9vafQY/ba05Kr6BVVE3ee5hGwJpQaxLnZmGlB
 tEpuxWZHkqD1ZdPCbTx8/Wca7JCIh5ALccNDuL/conAuJL0HmUBU2pWY6DZlnKCvyIkr
 TXcQUixCq2+sktCDQcRBR9mh1n3NXYo/kozvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757003543; x=1757608343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJ1GBiYl+LoRRdtskHYbAtGzNyCLpccL1yN8Wo/yHF0=;
 b=Sc1N3zcEfTEdzGAbbRbSZ2L1kt3Kvcdt3ULfWSXicN5hW6/YgaXaCTwwv9hJow8Slr
 4e1/xUezHw16v5/mZlYxWLPsgMiUGSreCt8RHlzUyrKXmi2Usw3QChZMVP0NJUtVcLU/
 5rPKY1QMjs+LlvTf/hI76uUUE3RplpktCgmwWBEIoae19RLDChjifbNeuVU7+pK68RyH
 xCfeYxu85dCgBIjwata49TbC+TiVxQSnM2bi9H5LcaIy9rX7iteu9Hj72NF7pjgQltEv
 ZP0IdZgPWwO6PfQZaDHVCt+/diaPfBd+kaTGd4HqO9uuIHXi7/jndn5zZM64em7zAy6x
 dFgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO3KzpZ44X6crXDXfTvlxsLNsx7dV88ZoToPN+6416+kz27QFlUj9e0vUnZWWbpmLiFCw=@dpdk.org
X-Gm-Message-State: AOJu0YxYDiYOV+1QJSEIByLIgSANLFZTuLueKxNrJ6nfsk1pnOyZFvSB
 dSNwubz607TwCeQ/cty1bT0W+YB8lgmEJod2rpV8K6YQwO2lp1GYU/sDCbeWUboEwvVSMgtzV6X
 FaF0WvPZqcBLGcmS8sym7qDl33kF2TFsR6vcjWZSLhA==
X-Gm-Gg: ASbGncuQGQXHdWhr/P8FnYRUEnebjbqBTj8E05PHHlZI5zYK3oF9k9+vP/C71++DBjf
 tVuP5YkV5MCQCT/bHpA0F5KmKjMfp7E+edildvvfK/Tqnz4yGZ69Smi6YWmugya5iCed74AI0Nq
 OSxnVeHE4c7CamNN3o29KEtF/aBC1YI8S6JAW1GuQJy7lfuFbKTRr+V3KUBpPAV8ydUI83fM8Jn
 wdlrIHZvXJGupbO94VWmFG+CQZcTzTAf3GmtuXGFw3owIrjzpk=
X-Google-Smtp-Source: AGHT+IG4EwZr9jLKk16a6vMyADDOJ8WdyJue3MkOUGbTX2pdkUuKGV/4kPlMcmg/zJ0kgrIIs7qnMtMbmReXkY6nkn0=
X-Received: by 2002:a17:90b:518e:b0:32b:5f76:9e29 with SMTP id
 98e67ed59e1d1-32b5f76a03amr8085448a91.32.1757003542859; Thu, 04 Sep 2025
 09:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250828123758.20451-1-abailey@iol.unh.edu>
 <175683053809.93271.2049800112988455963.luca.vizzarro@arm.com>
In-Reply-To: <175683053809.93271.2049800112988455963.luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 4 Sep 2025 12:25:35 -0400
X-Gm-Features: Ac12FXxFy3uf850KuFTZUaip6HkEj4xlhecSdbYbDcvi8nsP8j34LAY4dx0GSbo
Message-ID: <CAJvnSUBfrQsXuUhh_1vFfZ35+G8+UXbYv=BdYPuN5H=_bmQFVA@mail.gmail.com>
Subject: Re: [PATCH v3] dts: enable port binding on the TG
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000000aac46063dfc447a"
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

--0000000000000aac46063dfc447a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:52=E2=80=AFPM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> Hi Andrew,
>
> Thank you for clarifying. It makes more sense now.
>
> On Thu, Aug 28, 2025 at 08:37:58AM +0000, Andrew Bailey wrote:
> > diff --git a/dts/framework/testbed_model/port.py
> b/dts/framework/testbed_model/port.py
> > index fc58e2b993..e9ad145f97 100644
> > --- a/dts/framework/testbed_model/port.py
> > +++ b/dts/framework/testbed_model/port.py
> > @@ -126,7 +126,12 @@ def original_driver(self) -> str | None:
> >      @property
> >      def bound_for_dpdk(self) -> bool:
> >          """Is the port bound to the driver for DPDK?"""
> > -        return self.current_driver =3D=3D self.config.os_driver_for_dp=
dk
> > +        dpdk_driver =3D self.config.os_driver_for_dpdk
> > +
> > +        if "TG" in self.node.name:
> > +            return self.current_driver =3D=3D dpdk_driver and dpdk_dri=
ver
> !=3D self.config.os_driver
>
> The `node.name` is an arbitrary name that is chosen by the user.
> Unfortunately this is not a reliable approach.
>
> Another issue is that this logic doesn't really make a lot of sense in
> the context of this property. I'd much rather have a `bound_for_kernel`
> property, and then fix the checks appropriately where these are called.
>

A proposed list comprehension without actually creating the
bound_for_kernel property:

ports_to_bring_up =3D [p for p in ports if (p.current_driver =3D=3D
port.config.os_driver and not p.is_link_up)]

But yes I think it makes sense to add a bound_for_kernel property.


>
>
>
As an aside, I would like to send a patch soon which changes os_driver to
kernel_driver and os_driver_for_dpdk to dpdk_driver throughout the DTS
codebase.

--0000000000000aac46063dfc447a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 12:52=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@=
arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Andrew,<br>
<br>
Thank you for clarifying. It makes more sense now.<br>
<br>
On Thu, Aug 28, 2025 at 08:37:58AM +0000, Andrew Bailey wrote:<br>
&gt; diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testb=
ed_model/port.py<br>
&gt; index fc58e2b993..e9ad145f97 100644<br>
&gt; --- a/dts/framework/testbed_model/port.py<br>
&gt; +++ b/dts/framework/testbed_model/port.py<br>
&gt; @@ -126,7 +126,12 @@ def original_driver(self) -&gt; str | None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 @property<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def bound_for_dpdk(self) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Is the port bound =
to the driver for DPDK?&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.current_driver =3D=3D self.co=
nfig.os_driver_for_dpdk<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_driver =3D self.config.os_driver_for=
_dpdk<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;TG&quot; in <a href=3D"http://se=
lf.node.name" rel=3D"noreferrer" target=3D"_blank">self.node.name</a>:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.current_driver =
=3D=3D dpdk_driver and dpdk_driver !=3D self.config.os_driver<br>
<br>
The `<a href=3D"http://node.name" rel=3D"noreferrer" target=3D"_blank">node=
.name</a>` is an arbitrary name that is chosen by the user.<br>
Unfortunately this is not a reliable approach.<br>
<br>
Another issue is that this logic doesn&#39;t really make a lot of sense in<=
br>
the context of this property. I&#39;d much rather have a `bound_for_kernel`=
<br>
property, and then fix the checks appropriately where these are called.<br>=
</blockquote><div><br></div><div>A proposed list comprehension without actu=
ally creating the bound_for_kernel property:</div><div><br></div><div>ports=
_to_bring_up =3D [p for p in ports if (p.current_driver =3D=3D port.config.=
os_driver and not p.is_link_up)]</div><div><br></div><div>But yes I think i=
t makes sense to add a bound_for_kernel property.</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br></blockquote><div>=C2=A0</div><div>As an aside, I would like to send a =
patch soon which changes os_driver to kernel_driver and os_driver_for_dpdk =
to dpdk_driver throughout the DTS codebase.</div></div></div>

--0000000000000aac46063dfc447a--
