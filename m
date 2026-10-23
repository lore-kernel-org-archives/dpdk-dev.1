Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A2606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=VSsM8SgG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 124FE402C8;
	Fri, 23 Oct 2026 22:52:48 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id BDD994021F
 for <dev@dpdk.org>; Fri, 23 Oct 2026 22:52:46 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-917997ab0d9so15093836d6.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792788766; cv=none;
 d=google.com; s=arc-20260327;
 b=ovgjU2rsilEcIb1vSX19au0B8+GKy+tyjeG+p3hWrzNV35Fvax1Lhcxd6MZomu+cnJ
 PA6iRRWNQX9XaBQrf5c+oIMNn1xtqiO55Sv0IXxzYCRfOvA5vb4sNFA9AzvqUPAw99+y
 5xHtMi5vZf5So/AUTW1e9e6/8NPgaGYVGAsCVVQYCEfccDgAgw1vQ6KatBMsT0FvF+J6
 wJAHTdskJn07pS1p5AOV4H5Kt67Tk/v/I9Ci5gt+wua/wrRSNBhQ6oZx/d49xyzuTRi0
 Xqed+3UclMTYGUCmioIolrI/ewTsZu6tkENYE59LOE+6yOE4Xp+X4vLG8jwqUlP4Bdzm
 xA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aKHgkPrb6z/IYbMbIo1VxMOP/3D+5B+2RyWL79MBm2I=;
 fh=X+DPomYhbZ0AYSatKqwHqlxhIF/GWUOckr0V9ACP0fA=;
 b=RbSzL4xM+5nsZJco6kA15LRA3ki9S+LY1JurQMJuBbk3WSujjk0J19JN8j5hGvZUz6
 d5OgAOtuHfjBiGKuHdXvrpNVZ4Puoax+AtJXctdAfPEElL12LbVbuZXEOOzNYPtRH3VB
 LelWim6xWY6Mg7suxYdVfsCweqy7EDCiEWCAUypv3s2vpI3jwd1x4E8Vuk8OmroTOdS3
 lL4NLbV1XDO4EdXwhohbHWerGsgCics7oGjl+MChsuH/M3QepvZWiVg9KycqdvxFPpaL
 ywoydkyfJYyCbAYRDlveljz2fWWKfMuV0dnF8YEeIYzngow9GKai5J+8KDBS4LGm5xVC
 /jMQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792788766; x=1793393566; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aKHgkPrb6z/IYbMbIo1VxMOP/3D+5B+2RyWL79MBm2I=;
 b=VSsM8SgGveaDGpgCeff0kqa9ZX8Ol/KVq+jH3MpzfgqBmdIduvO9NvLMBjnIyup7p+
 nFy0EyPvNrIL6VVUa1/GP7oGxd01e/b71gb8YGgPJF45XoYAwGOpfHQAUlYMkbP7WDD0
 sidF/mkZPq5oBAjk7WL2spNYouqIXr7GPFxXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792788766; x=1793393566;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aKHgkPrb6z/IYbMbIo1VxMOP/3D+5B+2RyWL79MBm2I=;
 b=tFO4F+zJayZvyrau3lgRWetDRUrAgazsF6LoUWTmXOJYae8+4V0/n7fMBOCytbwqm9
 wShHPyUn/yXQthe1o3+zR93tFNLuCloV38cGDuSGkuyio7ahu83cFvTfYw43ZG3JuMTv
 wlAi6/0DJLNt+8inALqTin4kmlFtxy42KilOUZuEtpoc4nwU9vxY2s86qrpx15aGUnJZ
 Vjb7JeDlpm/+szzFggSIL+DcbJNncMxFey+Dt9M+TvGuHCi7b5/ZmM4YF9RK+ZHW32Dw
 Oz5z+nXVEwFeO2Gaw/2hvAgd28LmOBcHFPbp5Y3ybfw37IaYzAATgWxzvspxDtWNoIrb
 gj/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzinRiiOTeYnM4zXjHuUXEWYmmkmvM5HCcCYYKfPEhJaac/8Q/O9f0Kn/tD6Kd+bJhjd1U=@dpdk.org
X-Gm-Message-State: AFq9FYJ2IKec7Ttvb9T+3UoOCCqdCUxZRBjg2/qhXxNoGHAckYWAv6kj
 Y4MwU71bDsQLX19Yr2vYnBJlQpB1XkD7gxC9ZA2l6jUJFJF06JHogwO+ZOhMLS3pc0vLj31jkkJ
 J2VbSZG2wKPaU6059pbfglrQgj8SHahxYHZx31qDD9g==
X-Gm-Gg: AYBFou1M4bmS7kfNoS+74XGiU+g+8+ywgiin+tBB2RPij19wzEpgP8YB25XA14lCH5g
 L53Ma3xIpoK3/tyydK14xEJt+TtxW+cMGOAABq2NyJWizvHmMUqHZSp4jeWf8iKvKA33StNhr14
 fyZv31Dm3L1Hz8lt24n7/v8dx0oa9sWV2xPjxjezKHG8GLbE99o8SB9XqVW+xl/Djf9k57Zy2f2
 XEAlGawju4I7UvPt15UaM2ShnPf0k0CPbVGJoMrUz2aqK5U4UZnVbxzsubBM7WfgmDFICSl6jqL
 uDkDVZhlLISlWYeZAlkGkbnQTUuqX3PH6Qn2Eo1g9pkrkAsVvF/x0ILXLPslk5m4tpXNpZ/hQ7b
 ttSjRFB3TomtMTPJ2oIc7eO2nrJY3smfAsML8UuTrlIsqDtOfoD5eTka3mLtDfV+OB80q5mango
 sgQhe7FYf+zI+40JQlgqyyJ+NSOfPPXxZ7Y6H+B9pCT/MjmSmhqrWpueqyAujnvdWn0P4ZThS4K
 sXeULiIdmZwd/vKAK2G/T2jvW7aVZ6p
X-Received: by 2002:a05:620a:1a18:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-940ef9141d2mr32154985a.24.1792788765941; Fri, 23 Oct 2026
 13:52:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
 <CAKYPG+wJOvzq0mUQ+R5MNuydaj_ROwHHgOqyF6K4nP_ewkO5_Q@mail.gmail.com>
 <b324fbdb-a6d0-4515-a499-7e76692feeb3@arm.com>
 <CAKYPG+xMM3jT_ME0qYtPctP6zc8kYXC88FMJeW12GidH12iD5g@mail.gmail.com>
 <7d00f6a1-5909-48d6-906b-e078eeb9a1c3@arm.com>
In-Reply-To: <7d00f6a1-5909-48d6-906b-e078eeb9a1c3@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Fri, 23 Oct 2026 16:52:09 -0400
X-Gm-Features: AclHuK-1hmTs4Bv8Iesruke-yJjLdQdx0K_am6g_GN5znWkXPF1m0qSBJYgEI98
Message-ID: <CAKYPG+xyUbSoZzcG9pvJQxCct5kic5NY94NGkkTq7ytmnVZHHw@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000008d3c58065e8829a2"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008d3c58065e8829a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:38=E2=80=AFPM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> On 22/10/2026 18:29, Koushik Bhargav Nimoji wrote:
> >
> >
> > On Thu, Oct 22, 2026 at 9:51=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@ar=
m.com
> > <mailto:Luca.Vizzarro@arm.com>> wrote:
> >
> >     On 20/10/2026 17:06, Koushik Bhargav Nimoji wrote:
> >      > On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca Vizzarro
> >     <Luca.Vizzarro@arm.com <mailto:Luca.Vizzarro@arm.com>
> >      > <mailto:Luca.Vizzarro@arm.com <mailto:Luca.Vizzarro@arm.com>>>
> wrote:
> >      >
> >      >      > +        if (
> >      >      > +            ctx.topology.type is not LinkTopology.NO_LIN=
K
> >      >      > +            and testsuite_type is not TestSuiteType.CRYP=
TO
> >      >      > +        ):
> >      >      > +            if testsuite_type =3D=3D TestSuiteType.FUNC:
> >      >      > +                required_tg, other_tg =3D ctx.func_tg,
> >     ctx.perf_tg
> >      >      > +            else:
> >      >      > +                required_tg, other_tg =3D ctx.perf_tg,
> >     ctx.func_tg
> >      >      > +
> >      >      > +            if other_tg and other_tg.is_setup:
> >      >      > +                other_tg.teardown()
> >      >      > +
> >      >      > +                if testsuite_type =3D=3D TestSuiteType.F=
UNC
> and
> >      >     ctx.tg_node:
> >      >      > +                    for port in ctx.topology.tg_ports:
> >      >      > +
> >      >     ctx.tg_node.main_session.bind_ports_to_driver([port],
> >      >     port.config.os_driver)
> >      >
> >      >     I am a bit confused why this happens here. The driver to be
> >     bound to
> >      >     should be governed by the TG that uses such ports. Could be
> >     os_driver,
> >      >     could be dpdk_driver, regardless of Scapy and TRex.
> >      >
> >      > This section exists because of how scapy and TRex handle port
> driver
> >      > bindings. TRex automatically binds ports to the required driver
> when
> >      > setup, but scapy requires it to be done manually. That's why if
> >     the next
> >      > test suite to be tested is a functional test suite, the TG ports
> are
> >      > rebound to the os_driver manually here.
> >
> >     So I think the original intention here was that TRex would
> >     exceptionally
> >     change the driver as the normal behaviour was that the TG was not
> going
> >     to be subject to driver binding. Therefore what would make sense is
> for
> >     the TG to control driver binding accordingly. So if Scapy is setup
> that
> >     it would be up to Scapy to "bind to kernel drivers" if needed. What
> do
> >     you think?
> >
> >
> > I think you're definitely right here, it should be up to the TG to take
> > care of port bindings instead of doing it manually. Scapy currently doe=
s
> > take care of that, but there's an issue with DTS's internal state being
> > out of date after rebinding to the kernel driver. As a workaround for
> > this, I have added a teardown method to trex.py that rebinds ports to
> > the kernel driver before scapy is set up. I will send out a version
> > shortly that reflects these changes, thanks for bringing this up.
>
> So I think the problem with the state is because you are not using
> Topology which is the ports manager/owner. Even if `main_session` is
> public, it's an internal API which use should be limited to some. If you
> look at the setup of Scapy:
>
>      def setup(self, topology: Topology) -> None:
>          super().setup(topology)
>          topology.configure_ports("tg", "kernel")
>
> What I expect to see in the Trex class is:
>
>      def setup(self, topology: Topology) -> None:
>          super().setup(topology)
>          topology.configure_ports("tg", "dpdk")
>
> If this doesn't work as intended, then there is a bug that needs resolvin=
g.
>
> Luca
>

After looking into it further, I've found the bug!. The setup for TRex
never calls configure_ports() at all, instead letting TRex handle port
bindings itself internally which leaves the port configurations in a stale
state. I've added the configure_ports("tg", "dpdk") call to the setup
method in trex.py and removed all manual port bindings and teardowns. I've
tested the change and it works accurately on my end. I'll send out another
version of my patch shortly. Thanks!

--0000000000008d3c58065e8829a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23,=
 2026 at 1:38=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@=
arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 22/10/2026 18:29, Koushik Bhargav Nimoji w=
rote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Oct 22, 2026 at 9:51=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"m=
ailto:Luca.Vizzarro@arm.com" target=3D"_blank">Luca.Vizzarro@arm.com</a> <b=
r>
&gt; &lt;mailto:<a href=3D"mailto:Luca.Vizzarro@arm.com" target=3D"_blank">=
Luca.Vizzarro@arm.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 20/10/2026 17:06, Koushik Bhargav Nimoji wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca=
 Vizzarro<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:Luca.Vizzarro@arm.com" target=
=3D"_blank">Luca.Vizzarro@arm.com</a> &lt;mailto:<a href=3D"mailto:Luca.Viz=
zarro@arm.com" target=3D"_blank">Luca.Vizzarro@arm.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:Luca.Vizzarro@ar=
m.com" target=3D"_blank">Luca.Vizzarro@arm.com</a> &lt;mailto:<a href=3D"ma=
ilto:Luca.Vizzarro@arm.com" target=3D"_blank">Luca.Vizzarro@arm.com</a>&gt;=
&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ctx.topology.type is not LinkTopology.NO_LINK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 and testsuite_type is not TestSuiteType.CRYPTO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_type =3D=3D TestSuiteType.FUNC:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, other_tg =3D ctx.func_t=
g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.perf_tg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, other_tg =3D ctx.perf_t=
g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.func_tg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if other_tg and other_tg.is_setup:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other_tg.teardown()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_type =3D=3D TestSuiteTy=
pe.FUNC and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ctx.tg_node:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in ctx.topolo=
gy.tg_ports:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ctx.tg_node.main_session.b=
ind_ports_to_driver([port],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0port.config.os_driver)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0I am a bit confused why th=
is happens here. The driver to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0bound to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0should be governed by the =
TG that uses such ports. Could be<br>
&gt;=C2=A0 =C2=A0 =C2=A0os_driver,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0could be dpdk_driver, rega=
rdless of Scapy and TRex.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This section exists because of how scapy and =
TRex handle port driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; bindings. TRex automatically binds ports to t=
he required driver when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; setup, but scapy requires it to be done manua=
lly. That&#39;s why if<br>
&gt;=C2=A0 =C2=A0 =C2=A0the next<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; test suite to be tested is a functional test =
suite, the TG ports are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; rebound to the os_driver manually here.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So I think the original intention here was that TRe=
x would<br>
&gt;=C2=A0 =C2=A0 =C2=A0exceptionally<br>
&gt;=C2=A0 =C2=A0 =C2=A0change the driver as the normal behaviour was that =
the TG was not going<br>
&gt;=C2=A0 =C2=A0 =C2=A0to be subject to driver binding. Therefore what wou=
ld make sense is for<br>
&gt;=C2=A0 =C2=A0 =C2=A0the TG to control driver binding accordingly. So if=
 Scapy is setup that<br>
&gt;=C2=A0 =C2=A0 =C2=A0it would be up to Scapy to &quot;bind to kernel dri=
vers&quot; if needed. What do<br>
&gt;=C2=A0 =C2=A0 =C2=A0you think?<br>
&gt; <br>
&gt; <br>
&gt; I think you&#39;re definitely right here, it should be up to the TG to=
 take <br>
&gt; care of port bindings instead of doing it manually. Scapy currently do=
es <br>
&gt; take care of that, but there&#39;s an issue with DTS&#39;s internal st=
ate being <br>
&gt; out of date after rebinding to the kernel driver. As a workaround for =
<br>
&gt; this, I have added a teardown method to trex.py that rebinds ports to =
<br>
&gt; the kernel driver before scapy is set up. I will send out a version <b=
r>
&gt; shortly that reflects these changes, thanks for bringing this up.<br>
<br>
So I think the problem with the state is because you are not using <br>
Topology which is the ports manager/owner. Even if `main_session` is <br>
public, it&#39;s an internal API which use should be limited to some. If yo=
u <br>
look at the setup of Scapy:<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setup(self, topology: Topology) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().setup(topology)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0topology.configure_ports(&quot;tg&quot;, =
&quot;kernel&quot;)<br>
<br>
What I expect to see in the Trex class is:<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setup(self, topology: Topology) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().setup(topology)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0topology.configure_ports(&quot;tg&quot;, =
&quot;dpdk&quot;)<br>
<br>
If this doesn&#39;t work as intended, then there is a bug that needs resolv=
ing.<br>
<br>
Luca<br></blockquote><div><br></div><div>After looking into it further, I&#=
39;ve found the bug!. The setup for TRex never calls configure_ports() at a=
ll, instead letting TRex handle port bindings itself internally which leave=
s=C2=A0the port configurations in a stale state. I&#39;ve added the configu=
re_ports(&quot;tg&quot;, &quot;dpdk&quot;) call to the setup method in trex=
.py and removed all manual port bindings and teardowns. I&#39;ve tested the=
 change and it works accurately on my end. I&#39;ll send out another versio=
n of my patch shortly. Thanks!</div></div></div>

--0000000000008d3c58065e8829a2--
