Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C2C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 19:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 485BA402D5;
	Tue, 22 Jul 2025 21:03:35 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 86C514003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 21:03:33 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-700fee04941so56236256d6.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753211013;
 x=1753815813; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GkCl42IuGJb041YjPIz910OLtN5TDRccv+8pZjlS2vQ=;
 b=Esh7tBu36U3SIitGsCQbe0nWAyYPfdFUo2336rIhukPCq6ymu9WXPMttn5gd21Df2l
 Sn/Q2QMRfUY8jZ8Naw0mC56jXHXIEesMHe2bXUIRPaRllkFD9+4E260qvYxH716sQXQB
 xAYmkxVt+IDU65Z0SbFoAl0q3dui5MhiwYS0BQflxQGy/608fjR2cs0hti3bpX1ZvRLf
 jwOrbpq3KN5gRHo7QvYaiReGc3otCC6g51chuGZ/jNpvI1f+iCDwB4W1Gj0A0RjQE9C4
 YxkGis99KQ57WETmiv8wRi4q6AUrxiM7A08ZEVl6gftabhsZ3W2176bMCf+6CqEC/gRN
 n7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753211013; x=1753815813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GkCl42IuGJb041YjPIz910OLtN5TDRccv+8pZjlS2vQ=;
 b=uERV1L9wdRzY1CIxk/5YglfdbxYRgXE1tMMKULtxXwxW2rPZy9sz0rPWF3RUgwOoKq
 81plsni3bFQAAiIsL1xBjRYUoFY/ZcKC8rYLYx4xRKxwbXWNUWxGjBedDHwwudbOVdgf
 tK4kXxAzc0ZQj9grmMLzxJUn3DWGETsxGMemUaVh5mQiEKEQL0uynZ/DimC5uMr4LcmR
 +E51ceoTzrTwh8a0WQBCXfMZqUlYoD+5iTKNTmgAMWeKoKdBCAIiOSxQ+yU2Iv7MSVNo
 a0mSNFIUwoU6QxVKF6+LkpuLlUGZPYUTKfK0UfCgmzJDUMJpl/wf5t5tP7OQHIXxAWgM
 ksog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyr+szQQXSYQWrEiXtlhiVowjthk1w1T4cqlA1i783Cyv9mkNcPURDqCDHVsaBG6eM9Bc=@dpdk.org
X-Gm-Message-State: AOJu0Yz7+eM/VPN2vgjUkIMEbu/6DeWLjftTeXRiTqmNBe8kDod0dP2c
 1/nqr8s2KU17zfBHnrmXrjrfPre/ESnY53gYJaOYH18h17Fcvr2x+Pv6mHuXGeiNgHmq/PisFQ4
 oqoyuBcmvf581XKk7D3c4uuMeQmRJTIHv94ENR9S4YQ==
X-Gm-Gg: ASbGnctjXbss553g0zaAwBIaHW44zcc3uCRdGs9YS49gv96GH5cUeykKy3U05ges+bh
 7j84xJp9aUcIAQSmAOYuHTkoiELl9jglKzTNcYob//O3uYKyQ0O9JFK+clKqY8Ziymn2NdeSv8T
 CpAgTpqmrWXNaizznfbF7Bq5d6kU7EMjKW/y3QKn75Byo/KZvBMfcuzPMo0vH/+NmHyN6rKY9fd
 r9c2M+FRnLJZLF8kQ5J3yEQ4YI2eIaNvqFsCY7UGQ==
X-Google-Smtp-Source: AGHT+IH7QCSSSwPijZCK5E9LWSCxqJD7qvD6g2rI2mz9R9k8YIUzsCDMiM3acMbL+yBSRvuQfUC1rnglbk2jLRBfPoc=
X-Received: by 2002:a05:6214:1d0d:b0:700:c7e4:cac6 with SMTP id
 6a1803df08f44-7070058c6d5mr3396106d6.8.1753211012648; Tue, 22 Jul 2025
 12:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
 <20250722103824.7c9db0a0@hermes.local>
 <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
 <20250722112154.78349c82@hermes.local>
In-Reply-To: <20250722112154.78349c82@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 00:03:20 +0500
X-Gm-Features: Ac12FXxwo7rliNnEOujq5Yv2End3pc1YndA6Rh7cBsgAnhmVZs1dOQRHAJqhTrY
Message-ID: <CA++2-x6B7C7GUSQ_H4q_ay2snp3V0XJEQQif9ZFqa=BNzY9qDw@mail.gmail.com>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000a02e4c063a893f0c"
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

--000000000000a02e4c063a893f0c
Content-Type: text/plain; charset="UTF-8"

Right, those structures are accessed within each PMD, and I believe this
shouldn't pose issues even on weakly ordered systems. As long as the checks
are implemented using proper DPDK APIs, we can ensure correctness by
enforcing appropriate memory ordering where needed, without introducing
full locking overhead.

On Tue, Jul 22, 2025, 23:21 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue, 22 Jul 2025 22:53:08 +0500
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > Right, but performance and reliability are both important. While DPDK
> > rightly prioritizes performance, some level of reliability should still
> be
> > ensured, especially to catch known issues that could lead to instability.
> >
> > On Tue, Jul 22, 2025, 22:38 Stephen Hemminger <
> stephen@networkplumber.org>
> > wrote:
> >
> > > On Tue, 22 Jul 2025 22:04:32 +0500
> > > Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
> > >
> > > > Agree, but I think it's also a good practice to guard against known
> cases
> > > > that are prone to crashes.
> > >
> > >
> > > Right but DPDK chooses performance over API safety.
> > > For example rx/tx burst doesn't check args.
> > >
> > > The point is that as a library, if application is doing something wrong
> > > returning error doesn't always help.
> > >
>
> The problem is that all those values dev->data and private are shared
> between processes without any locking. If the API's are going to MP safe
> then they would require locking. The DPDK has made an explicit decision
> to not use locking in ethdev control or data path.
>
> You can get away with checking for dev->data being NULL on x86 where
> there is data consistency. But on weakly ordered platforms that is not
> going
> to work.
>

--000000000000a02e4c063a893f0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Right, those structures are accessed within each PMD=
, and I believe this shouldn&#39;t pose issues even on weakly ordered syste=
ms. As long as the checks are implemented using proper DPDK APIs, we can en=
sure correctness by enforcing appropriate memory ordering where needed, wit=
hout introducing full locking overhead.</div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Jul 22, 2025, 23:21 Stephen Hemminger &lt;<a href=3D"mailto:stephen@network=
plumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">On Tue, 22 Jul 2025 22:53:08 +0500<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; Right, but performance and reliability are both important. While DPDK<=
br>
&gt; rightly prioritizes performance, some level of reliability should stil=
l be<br>
&gt; ensured, especially to catch known issues that could lead to instabili=
ty.<br>
&gt; <br>
&gt; On Tue, Jul 22, 2025, 22:38 Stephen Hemminger &lt;<a href=3D"mailto:st=
ephen@networkplumber.org" target=3D"_blank" rel=3D"noreferrer">stephen@netw=
orkplumber.org</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, 22 Jul 2025 22:04:32 +0500<br>
&gt; &gt; Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk=
" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&g=
t; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; Agree, but I think it&#39;s also a good practice to guard ag=
ainst known cases<br>
&gt; &gt; &gt; that are prone to crashes.=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Right but DPDK chooses performance over API safety.<br>
&gt; &gt; For example rx/tx burst doesn&#39;t check args.<br>
&gt; &gt;<br>
&gt; &gt; The point is that as a library, if application is doing something=
 wrong<br>
&gt; &gt; returning error doesn&#39;t always help.<br>
&gt; &gt;=C2=A0 <br>
<br>
The problem is that all those values dev-&gt;data and private are shared<br=
>
between processes without any locking. If the API&#39;s are going to MP saf=
e<br>
then they would require locking. The DPDK has made an explicit decision<br>
to not use locking in ethdev control or data path.<br>
<br>
You can get away with checking for dev-&gt;data being NULL on x86 where<br>
there is data consistency. But on weakly ordered platforms that is not goin=
g<br>
to work.<br>
</blockquote></div>

--000000000000a02e4c063a893f0c--
