Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D3C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2803402B0;
	Tue, 22 Sep 2026 15:59:49 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 46D2D400D5
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:59:48 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so2962513a12.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790085587;
 x=1790690387; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aIRw389lNlSKDRgdIwqm1EqXisCxj/Ni4sAK+EfP2wY=;
 b=DQva1CEbcGuiGMrNhw4ke0Mzg8GWEBJ+/hH6BMdtThD3JAIN3Hoe2HVHdY+Jv8hv8P
 bvPgrFZxH2i0faWZnJhe/wgSYcUvUg5pF664GT1RDv4PoPGIZKQpF/NF7dfTCszUpBkO
 Md3qmSFeFJZLDDcWrWQOzEfZcaNP0/O35ZeYfB7cNTvnYKi0vjR3prpHz0Zi5TtiXIZ6
 mFDun/ECZVbLXG6daD/pA61B9OOCUq0IUkMHgLEK5AFlzXGJ0J+RaVneNHIi7q5pBnv2
 mMAhlUQCCmmaHWsC8E33HE92Mf0fBIlPPBZH/nv7t/L3wAwVyYxuSiSLiHdMi71eKWaD
 MFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790085587; x=1790690387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aIRw389lNlSKDRgdIwqm1EqXisCxj/Ni4sAK+EfP2wY=;
 b=VuDkc7fFyuSeVMCHVoQC1NRnLYnm5FsjksKbmZQCXIRiYlrBtd5ZGvv2AR3C/AkCyh
 Pg9tZh3uHy4+YxeEhotvavWuZR9b6/j60dOceiXBq6ssssNZOl7f8rRY6fYTcJbAf4wG
 DBfk/XzvvyE/raXeMaZ+0eDY5C0ceocCrUmoCa8RnHU/L9MVbbsy4afEHJY5H88vQrZ4
 yAxDN2oaBWt6tVecflTZdA0jAHNWfmLaLEgA60vdCEhDrHiOczpylwYKdKfK0C2i16CK
 tfQteR76w9Smfn9NeXLx7lLFFsFgyrCoZRXoFOVkcbwUYEW7iYO4Ua0zADnbZHnsQ2Mv
 a1dw==
X-Gm-Message-State: AFuF++kgZgbzJ45IXEVOo/KYn9/XOqPM/kd3rvcZCFWhdHU+1eO6BjYM
 VzPC8hJVeMA4QQfW5aWXMzTqdsKbFAPVuR4fYNWm7SQSMbs5bpQbZoVcGrMEN7RV1Gk=
X-Gm-Gg: AYBFou1eTOhFyHbfSHITjhHLz2R5CXO9BijcGxtYCoYJNvW+GLZArXMkioI8gSCUB2C
 CzWtauErGzFk99GvP9EnFREWg+q/T22CevfWAisQ+VII5omQHssxPSLbfnnPwBuSEbuKleuNUcE
 b2QIMhJoIoxLe+jyenMp0ujC2Nvr7bSbsfd8uCdXAYfP5LZQAa7iBFZTP02quhM5rsaTRtkt/pv
 s5PSxSkkjDfNEJ8Gz9/O4UfwaK5JcupBVl0eqqCxoSiuBtdndfGEKNt9g3+XwzmSdd4beUoTLQn
 xBNTQ7/CRQTucQ4Pzpy+c/b9NgxfLZ5Wuf8ZWGymoW3lKkw9p9fcd1qfRvONtrZVgtMYXnRP3Ry
 cFAKGCr0bEXJt0PEdrRjDAD9duEvda4dkar4lizn5ffYglfGBiAyRVHNPL+6yGyYf6zEMEuSIYQ
 qTTstwkUe8mEM1iKKLkKO6KeoeCiPeWzTm/ALCjIwhxJxnHejc3LZdbykZua+p3YfywZXkVrf6e
 YNDS6e1e6HPYfGB2avtT0P1o3HdUBC3IBpMV9E6Uy5+EV+0Q20=
X-Received: by 2002:a05:6a20:5483:b0:3d1:e510:905f with SMTP id
 adf61e73a8af0-3ddec5f0eb4mr1985480637.1.1790085587135; 
 Tue, 22 Sep 2026 06:59:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756b6344asm1029320a12.32.2026.09.22.06.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:59:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:59:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4-S1 0/5] dpaa2: bus, DMA and mempool base fixes
Message-ID: <20260922065945.2f5a43c1@phoenix.local>
In-Reply-To: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
References: <20260915113422.4166287-1-prashant.gupta_3@nxp.com>
 <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
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

On Tue, 22 Sep 2026 14:51:53 +0530
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
>  drivers/bus/fslmc/fslmc_bus.c            |  92 +++++++++++---------
>  drivers/bus/fslmc/fslmc_vfio.c           |   3 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |   5 ++
>  drivers/dma/dpaa2/dpaa2_qdma.c           |  44 +++++++---
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 103 ++++++++++++++++++++++-
>  5 files changed, 191 insertions(+), 56 deletions(-)
> 

Several issues reported by AI on this series:

[PATCH v4-S1 0/5] fslmc bus, dpaa2 dma and mempool fixes

Applied to main (6bbb7b3). Per-commit build with -Dwerror=true passes
for all 5 patches (x86, gcc 13, bus/fslmc, mempool/dpaa2, net/dpaa2,
dma/dpaa2, crypto/dpaa2_sec, event/dpaa2).

Series-level:
Three of five commit messages (2, 3, 4) do not describe the code in
the patch. They read as carried over from an earlier revision.
Rewrite them against the actual diffs.


Patch 2/5 bus/fslmc: reduce probe-time logging and MC traffic

Warning: the body only covers the NOTICE -> DEBUG change. The
dpaa2_hw_dprc.c hunk, which skips dprc_get_connection() for blocked
devices, is not mentioned. Split it into its own patch or describe it.

Warning: the skip tests only devargs->policy == RTE_DEV_BLOCKED. With
an allowlist (-a, or no_auto_probing), non-listed devices have no
devargs and are still queried over MC. Use
rte_bus_device_is_ignored(&rte_fslmc_bus, dev->device.name), as the
pci, cdx, auxiliary, platform and uacce buses do.


Patch 3/5 dma/dpaa2: fix array-bounds warning in dequeue path

Warning: the commit message describes a per-queue idxs[] scratch
buffer and merging the LONG and SG fle_sdd handling. Neither is in
the diff. The patch actually does two things. It rewrites
qdma_cntx_idx_ring_eq() as a two-part memcpy with wrap. It moves the
SG fle_elem append after the ring enqueue and returns fle_sdd to the
pool directly on -ENOSPC. Describe those changes. Also name the
compiler and version that emits the warning.


Patch 4/5 dma/dpaa2: validate IOVA in pre-populate helpers

Warning: subject and body describe changing fle_sdd_pre_populate()
and fle_sdd_sg_pre_populate() to use DPAA2_VADDR_TO_IOVA_AND_CHECK()
and return errors. Neither helper is touched. The diff adds a single
rte_mempool_mem_iter() check of the fle_pool at vchan setup. Fix the
subject and message.

Warning: the new error path returns -ENOMEM without freeing
vqs[vchan].fle_pool. A second vchan_setup on the same vchan then fails
in rte_mempool_create() with a name collision. Free the pool and
clear the pointer.


Patch 5/5 mempool/dpaa2: support ops index from primary in secondary

Error: rte_dpaa2_mpool_get_ops_idx() is called per op in the
dpaa2_sec enqueue fast path (dpaa2_sec_dpseci.c:1544, :1903). In a
secondary it now issues rte_mp_request_sync() with a 5 s timeout
whenever the cached value is still RTE_MEMPOOL_MAX_OPS_IDX. That is
the steady state when the primary has not created a dpaa2 pool,
because the reply is the sentinel and nothing is cached. The result
is a blocking IPC round trip per crypto op, from multiple lcores
concurrently, and a 5 s stall per op if the primary is gone.

The IPC is not needed. Mempool ops are registered by constructor in
the same order in every process, which the multi-process mempool
model already depends on, so the index is process-invariant. Resolve
it locally in the secondary by looking up the "dpaa2" name in
rte_mempool_ops_table once, and cache it. That removes the IPC
channel, the action registration and the atomic.

Warning: the reply handler path does not check
mp_reply.msgs->len_param before memcpy from msg_data.

Warning: on rte_mp_request_sync() failure the function returns -1,
not an errno.

Info: rte_mp_action_register() returns ENOTSUP for --in-memory and
--no-shconf. That is a runtime condition, not "no secondary process
support enabled at build time" as the message says.
