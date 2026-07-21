Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E569FC4452B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1745402A7;
	Tue, 21 Jul 2026 10:28:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8CDEA40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 10:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784622508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rfymxe5mh5NVOsiZWhMM6JlYyvIYqLDLzq4DHAVqXUY=;
 b=A7xWdpmlVZ5Vtzitp8ntyR6FxXm9Eq7sHs3LIlmoQaeOi14gmmrf9oyIsngAAY89rer76b
 LyxJUIOXOLNPaZxW30j0ESEB7B/7VcffhomajxuU7761POWC5cW523zutFMpcVGVik2YQw
 1XU1d92G3bc/QDI5pV+dK3VgDCy/MCQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Npbd8w_JPtKuwqSlYjlvVw-1; Tue, 21 Jul 2026 04:28:27 -0400
X-MC-Unique: Npbd8w_JPtKuwqSlYjlvVw-1
X-Mimecast-MFC-AGG-ID: Npbd8w_JPtKuwqSlYjlvVw_1784622506
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39d93d95a21so43540971fa.0
 for <dev@dpdk.org>; Tue, 21 Jul 2026 01:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622506; x=1785227306;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rfymxe5mh5NVOsiZWhMM6JlYyvIYqLDLzq4DHAVqXUY=;
 b=SnsCwy6R4WWWuSRTdHQg+T+awO+nZvt+ffWxHf0b8MHuNk9Xu29Qy+ljVZ2cSeOmxv
 4rkwOqkqWmnjsCc6vDGzhaa9FOWOrqBsTeqpwNkT54292AHcBuvSbVVqmjvKiJcGWDdf
 k/RwOe88KO1J0h4GDQx1HgOpoR32sGLQP+kP1WhcL+53rT4p3ViWpuapJGw9ysGx8fSV
 2qycdv9j+KH1EGwmmQgEMJ3Y+ELqHwY7kzQOhOL3oj/BHNT34wSQI0DeiCm0kfBs0ZvM
 Wx1u78ioAdFvWLbPpbaql0pxt9oiQOLqvQNJJKYwEzWrSNmZuiOT5uNvE7fDVOpb3lAb
 kcjg==
X-Gm-Message-State: AOJu0YxaC57RWCWdrq9tqAba6pwrafUWzURBImQa3nqjXAWFRSB32z1J
 XU7D5YYUHwqvTCwki5WmsCva4gztwQsvs893W8tTMb+y4AODSn0pVias/t8qm3UDMIAwL6YySeO
 3Fip/CCi0tzah0bCp3XiR1ZMRi3H8yhAp4rT6rX1WmLdD+vTztbOTfxnItxR9P5zL0iSlYKY+pv
 JXylSNd1zE1rUEyERyRZs=
X-Gm-Gg: AR+sD12oN2BiGvijKipw1923nqJmGGWcoZlXNtSYRu7Q9ByGpufDyAn9zWRwnq3vnjD
 BQtcVHMGKxq2BNcMQ4qNFRBr/59vcMEbo07dHJClJyaIKrMlrWpZnaS+kdCi1EqCp7ZxKpYxEt9
 5r5TTA3CPZOc9Ego6vYDYcctB2y3oikD41LMHIZ/Q7pDXSX8bW3xk8UUY3N5iqYyeWDpRZ34Yiv
 hOLyo7u2pZBJDVNWi3T8mzJNnyrM30ZyceExk8zU8iNGdl4
X-Received: by 2002:a2e:ad92:0:b0:39e:b257:e878 with SMTP id
 38308e7fff4ca-39eb270e690mr36199421fa.8.1784622505826; 
 Tue, 21 Jul 2026 01:28:25 -0700 (PDT)
X-Received: by 2002:a2e:ad92:0:b0:39e:b257:e878 with SMTP id
 38308e7fff4ca-39eb270e690mr36199331fa.8.1784622505322; Tue, 21 Jul 2026
 01:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260721081310.2542794-1-maxime.peim@gmail.com>
In-Reply-To: <20260721081310.2542794-1-maxime.peim@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 21 Jul 2026 10:28:13 +0200
X-Gm-Features: AUfX_mx-F8QUcYUou98iQeLOISuMwxIN07dhcp82ruTr_5YQgAk8qA2-VxeF4uc
Message-ID: <CAJFAV8yRBL1CTztvWsiYKZGZ_wW7xP6Q2uSd6q53BeKtUJb2TQ@mail.gmail.com>
Subject: Re: [PATCH v3] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: klMjT2z0g2fQBKJfrY23DVqeq2CWYCLClyNT3CkkyAk_1784622506
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

On Tue, 21 Jul 2026 at 10:18, Maxime Peim <maxime.peim@gmail.com> wrote:
>
> Threads registered via rte_thread_register() are assigned a valid
> lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
> lcore_config is left at -1. This value was set during rte_eal_cpu_init()
> for lcores with ROLE_OFF (undetected CPUs) and is never updated when the
> lcore is later allocated to a non-EAL thread.
>
> As a result, rte_lcore_index() returns -1 for registered non-EAL
> threads. Libraries that use rte_lcore_index() to select per-lcore
> caches fall back to a shared global path when it returns -1, causing
> severe contention under concurrent access from multiple registered
> threads.
>
> A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
> uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-core
> cache slot. When core_index is -1, all registered threads are funneled
> into a single shared slot protected by a spinlock. In testing with VPP
> (which registers worker threads via rte_thread_register()), this caused
> async flow rule insertion throughput to drop from ~6.4M rules/sec to
> ~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
> to spinlock contention in the ipool allocator.
>
> Fix by setting core_index to the next sequential index (cfg->lcore_count)
> in eal_lcore_non_eal_allocate() before incrementing the count. Also reset
> core_index back to -1 on the error rollback path and in
> eal_lcore_non_eal_release() for correctness.
>
> Fixes: 5c307ba2a5 ("eal: register non-EAL threads as lcores")
> Fixes: 99c05ce5ef ("eal: parse coremask as cpuset")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
> v2:
>   - Track allocated core_index values with a bitset instead of deriving
>     the next non-EAL index from lcore_count, avoiding duplicate indices
>     after non-EAL lcore release.
>   - Keep the bitset in sync when default EAL lcores are discovered, when
>     EAL lcore options remap the active set, and when non-EAL lcore
>     registration rolls back or releases an lcore.
> v3:
>   - Fix commit message to track also 99c05ce5ef

The patch is already merged in main.
And we can't really go back in time (for now ;-)), sorry.
If you want to highlight one more Fixes:, you may contact LTS
maintainers, but nothing more can be done in main.

Note: I see you sent the patch with a Reply-to: field where you
probably wanted to use In-Reply-To:.
It was also the case with the v2 patch iirc.


-- 
David Marchand

