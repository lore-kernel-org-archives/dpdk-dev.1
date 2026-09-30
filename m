Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E2CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1F2D427BB;
	Wed, 30 Sep 2026 18:07:24 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 16E36427B9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 18:07:23 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7c4c92477so1405579a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790784442;
 x=1791389242; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sOaxEXcS7oPNvE3ssY/FmT5NboGrpQcjbdXH/b/Y1Nk=;
 b=pJYC4E2QDcC4dU8H+BYSoWqEoByfgYRU3kbj0QcpeHRypBXve1efZF3I+75PChPB79
 IHc19VHkTeBt1VPhNB6iqmLOl0PZXXzLQoh/oVjaMAJ2V3tJ77kIAof9fNNSFEvfcWhr
 SQYutWUBMZvJNqRbnyWB8TTys8Dlc6sEb3x6sH7IOoDlC2ONKiZxL54/yb/EkN04qg7n
 PF4DfkrEa6lCoyNVS4WFndu94x0Am/pxkH2giDqhmNZw1jkV++GyEKw6Q9q3HzH2j307
 zemmu6PexRyytVZamcvsYQR/+xhT5boDfe69NneJJB16mcSRi73Vj7Lki7658hDanczt
 uwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784442; x=1791389242;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOaxEXcS7oPNvE3ssY/FmT5NboGrpQcjbdXH/b/Y1Nk=;
 b=h9yM0/K8siglEMnkMXZRZHSMJQ/NbJbkfdMs3dlI2O2mihTPX4GDDWJ4ObcvFKY8T8
 KPLq3zW5F4RR4OtSwOGSx9vErIIC0W/twLsSGqm1swanY48zT7hi6Lgr9liKW3najxdN
 lgwGeLghICczWOQ2GnDqk2HkDiRJXovm5arnrSEQ2+rxhpkIuMDSHaeC2dBWmmf3YCOZ
 lCUY7/V81+Rh3+zWEnfLrBHp9so/EG9iS3ENhSMjM8Jk/ZSHXLjSeCeKIa0T3srVZB1J
 yqI3WwEfsug0Cs2mo1HHg4Amf/0/BNUk+XEJT77h9ZiVoerFI55WAqJV+3umArYNlYmC
 OiCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7lH7Y4wFL6nRqFGGWebnUbfNjnNZ/2BjZjmvKjYKZ8koZKljeZFWAGI0csKXs2xMnKgQ=@dpdk.org
X-Gm-Message-State: AFq9FYJ+SZx4hLHxcrN9yDeVkcF2Bdv20pOvIHV7nvfmVo3zqhxen8Hb
 5J94ap7LC9olwWmVcz6ZHFRPfmJ58YezOd+ypbdzWESH6IZVp+GSvrmSLT2Vi/NrmH6v4J/gdut
 EziLXkM8=
X-Gm-Gg: AYBFou1mzqwdkr1kZd9WlEr2UT3z6MTDE3I2VKSJghh6HL85w5NaUc84y/kJ+hhgy7/
 7f16eyEJJQxi7Kh+drUVIpWvZ++dbPiGdPb9JOFwmZJNwfd0ocI0DfHrrDEvzZ0bOfcOLkplnMT
 zHyUFkY8Z7Okh/juOc9TMqbayCe/apm+JWeV3c8svlQNX7UxvGScu1YPYHgQHfpMLzKoGT4m08X
 zIoFh+8q4A+elvuHYBlybJ28Wv2F3NtDsVkIu/BV8lJVVJWM44kyTuMtPPnE65ysAObKaj8Eudw
 hY+E+C8ntORZ5TLtPWqcPMs9+xtdGTjH3tsuTb7zIzfmhemxgECPO5uzcrtZvjuIn5QGFOEsoxc
 nuVsp1D8HfyN5GVdZXZ8JNwetmLtW4wxVQe2xFSOWzM83ZR+LWybCHRwlDH4iSNn4JVU72hQFHY
 v/rHLWX/y6sS21VbTD2m1n0gxvyU7YY/r4IRF1NAxJSgYZE/OxhRxNbj+CYFH2m5HVYuLuXdUGx
 3lk99zMeWTjOy77syCK405AEciYgwsG/8Sxi03A
X-Received: by 2002:a17:902:ce12:b0:2df:83ce:724f with SMTP id
 d9443c01a7336-2e2e4b40c51mr14583895ad.30.1790784429465; 
 Wed, 30 Sep 2026 09:07:09 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5b89f57sm10126765ad.27.2026.09.30.09.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:07:08 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:07:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Message-ID: <20260930090707.7d0891c0@phoenix.local>
In-Reply-To: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
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

On Wed, 30 Sep 2026 11:54:13 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v18:
> * Dropped the "net/dpaa: fix device remove" patch. It papered over the
>   symptom in rte_dpaa_remove() instead of fixing the cause, and was
>   replaced by the two fixes now at the head of the series.
> * net/dpaa: fix the double dpaa_eth_dev_close() call and the eth_dev
>   dereference before the NULL check in rte_dpaa_remove().
> * net/dpaa: unwind rte_dpaa_probe() through cleanup labels so the Tx SG
>   mempool failure path closes the device and releases the port instead of
>   leaking the port, the queue arrays and the QMan FQID/CGRID ranges.

[PATCH v5-S1 0/5] dpaa2 bus/dma/mempool fixes

Series

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
