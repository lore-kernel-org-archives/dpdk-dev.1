Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E2CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 17:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68FE74161A;
	Thu, 16 Oct 2025 19:50:27 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id C01E34026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 19:50:25 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-290a3a4c7ecso10999655ad.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760637025; x=1761241825; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DsdLfJARwFYHQEwg3hi5ehjZOKwtmIBnKQKwEZIHXSE=;
 b=KuIkHAKPJ6Qg3BfErS8hFJcuurO1bCdQGAZ2QttN4Iwur12SDz7cZpW6rIBva2booj
 bRB6uSsB1+D219psXT3iHVDKRTHmJcEMPqgcdicGx6rjFJc5dTkbiecmgKhPT8lS6TzM
 f2ZE15PN01CpneactBWj5k/dn/od3HBaA3SbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760637025; x=1761241825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsdLfJARwFYHQEwg3hi5ehjZOKwtmIBnKQKwEZIHXSE=;
 b=FdDjo8zdDY8mNOKh/9jB4Ckp34lNnE6/KiXJ/bpFV56Np71kovDpdQI0A80H113h9o
 LG6V7EKWl1lnl6uNHBj6n1CvieBMSg0BhWkylKyoWCJB7TSqfBxGg0Jqaq164WbVBDYR
 5jxm/hlTtzV5qJbbmniBNKBrH4ZMqjvSiHDHqH43hGHMX4fIe+SMO23pdhZLRTAoE8Jb
 zxPFS0fJB3EMSCfDkd8YHrVgXqRq9PNE8tmwhRgYUQZaGTwk3mzYNu4vdTXeYgfCXru/
 yaREbv0r+piHdbFjAvQ2w6EXqsGDeBfRbVeuhA+TRZHKkNqJuGuQOkRU48U0IkOeBsF+
 1pQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq/4HIMO1EIWN1l5Ceh61Q0wCUNMtthKMCSyDT2AWCvtL47MY3CWMxe4ehaHAdyj2CmE0=@dpdk.org
X-Gm-Message-State: AOJu0Yxx7acxxzoEKr0Y5pKnfc/apKXoZgCNOArBBsqXcbJ/Cyf0f73k
 22rV91Fynuolvx3zTjOdvzGorJJS0hmrt/XHdsgFdlHVqD/2tDKOfDCIiL93Co0AIN0mX820S1x
 0qM791Xyee22GAdCYWolNLxAxM8mImLUNzkweoHUTaqILShBpsIi10kc=
X-Gm-Gg: ASbGnctpckljTPW2q6i/iducIGQJMe/kLG9XXetH43oMG+/S7XNb2jcwd3M1ccTlD8E
 WFjjEbxUy2N96nquDtURZalLqdlkjuiFHdUyQvFGKDxO0ctVwIFuOJ5RwmZMRTWRuv+3TGDAYnk
 hG5wT7lR77Xh88MhL5Z36J573LIi2ob+GFoX9zMY0o3nA2TlSR3EoTfLjCQL08kBqcvIj8Qn6iZ
 IXhr5ku2lrhURo3VpCky+Qnf7kcOjp7aWQbd//Lm/GF9W5ByUmEw3gX3hmKfdbSnjmXeSHpC1od
 +AUvcrcZnvN482pd+g==
X-Google-Smtp-Source: AGHT+IGU/jaQdlc9uqnSFs10X0hBsRZqr6uWJXgbPdK1QN0tv+61QTgUhhBm9KNhsT+8rst/QJBTm9IR/IhHsDhVjKc=
X-Received: by 2002:a17:902:ec87:b0:264:70e9:dcb1 with SMTP id
 d9443c01a7336-290cba481bemr10086615ad.56.1760637024663; Thu, 16 Oct 2025
 10:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251016090948.836029-1-zhoumin@loongson.cn>
 <CAJvnSUCqYoRQg29ovs+r7CQH=wnJQMMLusi_oJthvXA6oa4aEQ@mail.gmail.com>
 <fec69d04-4ba6-2378-61c9-15be790bb8e5@loongson.cn>
 <c7f0e0cc-bd06-4474-2e7e-410c302b222e@loongson.cn>
In-Reply-To: <c7f0e0cc-bd06-4474-2e7e-410c302b222e@loongson.cn>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 16 Oct 2025 13:49:38 -0400
X-Gm-Features: AS18NWDJTVy2Ib_Pt4iwYS1EYzvIdbgGl-H9oMtN85D4U-yp-0Zq2IGeJIEU9sI
Message-ID: <CAJvnSUAVdq-um2bD3jaQeH-A1WY=NNFhENSQoCp-Np=n-WTWRg@mail.gmail.com>
Subject: Re: [PATCH v1] maintainers: update for LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: zhoumin <zhoumin@loongson.cn>, thomas@monjalon.net, dev@dpdk.org,
 ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006f0b9306414a40e5"
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

--0000000000006f0b9306414a40e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Min Zhou for your contributions to DPDK CI Testing these past
years.

Welcome Bibo!

On Thu, Oct 16, 2025 at 8:43=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:

>
>
> On 2025/10/16 =E4=B8=8B=E5=8D=888:30, zhoumin wrote:
> > Hi Patrick Robb,
> >
> > Yes, Bibo will also be responsible for maintaining the LoongArch CI
> > testing going forward.
> I will be responsible for maintaining the LoongArch CI also,
> and best wishes and thanks for contribution for Min Zhou.
>
> Regards
> Bibo Mao
> >
> > On Thu, Oct 16, 2025 at 7:32 PM, Patrick Robb wrote:
> >> Hi Min Zhou,
> >>
> >> Will Bibi be responsible for maintaining the Loongarch CI testing
> >> going forward, or are you retaining that responsibility? Thanks.
> >>
> >> On Thu, Oct 16, 2025 at 5:46=E2=80=AFAM Min Zhou <zhoumin@loongson.cn
> >> <mailto:zhoumin@loongson.cn>> wrote:
> >>
> >>     Update maintainers for LoongArch architecture.
> >>
> >>     Signed-off-by: Min Zhou <zhoumin@loongson.cn
> >>     <mailto:zhoumin@loongson.cn>>
> >>     Signed-off-by: Bibo Mao <maobibo@loongson.cn
> >>     <mailto:maobibo@loongson.cn>>
> >>     ---
> >>      MAINTAINERS | 2 +-
> >>      1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>     diff --git a/MAINTAINERS b/MAINTAINERS
> >>     index 1a2729be66..7abe482e7d 100644
> >>     --- a/MAINTAINERS
> >>     +++ b/MAINTAINERS
> >>     @@ -320,7 +320,7 @@ F: examples/*/*_neon.*
> >>      F: examples/common/neon/
> >>
> >>      LoongArch
> >>     -M: Min Zhou <zhoumin@loongson.cn <mailto:zhoumin@loongson.cn>>
> >>     +M: Bibo Mao <maobibo@loongson.cn <mailto:maobibo@loongson.cn>>
> >>      F: config/loongarch/
> >>      F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst
> >>      F: lib/eal/loongarch/
> >>     --
> >>     2.27.0
> >>
>
>

--0000000000006f0b9306414a40e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Min Zhou for your contributions to DPDK CI Testi=
ng these past years.<div><br></div><div>Welcome Bibo!</div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Thu, Oct 16, 2025 at 8:43=E2=80=AFAM Bibo Mao &lt;<a href=3D"mailt=
o:maobibo@loongson.cn">maobibo@loongson.cn</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2025/10/16 =E4=B8=8B=E5=8D=888:30, zhoumin wrote:<br>
&gt; Hi Patrick Robb,<br>
&gt; <br>
&gt; Yes, Bibo will also be responsible for maintaining the LoongArch CI <b=
r>
&gt; testing going forward.<br>
I will be responsible for maintaining the LoongArch CI also,<br>
and best wishes and thanks for contribution for Min Zhou.<br>
<br>
Regards<br>
Bibo Mao<br>
&gt; <br>
&gt; On Thu, Oct 16, 2025 at 7:32 PM, Patrick Robb wrote:<br>
&gt;&gt; Hi Min Zhou,<br>
&gt;&gt;<br>
&gt;&gt; Will Bibi be responsible for maintaining the Loongarch CI testing =
<br>
&gt;&gt; going forward, or are you retaining that responsibility? Thanks.<b=
r>
&gt;&gt;<br>
&gt;&gt; On Thu, Oct 16, 2025 at 5:46=E2=80=AFAM Min Zhou &lt;<a href=3D"ma=
ilto:zhoumin@loongson.cn" target=3D"_blank">zhoumin@loongson.cn</a> <br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:zhoumin@loongson.cn" target=3D"_blank=
">zhoumin@loongson.cn</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Update maintainers for LoongArch architecture.<=
br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Min Zhou &lt;<a href=3D"mailto:z=
houmin@loongson.cn" target=3D"_blank">zhoumin@loongson.cn</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:zhoumin@loongson.c=
n" target=3D"_blank">zhoumin@loongson.cn</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Bibo Mao &lt;<a href=3D"mailto:m=
aobibo@loongson.cn" target=3D"_blank">maobibo@loongson.cn</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:maobibo@loongson.c=
n" target=3D"_blank">maobibo@loongson.cn</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0MAINTAINERS | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletio=
n(-)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index 1a2729be66..7abe482e7d 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/MAINTAINERS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -320,7 +320,7 @@ F: examples/*/*_neon.*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0F: examples/common/neon/<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0LoongArch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0-M: Min Zhou &lt;<a href=3D"mailto:zhoumin@loon=
gson.cn" target=3D"_blank">zhoumin@loongson.cn</a> &lt;mailto:<a href=3D"ma=
ilto:zhoumin@loongson.cn" target=3D"_blank">zhoumin@loongson.cn</a>&gt;&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+M: Bibo Mao &lt;<a href=3D"mailto:maobibo@loon=
gson.cn" target=3D"_blank">maobibo@loongson.cn</a> &lt;mailto:<a href=3D"ma=
ilto:maobibo@loongson.cn" target=3D"_blank">maobibo@loongson.cn</a>&gt;&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0F: config/loongarch/<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0F: doc/guides/linux_gsg/cross_build_dpdk_=
for_loongarch.rst<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0F: lib/eal/loongarch/<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A02.27.0<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--0000000000006f0b9306414a40e5--
