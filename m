Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5D606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=XKJ1PrU1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F72240264;
	Thu, 22 Oct 2026 19:30:12 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id D50FC4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:30:10 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-530e75d1ba1so18172761cf.2
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792690210; cv=none;
 d=google.com; s=arc-20260327;
 b=b8z+tcMJFtPQy/MZ66YfTrl+iCMevMPt9teU0DVbz80b32eWfVFRbcYaWF1U2F14PU
 55OTnFJ2dxShJM/u+9WQ55nybdQY/4zswcUZqdLMBYcqYCeJTa8fJzeApdHf6hrBsq35
 422Sio/b2yGkjIJ801ruHPPdazK0a67rsHGa1fj9dx8NZe4A0+MR8efgjhdQZ4GuezWO
 hhRyFVF0bpOE4GLSuEsJEw59bZ7lGNyxGGcDkcuOS9M7s5Zcf8PzzUQesy+kgu4Wf5X/
 3sRioq9DrZv9kMVrVCSu/pdae/DdC3DWTWdoNpIRrAFFtA1b3Fl0Px0hqcf8bPpOSM/z
 YvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MQLwf7+XJmBWZBAucWw+skxWCux5DJ3kASPc4ObOFBw=;
 fh=tw7n5hDzgu3rtgf7tx6/0xmduUAGoLZaTyr7KsDgFSQ=;
 b=g041zrz1bVQNKnaZ9HG36UTNsStldQzZ+jKQpciFIdMg44pMl/pAhTCIm228O2/qPi
 EYk3Up40PqeK1n4jQcpjrbFnFHxtmqJ4vH1ESK7OR2mx25QgBrg+t4o3ItIO//89IkK3
 nBsf2tDDTUIjnTdDYdCrj76F6HbrH+b9uHVeGoD3VqDmpc3Ggs0M83u+/6mG5MvLombm
 dW3OozLIkrQJ2hSIkaJWqc2EjvXMTyTA3HWuB4S+qV13O9W1K5DX4WhWTLSLeUOPBUxG
 geaoh3qM7m1dJcNIRpFINogM6HScxgvl53NDILeepEoIJaB0s0hkxZ8bCNOApIbt3edw
 qR4A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792690210; x=1793295010; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MQLwf7+XJmBWZBAucWw+skxWCux5DJ3kASPc4ObOFBw=;
 b=XKJ1PrU1pnUHNGeXsqMdRSqGYTi3ffb5W+buVWOJQdeujBKZxAo8qMGmCFWzS2Dbks
 ejSAx2wEOYaQglrQ+KiypymJg6UXZYMCyygo+1/vf728FgiAM+ZGxj02cyyAxHm8cTJ4
 mFf4qKQmIMx/3W5bRWOGsBPTGNrRB150tY64I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792690210; x=1793295010;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MQLwf7+XJmBWZBAucWw+skxWCux5DJ3kASPc4ObOFBw=;
 b=LAzcQyD77AAvTmYI2v4v3QEjmlZK8EmzRLr0jWJdrDfZfO/GGkK7C8jGettVTQsmZm
 d6uvxN13VL4PnBj+YlIgmzVb7cKe2/C8uLT56WJL8tnaaNwnwHpZqra3ieH//OdHkqMl
 O57ICT5WJt7Z6h/FCajuOvfsId9wlinll7zLNoKh2x8xiykXLDUttknk2VujgExGkn5B
 J75mcIj0zIOJ8UYecs6/tB0JURGEqyt3PoetgIJr+4j1x+NjE4mfUyj0dpX2i1Ly80Se
 BpJgrXhs7Slq8/lX4cZWgw5IAEd8uEp1oOJCdWQEdBgbRnTU/eJZplFxal4URexJW2kR
 V9hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1gWTBHI8tCxF8MAI8ZHZcTwiZy6itC4inae0ItdFPUKaGLYQdRNSdPqaSUlrY33gHkok=@dpdk.org
X-Gm-Message-State: AFq9FYKIaMODXC8FAmV65v4QO9zNXKQ+AQnaEwk3dA+4YGZLTijpZnQ1
 kkOiEb1IdDocw2/xfaxKyRau5s72wLJqYymzsvyoo/WQFUY887bp2A71NSXq2Y312mkkGjQ5A/i
 U9TWkfF6ky3x3v/AfrxJaRkA0UeHa9LNOjOp8xYaj6w==
X-Gm-Gg: AYBFou0d+AZs6i35AvajVgesmzVWdMtPSot11N35ytHy117SlcEUCvr2k+tnMOFI9ZT
 0u6TVEjnsa3rGoaGdrVSmzbLrrHAjfb1zsbrqsQx9J62+WA+MKgPfiSwJsrXoNl+d6jqR48bYZn
 W7qZWirHTLrVWYsIJbmF5rkpL8mRAIt6mKoEunwdTz8E/ZrFdVrz/fgew+cktz5HCvQGn8CfGzl
 1H5+95BL51qudig509SJTzl8oNlwCcjg0CZs+6zrs+SRZ9sJ51FdN8feRKuiRA9DlDkzutm5YO9
 QJ6Aa5cxljn3BzVXTvgYYco3B/tMuuy2M9Gjl1X7qb3MmW3/5aqKILQiXIoSLzswlwYgSJBiceD
 p1K8bamOGA+3QP+NKmTYIDqZNybE9y0kWunAICcrcElclnLGeqhTBUwOdqrxXbxG4pobgl23fjw
 4lfYbynHpC3/XiiTwHIjGIzfEx0+3gBl3tGOQTYpfv1j+/u91x8o6ZziOCv0wi8F2Tdcw9ipPg9
 xdJtCYG3MeWCEiKZmoz8JVMxCLG
X-Received: by 2002:ac8:59c9:0:b0:535:856c:1241 with SMTP id
 d75a77b69052e-5369b8c9e92mr90390051cf.56.1792690210070; Thu, 22 Oct 2026
 10:30:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
 <CAKYPG+wJOvzq0mUQ+R5MNuydaj_ROwHHgOqyF6K4nP_ewkO5_Q@mail.gmail.com>
 <b324fbdb-a6d0-4515-a499-7e76692feeb3@arm.com>
In-Reply-To: <b324fbdb-a6d0-4515-a499-7e76692feeb3@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 22 Oct 2026 13:29:33 -0400
X-Gm-Features: AclHuK_7VMU-cT4D0no9QyQhE6i6YskepHofSZo9YuGQ3_Fd3dDPaJu1jBCrhL0
Message-ID: <CAKYPG+xMM3jT_ME0qYtPctP6zc8kYXC88FMJeW12GidH12iD5g@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000029f6ce065e713796"
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

--00000000000029f6ce065e713796
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 9:51=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> On 20/10/2026 17:06, Koushik Bhargav Nimoji wrote:
> > On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca Vizzarro <Luca.Vizzarro@a=
rm.com
> > <mailto:Luca.Vizzarro@arm.com>> wrote:
> >
> >      > +        if (
> >      > +            ctx.topology.type is not LinkTopology.NO_LINK
> >      > +            and testsuite_type is not TestSuiteType.CRYPTO
> >      > +        ):
> >      > +            if testsuite_type =3D=3D TestSuiteType.FUNC:
> >      > +                required_tg, other_tg =3D ctx.func_tg, ctx.perf=
_tg
> >      > +            else:
> >      > +                required_tg, other_tg =3D ctx.perf_tg, ctx.func=
_tg
> >      > +
> >      > +            if other_tg and other_tg.is_setup:
> >      > +                other_tg.teardown()
> >      > +
> >      > +                if testsuite_type =3D=3D TestSuiteType.FUNC and
> >     ctx.tg_node:
> >      > +                    for port in ctx.topology.tg_ports:
> >      > +
> >     ctx.tg_node.main_session.bind_ports_to_driver([port],
> >     port.config.os_driver)
> >
> >     I am a bit confused why this happens here. The driver to be bound t=
o
> >     should be governed by the TG that uses such ports. Could be
> os_driver,
> >     could be dpdk_driver, regardless of Scapy and TRex.
> >
> > This section exists because of how scapy and TRex handle port driver
> > bindings. TRex automatically binds ports to the required driver when
> > setup, but scapy requires it to be done manually. That's why if the nex=
t
> > test suite to be tested is a functional test suite, the TG ports are
> > rebound to the os_driver manually here.
>
> So I think the original intention here was that TRex would exceptionally
> change the driver as the normal behaviour was that the TG was not going
> to be subject to driver binding. Therefore what would make sense is for
> the TG to control driver binding accordingly. So if Scapy is setup that
> it would be up to Scapy to "bind to kernel drivers" if needed. What do
> you think?
>

I think you're definitely right here, it should be up to the TG to take
care of port bindings instead of doing it manually. Scapy currently does
take care of that, but there's an issue with DTS's internal state being out
of date after rebinding to the kernel driver. As a workaround for this, I
have added a teardown method to trex.py that rebinds ports to the kernel
driver before scapy is set up. I will send out a version shortly that
reflects these changes, thanks for bringing this up.

--00000000000029f6ce065e713796
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22,=
 2026 at 9:51=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@=
arm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 20/10/2026 17:06, Koushik Bhargav Nimoji w=
rote:<br>
&gt; On Fri, Oct 16, 2026 at 12:28=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"=
mailto:Luca.Vizzarro@arm.com" target=3D"_blank">Luca.Vizzarro@arm.com</a> <=
br>
&gt; &lt;mailto:<a href=3D"mailto:Luca.Vizzarro@arm.com" target=3D"_blank">=
Luca.Vizzarro@arm.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ct=
x.topology.type is not LinkTopology.NO_LINK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 an=
d testsuite_type is not TestSuiteType.CRYPTO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 testsuite_type =3D=3D TestSuiteType.FUNC:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 required_tg, other_tg =3D ctx.func_tg, ctx.perf_tg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 el=
se:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 required_tg, other_tg =3D ctx.perf_tg, ctx.func_tg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 other_tg and other_tg.is_setup:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 other_tg.teardown()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if testsuite_type =3D=3D TestSuiteType.FUNC and<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.tg_node:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in ctx.topology.tg_ports:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0ctx.tg_node.main_session.bind_ports_to_driver([port=
],<br>
&gt;=C2=A0 =C2=A0 =C2=A0port.config.os_driver)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I am a bit confused why this happens here. The driv=
er to be bound to<br>
&gt;=C2=A0 =C2=A0 =C2=A0should be governed by the TG that uses such ports. =
Could be os_driver,<br>
&gt;=C2=A0 =C2=A0 =C2=A0could be dpdk_driver, regardless of Scapy and TRex.=
<br>
&gt; <br>
&gt; This section exists because of how scapy and TRex handle port driver <=
br>
&gt; bindings. TRex automatically binds ports to the required driver when <=
br>
&gt; setup, but scapy requires it to be done manually. That&#39;s why if th=
e next <br>
&gt; test suite to be tested is a functional test suite, the TG ports are <=
br>
&gt; rebound to the os_driver manually here.<br>
<br>
So I think the original intention here was that TRex would exceptionally <b=
r>
change the driver as the normal behaviour was that the TG was not going <br=
>
to be subject to driver binding. Therefore what would make sense is for <br=
>
the TG to control driver binding accordingly. So if Scapy is setup that <br=
>
it would be up to Scapy to &quot;bind to kernel drivers&quot; if needed. Wh=
at do <br>
you think?<br></blockquote><div><br></div><div>I think you&#39;re definitel=
y right here, it should be up to the TG to take care of port bindings inste=
ad of doing it manually. Scapy currently does take care of that, but there&=
#39;s an issue with DTS&#39;s internal state being out of date after rebind=
ing to the kernel driver. As a workaround for this, I have added a teardown=
 method to trex.py that rebinds ports to the kernel driver before scapy is =
set up. I will send out a version shortly that reflects these changes, than=
ks for bringing this up.<br></div></div></div>

--00000000000029f6ce065e713796--
