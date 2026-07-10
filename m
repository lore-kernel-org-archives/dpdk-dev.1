Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76528C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 16:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50EB04028E;
	Fri, 10 Jul 2026 18:43:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B393C400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 18:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783701801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yFgg9pEYag9ZfuFlG8vEGol2pKCgNyPCKIyNoRg+Q7A=;
 b=D7GQnQlCa8EAWZYZVe6BaFm7b1rznExWWW52xu61mEFwhejTmfqJ/4bouQ3KRfSO9m+MCG
 FLYVdppTQ4MC6jKmtbgTcBFJT+qb9sA8Q3YAFgR4vSkii+Hw+Zrbiux2vD3GTZG8PAI0Tg
 PZf+fFgVvtO/69PG8GwT83exgE/SKoY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-XcY16qmxMsy8k0wqVocNTQ-1; Fri, 10 Jul 2026 12:43:20 -0400
X-MC-Unique: XcY16qmxMsy8k0wqVocNTQ-1
X-Mimecast-MFC-AGG-ID: XcY16qmxMsy8k0wqVocNTQ_1783701799
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb351bb5fso825172e87.2
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701799; x=1784306599;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yFgg9pEYag9ZfuFlG8vEGol2pKCgNyPCKIyNoRg+Q7A=;
 b=P3OdCvH1+hGuvZYQ1ThRih6l9px7V/u67vXFCkxMJm33Tc5OkLqh/PH7Fusmw8L3R9
 AGtvfSzFHl0ju2mt29B8/b4c3w6OCiip6uDwkTZBFX8EmfN0mL50CEmCdq6RQYRUQeaN
 IAgu3g5ibCq1qPqS+N+pc9wCosl5PivK4ipABLGGrBlbM5LtiIp3FTigG508HYAnzKEO
 X3/c9Bc+3igONn0moqFizg7Pa3ZLbpNy8vYe8j+KrCXPDHyiz0T6RaR3oUFBe59fzE2+
 TOOqfeKPiUbCuhcnsDVIAbEC9QyVS/lXyZEVmSS2kZ300qRVeUkHx0pUdR8ppwaLBB7C
 qiqQ==
X-Gm-Message-State: AOJu0YxdPERdpSAYVaLfns51QvdlbHqZBtEPIUfiwSvwAWSFKWPATuGy
 9a3NvBta0Ic8YJvL0mMxAu3t0xjS0KDjHmR6KB9x1llHAUbreKIgQ52S/s/v/ZkvmdC5wOSS0QO
 YQHRkGySV/5yH/hd3m4ddfrQ5NVAkSd+a8D3DEm27dD3U1XBjxclLhzeoiSIWMpp2KJjhpw9xab
 hwfE0eA0tjsd53PDY3znFQvH89k3k=
X-Gm-Gg: AfdE7cn2xU+50NFQsyamq2mQ8Q1TUAHBlQqgd+aWveX+9zr9B2BWBI5wXiG0WwPIhOM
 BXaWCbgQZsqqf9Fjyr+Of165PsnS1zFZCtQLJkLiQIr2WAF3zg/GdRAWy7N/+s5ct296/vCHgVZ
 LLpHN6E+4F9pSjqgnYiwW8cVIE2woZjttCJybtbPc3mYynJXnPVDw6wGLklFcz1Vf/8d+CLBNk2
 bsPjNm4p9WZBiDsPFJmPR/655wRxcI2So9gin9ArQ3uc4pecuzoLrmxNXo=
X-Received: by 2002:a05:6512:6805:b0:5b0:137f:9466 with SMTP id
 2adb3069b0e04-5b0137f970dmr1974753e87.59.1783701798745; 
 Fri, 10 Jul 2026 09:43:18 -0700 (PDT)
X-Received: by 2002:a05:6512:6805:b0:5b0:137f:9466 with SMTP id
 2adb3069b0e04-5b0137f970dmr1974751e87.59.1783701798130; Fri, 10 Jul 2026
 09:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260702130729.26577-1-mkashani@nvidia.com>
 <20260702161244.363233-1-stephen@networkplumber.org>
In-Reply-To: <20260702161244.363233-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 10 Jul 2026 18:43:06 +0200
X-Gm-Features: AVVi8CfkdXjV5C40k43xWD4A-n5lE9ZKBnCcw9u3RbvbFCm2_uAGq4STLa2tvkY
Message-ID: <CAJFAV8yZxv247z5eDvY-BgN23Ot=Abn_n4zdxSCkxhdOzmutqQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] app/testpmd: fix socket id handling with NUMA disabled
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BTfYJ8Z66GOklv7-wOO_EtiHbtekKxhXkWsjKYqcM-8_1783701799
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

On Thu, 2 Jul 2026 at 18:13, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Alternative to the patch "app/testpmd: fix multi-pool Rx setup with --no-NUMA"
> from Maayan Kashani, fixing the problem at the source
> rather than remapping inside mbuf_pool_find().
>
> Since commit 835fd4893a31 ("app/testpmd: support cross-NUMA allocations"),
> mbuf pools are created (and named) on SOCKET_ID_ANY
> when NUMA support is disabled, but port->socket_id still holds 0/--socket-num.
> Every name-based pool lookup that does not go through the single workaround in
> start_port() misses. The reported multi-pool Rx failure is one instance; plain
> "testpmd --no-numa --forward-mode=txonly" also crashes with a NULL
> mempool dereference, and --socket-num no longer affects pool allocation.
>
> Patch 1 restores the invariant that port->socket_id equals the
> socket id the pools are created and named with, and removes the
> start_port() workaround. It should go to stable (the regression
> shipped in 25.07 and 25.11); it cherry-picks onto 25.11 with
> trivial context conflicts and was build- and run-tested there.
>
> Patch 2 consolidates the three diverging copies of the port socket
> id policy into one helper; this also fixes hot-attached ports
> ignoring --port-numa-config, --no-numa and --socket-num.
>
> Patch 3 prints SOCKET_ID_ANY as "any" instead of 4294967295.
>
> Patch 4 adds the error string to the interactive queue setup
> command failure message; rte_eth_rx/tx_queue_setup() can return
> -EBUSY silently when the port is started and the PMD lacks
> runtime queue setup support.
>
> Stephen Hemminger (4):
>   app/testpmd: fix port socket ID with NUMA disabled
>   app/testpmd: consolidate port socket ID computation
>   app/testpmd: display any socket ID as text
>   app/testpmd: report reason when queue setup command fails
>
>  app/test-pmd/cmdline.c |  12 +++--
>  app/test-pmd/config.c  |  18 ++++---
>  app/test-pmd/testpmd.c | 120 +++++++++++++++++++++--------------------
>  app/test-pmd/testpmd.h |  11 ++++
>  4 files changed, 92 insertions(+), 69 deletions(-)

LGTM.

Series applied, thanks for the cleanups.


-- 
David Marchand

