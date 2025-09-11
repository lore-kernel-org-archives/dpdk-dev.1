Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3702CAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 19:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B40A9402C4;
	Thu, 11 Sep 2025 21:00:58 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id CFE5340285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 21:00:57 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4b38d47fa9dso9787321cf.0
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757617257;
 x=1758222057; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dF8yUUbFqHyTvsTI1dJZjz/DoSUSW+YBn1T/C+ev4Zs=;
 b=eoixfWIHBbsYsTB52W3Z+CrZYlnuJ2UtAgTOHOOM8jlyvkxIGQa1MGAtyQQwbDCxhU
 IASywFn3xfFwo3BZ06tMX89qTh6P0qRvAx89s2iBAqNa6euedMIWNEG6Zuh46A+QNY1g
 Tby895NJ4qluiHFlOTYPJU6NK7ipFU+x/H5YMNh4OJY2InagaoK7HlZKJNQKVR/w27MS
 PBCyzAfxDyqCqAwRpmrFOBD9RXHHgCN95SI3Eg7EYWynZXmAOt7Qu2x2N0TBRQcDZEUx
 6fQFcjJSf3ykz1zfFw1b9o0dDeh+hYUnd98aH8SzpwiX4KZmkTlrP9hiA/FPa4PDFOsi
 07EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757617257; x=1758222057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dF8yUUbFqHyTvsTI1dJZjz/DoSUSW+YBn1T/C+ev4Zs=;
 b=XiMAQ2hEVU1DCyupZrgu7phoESAIhqEIVKJuXTOR6E4+UAFd2syhg7sKL3/RuDp8+m
 0hi2UYAeEMId5kkEqZOz4fvS179gkmyJVGPupyHspNaEGaX1Qqu5ZQjbJUJxMiIKWnbo
 Ll1wi38X8Kr2Tn+BP0T4H2dmJas2u8opupLNf3JBRW1YNUNT1DC5EIb7ergyQp/UGp7s
 6phcnef24HRnGd6WMFODfwm8e2dXDGC0MAOLpePPZKsGP66eoCHk08HAGcYkjpHryCYW
 kmCyd8useSu3KjMTSepY6/jauQkAsc+IS1NtkBKqTKvs8pkdYo75EvlvoIERyRdv4biE
 yoIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvhFwithXutWkHQVDZScM38B2PFL1dwyaRAbp/LlngvcMyXbTW3WEVllkdQ+H8NIOeLYw=@dpdk.org
X-Gm-Message-State: AOJu0YyefgnUUZd8zhqAUGxByYViKugyacN4Mk3EcZ91v1IOvgNrQQag
 Di6m5XlleCsTfTo5ej/fiJOdXv93PizPnBZeo+vK1KMbKorEU7DXLQI0njfa9sDYB7ezuNCoJ8U
 uHY6EIVcoDYrHy/S4Rj0OjhDINvjqTgV0H84ZEDR51g==
X-Gm-Gg: ASbGncsKBkFmjYyXCG6wyFMkoqKCycvbMaFoREN3c8uhWaMhFnRBk65bUzISygPVmfX
 9d1/iuFdnv0KoleTNyGaZSqxGIaC2+tgKNzwjdZrjeHF7eVhzkhFZQGsDvcvCePgIksaJF+b1wY
 gn8IAJ7mZ8D2bqBIPINLzf4U8OUaMKlFEezlK3M+xAQqCljVv0SYEuoxqEHPcAF/SfhptPyBbK/
 2DD/qwTlBO+MKpRWDJ/MrxMkH2WVhp330JYMWh8fkjoVAq5+yQjwCdMsAKOuyBAhOL8zrV5wXuG
 NzafErueEdeDdHSvlKNGOGT3nRYJPPJAvrroOZXl94zTVyiryn2qkhaAcKq+2bRVwxM=
X-Google-Smtp-Source: AGHT+IFK3fIkKJ/dxKD4b0ShVfBmBZZ+75njwHzW++yIl3+LYKu3h6TNathVrOtBMd4s5bumBIKJpESXN1JcDlaCkVk=
X-Received: by 2002:a05:6214:b69:b0:725:29f0:c7c8 with SMTP id
 6a1803df08f44-767c339a299mr6118306d6.47.1757617256762; Thu, 11 Sep 2025
 12:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911105305.5eb9c67a@hermes.local>
In-Reply-To: <20250911105305.5eb9c67a@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 12 Sep 2025 00:00:44 +0500
X-Gm-Features: AS18NWBnPosrL0A9TdsbMpSfIJ_bjxjOXkJs338sHmQ9RGiWR2KtxjknpJ5w3KA
Message-ID: <CA++2-x5ZYWrsR_Lm1=+WtoZL+uH03BateiDWDFvm4vvm_Y42Uw@mail.gmail.com>
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000003da4f7063e8b28fa"
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

--0000000000003da4f7063e8b28fa
Content-Type: text/plain; charset="UTF-8"

Hi,


On Thu, Sep 11, 2025, 22:53 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Thu, 11 Sep 2025 03:25:01 -0700
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > When the secondary process testpmd application running any fwd_engine
> > and after that primary has exited will cause a crash.
> >
> > This patch forces secondary process forwarding lcores
> > in fwd_engine to stop before the primary process exits.
> >
> > Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>
> NAK
> As you said, you did not test it on Windows, yet you added #ifdef
> for Windows support. Since Windows doesn't support secondary
> processes (yet) how could you.
>
> Adding Windows here has to wait until it can be tested.
>
Can you please double check the code?
I have used the following macro everywhere which means the code is only
targeted to Linux.
#ifndef RTE_EXEC_ENV_WINDOWS

I will add a newer version to if you agree to add additional comments to
further clarify that the solution is only targeted for Linux.

Best regards,
Khadem

>

--0000000000003da4f7063e8b28fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div>Hi,</div><br><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 11, 20=
25, 22:53 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.or=
g">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On Thu, 11 Sep 2025 03:25:01 -0700<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; When the secondary process testpmd application running any fwd_engine<=
br>
&gt; and after that primary has exited will cause a crash.<br>
&gt; <br>
&gt; This patch forces secondary process forwarding lcores<br>
&gt; in fwd_engine to stop before the primary process exits.<br>
&gt; <br>
&gt; Fixes: a550baf24af90f (&quot;app/testpmd: support multi-process&quot;)=
<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt; <br>
&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpesha=
war.edu.pk" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.ed=
u.pk</a>&gt;<br>
<br>
NAK<br>
As you said, you did not test it on Windows, yet you added #ifdef<br>
for Windows support. Since Windows doesn&#39;t support secondary<br>
processes (yet) how could you.<br>
<br>
Adding Windows here has to wait until it can be tested.<br></blockquote></d=
iv></div><div dir=3D"auto">Can you please double check the code?=C2=A0</div=
><div dir=3D"auto">I have used the following macro everywhere which means t=
he code is only targeted to Linux.=C2=A0</div><div dir=3D"auto">#ifndef RTE=
_EXEC_ENV_WINDOWS</div><div dir=3D"auto"><br></div><div dir=3D"auto">I will=
 add a newer version to if you agree to add additional comments to further =
clarify that the solution is only targeted for Linux.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Best regards,=C2=A0</div><div dir=3D"=
auto">Khadem=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000003da4f7063e8b28fa--
