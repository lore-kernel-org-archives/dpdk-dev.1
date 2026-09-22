Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CBBC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E8EB402B8;
	Tue, 22 Sep 2026 15:54:41 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 16D29400D5
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:54:40 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so3796107a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790085279;
 x=1790690079; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5uCafkbQtDcRZ6nnnXXz32JzVIZr5So0GPwdlXRO5dw=;
 b=bUrQDaexgH9MjLYw9Kggms2yq4NASfqgYIbzNteeudCe/5ZELxLP7sxhTfnzoQeYco
 ToF2b1xI7FE1C0oSa2ZV+iE5Mp7aBdu0uLaHLEQO9dPLJim6He7q+YzAytMKbjMLKod0
 oY7G8tnAzRqCrQZsp82PM6SqBSrOVqIhN5lADSEsdgiiP/CCkRs0InwjAfaU14qAiHB9
 6989nOeJxOq4lnzODEOA7ZN0f/Kabl6o4i7ghPxlZE702mJOYdospSDwHkNqEO58UmVB
 DmeQoH7+AfaXUVZSIVBN39Bnxp7PSAQkAKydFt2zPAmRBGBme3Sbc14P8gtGe/NWCSCf
 stqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790085279; x=1790690079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5uCafkbQtDcRZ6nnnXXz32JzVIZr5So0GPwdlXRO5dw=;
 b=R1ggYVtynLonhPQC3geIjBC8gYylX4VRYryaPQ0of3T/nfXyeNhv8PGdDeEcBKEEK+
 nWuKq4EYdnTL7WsAhPenVd7ImRZg1dC/+ElE2OU855I30pDO6oJMZV/ovj0id8LA92v2
 vv4BVvgnEVukc5ssHOo6GHqixJPkM6OeKfL+onOrT8WyQ9gNRQREIfufjlkxJx4lKvU8
 mju+PSAsd4FXFnBv8a8DMxxQ+FHow1Ajd0fu5aQMNQ314DQwApcr/XMlGkxzrpxG652h
 Ptm/OykUuKsfvAG3RoN6iDeaoKuX8IveXfW8tfGDW/fFfeInTY20uJeZSXzOM/2kmURX
 yfTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXT5mczxJMmwcYH7HxchcYGx/67Zy3EK6hC3ULZiSwWj0MJHR4KMXuOi0sZ1UK5KMpAlU=@dpdk.org
X-Gm-Message-State: AFuF++lk5DO/z+JlG/uJBEk6FzAN5hPSkny3Ux2s6k/noiPmoND2WMHj
 FsfS0SLZ6q9Rq6bFZ4liNVwnzrfivQZ/Xosgw7vUVJFWzDKOqnqS5otnLcPXvCIOdM6LlUZlTBl
 08dr0
X-Gm-Gg: AYBFou3rGD4fWwYWdOPitS+sjOFATmcisLbhNsM4d1BpcUcPTZbrJtIXttvraK03hmP
 eZhUed0hYMaQwuEPhm7YLXqColYp/Km6IDkfDx0Ci3jf9ilcOcrtcrsozyQJIGcMi3gYpA495ky
 6tXO7h8AuE/FHuz1El5s95zv/ggZ49opDgNw4y+fbQObO1nOd+SyaO87PivjDZZdlq+0W+wsfEh
 EuC47Iud1cqsy8tzx5uQv/KmPITUht++W5tXxE7BczrliWFlHBJ+vJAbZx4fUj5792O0B6KaKTi
 MLBycqDIT36CCA9o8GhsX/UO4OW/QuI42mqL3Y3rCK8vwDVGRN6bCRk/y8qXDlSMW7N70fVm8ZV
 zv+XeEb5bh8z8WrKtbHIz99F3JbYdzzIPy4/0EGec7Md0KnChMFjlogBm0KibNNkJPprCMtVG+W
 a4saEZ2q8nN3rcSqgswQ7aey8wXdCLne9rJ0mI81ukKDyfFlCGreDic08+/vhLM+EsjG7wYxJTN
 D8fhhulbgUfBsCfasQUodLfbJkw9cn5gfTXLOJx
X-Received: by 2002:a17:90b:264c:b0:39e:6c68:1552 with SMTP id
 98e67ed59e1d1-3a07320e566mr1130857a91.26.1790085278989; 
 Tue, 22 Sep 2026 06:54:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06e26e70asm4545951a91.1.2026.09.22.06.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:54:38 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:54:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nam Tran <hoangnamtran18122005@gmail.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org
Subject: Re: [PATCH] mbuf: avoid temporary array for bulk free
Message-ID: <20260922065437.2e3f5c15@phoenix.local>
In-Reply-To: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
References: <20260922012856.30090-1-hoangnamtran18122005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 21 Sep 2026 21:28:56 -0400
Nam Tran <hoangnamtran18122005@gmail.com> wrote:

> rte_pktmbuf_free_bulk() currently stages freeable mbufs in a
> temporary array before returning them to their mempool. For flat
> packet arrays, this requires copying pointers even though the
> original array already contains contiguous freeable mbufs.
> 
> Track contiguous same-pool runs in the input array and pass them
> directly to rte_mbuf_raw_free_bulk(). Flush a run when encountering
> a NULL mbuf, an mbuf retained by reference counting, or a pool
> change. Preserve the existing array-based implementation as the
> fallback for chained packets.
> 
> On an ARM64 Linux test environment, same-binary A/B measurements
> using rte_rdtsc showed lower median timer ticks per call for flat
> bulk frees:
> 
>   burst  32:  2.05 ->  1.50
>   burst  64:  5.16 ->  4.52
>   burst 128: 11.16 ->  6.90
>   burst 256: 26.46 -> 19.73
> 
> This corresponds to reductions of approximately 12% to 38% across
> the tested burst sizes.
> 
> Add coverage for NULL entries, mixed mempools, and shared mbufs.
> 
> Signed-off-by: Nam Tran <hoangnamtran18122005@gmail.com>
> ---

More detailed AI review (Claude Opus 5)

Subject: Re: [PATCH] mbuf: avoid temporary array for bulk free

Warning:

lib/mbuf/rte_mbuf.c: runs are unbounded. The old code flushed at
RTE_PKTMBUF_FREE_PENDING_SZ (64). Now a same-pool run can be the whole
burst, and rte_mempool_do_generic_put() sends any n > cache->size / 2
straight to rte_mempool_ops_enqueue_bulk(), bypassing the per-lcore
cache. With a 256 entry cache, a 256 burst that previously went into
the cache in 64 entry chunks now hits the ring every time. That is
cheap on a single lcore, which is what the benchmark measured, but is
shared ring traffic with multiple lcores, and hands back cold objects
instead of keeping hot ones in cache. Cap run_count at
RTE_PKTMBUF_FREE_PENDING_SZ and flush when reached.

Benchmark: rte_rdtsc() on arm64 reads the generic timer (cntvct_el0)
unless built with PMU support; a delta of ~0.5 ticks per call is at
the resolution limit. Please state the timer frequency, the mempool
cache size used, the number of lcores, and include x86 results. The
test pools in test_mbuf.c have no cache, so they do not exercise the
cache path at all.

Info:

The flush sequence is open coded four times, and
rte_mbuf_raw_free_bulk() is __rte_always_inline, so the function body
grows accordingly. A small static helper or restructuring the loop so
NULL, not-freed, and pool-change share one flush point would be
cleaner.

Tests: add a case that mixes flat and chained packets in one array
(flat run pending when the chain is hit, then flat after it), and one
with an indirect (cloned) mbuf in the flat path. Current tests do not
cover the transition into __rte_pktmbuf_free_bulk_fallback() with a
non-empty run, which is the new logic most likely to break.

Nit: the blank line added after "m = mbufs[idx];" in the fallback is
unrelated churn.
