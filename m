Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB6C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F52E402E0;
	Wed,  1 Jul 2026 12:28:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5F61A40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 12:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782901682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W0JZGnCFhWqiUSr6ctIxtMDU7ZyI0M44SwVaYwJFvPQ=;
 b=WnFsZZsjkyB1MjJ5jbYkJm5EXA/YHHmPWJzvBlV58YRpw+qgIo3AUYDEea75J5DrNO84/k
 l6s75QM41mvgPCT83kMR5qJcAlv7gfu/ba7pSracBlcOmLNls1e6FKcjEVrAlL3xqgYv+8
 bqXTjw0kkxBypaPpFZA1m3aYN+QWqC0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Apn0I6HfNKiMaKbyzUZTFA-1; Wed, 01 Jul 2026 06:28:01 -0400
X-MC-Unique: Apn0I6HfNKiMaKbyzUZTFA-1
X-Mimecast-MFC-AGG-ID: Apn0I6HfNKiMaKbyzUZTFA_1782901680
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39ae216b900so2981131fa.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 03:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901680; x=1783506480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0JZGnCFhWqiUSr6ctIxtMDU7ZyI0M44SwVaYwJFvPQ=;
 b=rqR1i/ofOdMEbAOpeYggbGf1rb5+735oLBntmENsGYPQ04liE+7C5RC7yuO6Ms24yE
 kQatTrwwcGhwakjkfEk+rlydOE0ZlNHEMNLifQB1SX6cUsY696IwYZqqTYye4jA9Z+jC
 ukxuvAFuHVnw/bGWNQaeKMRLAIMSx8UYjFTaDBgvAHCUosLgftQTlZjSghe/0w6Baro1
 TaSvi7UMrITh9kEEvpIS2mpiGOCRA8kj0uZzgyrt8eNwUkq0NQ4QFgyhL9ZmZPPxl+W/
 oDy/pdl3cvppXST0RrpJPGjmAl35u40tcfBE9suvD/nFy6XSrwmz57m3W3XejoSRnkYc
 kBRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfNfnBra6qN9rxDN2JMI5xgOFRL15DG3VeZ9BCXtxVN8ZYKw8bkBZdn+BtScZIsln57hI=@dpdk.org
X-Gm-Message-State: AOJu0YwRJcUZRIjmFmTIJXC6yAQystsU1fLDAX7ybhBVpDf2sCU7LWO0
 +qhR921rhmlS3oX77lvGYTTM1lV0wPSr4SjytTrwssW7MaIeH4F9vZLPnCcgvf4dhZE4hLqHQ1Q
 lP8LJxwZhCfSH28GtRzvjscr4emjt5XOKt/dJCY7Q65s+sNbnSYnPJF28CjMohoOLfc76f55xyc
 jOxa9aZZpMcyipI1DyuAg=
X-Gm-Gg: AfdE7cmXSFZmEbjd66gY7vTVzhinA6qcExAa16TsIxWQLewP+gwL//QDCSk/S8XOSR3
 B4Zpd1G8pKDBdzIXc1ekjrgbcD8LyXOJdVL6t6PbnjrmPmeRIqcVjn0ynA2FDd9MFe9iWM+mptB
 PVSiqAZ/PmFT8kSGs1CqFHyFWn5tkQNFjYOiZSDEwqHjiT8Gehz/G2Ufvg1KB6xHVBeZZXh8Rgy
 oO8n3wQLPZJjz++e3MD5QGZRIcWsfznurA2hQeifA5+q8sdDOe/ISX/GAs=
X-Received: by 2002:a05:651c:50f:b0:39a:e29b:78fc with SMTP id
 38308e7fff4ca-39b34133cb8mr2256681fa.40.1782901679941; 
 Wed, 01 Jul 2026 03:27:59 -0700 (PDT)
X-Received: by 2002:a05:651c:50f:b0:39a:e29b:78fc with SMTP id
 38308e7fff4ca-39b34133cb8mr2256581fa.40.1782901679372; Wed, 01 Jul 2026
 03:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260522145855.1748406-1-maxime@leroys.fr>
 <20260617082400.142129-1-maxime@leroys.fr>
In-Reply-To: <20260617082400.142129-1-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Jul 2026 12:27:47 +0200
X-Gm-Features: AVVi8CfH9iRkz_PZbMP-T5pxGvtvgZ3OTp1Izkx6tutzge4gTdNQ1UrZNTLnByw
Message-ID: <CAJFAV8wtofuPBLvM+GJPjC15VEyxCLLHEe820AQZWfee-VdHFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fib6: fix tbl8 reservation drift
To: Maxime Leroy <maxime@leroys.fr>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1YPO65JKzT95mkW49WxqBdgRUISh57lhT7E1yKH9i1A_1782901680
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

Hello Maxime,

On Wed, 17 Jun 2026 at 10:24, Maxime Leroy <maxime@leroys.fr> wrote:
>
> trie_modify() maintained rsvd_tbl8s by computing a depth_diff from the
> current RIB topology at both ADD and DEL. The two values diverge when
> the RIB changes between an ADD and its later DEL (a covering parent
> added or removed), so rsvd_tbl8s eventually wraps to UINT32_MAX and
> rejects all subsequent /25+ ADDs with -ENOSPC. A zebra-kill /
> reconverge cycle on a live BGP router reproduces it.
>
> The fix computes the reservation from the RIB node shape:
> count_empty_levels() returns the number of byte boundaries between the
> prefix and its covering parent that no other prefix occupies
> (has_children + parent depth), in O(1). It is the count of tbl8 levels
> the current route set needs, so ADD/DEL accounting stays consistent and
> cannot drift.
>
> Patch 1 is the minimal self-contained fix (Fixes: + Cc: stable).
> Patches 2-3 add the reproducer and extended regression tests.
>
> Validated on a live BGP router (grout + FRR, 128 IPv6 prefixes):
> RSVD_TBL8 returned to its pre-cycle value (70) after a zebra-kill /
> reconverge cycle.
>
> Maxime Leroy (3):
>   fib6: fix tbl8 reservation drift in trie
>   test/fib6: add reproducer for tbl8 reservation drift
>   test/fib6: extended drift test cases
>
>  app/test/test_fib6.c    | 335 ++++++++++++++++++++++++++++++++++++++++
>  lib/fib/trie.c          |  83 +++++-----
>  lib/rib/rib6_internal.h |  22 +++
>  lib/rib/rte_rib6.c      |  15 ++
>  4 files changed, 415 insertions(+), 40 deletions(-)
>  create mode 100644 lib/rib/rib6_internal.h
>
> ---
> v2:
> * Compute the empty-level count directly from the RIB node
>   (rte_rib6_node_has_children + rte_rib6_get_parent, O(1)) instead of
>   the v1 multi-level supernet scan over byte boundaries.
> * Drop v1 patches 4-5 (valid_descendants counter + single-descent
>   helper): no longer needed, the node-based count is already O(1), so
>   rte_rib6 needs no new per-node accounting field.
>
> v1:
> * Keep rsvd_tbl8s; recompute it via topology-stable empty-supernet
>   count (dir24_8 pattern at 13 levels) instead of RIB-derived
>   depth_diff.
> * Drop RFC patch 3/3 (no longer needed).
> * Add extended regression tests.
> * Add patches 4-5: RIB valid_descendants + single-descent helper
>   (optional perf optimization; not for stable).
> * Production-validated on a live BGP router.
>
> --
> 2.43.0
>

Series applied, thanks.


-- 
David Marchand

