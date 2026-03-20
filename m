Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C41098788
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29F86402D1;
	Fri, 20 Mar 2026 15:25:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 30559402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 15:25:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774016742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GhqAZl9RdFwohZwh64ftNIigkLW/Gffo/lBHqu3WlHE=;
 b=GBfdF/rxNVhpfLrLvukh/J4C4BDaZHeGv8g6PXMYoAimhK8j9wkk0P0N5fAex8rLMcMq77
 fNKdPxROCKBoeOofQWBy9C9ZU1k4smfGM/OGsU2iePdggvdACQ1gXnYJmMdPDti9JOmI5J
 J1b9OAjJdjzFFE+Q/43NbRHXOV2pBPM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-sppNpfwPNz6XKB9wQy8EVQ-1; Fri, 20 Mar 2026 10:25:40 -0400
X-MC-Unique: sppNpfwPNz6XKB9wQy8EVQ-1
X-Mimecast-MFC-AGG-ID: sppNpfwPNz6XKB9wQy8EVQ_1774016739
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-389e0db12cbso10851041fa.3
 for <dev@dpdk.org>; Fri, 20 Mar 2026 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774016739; x=1774621539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhqAZl9RdFwohZwh64ftNIigkLW/Gffo/lBHqu3WlHE=;
 b=NITEZqo5A3gjNGmJFfB+RXHyBmdzoXNQdfEH9MA0vlrJKhkyvn8d4NZZXUELqHd0xQ
 P5ibb4pq6rhkHxOZKYpbjwUsTTBBw0uifCJQipZQdRqXzzBLzcPRCXHldxPnypY9F7Zx
 VqyyItCkicuXKHMD97g2MWYO/IgxkRYzgibxY34Jd+/6qyGvv0YvEZVjlvXEuAcGWr9j
 UM7HCyDzFadS2+4PY04UIqNy2n2qWx+YXWjaocJkxGauIGtsmPGILYRHsT00QMX17aaI
 TaP3zE9Ho5aqMXdYmBQL9ERBjEIxEAlPPEUZ6mEhMeLSZuEXfWGK1fmgXxhzZ/ZbONLq
 JpjA==
X-Gm-Message-State: AOJu0Yyw3MA5OCYJcPyPHqJhVtXIOkaqahfRBhahBtNYTftNfKD3r3F0
 UKQ/yd+jVykOW4u7XyJF/YKkMXVchIiG0gKW5TBf1An5JpCFHXhne9RVRX67JH2FMkkUsyPaXQu
 hAFHrPKhlKBvgnGVE9LkPnz7bqsTsbqL9krDy/GdqcN3epFpMWVUNwYU5fnehT0poL0l4fQ/6yx
 bClv3EzMW7czchE2hrFLA=
X-Gm-Gg: ATEYQzxrTZYrBkL4K06Z2jW+6b7+yb2M30BACga0aquKDHaypB7U50pt6HANrCwsJaG
 PB/6t+iVeS+G9du4iaKkprYH91QFfGT12JipkN/LBxMv9t5rLP2MQBvUVrwNt+D3KoytncR2qdg
 HOcGCEZrgt6yxwZDxlOWj1lkN60+XyiJDTznJdjA3nFWkz0BVm9hit82GBEJp3jVWhbnDEu1B2N
 WmjQiQJKCMysL95q7PMJysU0vZZluLXL01wa9MHWFBOITunybKNp7VyEwJqewuCVAdqXQ==
X-Received: by 2002:a05:6512:3b0b:b0:5a1:3f63:c7e1 with SMTP id
 2adb3069b0e04-5a285b3fd6fmr1053206e87.26.1774016738921; 
 Fri, 20 Mar 2026 07:25:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3b0b:b0:5a1:3f63:c7e1 with SMTP id
 2adb3069b0e04-5a285b3fd6fmr1053195e87.26.1774016738420; Fri, 20 Mar 2026
 07:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 20 Mar 2026 15:25:26 +0100
X-Gm-Features: AaiRm524PpJgkeT_cEU5fYhjg-1x681ubvbkfedMwxmdLdHOS5ywsNct25lBraQ
Message-ID: <CAJFAV8ynEzM+h0YTb-ONxqTcAzhu4hfj6yE0ZQFTZAi-9J02RA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Get fast-test suite to run on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, probb@iol.unh.edu
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fd-8Hcj5-oeyViiOOFCJ7FmrcNe_yATBFygF2GdqK0s_1774016739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 19 Mar 2026 at 18:13, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Bugzilla ID: 761
>
> The standard "fast-tests" suite is used to sanity-check large parts
> of the DPDK codebase, but it failed to run successfully on FreeBSD,
> with large numbers of failures. This is a long-standing issue reported
> in Bugzilla back in 2021 (hence the 3-digit BZ ID)
>
> This set attempts to rectify this situation by allowing the suite
> to run without errors. Mostly it does this by disabling test suites
> that rely on features like multi-process which are unsupported on
> FreeBSD. It also fixes the test_debug suite which should run on
> BSD but was failing.
>
> After this set, a run on my FreeBSD system passes with zero failures
> and 22 tests reported as skipped.
>
> Bruce Richardson (7):
>   test/timer_secondary: skip test on FreeBSD
>   test/eal_flags: skip test on FreeBSD
>   test/pdump: skip test on FreeBSD
>   test/secondary_process: skip test on FreeBSD
>   test/external_memory: skip test on FreeBSD
>   test/interrupts: skip test on FreeBSD
>   test/debug: fix unit test on FreeBSD
>
>  app/test/process.h              | 11 ++++++++---
>  app/test/test_debug.c           |  6 +++---
>  app/test/test_eal_flags.c       | 26 +++++++++++++-------------
>  app/test/test_external_mem.c    |  4 ++--
>  app/test/test_interrupts.c      |  2 +-
>  app/test/test_mp_secondary.c    |  4 ++--
>  app/test/test_pdump.c           |  6 ++++++
>  app/test/test_timer_secondary.c |  4 ++--
>  8 files changed, 37 insertions(+), 26 deletions(-)

I would put the exec discovery rework in a first patch, then squash
all the rest together.
Otherwise, it lgtm on the principle.


-- 
David Marchand

