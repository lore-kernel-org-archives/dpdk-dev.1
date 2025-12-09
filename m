Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128CD5C0C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 08:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30DA6402AC;
	Tue, 16 Dec 2025 09:56:04 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id CC6AD40689
 for <dev@dpdk.org>; Tue,  9 Dec 2025 17:40:47 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-78c4aa7af99so27466697b3.0
 for <dev@dpdk.org>; Tue, 09 Dec 2025 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765298447; x=1765903247; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WmgIz9e/tMxQlI7bn7f9SpWFjQyMSSU2tt8f0rwy6o8=;
 b=OhfPNs+bsfRg3ehbwDHqWZqL+Wmj2bDfAROgQT4lziatP9XhuQ8AFIDv3YnjAn3/Aq
 gvzHGHBljl5Q/wzTF7vjg8mzk+yQnuyTZ43jlE6CxwoK2Ek2TUnbLtfUt/gJBE8rcq7q
 gmV9xx6wHn+oF17BI3Hyb1LHa7TFqPZJIYLpWxHBUSjus5yBz1JcyxTkud3mn9V+3/qW
 H1NYtE6fy6IbptHO0qiBVv1VG57iPFAEwwvGOTfSk3vBGv6UcUH+hPSdQveZ5XN7Cmed
 UWif9XLJ+tx7q+suwaj6FohqE2D9MUnr9Y/f1VoheIH/dQkxGOUBVoQkhZclBRdsAoff
 LqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765298447; x=1765903247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmgIz9e/tMxQlI7bn7f9SpWFjQyMSSU2tt8f0rwy6o8=;
 b=WITZsmGyaE5xcP81GEdQplCnlOT4QwSwhlxBtr0Ieusm/dhCCUXh1W54rFAjFuV/Xi
 GZgYSe7PD4PEb5a2gir2MQGRTF+tGjaAWvu5/+towARF9lWbuW9nyvbwBkJ4zz0xd7Ww
 cvAm08cDckfiC/n80eYlPxVQ01T6A/HKW06zZraYXSrP6svoZT7U6SC0xJrTEyBtKgNu
 h5BQJdpp7BbOq+oVAtH7Vc4nWXNd1vGuYThVTs7fzzlhGcoISTaQxxPMNJ1PAfgu+OZv
 EFE9egMxtjfOFDeoqr7IaAGUPGnuGJhXMIBVPsjQfxyFEE1TsoCNk8zk0iRY8zACVGSK
 JyqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscTy3lIYJlfxkuEuFXGdOvKAVpDjSly7MihXXCVxObKTyCzODEj9J0oIquQIbN5pqq1Q=@dpdk.org
X-Gm-Message-State: AOJu0YyP+nX+63uVziOXsUiSv5f5dMQZIHrDEQS/MzIWSk4CSQj1AVdF
 VnN+44ZKVHw2qybq/+iLruBI6YMTnnruGRBYS5WLbmn8KuPnGGwfs5Ri4aLpS74C94J6HZ/EIBw
 W/bz1Rni14GcBvQ1oCYBsZUCINbPJJQQ=
X-Gm-Gg: AY/fxX7ZurqRE92eL2ct6FY2n9KN78HOK1t4IHxedTcskVDWueg5IDp4sK4a+4HNiet
 nugFOx0h+Lm1iT1uyKwHVsUwTpTML8OR3/nwX/qZo/p8YSDKpkbLg/ucVvDrNNPWWdoE5HxM3oI
 oXH0llid2SIoO7HpdGCw2oBAAIV22P1Xfi0+j17rBnNZBvX4nfl2rp0zszd45kBmNdzO7m6+LR5
 PHyXI8K7V2H3B3vU4k8fLuoBrRKG5HamhNokStk9KXS7mQcABYUHPY/rAJhPN27AJPKdqDQoelt
 I/2Iuc/MWLxVAyt2S6vO9EdP0H0tJA==
X-Google-Smtp-Source: AGHT+IFGIVDlmL7RBfiLRhlpG3R4Xm7FWmsu29xw5wRh00wuz11pRm9bAkjVk8qbFqXijFPr+7TGFZSju2G9JoXl+10=
X-Received: by 2002:a05:690e:245a:b0:63f:a713:c6aa with SMTP id
 956f58d0204a3-6444e750298mr9359200d50.4.1765298446929; Tue, 09 Dec 2025
 08:40:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMf-ZCH+EuZxuUyvrJCJacC1JO15FccXNkg2+nuC4+nMGpJDSg@mail.gmail.com>
 <aTfkCg8pU0OKYTDS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTfkCg8pU0OKYTDS@bricha3-mobl1.ger.corp.intel.com>
From: Matt Goralka <mgoralka4@gmail.com>
Date: Tue, 9 Dec 2025 10:40:35 -0600
X-Gm-Features: AQt7F2qBC-1zC6HUlzUniKnR_QSMF8_9npQoJMCJ-QluNQ8MF0WGwdHqV2xdkvE
Message-ID: <CAMf-ZCE3TJUV4XQp_moOTrhggunzcL_sDf6iwbkk_cLiCNKNHQ@mail.gmail.com>
Subject: Re: contributing to dpdk
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: users@dpdk.org, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000da14510645879216"
X-Mailman-Approved-At: Tue, 16 Dec 2025 09:56:02 +0100
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

--000000000000da14510645879216
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Bruce! I have a few things to figure out but I will lyk!

Best,
Matt

On Tue, Dec 9, 2025, 2:55=E2=80=AFAM Bruce Richardson <bruce.richardson@int=
el.com>
wrote:

> On Sun, Dec 07, 2025 at 02:11:15AM -0600, Matt Goralka wrote:
> >    Hi,
> >    My name is Matt Goralka.  I'm interested in contributing to dpdk and
> am
> >    wondering if you are taking people and have a few questions if someo=
ne
> >    can help get me started.  I have a computer hardware engineering
> degree
> >    and experience in web dev so not totally starting from scratch.
> >    -How do you guys get newbies started?  Can you kind of get me going?
> >    -I have a gaming laptop with a Ryzen 7 chip and NVIDIA GEFORCE RTX
> 5060
> >    chip.  Would it be enough to virtualize linux?
> >    Thanks guys, looking forward to hopefully working with you!
> >    -Matt
>
> Hi Matt,
>
> new contributions and contributors always welcome! To get started, I'd
> suggest getting linux up and running on whatever hardware you have and th=
en
> build DPDK as described in our linux getting-started-guide doc[1]. Beyond
> that, for questions I'd recommend joining the DPDK slack channel as linke=
d
> on our contribute page [2].
>
> Regards,
> /Bruce
>
> [1] http://doc.dpdk.org/guides/linux_gsg/index.html
> [2] https://core.dpdk.org/contribute/
>

--000000000000da14510645879216
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Bruce! I have a few things to figure out but I wil=
l lyk!<div dir=3D"auto"><br></div><div dir=3D"auto">Best,</div><div dir=3D"=
auto">Matt</div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 9, 2025, 2:55=E2=80=AFAM =
Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com">bruce.ri=
chardson@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">O=
n Sun, Dec 07, 2025 at 02:11:15AM -0600, Matt Goralka wrote:<br>
&gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 My name is Matt Goralka.=C2=A0 I&#39;m interested in cont=
ributing to dpdk and am<br>
&gt;=C2=A0 =C2=A0 wondering if you are taking people and have a few questio=
ns if someone<br>
&gt;=C2=A0 =C2=A0 can help get me started.=C2=A0 I have a computer hardware=
 engineering degree<br>
&gt;=C2=A0 =C2=A0 and experience in web dev so not totally starting from sc=
ratch.<br>
&gt;=C2=A0 =C2=A0 -How do you guys get newbies started?=C2=A0 Can you kind =
of get me going?<br>
&gt;=C2=A0 =C2=A0 -I have a gaming laptop with a Ryzen 7 chip and NVIDIA GE=
FORCE RTX 5060<br>
&gt;=C2=A0 =C2=A0 chip.=C2=A0 Would it be enough to virtualize linux?<br>
&gt;=C2=A0 =C2=A0 Thanks guys, looking forward to hopefully working with yo=
u!<br>
&gt;=C2=A0 =C2=A0 -Matt<br>
<br>
Hi Matt,<br>
<br>
new contributions and contributors always welcome! To get started, I&#39;d<=
br>
suggest getting linux up and running on whatever hardware you have and then=
<br>
build DPDK as described in our linux getting-started-guide doc[1]. Beyond<b=
r>
that, for questions I&#39;d recommend joining the DPDK slack channel as lin=
ked<br>
on our contribute page [2].<br>
<br>
Regards,<br>
/Bruce<br>
<br>
[1] <a href=3D"http://doc.dpdk.org/guides/linux_gsg/index.html" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">http://doc.dpdk.org/guides/linux_gsg/i=
ndex.html</a><br>
[2] <a href=3D"https://core.dpdk.org/contribute/" rel=3D"noreferrer norefer=
rer" target=3D"_blank">https://core.dpdk.org/contribute/</a><br>
</blockquote></div>

--000000000000da14510645879216--
