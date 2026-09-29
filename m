Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCEC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EF4041133;
	Tue, 29 Sep 2026 17:45:29 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id 296EF4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 17:45:28 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4bd597d68so12351a91.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790696727;
 x=1791301527; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TDTfTI2nGlsWydIVaqkSKtsRa5CV3lIa8guKiF4JKDQ=;
 b=Pp53TIScAy9W08NrzSnyqPTXita+Ruxtk+aQ8lfm/XSOovq3CzaFU+69PpltP5C7DG
 KwxrGzfSp8t6f62AuJyx4D7DTzdeKqJA81e2Z7FIumQ54YyrZPcgJN8/BRkBe8v8lvUz
 rOi5KFuz4ldxAD/4sICueuoQJB/huTZWyT0GlwaFo8jAyrEBGTjZgrwg9rjh5YEHu7nv
 za5H6hSXIOJF5h17ejjXK4LI6VuzPUVmdEUcqFSM7ca8fDjhDecuMftU44+DHYXj53Hd
 zvu6aBTKZgq5mqQ4WNVodijF/mFocLW4nTEdS+DZTBmtEtBkKElyxlt6tXFxrPPHOcSv
 bE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696727; x=1791301527;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TDTfTI2nGlsWydIVaqkSKtsRa5CV3lIa8guKiF4JKDQ=;
 b=uirYo6at73zQgNMxsy5omMjmCmmpMW2a2sw3ADyclRruWHWA2rX2LsHL0QmL/im0pw
 L1FHJPtD05PbprQP/r5VSln6c9lgIx1+lOBTsQnMTi9bOpKtAc0KeikB2gNvhJPDcECq
 Vlnb4eUUaCQggCfClI3euZDZZ35DwSJTPN5DHo17QpQcxHR+DNQEcqaoDn1/ZwAs7Z5J
 H+5ZDbdspO5480A4HMHN7ZfqmGNjgYvfeiT8CnI1+HLyXZ4sa+7IysVUbbt+CrUm5dNP
 Ss2K7JNy6ruPW2cSKRN+SJOkK4XGeYAPdTxNFVuKJTE0YiQfAhz/ztcmzY7jSGYq9i8z
 2zYw==
X-Gm-Message-State: AFq9FYLbyWiLIpypjgaPyLPwUSSfAIPtvsZvR5q6JCGj/FJlTx4uLJgK
 3a6wdHH39D0zgOO2XfCr8bkyJbASZwsjVnOXFDwkq1FBcA9beOWdofANoTUmbHCfOlo=
X-Gm-Gg: AYBFou3cFxw3p3TRfUv6pBOOLNaPDswwUYfL1ydagZPs8T9GDOC3V8mUjn7z+G9AQLJ
 JbEC/XKFOEQT4Hn6qBlSPe9y8P3xWC2EOxgnb7UmKbzMCLH9IMpjox1f2Me+9ngV7gJZ+3ogmFG
 3QM5xhDGtY9jcJat1tmP1vTuqcW4e8C6pOCVtLanxqI7leN4Sdcyt5Lpl1PEavth52oc8kx7No6
 zkjrAI5gvTwMMPdK5d7ywz6v1b5JPTs8XT4JyMdSea6QNSOcmo03T0VuU22G2xsMMyz3LajrzYi
 Z0sEeaeF8GznKatHraZU6qG26TbNTTTeF4cPlh7PSVUydyYDiCx7knh4uQtqPAc/Cbc2bie+AQo
 R/Baj+f+dJBjmZrM2Wt3zXPqbd/sBkply5V1ay3urS+YA2jjuQKKlqn48+tSFLUoGCS+VJvz03p
 3678AQbvMKZYRHr8nEN5+/59EVPcFNT7agCIVLgCtFGbCo7sIjbdaukbAdggX7SuP95Q+/aT7LX
 4zCc/N6RNFzs0VqfYS4ZeOTQUaWyQA8hBfiSpbz
X-Received: by 2002:a17:90b:58ee:b0:3a4:9859:9749 with SMTP id
 98e67ed59e1d1-3a498599f39mr3007671a91.38.1790696726843; 
 Tue, 29 Sep 2026 08:45:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49c1afb23sm6457890a91.16.2026.09.29.08.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:45:26 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:45:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5-S1 0/5] dpaa2: bus, DMA and mempool base fixes
Message-ID: <20260929084523.4119cf81@phoenix.local>
In-Reply-To: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
References: <20260922092158.2340839-1-prashant.gupta_3@nxp.com>
 <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
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

On Tue, 29 Sep 2026 19:51:12 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series is the first of four that upstream the missing NXP dpaa2
> driver changes. It collects the foundational bus/fslmc, dma/dpaa2 and
> mempool/dpaa2 fixes that the later series build on:
> 
> - defer fslmc bus initialization to probe; reduce probe-time logging
>   and skip ignored devices during DPRC population,
> - fix a GCC -Warray-bounds warning and an SG FD double-put in the
>   dpaa2 QDMA dequeue path,
> - validate the FLE pool IOVA mapping at vchan setup and free the pool
>   on failure,
> - resolve the mempool ops index locally in secondary processes by
>   scanning rte_mempool_ops_table, removing the need for IPC.
> 
> Every commit builds cleanly (including the aarch64 DPAA cross build with
> -Werror) and the series is bisectable.
> 
> Gagandeep Singh (1):
>   dma/dpaa2: validate FLE pool IOVA mapping at vchan setup
> 
> Hemant Agrawal (1):
>   bus/fslmc: reduce probe-time logging and skip ignored devices
> 
> Jun Yang (2):
>   mempool/dpaa2: look up ops index locally in secondary
>   dma/dpaa2: fix array-bounds warning and SG FD double-put
> 
> Prashant Gupta (1):
>   bus/fslmc: defer bus initialization to probe
> 
>  drivers/bus/fslmc/fslmc_bus.c            | 92 ++++++++++++++++++--------------
>  drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |  4 ++
>  drivers/dma/dpaa2/dpaa2_qdma.c           | 46 ++++++++++++----
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 25 +++++++--
>  5 files changed, 113 insertions(+), 57 deletions(-)
> 

Several AI errors here. 
I think it is complaining that From and Signed-off-by don't match.
If you are managing these with git the problem is that you merged patch
but the author field didn't get set to match.

[PATCH v5-S1 0/5] dpaa2 bus/dma/mempool fixes

Series

Warning

  Prashant Gupta sent patches 2-5, but they carry only the original
  authors' Signed-off-by. The submitter needs to add his own
  Signed-off-by to each one (DCO clause c).

Info

  cdefd2e980bd made the same scan/probe move for bus/dpaa, and that
  bus has the problem this series fixes for fslmc.
  rte_dpaa_bus_scan() calls rte_mbuf_set_platform_mempool_ops()
  (memzone reserve) and dpaax_iova_table_populate() (rte_zmalloc)
  before EAL runs rte_eal_memzone_init() and
  rte_eal_malloc_heap_init(). Both return values are ignored.
  bus/dpaa needs a matching fix.

  Patch 1 reverses part of cdefd2e980bd (the move to generic probe).
  Cc David Marchand.


Patch 2/5: bus/fslmc: reduce probe-time logging and skip ignored
devices

Warning

  The commit message says "clean up a redundant variable assignment
  while there", but the fslmc_vfio.c hunk only changes the log
  call. Drop the stale sentence.

Warning

  +		if (rte_bus_device_is_ignored(&rte_fslmc_bus, dev->device.name))
  +			continue;

  This skip leaves ep_dev_type, ep_object_id and ep_name unset for
  devices that stay on the bus. fslmc_vfio_process_group() only
  removes devices with devargs->policy == RTE_DEV_BLOCKED. In
  allowlist mode, unlisted devices stay on the list, still go
  through fslmc_process_iodevices(), and can be attached later with
  rte_dev_probe() because fslmc sets .probe_device. Such a dpni
  keeps ep_dev_type == 0 (DPAA2_ETH, from the calloc() in
  scan_one_fslmc_device()) and ep_object_id == 0. The loopback setup
  in dpaa2_recycle.c then treats dpni.0 as self-connected, and a
  DPMAC-connected port gets -ENOTSUP.

  The commit message does not say what fails without the check. If
  the problem is dprc_get_connection() failing for an ignored dpni
  and aborting the whole DPRC, make that failure non-fatal: set
  DPAA2_UNKNOWN and continue instead of skipping the query. If this
  fixes a regression, add a Fixes tag.

  The log level change and the ignore check are unrelated. Split
  them into separate patches.

Info

  Pre-existing, not introduced by this patch:

  	sprintf(dev->ep_name, "%s.%d", endpoint2.type, endpoint2.id);

  This runs for every device, but endpoint2 is only initialized in
  the DPAA2_ETH branch. A non-ETH device ahead of the first dpni
  formats uninitialized stack, and type[16] need not be NUL
  terminated.

Info

  Pre-existing: net/dpaa2 never assigns priv->ep_dev_type,
  priv->ep_object_id or priv->ep_name. The test
  "if (priv->ep_dev_type != DPAA2_MAC)" in dpaa2_ethdev.c reads a
  field nothing writes, and rte_pmd_dpaa2_ep_name() returns a buffer
  nothing fills.


Patch 3/5: dma/dpaa2: fix array-bounds warning and SG FD double-put

Error

  The SG FD change does not fix a bug. Before the patch, fle_sdd was
  stored in fle_elem[] ahead of qdma_cntx_idx_ring_eq(). On -ENOSPC,
  dpaa2_qdma_dequeue() clears pending, leaves the loop, and still
  runs:

  	rte_mempool_put_bulk(qdma_vq->fle_pool,
  		qdma_vq->fle_elem, fle_elem_nb);

  So the FLE went back to the pool exactly once. After the patch it
  also goes back exactly once, through rte_mempool_put(). There was
  no double put. rte_mempool_free() does not free objects
  individually, so the described "double-free when the pool was
  later destroyed" cannot happen. The DPAA2_QDMA_FD_LONG branch just
  above keeps the same store-before-enqueue order. Drop this half,
  or reword it as a cleanup with no Fixes or stable tag.

Warning

  The array-bounds half does not name the compiler, version or
  target, and does not quote the diagnostic. The pre-patch loop
  builds clean on x86_64 with GCC 13.3 and 14.2 at -O3 -Werror
  -Warray-bounds=2. The loop it replaces came from 07d679bceee3
  ("dma/dpaa2: refactor driver"), not 388e888dc082, so the Fixes
  tag does not cover it. Make it a separate patch with its own
  Fixes tag and the warning text in the message.

Info

  Pre-existing: when dpaa2_qdma_dq_fd() returns -ENOSPC, the FD has
  already been pulled from hardware. Its cntx_idx values never reach
  the ring, so rte_dma_completed() never reports those jobs. The
  early exit on

  	if (ret || free_space < RTE_DPAAX_QDMA_JOB_SUBMIT_MAX)
  		pending = 0;

  also abandons any later results already written to dq_storage,
  because active_dqs is then switched to dq_storage1.


Patch 4/5: dma/dpaa2: validate FLE pool IOVA mapping at vchan setup

Info

  The check confirms each chunk has an fslmc mapping. It does not
  check the property the fast path relies on. Enqueue converts every
  FLE with

  	fle_iova = (uint64_t)fle - qdma_vq->fle_iova2va_offset;

  and that offset comes from fle_pool->mz. That memzone is the
  mempool header (mp->mz in rte_mempool_create_empty()), not the
  object chunks reserved in rte_mempool_populate_default(). The
  callback already has memhdr->iova. Comparing
  (uint64_t)memhdr->addr - memhdr->iova against the offset would
  catch a pool spread over chunks with different VA/IOVA offsets
  (IOVA as PA with fragmented hugepages). The offset handling itself
  is pre-existing.

Info

  Pre-existing: later error paths still leave the stale pool that
  the commit message describes. The two rte_mempool_get_bulk()
  failures in silent mode and the ring_cntx_idx allocation failure
  return without freeing fle_pool. The fle_elem rte_malloc() result
  is never checked and is written in dpaa2_qdma_dq_fd().


Patch 5/5: mempool/dpaa2: look up ops index locally in secondary

Warning

  This fixes a bug from de6a6e897fe6 ("mempool/dpaa2: add operation
  index"), which shipped in 25.07 and is in 25.11 LTS. In a
  secondary process, dpaa2_sec compares mb_pool->ops_index against
  the sentinel and always takes the MAX_BPID path. Add:

  Fixes: de6a6e897fe6 ("mempool/dpaa2: add operation index")
  Cc: stable@dpdk.org
