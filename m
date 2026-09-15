Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1940C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3C1440B91;
	Tue, 15 Sep 2026 17:24:37 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 1BE6440A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:24:36 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db22383fe8so24258025ad.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789485875;
 x=1790090675; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CTUCnaPPqC04NbXuLY1KN0ehxONjVp+tzHU2EwGmaQA=;
 b=iP1ROknOlP4sJ3Og1KLW07AoILS1HIsFVkZrUI618ysdtJ5Pj44FzpIyiQZmnWR0H+
 JALEaoFOgCRqTz8MEBgfpzKTd1S7ziiXihhj0QZi0ksJjgG1RnPWyLm8a+BAcrscK9Rh
 mc45G8E2ZswlkQtkpbUwIUGLWSAG4HDdrdkOM6tkuXA28F7OpZBSrg3R49OjRsselUmn
 X71Y+tWGzDkO4SjDpGTYTBuCf6gGfwm5zjceDllBvOu575KEsbofVo9hwa1TTjmBZVYD
 HDQ8QvhDL9AnANo7+neZ0+DsF4uHQ3KHMj7QpS1NZacXuEETP0r3quN2tK5ebWB6ApOA
 pYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485875; x=1790090675;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CTUCnaPPqC04NbXuLY1KN0ehxONjVp+tzHU2EwGmaQA=;
 b=C3P4sstX68AXDuvCuN3oo+N4/W+MjZKlyyEmlC/8LiR1XsA13UofPyxtrQv01CzO30
 IbB0TM0oHHq1cirrp7sqU9mDVThBhI6+MXzDcgDvMpCHL0wCaooFaX7ZAWqP8bguhGye
 +zg/s5slbgVJMJfpjJzINUqrwXpZIA0IsD+TixfhdaL5fV9gGc00gkS7+RO2Jq0lp9Y1
 fMnUBOB+GeA7575s9YnA/9HJS3M9YkrpLcz8MyEAP/8fIIq4uAco/XPZYtzRUzUSReJB
 GrHFNh8EYMXhxR+GQ9SPS2FiA11I+ExETinn+LgZ+r2BU81DgYs5v6hV4NxgjXzqTMYW
 wW5g==
X-Gm-Message-State: AFuF++lXb0cTuIKT3XS1Jkp46iH6vRN1JqIhv6AhGUfh22fl6NODki1H
 ChjbltVAgrLuLs2bYVpH1dwdgrFl98sLhem4nFUM949sZahLfTh5Cf2roKgqPmjq791a/OaQTgT
 YwNJWkNz4AA==
X-Gm-Gg: AYBFou1LWJoVEonj2YRHFHMHgJIjsfUMhOPmj0Q9xo2LLVhE4CRCfLLA4g0V65bDIfU
 SC0/tw4dJWDFGF/DF69hZSviOjxKqEyigFXKSw+oJe3mMl+V8tExr0JWDgSaiddvWIs6+4P+mjl
 9wa50ku0eVI9AQOozQrjFx+3VlfOSLIidVOP8VYsAIHEnUgx9bAkXdXfcljhLGsVrkaW1kBpHF8
 tFM+sFQB/5O0YSxoMnhIgAij9Kf5tN9CsjbIsa3Futz7IeSQWUN9fOg8L8dKJKQjm90Oionj3u8
 2NAal+WAMHfHDYmq8tDpkT57Kq/yu/EIgc5AUaP7rUB1oracsU21Sb2cmWm8deXCgt007iWQYaE
 aIh1yZP/Fr9RXKdBmYZx+UlWD9011r/vcP+uItdGfaDj6vRDWL1YItYjbvbpWoV7m6H71vwNwxv
 PkMY4VIvJGWnTJIMD5wVBms50pO4oupU3MgqHZtuFslIPbVYLZAobyt7fEmqG3IfzezLb0OzLib
 w8pGP2Yu+71NZsp8/fgy0GkaZ2c7md8/kJHZnGZxA==
X-Received: by 2002:a17:903:320e:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2dd6c5eebcfmr184555635ad.6.1789485875190; 
 Tue, 15 Sep 2026 08:24:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2ceb6861sm68791605ad.36.2026.09.15.08.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:24:34 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:24:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3-S1 0/5] dpaa2: bus, DMA and mempool base fixes
Message-ID: <20260915082429.3f23410f@phoenix.local>
In-Reply-To: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
References: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
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

On Tue, 15 Sep 2026 17:04:17 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series is the first of four that upstream the missing NXP dpaa2
> driver changes. It collects the foundational bus/fslmc, dma/dpaa2 and
> mempool/dpaa2 fixes that the later series build on:
> 
> - defer fslmc bus initialization to probe and reduce probe-time logging
>   and MC traffic,
> - fix an array-bounds warning and validate IOVA in the dpaa2 QDMA
>   pre-populate helpers,
> - support fetching the mempool ops index from the primary process in a
>   secondary process.
> 
> Every commit builds cleanly (including the aarch64 DPAA cross build with
> -Werror) and the series is bisectable.
> 
> Gagandeep Singh (1):
>   dma/dpaa2: validate IOVA in pre-populate helpers
> 
> Hemant Agrawal (1):
>   bus/fslmc: reduce probe-time logging and MC traffic
> 
> Jun Yang (2):
>   dma/dpaa2: fix array-bounds warning in dequeue path
>   mempool/dpaa2: support ops index from primary in secondary
> 
> Prashant Gupta (1):
>   bus/fslmc: defer bus initialization to probe
> 
>  drivers/bus/fslmc/fslmc_bus.c            | 92 +++++++++++++----------
>  drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
>  drivers/dma/dpaa2/dpaa2_qdma.c           | 96 ++++++++++++++++--------
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 95 ++++++++++++++++++++++-
>  4 files changed, 209 insertions(+), 77 deletions(-)
> 

Detailed AI review finds errors

Review: [PATCH v3-S1 0/5] NXP fslmc/dpaa2 fixes
Base: main f43632a (26.11.0-rc0)

Series applies cleanly. Per-commit build of bus/fslmc, mempool/dpaa2,
dma/dpaa2 with -Dwerror=true passes at every commit.

Series summary
--------------
Patch 5 does not work: the IPC reply is parsed from the wrong offset,
so every secondary lookup fails, and the lookup sits in the dpaa2_sec
per-op enqueue path. Patch 3's commit message describes a change that
is not in the diff. Patch 1 reverts only half of cdefd2e980bd; the
DPAA bus has the same problem.


Patch 1/5: bus/fslmc: defer bus initialization to probe
-------------------------------------------------------
Warning:

cdefd2e980bd moved init into scan for both NXP buses. Only fslmc is
restored here. rte_dpaa_bus_scan() still calls
rte_mbuf_set_platform_mempool_ops(), which does
rte_memzone_reserve(), and dpaax_iova_table_populate(), which does
rte_zmalloc(). EAL runs rte_bus_scan() (eal.c:680) before
rte_eal_memzone_init() (784) and rte_eal_malloc_heap_init() (802), so
bus/dpaa is broken the same way. Fix both in this series, or say in
the commit message why dpaa is unaffected.

Info:

rte_fslmc_probe() returns 0 on every init failure and skips
rte_bus_generic_probe(), so a VFIO or DMA map failure results in no
devices and a zero return from rte_bus_probe(). This is the
pre-cdefd2e980bd behaviour, but now that the function is being
rewritten, returning ret would let EAL init fail visibly.


Patch 2/5: bus/fslmc: reduce probe-time logging and MC traffic
--------------------------------------------------------------
Warning:

The subject says "and MC traffic" but the patch only changes one log
level. Either drop that part of the subject or include the MC change.
Also fslmc_map_dma() is called from the memory hotplug callback, not
just at probe time.


Patch 3/5: dma/dpaa2: fix array-bounds warning in dequeue path
--------------------------------------------------------------
Error:

Commit message does not match the patch. It says an
idxs[DPAA2_QDMA_MAX_DESC] scratch buffer is added to struct
qdma_virt_queue and idxs[0] is used instead of &idx. Neither happens:
dpaa2_qdma_dq_fd() still passes &idx, and dpaa2_qdma.h is untouched.
The real change is rewriting qdma_cntx_idx_ring_eq() from a per-element
loop to a two-segment copy. Describe that, and state which compiler,
version and target emit the warning, since a Cc: stable fix for a
warning needs to be reproducible.

Warning:

New code uses rte_memcpy() for small variable-length copies of
uint16_t. Use memcpy(); rte_memcpy is being removed from non-datapath
and small-copy users tree-wide.

Info:

Merging the LONG/SG fle_sdd handling is an unrelated cleanup inside a
stable backport. Split it out, or drop it from the fix.


Patch 4/5: dma/dpaa2: validate IOVA in pre-populate helpers
-----------------------------------------------------------
Warning:

The check runs in the enqueue path. On failure fle[SRC].length stays
zero, so every subsequent copy on that object re-runs
rte_fslmc_cold_mem_vaddr_to_iova() plus rte_mem_virt2iova() and emits
DPAA2_QDMA_ERR, flooding the log at packet rate. fle_pool is created
by the driver in dpaa2_qdma_vchan_setup(); validate the pool mapping
once there (e.g. rte_mempool_mem_iter over mp chunks) and fail
vchan_setup, instead of checking per object on first use.


Patch 5/5: mempool/dpaa2: support ops index from primary in secondary
---------------------------------------------------------------------
Error:

Reply parsed at the wrong offset:

	rsp_msg = (void *)mp_reply.msgs;

mp_reply.msgs is struct rte_mp_msg *, whose first member is name[].
msg_type is read from the bytes "dp" of "dpaa2_pool_mp_sync", never
matches DPAA2_POOL_OPS_IDX_RSP, and every request fails with "received
invalid response". Must be:

	rsp_msg = (void *)mp_reply.msgs[0].param;

Also check mp_reply.nb_received == 1 rather than msgs != NULL, and
check len_param before copying msg_data. This path has clearly not
been exercised.

Error:

rte_dpaa2_mpool_get_ops_idx() is called per op in
dpaa2_sec_enqueue_burst() and the ordered variant
(dpaa2_sec_dpseci.c:1544, 1903). In a secondary, whenever the lookup
fails, s_dpaa2_pool_ops_idx stays RTE_MEMPOOL_MAX_OPS_IDX and the next
op issues another rte_mp_request_sync() with a 5 s timeout. That
happens always with the bug above, and also whenever the primary has
not created a dpaa2 pool (no action registered, primary replies
MP_IGN, nb_received is 0). A blocking IPC must not be reachable from
a datapath function; resolve once at init and cache the result,
including failure.

Warning:

The IPC is unnecessary. The mempool ops_index stored in the shared
struct rte_mempool is only valid because primary and secondary
register ops in the same order; the secondary already dispatches
through its own rte_mempool_ops_table with that index. The secondary
can find its own index by scanning rte_mempool_ops_table for
DPAA2_MEMPOOL_OPS_NAME, which removes the handler, the message
protocol and the timeout entirely.

Warning:

Missing Fixes: tag. The commit message describes secondaries failing
due to the unset index.

Info:

dpaa2_mbuf_pool_mp_primary() returns -ENOTSUP on an unknown type
without replying, so the requester waits the full timeout. The action
is never unregistered.

Commit message: rte_mp_action_register() returns ENOTSUP when IPC is
disabled at runtime (--no-shconf / --in-memory), not due to a build
time option.
