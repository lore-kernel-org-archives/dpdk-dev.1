Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCFAC369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 06:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7734C4066E;
	Fri, 11 Apr 2025 08:49:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A34EC40285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 08:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744354197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXEfaW9MGCzkOQgPtwNibVzCw1LKGWOJBRlYLL5yCcg=;
 b=UjWVy9wvtnG4mEXZjpRBzsTEDQWlmFAunMfr6XEDV4ckukGRjATFquzEGkReP35h1Mgji2
 LWx2e04BM7UYURXmiyn9Me/R50A6tk6Nm2tK/g+sCP6p9HVj7cgC+8KRW0bvPO31mfH7tA
 6pfzRmZZhFAs3L9fOMl9kFADltVaJI4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-KS0m6SOLOc60eH4GNgKgVQ-1; Fri, 11 Apr 2025 02:49:55 -0400
X-MC-Unique: KS0m6SOLOc60eH4GNgKgVQ-1
X-Mimecast-MFC-AGG-ID: KS0m6SOLOc60eH4GNgKgVQ_1744354194
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5498963ebc3so876501e87.0
 for <dev@dpdk.org>; Thu, 10 Apr 2025 23:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744354194; x=1744958994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXEfaW9MGCzkOQgPtwNibVzCw1LKGWOJBRlYLL5yCcg=;
 b=ruVJVzSwwT5HsKasvikEEd99oF6D1/cDE2MiUur9L3GyZj1jLyCJwlk2j4xOVOYfAH
 j06/8BbMqAacspyX56Q770IS1GoQS1zIFDMnb87LmKhLkEcKK19VJVq+lmVEcPOTZ4Ax
 Ef9CbcvFJiXExCF5dOefFrpJuwBIWhrZQriYge0E+LiaD/Z1vKuAjoUWlFMmpNk0ow01
 M5pGhcjT0W8Edi1rRNFnt8rgF/J6/XMWGpuX7g8wF6AWdrMi451maXsKTIVrBiUvth2g
 ifc6gmGwh4vLUouaPM8xPUpS3mLHlSt9NGFsjt+cAWbRgcwqQPnhYXO5znlXP8ruAphD
 2ZIQ==
X-Gm-Message-State: AOJu0Yy6v73ElMnZptF/lf3QMlSRFpGope1X6aBohtl9pmOXJBaYoTD4
 Ukft07SbjedMfnOw0WJp83r9yvvEzOIHA9fA24POzXCaoTAtm6brxef/NuJgeudgH0D5AYCgjWn
 s5JdI8BIdUMjcbwF/08ZUHz16EO7GSJBuEXtbQ3cYnLMfiWou66NoQFpaEdK/zb4hdKh6w42ZEU
 WhfitWXQFC4bcbgO4=
X-Gm-Gg: ASbGncvsy4HISJf4xgcXr6/FUzgU+eGqT8P04hfDGve5fJmIzqbCgEopRM3kbXrPHuj
 C7/hhwGw4HzkaVJWThaEuwVQ4eATmuwJICRy6V/6i3zweN9CmSsPYR8u3KCw1CocdBWP1seg=
X-Received: by 2002:a05:6512:10d6:b0:549:8f24:b617 with SMTP id
 2adb3069b0e04-54d4528c548mr453160e87.4.1744354194193; 
 Thu, 10 Apr 2025 23:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF5leP5dLv/GuA2FfF10SxYG2Vn/xFB3HA1GWbUaDTLeLRspNpFiX+/L7PWheYRkDSanI/g9ve80lnGz8ZLUA=
X-Received: by 2002:a05:6512:10d6:b0:549:8f24:b617 with SMTP id
 2adb3069b0e04-54d4528c548mr453156e87.4.1744354193825; Thu, 10 Apr 2025
 23:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Apr 2025 08:49:40 +0200
X-Gm-Features: ATxdqUE9TqD3QDsx1QsGKEdvWdPZuJ7tHuZMH4612SlZq1-QOlEr-4DWTKynxjM
Message-ID: <CAJFAV8yhcDpvmBnCXtUw=z-+Hhz1DdzH=gWr+L3+dF4thUO0iw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] enable "app" to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HSpcGBA5a3-0QSrTPYN_IOUlNs30IK7eUzBYgnE4d44_1744354194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Andre,

On Mon, Feb 24, 2025 at 5:25=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> v6:
> - remove "volatile" and use rte_atomic_xxx to access the RTE_ATOMIC
>   qualified lcore_count, which is cleaner than using "volatile".
>
> v5:
> - add "volatile" to declaration of lcore_count in test_ring_perf.c.
>
> v4:
> - add explanation about the expression used in __rte_constant during v3.
>
> v3:
> - use clever expression with _Generic for __rte_constant and use it
>   where __builtin_constant_p was being used.
> - use %u in csumonly.c and just cast variables to unsigned int.
>
> v2:
> - use lcore_count as atomic always, not only when RTE_USE_C11_MEM_MODEL
>   is set.
> - use PRIu64 in csumonly.c instead of casting variables to int.
>
> Andre Muezerie (10):
>   eal: add workaround for __builtin_constant_p
>   test_alarm: avoid warning about different qualifiers
>   test-pmd: fix printf format string mismatch
>   test-pmd: do explicit 64-bit shift to avoid implicit conversion
>   test-pmd: avoid undefined behavior
>   test-pmd: avoid non-constant initializer
>   test-pmd: don't return value from void function
>   test/test-pmd: declare lcore_count atomic
>   test: add workaround for __builtin_constant_p in test_memcpy_perf
>   app: enable app directory to be compiled with MSVC
>
>  app/meson.build                     |  4 ---
>  app/test-pmd/cmdline.c              | 16 +++++----
>  app/test-pmd/cmdline_flow.c         | 22 ++++++------
>  app/test-pmd/csumonly.c             | 23 ++++++------
>  app/test-pmd/meson.build            |  1 -
>  app/test-pmd/testpmd.c              |  2 +-
>  app/test-pmd/testpmd.h              |  2 ++
>  app/test-pmd/util.c                 |  2 +-
>  app/test/test_alarm.c               | 12 +++----
>  app/test/test_memcpy_perf.c         | 54 ++++++++++++++---------------
>  app/test/test_ring_perf.c           | 13 +++----
>  lib/eal/include/generic/rte_pause.h |  2 +-
>  lib/eal/include/rte_common.h        | 34 +++++++++++++++++-
>  13 files changed, 109 insertions(+), 78 deletions(-)

I replaced patch 5 with the alternative that I sent yesterday.
Series applied.

We now have dpdk-test and dpdk-testpmd built with MSVC in the CI.
We are still missing net/null and mempool/ring to do some basic test
like devtools/test-null.sh.
On the other hand, what prevents us from running the fast-tests
testsuite in the CI?


--=20
David Marchand

