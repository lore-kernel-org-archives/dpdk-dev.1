Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5334FCD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 10:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A163D4027F;
	Thu, 18 Jun 2026 12:37:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 49FCC40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 12:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781779022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nkr9wEwiUJ15/1dpW5QMMZCGdtboMogKTXgSc0FgqbU=;
 b=ZmpaN2+nB+m8RUL9Sw+3Fbc8VdaSH4g4drpDaEmTMui+NqSatrAv7swi7nuX0LKhCNBU31
 5pX6LG5M6JOkW9qLFDrD8GIqWhXLq/DbLp7FHAhZZI6xe9o1vkD9tTz6tBepP/9v8LZzkc
 XkItA+3DIn7f0Rg0H3ZySIEXJsiDtYA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-XURZ39GFMvaHbGUUW7-Mrg-1; Thu, 18 Jun 2026 06:37:01 -0400
X-MC-Unique: XURZ39GFMvaHbGUUW7-Mrg-1
X-Mimecast-MFC-AGG-ID: XURZ39GFMvaHbGUUW7-Mrg_1781779020
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa4bb157a9so734525e87.2
 for <dev@dpdk.org>; Thu, 18 Jun 2026 03:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779019; x=1782383819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkr9wEwiUJ15/1dpW5QMMZCGdtboMogKTXgSc0FgqbU=;
 b=HavN7Vaa/m4sb2CI6rX3if03OhWNjim7/YqgwRUVX8GGvC6i7axv7Wf9x5JTzt+P8Z
 XMd9vGK18UCYEoaAobsXBM9mIrvCSzYbIdfDDz5gukOSI2WMhrZ6ar6edEaxm+k5hVHV
 R110kaLKVHbd2Uph3cFdOHOCjtLi/82AmVy+7yci9BfajJBdkmK0mNMQ3L9WUaMO2ZOk
 e7nY3ZdJ0KUXmvZSZtdtaCTj9GYMrJRCGq+2HE9QEhkhwHxPO9WddukZ/swvAzR5uCBn
 xDKGwOyqcxrSIx9+eyCuWgqCOxgYtuez23/NaBy2Uwocu7BpPX1TCfVfFI7TA1z8pVP2
 ALJA==
X-Gm-Message-State: AOJu0Yyr5N2OizKwwqeXI9ZZ8ke4Wy/CUV5F6qj5ivqz2hZAhy0rfUie
 9jV0zHgoxgsgxwyCXVkxog14/ot2/9zBHbVzT71n+30HKo0aNvTv581LKk50GVHA3NYmVqTJ/t6
 d9k6BPABsr8MkA70+ivcKv9o2lJI3m1zMUrGhfDS1JBSQE9XMfGmjUHRK2ztvqTd215GxdSZoJx
 2rw6/nmF9ZdcYJJnmcuUY=
X-Gm-Gg: AfdE7cnACx8eFQSn6tjwlBdWvJZfz9+y0Pjmn2n2cqNCP2I2u7T0jsO1KoMMjGsNvwS
 4vlUtQT2Q+86XwJInQBwdXFvZlF3yrRAVL/fGv2ZtOIquVupPxnncEIQi7SioIxq8ddCBLMpdbs
 0TMxCkb0i/G5jVPyuoSvWN1bHPknml0BuzW/s1Ai+wcSV7MGoA/lwvaD+hUqACMd+1/V0fZDpjk
 Axrvp56/+pjT9hK7gy2CQqanSWVgPq1/u0vMdFED66WAhH27sLLBkBVtsY=
X-Received: by 2002:a05:6512:61d8:10b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5ad4dac4484mr673892e87.26.1781779019445; 
 Thu, 18 Jun 2026 03:36:59 -0700 (PDT)
X-Received: by 2002:a05:6512:61d8:10b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5ad4dac4484mr673880e87.26.1781779018873; Thu, 18 Jun 2026
 03:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080949.1658507-1-maxime.peim@gmail.com>
In-Reply-To: <20260617080949.1658507-1-maxime.peim@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 18 Jun 2026 12:36:46 +0200
X-Gm-Features: AVVi8CfoShqlS_f5Xh9sK-rZ0l-tLCTNKdKvvUwMRY8ech04rlbJ9Zx4ReUsFPc
Message-ID: <CAJFAV8yVo8hL2dKa6ATK4xssGaTTenbCJMOH=N0_12yqboe8QQ@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0FizYAipnplHNGT00Ve7uWebMp9DX6m7OXJhV9WaiEw_1781779020
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

On Wed, 17 Jun 2026 at 10:10, Maxime Peim <maxime.peim@gmail.com> wrote:
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
> Fix by tracking currently allocated core_index values in a bitset and
> assigning non-EAL threads the first free index. Keep the bitset in sync
> when initial EAL lcores are configured, when EAL core-list parsing
> remaps lcores, and when non-EAL registration fails or releases an lcore.
>
> Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
> v2:
>   - Track allocated core_index values with a bitset instead of deriving
>     the next non-EAL index from lcore_count, avoiding duplicate indices
>     after non-EAL lcore release.
>   - Keep the bitset in sync when default EAL lcores are discovered, when
>     EAL lcore options remap the active set, and when non-EAL lcore
>     registration rolls back or releases an lcore.

Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks for this fix Maxime.


-- 
David Marchand

