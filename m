Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429BEF48CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 07:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71160402B2;
	Fri, 13 Feb 2026 08:46:17 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id A8787402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 08:46:15 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-65a196a735eso1078221a12.2
 for <dev@dpdk.org>; Thu, 12 Feb 2026 23:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770968775; cv=none;
 d=google.com; s=arc-20240605;
 b=gjgYexTnLm+ZhtkV7MXMmo3oZuXsBXP6LOuy35Z3LIXtHYTWxRGrrOIkQtYePljfjM
 IBaezzqKrruxspJ+mn6wQQIh1W9ZEtTYcwtOp7B3BSwVcr5akx/SEWhapDbQvgGC5qUL
 MbDfKeYkk+4Rw0LavHSOoxsxBmVqC7O3UA16pBn1nh3D/nBxa7yYt3csuNGHh7DXgvia
 9V8ks1sb4wd+iOBr2lzArYkY8Gu7aKQL3Weye2G6jizn5XBK+LDAnCcXuTGMPa5TWiuj
 qruXn3X7pIcve795Yv5Z+YfHrU+aAySG6l+HD+mXpJvRolnhoJAeOA+xRFPKpNvsnF+P
 tOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fBP29DYjE9aiBdDy2z31MDBDdimoHhv8CDVSro8zrBE=;
 fh=t6yFjtfEoCDwX6CqpesggVS+igo7WTpqyOV9dGSh1F4=;
 b=hNT1DKzPAFYPNcIJPeIoJw6whGktPfgeEPxe0ET7Kj7o1Ln05neqW+QVdEqXyLiEjj
 4DCx2H778Ksg/xVhhadBMHpduB2WlPqmxkIFNLRgjsVe5t8JA6OkD3KMY21rYg8xaDJp
 AocB66Dgc9cgEUI/9sIlzCRiadbm103ySVc534CdfFmlI1oAtllUFQEXYCdIdMMtwaO2
 IzYqeJOajcysgFtZVmACtwP9hnzPLbrJM/AIMuPjOEfYqXTjhhCkSDyRjHfbTxmPq9uj
 8hQKn1QYvbeyFQLGUqq2emfoBbFk36S4lGWdTj0sR9IxF2aPlDMBvjFdJhpS3iCRfzoX
 6ZFw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770968775; x=1771573575; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fBP29DYjE9aiBdDy2z31MDBDdimoHhv8CDVSro8zrBE=;
 b=CHVH23wSyrLjsSbljkscHayny05tFnHMcsL9RZP8MfyPW/qGK8ppmyy3UB/ghncwlE
 ExCACD1v7NREhmht1tm+mZ1izduWyvonDKqfMnwDTQYWcTif2Ji3RkLWGZAb0eKjjoeU
 UKRF6VFVtbcojtJaR1TkmFAwHEeHT+PjYEZGJLihpUHCuA3W6hbo6ALMAYZx6tJioy2j
 TwLwxaDo9H/WFHyngzuBsmRtDAegDe9mgiT4DdsvmsRI7vIYmtg9JnYmRlTK4c5Sblke
 UT3uhvG+PYQXuWf+ybo2lY1llRVlVkivsMn7zu7c9Xx2vZJMppUmmPvBWeftVo7CNBnN
 cpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770968775; x=1771573575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBP29DYjE9aiBdDy2z31MDBDdimoHhv8CDVSro8zrBE=;
 b=B6SHV+vPwgMXppx0nnh3Oyq/Z9mI1dofRrdGVoycYMTlgzkRmaGrxvfaWBvXamstrH
 QpPgoFx7xBA4oNB/ECBhsa4fVgi249wL0mcAyr5gALoUio3xn7lp/KM7vS4ni93/Mvw2
 h5qT/3aV/FMdPkcj2f3q2Z8XJVJowBD1lfBQyRPU2GTD9uCytjYMwsBKJsXs63x09xZI
 wm4YA1YwXqECDZaMj3HeiRG/OTmKgPn/K5gj3fKCnhgZCyAR0NUG785WOY4S7XoXHl91
 wclIPV6SxfOgh/NK324a850RI1iGSgoUmxcJcXE8skveLXo9zEQ3aJPRHPJY2swShmAf
 Mi8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIPs1n3uD+8nUmYs2i3xOr16Xo/VvgGLT8dP8HzC1WKQGLtxsZrJebmi88TnP8cUzRpSQ=@dpdk.org
X-Gm-Message-State: AOJu0YyXUT70+0fAfzSKlfPJK+cqC6yblZnaNDmPhzVPCmG8buwuf6KF
 WF/jIf1t9K+K+clZONkZRv4I5CUMuPCBBX5nhm5Tfj3A9GL4SU03aSt/v/OWHst7XGu64cTVCky
 tQy3xwR9WkvM1P0jRGeK1h4AvDejyWPvcarF73woQ0Q==
X-Gm-Gg: AZuq6aK2nOzTHxqT8PDoAFfs+IiQ6gje/kb8Kz6i97yqHlazKzmF7Lo9mYCqbrUf+1t
 Sy2cenRiBWyV5TuC2+4AXHLxIIceRR4dtq64gEs0NsOo0iPIekdrTQwi6MB2GIy65+h3SeGz8Kt
 M1P321itghPLCUN2XxxZRL/fYXyUPX6FiD4VYV629oxEqCLEXt79VNhGJgC8XVJAWqfG87AjRJi
 +vwXzrCV47GjabiJVDtf/8ijZhfiyHlBMeEMdRghDvwGyu3rrsqjasExNo0/mCxAG5foFbzHJL6
 rR+tbBs=
X-Received: by 2002:a05:6402:278b:b0:65b:9832:4389 with SMTP id
 4fb4d7f45d1cf-65bb13bba5amr353929a12.27.1770968774896; Thu, 12 Feb 2026
 23:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local> <2762564.TLkxdtWsSY@thomas>
 <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
 <20260212164341.074639cd@phoenix.local>
In-Reply-To: <20260212164341.074639cd@phoenix.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Fri, 13 Feb 2026 08:46:04 +0100
X-Gm-Features: AZwV_QjwoXxHKhZdyaR1EHSh3yAUoKQneN50GnEeO0h2YY2-RRytxSW_K5Vya5c
Message-ID: <CAPQRu6EAKR59BGgRFAr=eWuQr+=3z14+xdCkbZMvfhM5K8bN0A@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org,
 Ori Kam <orika@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000bc7cf6064aafccf2"
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

--000000000000bc7cf6064aafccf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 13. 2. 2026 v 1:43 odes=C3=ADlatel Stephen Hemminger <
stephen@networkplumber.org> napsal:

> On Fri, 6 Feb 2026 16:40:39 +0100
> Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
>
> > p=C3=A1 6. 2. 2026 v 15:02 odes=C3=ADlatel Thomas Monjalon <thomas@monj=
alon.net>
> > napsal:
> >
> > > 04/02/2026 15:53, Stephen Hemminger:
> > > > On Tue, 3 Feb 2026 09:34:26 +0100
> > > > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
> > > >
> > > > > >
> > > > > > The kernel version of checkpatch complains here. The DPDK shell
> > > script
> > > > > > seems to be set to ignore this but.
> > > > > >
> > > > > > WARNING: break is not useful after a return
> > > > > > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > > > > > +               return cmd_flow_parsed(out);
> > > > > > +               break;
> > > > > >
> > > > > > Should I create a new patch set or just let it be at this
> moment?
> > > > > Lukas
> > > >
> > > >
> > > > I am ok with it as is.
> > >
> > > Better to update.
> > >
> > > There are other warnings:
> > >
> > > WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over
> strncpy
> > > - see: https://github.com/KSPP/linux/issues/90
> > > #13052 <https://github.com/KSPP/linux/issues/90#13052>: FILE:
> > > lib/flow_parser/rte_flow_parser.c:12825:
> > > +       strncpy(buf, str, len);
> > >
> > > and a lot of WARNING:LONG_LINE
> > >
> > > I can have a look after the decision.
> >
> > >
> > > And on a more general note, I would have expected to ask the opinion
> > > of rte_flow maintainers, but they are not Cc'ed in these patches.
> > >
> > I communicated primarily with Stephen, and will CC Ori too. Anyone else=
?
> >
> >
> > > I'm a bit skeptical about adding this outside of ethdev library
> > > which defines the flow API.
> > >
> >
> > CCing Ori to make a decision. I don't mind putting it directly into
> ethdev
> > as well, I just thought the parser could be its own separate lib as it =
is
> > just consuming strings and producing rte_flow structures. I can see the
> > heavy ties to the flow library, though. Thomas, Stephen, what are your
> > opinions?
>
> I am beginning to agree with Thomas, this belongs in the ethdev directory
> next to rte_flow.
>
> Also, not sure what the purpose of parser_ops is. It says to pass NULL, b=
ut
> test-pmd is doing something else. It would be better to have an initializ=
er
> (i.e RTE_INIT) instead? Maybe
>


Ok, I can move it there then. Should I proceed with Patch v11 - that would
include moving the ethdev directory and addressing the kernel's checkpatch
issues?

The initializer doesn't seem like a bad idea. I didn't know about that one.
The parser_ops are not needed for purely parsing, but to remain compatible
with the testpmd's code, which is using, e.g., the hints on the commandline
I added parser_ops.
The simple public library API is for converting strings to rte_flow
structures,
the parser_ops is for hooking up the testpmd.

--000000000000bc7cf6064aafccf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">p=C3=A1 13. 2. 2026 v=C2=A01:43 odes=C3=
=ADlatel Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org=
">stephen@networkplumber.org</a>&gt; napsal:</div><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Fri, 6 Feb 2026 16:40:39 +0100<br>
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 &lt;<a href=3D"mailto:sismis@dyna-nic=
.com" target=3D"_blank">sismis@dyna-nic.com</a>&gt; wrote:<br>
<br>
&gt; p=C3=A1 6. 2. 2026 v 15:02 odes=C3=ADlatel Thomas Monjalon &lt;<a href=
=3D"mailto:thomas@monjalon.net" target=3D"_blank">thomas@monjalon.net</a>&g=
t;<br>
&gt; napsal:<br>
&gt; <br>
&gt; &gt; 04/02/2026 15:53, Stephen Hemminger:=C2=A0 <br>
&gt; &gt; &gt; On Tue, 3 Feb 2026 09:34:26 +0100<br>
&gt; &gt; &gt; Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 &lt;<a href=3D"mailto:=
sismis@dyna-nic.com" target=3D"_blank">sismis@dyna-nic.com</a>&gt; wrote:<b=
r>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The kernel version of checkpatch complains here. T=
he DPDK shell=C2=A0 <br>
&gt; &gt; script=C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; seems to be set to ignore this but.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; WARNING: break is not useful after a return<br>
&gt; &gt; &gt; &gt; &gt; #15008: FILE: lib/flow_parser/rte_flow_parser.c:14=
763:<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return cmd_flow_parsed(out);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Should I create a new patch set or just let it be =
at this moment?=C2=A0 <br>
&gt; &gt; &gt; &gt; Lukas=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am ok with it as is.=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Better to update.<br>
&gt; &gt;<br>
&gt; &gt; There are other warnings:<br>
&gt; &gt;<br>
&gt; &gt; WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over=
 strncpy<br>
&gt; &gt; - see: <a href=3D"https://github.com/KSPP/linux/issues/90" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/KSPP/linux/issues/90</a><=
br>
&gt; &gt; #13052 &lt;<a href=3D"https://github.com/KSPP/linux/issues/90#130=
52" rel=3D"noreferrer" target=3D"_blank">https://github.com/KSPP/linux/issu=
es/90#13052</a>&gt;: FILE:<br>
&gt; &gt; lib/flow_parser/rte_flow_parser.c:12825:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(buf, str, len);<br>
&gt; &gt;<br>
&gt; &gt; and a lot of WARNING:LONG_LINE<br>
&gt; &gt;<br>
&gt; &gt; I can have a look after the decision.=C2=A0 <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; And on a more general note, I would have expected to ask the opin=
ion<br>
&gt; &gt; of rte_flow maintainers, but they are not Cc&#39;ed in these patc=
hes.<br>
&gt; &gt;=C2=A0 <br>
&gt; I communicated primarily with Stephen, and will CC Ori too. Anyone els=
e?<br>
&gt; <br>
&gt; <br>
&gt; &gt; I&#39;m a bit skeptical about adding this outside of ethdev libra=
ry<br>
&gt; &gt; which defines the flow API.<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; CCing Ori to make a decision. I don&#39;t mind putting it directly int=
o ethdev<br>
&gt; as well, I just thought the parser could be its own separate lib as it=
 is<br>
&gt; just consuming strings and producing rte_flow structures. I can see th=
e<br>
&gt; heavy ties to the flow library, though. Thomas, Stephen, what are your=
<br>
&gt; opinions?<br>
<br>
I am beginning to agree with Thomas, this belongs in the ethdev directory<b=
r>
next to rte_flow.<br>
<br>
Also, not sure what the purpose of parser_ops is. It says to pass NULL, but=
<br>
test-pmd is doing something else. It would be better to have an initializer=
<br>
(i.e RTE_INIT) instead? Maybe<br>=C2=A0</blockquote><div>=C2=A0</div><div>O=
k, I can move it there then. Should I proceed with Patch v11 - that would</=
div><div>include moving the ethdev directory and addressing the kernel&#39;=
s checkpatch</div><div>issues?</div><div><br></div><div>The initializer=C2=
=A0doesn&#39;t seem like a bad idea. I didn&#39;t know about that one.</div=
><div>The parser_ops are not needed for purely parsing, but to remain compa=
tible</div><div>with the testpmd&#39;s code, which is using, e.g., the hint=
s on the commandline</div><div>I added parser_ops.</div><div>The simple pub=
lic library API is for converting strings to rte_flow structures,</div><div=
>the parser_ops is for hooking up the testpmd.=C2=A0</div></div></div>

--000000000000bc7cf6064aafccf2--
