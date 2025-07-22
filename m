Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C802FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E550540283;
	Tue, 22 Jul 2025 19:53:23 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 5E5F44003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:53:22 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-704cb8b1314so35080866d6.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753206802;
 x=1753811602; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ/iVj0+/agpv8Ut9qV+p/ajQfDHUCI3RQPVXm8/yI4=;
 b=iUyQxsP0zEGR52GagwH6MgH6gf+QSIAtMTdxTAJMURG6QhVRTb/Bh7st6tlNUBrlc6
 Qr9f94DX1IQHYvLRwa4b7k1A1+CNMAweV/uQ6ZarxSOmqDRKIsq/K0vWUPjUgZgKHa3M
 Gdy9AiSiXwejt8ud2NgF3jVIHaP0/HKdPNQOGdNrpZE9LRVizW3khv8JYsiEtWVlAFIb
 cxih06v110UN6hWlZvB9PjMSy/AKJEuOo2K5GUKLR6ONOIGPDXw+OxOqp8u+Rj5Ia+iN
 zD9tg3AmtInYnd1MJt5p3ePy5wuTQ8ieWoAiIco23vB6NORmg+oGpGK6OmaucAd1ZElQ
 M2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753206802; x=1753811602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJ/iVj0+/agpv8Ut9qV+p/ajQfDHUCI3RQPVXm8/yI4=;
 b=IOvPYE4yWdk/Ys9MK69SpnCCEgMGQYzXTSGRiUz6CXy/Y1K97yRm/uByGiIqNm4CXM
 F/hZGVH6/WrTqLhkmAuINd11ulxotxpMCj/xqzaLu8FVLgosyCZ5nEPv9yUNSAKCeAbS
 nUK+r5qGWF5RFtgrl2sqJXQ1BJE/Gs+6uQ8w1YW+kHkXuPqqN6rVCxf4Gl6h4/RCp66Q
 EMtpOaHZ2wDtUggl8kTk9FDo/tXF46cMhGceVr8m0gOmBuDoXZf6TVasPDN/rf7dueH+
 rZYZ7dw4ME811DNsGtd4zO3NxJvteXzuLBRe6+KiHYIY+v9cSKIf4RzjI1K4l8iOJAib
 xlyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr18CJU3tjrVa4Lkmby69fFA8MBMGeXTJ2GOrrWn57e4P3Xbv+xwBA8i9JUXLHkb61ydk=@dpdk.org
X-Gm-Message-State: AOJu0Yzh0Gl19PaK6UBVmWpBwYSH6CXkvBIHooFqcS89yZiDEsQQEsI0
 IguUA/8w7l2bAQgBMutDZ3J96cEQfsa8wOt0gHqjhFZbQ+UoFiNvXSOYr0/jdhyA458Thabsc2F
 w8YAI4HwV/SmJD6pV1k/UMqWZlB0b4fUammeuLRHnOg==
X-Gm-Gg: ASbGncs547WgRjd7iAN1p0jPrL7jSUsvaBjZBvF0ibePaJSXQJEQfoPFsKve5icoUOb
 xE7+/vCpvh9fOLkbP4KNMV9vGbUBgVhp3DGWOmMacoxZGVHMv1CP/UaCEEu66BucEmPMA/6YbXp
 R+9ww7NYJpeRoTV30wVNOT1IGzd7tuxsNQn8F2jcGfhzMw2I8H+9obzpLDzNS0rTJBGj6LrKykJ
 ziESeI6sC1xtukbHFkUoPbgvM2BEbB7Nf1cvvF0gg==
X-Google-Smtp-Source: AGHT+IEboEbvkQ2uVY3IJu6Lf812u5MMkAmzbR+rPQX2OiFLzQ88EJLvZSa51xglrSwEcect9Bt3Sa628VvoHZ8jacQ=
X-Received: by 2002:a05:6214:248a:b0:706:ffcd:505f with SMTP id
 6a1803df08f44-7070023f4acmr1427906d6.0.1753206801551; Tue, 22 Jul 2025
 10:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
 <20250722103824.7c9db0a0@hermes.local>
In-Reply-To: <20250722103824.7c9db0a0@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 22 Jul 2025 22:53:08 +0500
X-Gm-Features: Ac12FXyPX0a32Am_-ztIqBfxBzEu49MxOEWK7i6Xb-3f73E-Pvy_qreP26rZfLA
Message-ID: <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000009fe94c063a88449a"
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

--0000000000009fe94c063a88449a
Content-Type: text/plain; charset="UTF-8"

Right, but performance and reliability are both important. While DPDK
rightly prioritizes performance, some level of reliability should still be
ensured, especially to catch known issues that could lead to instability.

On Tue, Jul 22, 2025, 22:38 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue, 22 Jul 2025 22:04:32 +0500
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > Agree, but I think it's also a good practice to guard against known cases
> > that are prone to crashes.
>
>
> Right but DPDK chooses performance over API safety.
> For example rx/tx burst doesn't check args.
>
> The point is that as a library, if application is doing something wrong
> returning error doesn't always help.
>

--0000000000009fe94c063a88449a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Right, but performance and reliability are both important=
. While DPDK rightly prioritizes performance, some level of reliability sho=
uld still be ensured, especially to catch known issues that could lead to i=
nstability.</div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 22, 2025, 22:38 Stephen Hemmin=
ger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@networkplumbe=
r.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 22 Jul=
 2025 22:04:32 +0500<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; Agree, but I think it&#39;s also a good practice to guard against know=
n cases<br>
&gt; that are prone to crashes.<br>
<br>
<br>
Right but DPDK chooses performance over API safety.<br>
For example rx/tx burst doesn&#39;t check args.<br>
<br>
The point is that as a library, if application is doing something wrong<br>
returning error doesn&#39;t always help.<br>
</blockquote></div>

--0000000000009fe94c063a88449a--
