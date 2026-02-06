Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E397FEE20A6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 15:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F39DD40276;
	Fri,  6 Feb 2026 16:40:51 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id ADA4840156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 16:40:50 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6582e8831aeso3879007a12.1
 for <dev@dpdk.org>; Fri, 06 Feb 2026 07:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770392450; cv=none;
 d=google.com; s=arc-20240605;
 b=Udu2O6AamBCH0wCBnNiP9gyjpV1yXASIYd1JxVpuEUIKoT4d4FgLnOhMbZyBLk6PHO
 9syasrSvCeRzj3qiSgM5IYhBvDGmeQ9cDOPfElCqjMGhhp2q2+bVaRGAYrn/3IhqIQLJ
 ZV5FNUoh1kocU/zJUqKGSEP20pZEwgN17o+E97YBaUO8rtJxUKMWpp822J2XqAS4lNSv
 F5A1KLmo73neIGlLpM8QYgncle6RorPtoDOF57Nse12xkgKqO2+WRmOZ9cmpzSKjqsl8
 Fc59iwg+MjUg2Z0vEgu4wduAXifIo55py+M5sleq6aFZhYL9ewMzYjuGSN1WvzncngRo
 Zvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VV9UxIhHTrlWQjsFx831XrI+UKDzQZR1vft3i2iYp0M=;
 fh=3CQCuLaLNcRtM5JRGk/BdtAqcbCjnKFO9eZmMRf/oEs=;
 b=eckR223D3hzuiIIPZ8WC1VnzTVnbdCpaeYFFJPiHb95mMQkFOoz1BDAYHZ4XTEyuUc
 rRv9hO6/NCMxLruLHA2BWBq0uHbytY+NHcKwijupQEKXVqEzgdXxP6XPPvXq0v4JXmgG
 LqYT2U81Truvt7EHWOEbTvO6WBydJ8rihJZKca0tDBWL66jdw0ZpdiuPI04z8alLMYG/
 iC3s76elPd/u6TPnoWdrvtYjkICbIXcY/JJUdA241+2LasGPxvXbXMRuyzKzct6KzCP9
 yTy6o231r7ZJACsXOo+TN8iNRGJunuT7nUoiR157vVHop8jMIMdHWptdY21n9ABfx3Q2
 4gEg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770392450; x=1770997250; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VV9UxIhHTrlWQjsFx831XrI+UKDzQZR1vft3i2iYp0M=;
 b=DDhrCrUFkr8LxylX5h9UpH9CBfuzbOYVs5Gdvyvdq8xirWYSNJdCa5x/uU6Q/gVDxi
 4YqB89l32QKuiTah9lAlk00TwsB4o6GBOnh1SEhjsRdlwD3b9WlOGYai76MGg1QxI4fS
 5g76q6VSmBmiL7YSkZcLpjhOCLZHqbgMXVHGjW/Muw7fV/mB3ehmKbvvXy6u6Sqs19wR
 M7z4dJMBvxMc/I/tI2qbF4RjLT40OAypG2AZ/kYjrxpLOU+aKhJdcYsUg5spoXrpyuIW
 9VexmLaDQEvkuJeeaqQYKUlNFcMyrkNc+qq4EqLqQpoBUaQHzNUwPHi6F4GAzrNFbul7
 m2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770392450; x=1770997250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VV9UxIhHTrlWQjsFx831XrI+UKDzQZR1vft3i2iYp0M=;
 b=kkBAxGURZHJIe7fglsWg0i1HMqmv5rlojdfPjpelLP0vVYNAOfL8VSACiAopa48S3K
 2NZxxTBvSI7oEFqeCRwMdS+QwDWX39nQObVwl5t5Hm0Hm7a6JMjniUR1MtqKYv9/JEz0
 FyhDQy2sjdMGOwB6kcot2fBCPY4WEaW8/donjkslUftsn/PjKToLvXCYaLosTtzkDEIY
 Heydv3x9OHpFJpqSIoMGdFIqBZO4MOTaQScCKFrszpkQe1OJb5xI3sbx2RQW+ytLtcKH
 mri1f8tbAIA04Rwk2+QLQeCvdKhZjU8arrj6wgFDT+2OJQZukh2LrEz6snRBs0cQow5O
 lDog==
X-Gm-Message-State: AOJu0Yzp94AoglXbzCWWWX+vjczLe/KHDQp2pirbIvTAAbesi8AIcUt5
 SQh7Q/BiDE5KuheTxkcci0oOzZZ5M4MahmYMZyU4J50Wn3X2U2KHDSjoQhZDQjIczkeywiAncU3
 takjiIWzy2AreuV0LJKWs1x2vPEHYyqqaCwmMfw5UZg==
X-Gm-Gg: AZuq6aLL/HY8auMuINscbEoVUULIfdspxPy6qKCcUxpV32pgiMI3SGFIj/BctoJdUnG
 RZm6qpHY3K2NuynJzXTBdKLyMFS7kC8iJoCIKdVU+PLHdN5YQs2uFmvBVwwm6RzdTeYVDSuDaKc
 1iS/uCnsayqhhOzfS5kluzLKuwpdSbu94JT2oU3PYF9y4AiRFk3xGeFx52lwYBD2VjejJOH+aca
 WbA33MVEDDuHsf8NUqpyaRoo1FOkkIJYrdpG37a4QidcikV0vqTAvNaP3BZx0cDM/D6MoA=
X-Received: by 2002:a05:6402:2103:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-659840bfb76mr1782956a12.0.1770392450067; Fri, 06 Feb 2026
 07:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local> <2762564.TLkxdtWsSY@thomas>
In-Reply-To: <2762564.TLkxdtWsSY@thomas>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Fri, 6 Feb 2026 16:40:39 +0100
X-Gm-Features: AZwV_QiRlrLIHTlpq7DVtOGLZhfj6TDFsLkIUML18_vSAqLiIGD92GW6j8chfBA
Message-ID: <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Ori Kam <orika@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000197b6e064a299d41"
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

--000000000000197b6e064a299d41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 6. 2. 2026 v 15:02 odes=C3=ADlatel Thomas Monjalon <thomas@monjalon=
.net>
napsal:

> 04/02/2026 15:53, Stephen Hemminger:
> > On Tue, 3 Feb 2026 09:34:26 +0100
> > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
> >
> > > >
> > > > The kernel version of checkpatch complains here. The DPDK shell
> script
> > > > seems to be set to ignore this but.
> > > >
> > > > WARNING: break is not useful after a return
> > > > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > > > +               return cmd_flow_parsed(out);
> > > > +               break;
> > > >
> > > > Should I create a new patch set or just let it be at this moment?
> > > Lukas
> >
> >
> > I am ok with it as is.
>
> Better to update.
>
> There are other warnings:
>
> WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strncpy
> - see: https://github.com/KSPP/linux/issues/90
> #13052 <https://github.com/KSPP/linux/issues/90#13052>: FILE:
> lib/flow_parser/rte_flow_parser.c:12825:
> +       strncpy(buf, str, len);
>
> and a lot of WARNING:LONG_LINE
>
> I can have a look after the decision.

>
> And on a more general note, I would have expected to ask the opinion
> of rte_flow maintainers, but they are not Cc'ed in these patches.
>
I communicated primarily with Stephen, and will CC Ori too. Anyone else?


> I'm a bit skeptical about adding this outside of ethdev library
> which defines the flow API.
>

CCing Ori to make a decision. I don't mind putting it directly into ethdev
as well, I just thought the parser could be its own separate lib as it is
just consuming strings and producing rte_flow structures. I can see the
heavy ties to the flow library, though. Thomas, Stephen, what are your
opinions?

--000000000000197b6e064a299d41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">p=C3=A1 6. 2. 2=
026 v=C2=A015:02 odes=C3=ADlatel Thomas Monjalon &lt;<a href=3D"mailto:thom=
as@monjalon.net">thomas@monjalon.net</a>&gt; napsal:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">04/02/2026 15:53, Stephen Hemminger:<b=
r>
&gt; On Tue, 3 Feb 2026 09:34:26 +0100<br>
&gt; Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 &lt;<a href=3D"mailto:sismis@dyn=
a-nic.com" target=3D"_blank">sismis@dyna-nic.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The kernel version of checkpatch complains here. The DPDK sh=
ell script<br>
&gt; &gt; &gt; seems to be set to ignore this but.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; WARNING: break is not useful after a return<br>
&gt; &gt; &gt; #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn cmd_flow_parsed(out);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brea=
k;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Should I create a new patch set or just let it be at this mo=
ment?=C2=A0 <br>
&gt; &gt; Lukas<br>
&gt; <br>
&gt; <br>
&gt; I am ok with it as is.<br>
<br>
Better to update.<br>
<br>
There are other warnings:<br>
<br>
WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strncpy -=
 see: <a href=3D"https://github.com/KSPP/linux/issues/90#13052" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/KSPP/linux/issues/90<br>
#13052</a>: FILE: lib/flow_parser/rte_flow_parser.c:12825:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(buf, str, len);<br>
<br>
and a lot of WARNING:LONG_LINE<br>
<br></blockquote><div>I can have a look after the decision.</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
And on a more general note, I would have expected to ask the opinion<br>
of rte_flow maintainers, but they are not Cc&#39;ed in these patches.<br></=
blockquote><div>I communicated primarily with Stephen, and will CC Ori too.=
 Anyone else?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
I&#39;m a bit skeptical about adding this outside of ethdev library<br>
which defines the flow API.<br></blockquote><div><br></div><div>CCing Ori t=
o make a decision. I don&#39;t mind putting it directly into ethdev as well=
, I just thought the parser could be its own separate lib as it is just con=
suming strings and producing rte_flow structures. I can see the heavy ties =
to the=C2=A0flow library, though. Thomas, Stephen, what are your opinions?<=
/div></div></div>

--000000000000197b6e064a299d41--
