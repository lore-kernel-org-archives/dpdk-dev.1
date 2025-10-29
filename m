Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F126CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 14:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0988F402D2;
	Wed, 29 Oct 2025 15:32:20 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id E7B5A4026F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 15:32:18 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-78af743c232so6785174b3a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761748338;
 x=1762353138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QB1AvB0iBmCeLCBiP3WNQx2iewg81zJ8kxbY+YPZFU=;
 b=o/i/tFz8lV2/BKMKOQwtJa4PvvL1Zi2cg1fnakvHhs6gfU4YnZDDwvBH+l/U9XgeAf
 r2LCQjiT1XgZtDr5CXJsJE8qe238h0SNw4FdWs8X7x3tqTNTKh2ucEkevI9GjrPmZXHj
 TjpVFRCdnIIkJ26391rFLxBV1sw8NBE5ngW+UNrfvk0SoFL0VCTvA1+rlStXwIDkrcqG
 CazzM5BXO1Ooh5KMYQWa5WcgQgKc6nQbns7Hg3vfcmDpZtqXAv5QGxVjZJ2GpS/gyLwQ
 yveZL23mJU/tnQLNIIQFLHnkV3HsA7G7YMFHyp1+kYnjDmCueYbH86YNB+jybXM3qcOb
 47PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761748338; x=1762353138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QB1AvB0iBmCeLCBiP3WNQx2iewg81zJ8kxbY+YPZFU=;
 b=RJFg9PvIwsAPWGrHr8O2hYcFpKh+c/88IOq/5naZRArwfWmPWHp7gpLpM1rmG38kk9
 h4Xz6SiH88s2lYO9TvJbXTw0096WxY/WdesbKN3g/pLli42+U32oKrKd9RVg0pQQJ2ww
 eP1D7fturBW4xxde2ePlbRA+rMviZZ7x0vCVTgAYtP5uhqOoQcgf7xjK5zQR9ULiJqJg
 gYkWL0v6oBoo3rwTx5eRcOZKEAh6RW2TLL5fpkvcyIElsKhvodQ3RqD0/fHLp3n6M/r/
 rg4nclZzOXnjF0fPYBV3owimXaP920c5VmU0nY+rUuodoXxldR0NEspY7IbR4RnVArJx
 XmaQ==
X-Gm-Message-State: AOJu0YyBopJoAo5m8mZSK6mkJGTK74GCNeCbdtwBdR7+13ma28dFEXD3
 pNDWtDGsYWUk267VudlNbJ/dwmfyObIz1uKq3xPJimQzHw0Txka6e5RHIclWXg8gsMg=
X-Gm-Gg: ASbGncvxcyhmGJPmPB7d9THg7U++G5nftV7nLJ5gW8Vf0frR1KamZauM4vAuTEwUcSr
 itYxvOonROZ+z231zEklFX4zluVCSAzAnihkpA0BCx3ZqJEQ1EorYQYyQKQ92Gq+Pi32YM8qX31
 2jaSbpJGPYG1f0t6wZTZ03LMvo+31IbwQkLGCM5+eGxUrjJOxgFjhiLGg/t81XOX9LVy5bdEY8j
 eM0pM+TOcAauBp9HfayuBp9jlsG9NzE35Vvgda0S1JtVgp2q7D3PCyziKAlAL2+1LyEBEFAuDkG
 dRs9e2RbzNgeJB4ymmYy7YYkAly9eEv5+b6F4MaLk8dN7n6Z313jWEuRpglyiJx5nbNimpn04te
 vJf/KWBuLUzQG4Hoaosyc32pyqupp0fRJCwOxEomPOvuzcW+BeuoggGbfWRlww6r2o1bvlgYgYS
 imxBGKCrfMVZO+O1M5u5Dbf2paCs1pPNrWQw==
X-Google-Smtp-Source: AGHT+IG6nM37uZ/uOI1Ew58WP5G5o7CGiBdOrN3zvuOHq+dpDD70cGX6jZ2c/i9OfLHAgOY+BymVlg==
X-Received: by 2002:a05:6a00:1742:b0:7a1:49f7:ad04 with SMTP id
 d2e1a72fcca58-7a4e2dfd22fmr4255157b3a.14.1761748337749; 
 Wed, 29 Oct 2025 07:32:17 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012d02sm15884362b3a.4.2025.10.29.07.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:32:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 07:32:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
Message-ID: <20251029073215.494d130e@phoenix>
In-Reply-To: <CAJFAV8zi5=hBo6wEWwqr=QZyzodkf1K-39m82Fj9CA+-2SX1PQ@mail.gmail.com>
References: <20251027164621.175861-1-stephen@networkplumber.org>
 <CAJFAV8zi5=hBo6wEWwqr=QZyzodkf1K-39m82Fj9CA+-2SX1PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 29 Oct 2025 14:48:13 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Mon, 27 Oct 2025 at 17:46, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Missing definition of errnos causes build failure:
> >
> > In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
> >                  from ../lib/dmadev/rte_dmadev_trace_points.c:8:
> > ../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy=E2=80=99:
> > ../lib/dmadev/rte_dmadev.h:1183:25: error: =E2=80=98EINVAL=E2=80=99 und=
eclared (first use in this function)
> >  1183 |                 return -EINVAL;
> >       |                         ^~~~~~
> >
> > Bugzilla ID: 1814
> > Fixes: 8f1d23ece06a ("eal: deprecate RTE_FUNC_PTR_* macros") =20
>=20
> I am not following the rationale... 8f1d23ece06a removed a macro but
> use of errno was already there, so I am skeptical this is the right
> Fixes: tag.
>=20
> The issue was present from the start, so:
> Fixes: 91e581e5c924 ("dmadev: add data plane API")
>=20
> > Cc: david.marchand@redhat.com
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
>=20
>=20

Yes, the fixes tag is incorrect. The issue probably goes back further
in time. Might be related to tracepoints not including errno.h
