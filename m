Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E22CF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B2A402B0;
	Tue, 13 Jan 2026 01:42:56 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 0FA96402A2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:42:55 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b872b588774so176797666b.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768264974;
 x=1768869774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNNNeD+DhAgN0Wnoh80fi0t8/auGH+KCqWbpuFRT/mg=;
 b=1azuV6LgjnyQ7P8jmPwbvxiR8/gqtO5GBlvjNeK4uB23X/7lG3PjyzeTMvMsXbTvRC
 xrBGRyIHG9XUjRZqxzUmQYRC5UZoRMgEKKsdRjeWZOXbrwLjBjNEDEe661JUBEkVFVJy
 Q2kSvF86VNTjd+8+0CWbacPDpdZTcqS/PP7xVK585EYuGQmg650bk0zXRitU+eoVHZAs
 4ID8GV/Awtv3MsoQ1Zohx7glBMHSXJkjsORyfbCai9JxF9w7YmAqMYHuAQg/81DO8wJM
 iPcP6Qyp7htu757dXKIizC+fFqeZyRIRSDcbEYvizECkYTRWQ4mOarW66zTrU5Di6saw
 TlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768264974; x=1768869774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XNNNeD+DhAgN0Wnoh80fi0t8/auGH+KCqWbpuFRT/mg=;
 b=sgFPznevJ4jXiGELD8jmWMFirVwMuiWEud8iTlVrcZ6KaPkU3yXep/4OF6MN85RWYF
 Hq6Voi1cTlyjQJmTPzIUCRRrPVb0rJEIZukH3wzY6BkIw7f5Naek9QvyyOUnRVTvFBWk
 O3xCAGEZRkyqbku6YTs8w2Opvc6/Mfh0KWG0mNxPXa4iIDG3g5W30sWWIvxQAVaBAxoa
 OdKGh3S8fAeakzijDMt03aU6X6vk2utR27SyzGnrrAOHW5wveyQpbTNSYG7qBf9H0qh4
 daIsD1DOxqelTaLG4IOWW5YDoJ5UysWqcTJtW4ktmbfilbS4kpdUZRPDPf4vINrYcktD
 FtGA==
X-Gm-Message-State: AOJu0Yy4pKGvyfEMqPRH/xFDPNI01Tmqu2g4aWEDB9ZLwAfGYuCHgQA8
 dnIn2TJemTyzav7Bk7gGiZ5hHpIKXsi4I3JRA6u//ciFyvc2OIuF4V5dWxg+e+94eSM=
X-Gm-Gg: AY/fxX686VrKS9BKfi0XxPtJU/8AFMqUDT0EClQU8ymAJUdh4Y2FtGmJM9hBr3qJF/k
 f0/7cQ8iKKjYdgaBlc+dWVz28Sr34SI6QF5goVK+hC29I6xD409XnGyAWAecMIgPbgbph7Vy0aR
 L1AXO/wLbImoQsVQ+9zS5LFDMAMPYTiy4gKupUGFmGh41MeqSp96DdHTbNuhlGC4U+JMyxyhs89
 UvHjIZFu7bpFPcB3LtvthPH1o/ijTEdpoMJ1+doZoAi1Qv3d+ED44VY4oUbrigeJKY9UOuhyRWM
 dSyqzqW1jzB5F45Ia8EJMdIhDcGHOcMR5AhtrsL8mtD3oz5BWFk2FUqmrJzkvrz29HV4DtXEPiS
 jBz1WNdBXd54Rg/DEkLrNGnOx9hLmgd0hIWh1dEZRX1/g2cEaxT6yoLJolkuDmuVIiFVWbZPewM
 dVQevKHn5ZSRSxM8HvUrAoj+zANZcbyFw8X4uasqERzEZfp5FOXSzk
X-Google-Smtp-Source: AGHT+IEa3lcAQtaaf4FAjtmpIPU6Flajj8+OPzswE/w/fahbkTSnBAbNlQaWCe9OFr9Rb/Yz+n3dBw==
X-Received: by 2002:a17:906:7954:b0:b87:2579:b6cf with SMTP id
 a640c23a62f3a-b872579ba1bmr363170866b.41.1768264973598; 
 Mon, 12 Jan 2026 16:42:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b872152ee10sm348701266b.34.2026.01.12.16.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:42:53 -0800 (PST)
Date: Mon, 12 Jan 2026 16:42:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/bnxt: fix the stat collection
Message-ID: <20260112164248.0e474584@phoenix.local>
In-Reply-To: <20260112192354.3096196-1-kishore.padmanabha@broadcom.com>
References: <20260112192354.3096196-1-kishore.padmanabha@broadcom.com>
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

On Mon, 12 Jan 2026 14:23:51 -0500
Kishore Padmanabha <kishore.padmanabha@broadcom.com> wrote:

> The stats collection was not aggregrating the stats for rings greater
> than RTE_ETHDEV_QUEUE_STAT_CNTRS  if the application did not increase
> the stats counters but supports more than the limit.
> Added checks to increment the aggregated stats from queues
> greater than the limit.
>=20
> Bugzilla ID: 1836
> Cc: stable@dpdk.org
> Fixes: 57d5e5bc86e4 ("net/bnxt: add statistics")
>=20
> Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> ---

Did AI code review on this (yes I am lazy)..

DPDK Patch Review: net/bnxt: fix the stat collection
Summary

This patch fixes statistics aggregation for Rx/Tx queues beyond the RTE_ETH=
DEV_QUEUE_STAT_CNTRS limit. The approach is to iterate over all rings but p=
ass NULL for per-queue stats when the index exceeds the limit, ensuring agg=
regate counters still accumulate properly.
Commit Message Issues

ERROR =E2=80=94 Tag Order Violation

The tags are in wrong order. Per AGENTS.md, the correct order is:

Bugzilla ID:
Fixes:
Cc:
<blank line>
Signed-off-by:

Current patch has:

Bugzilla ID: 1836
Cc: stable@dpdk.org       =E2=86=90 wrong position
Fixes: 57d5e5bc86e4 (...)

Signed-off-by: ...

Cc: must come after Fixes:, not before.

WARNING =E2=80=94 Typo in Commit Body

Line 105: "aggregrating" should be "aggregating"

WARNING =E2=80=94 Double Space

Line 106: There's a double space before "if" (CNTRS  if)

INFO =E2=80=94 Suggested Rewrite

net/bnxt: fix the stat collection

Stats collection was not aggregating stats for rings greater
than RTE_ETHDEV_QUEUE_STAT_CNTRS when the application did not
increase the stats counters but supports more queues than the
limit. Add checks to increment aggregated stats from queues
greater than the limit.

Bugzilla ID: 1836
Fixes: 57d5e5bc86e4 ("net/bnxt: add statistics")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Code Review

Style Compliance =E2=9C=93

    Line lengths within 100 characters
    Proper use of DPDK atomics (rte_atomic_load_explicit, rte_memory_order_=
relaxed)
    Consistent indentation with surrounding code
    No forbidden tokens detected

Technical Observations

The fix correctly:

    Extends iteration to cover all rings (bp->rx_cp_nr_rings / bp->tx_cp_nr=
_rings)
    Uses conditional i < num_q_stats ? qstats : NULL to suppress per-queue =
stats for indices beyond the limit while still accumulating aggregate stats

INFO =E2=80=94 Implicit NULL Handling Assumption

The patch assumes bnxt_fill_rte_eth_stats() and bnxt_fill_rte_eth_stats_ext=
() safely handle NULL for the qstats parameter. This is likely intentional =
and correct, but worth confirming in review. A brief comment in the commit =
message like "The fill functions already handle NULL qstats for aggregate-o=
nly collection" would strengthen the patch.
Verdict
Category	Status
Subject line	=E2=9C=93 Pass
Tag format	ERROR =E2=80=94 wrong order
Body content	WARNING =E2=80=94 typo, double space
Signed-off-by	=E2=9C=93 Present
Code style	=E2=9C=93 Pass
Technical correctness	=E2=9C=93 Looks correct (pending NULL-handling verifi=
cation)

Recommendation: Request v2 with corrected tag order and typo fix.
