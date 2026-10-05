Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A9CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 21:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34960402DD;
	Mon,  5 Oct 2026 23:04:17 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 40373402DA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 23:04:14 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 d9443c01a7336-2e2c7eb3b8cso9782805ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791234253;
 x=1791839053; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P90FaVTM5SgbvgFOUkTXOLawiwpjjfQDJsriA2YeFLU=;
 b=Ub85X4gEls1dZnqWnddBXlYJ2od5vThtTFlQhQR5if52z+blcK7++d86Qd+sKa1Eks
 3FSO7TqoNnbnlabifHCanUNXEXE4ICbuksPTJU+B4AdEawDrpOsFPnLVZoTbnwT19+Ot
 V1raz3EyIX9/X67S+LWCqbklAiLTqpOJcDb02R3nFJT7QXvpB8Bb8ukAaYXK0JEHPe/A
 stxOg12MWibvPsjs4e3D65asb8zg91jFnjYlrQKK9+5Cf8twk+xfRJMVkwUjbjOfawiF
 xQgYCItyqy1q3y4J+DfdM1HjoN7Qne1NIjlp+VVfjrAlP4AoxaCkl/qS21tr49oaPJVY
 vLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791234253; x=1791839053;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P90FaVTM5SgbvgFOUkTXOLawiwpjjfQDJsriA2YeFLU=;
 b=qyU+EvHhzKIcCAPVDzxxIfUxR/tm9ex2ae++2N9NXS0i1LZwraRPfmG2NeoDWu0VBX
 WYmHAOGFHx34Z0lebeNlCI32VGEGnoruFiLlHAMoRW9qFqSvA747R5827jp4zePzWdKo
 tc1+suntbv7a9qZX43qwb1H/eoirv6pZFj+XWoddDz8zdj7b15oVII2OODuP8JjYeS8x
 fpLXEdnS8saOoneQ1N9rU1oKi4qgwUtTZotrhuAwIhMQQwebS5iy4z3bVof/G1XuO+qF
 AvJti7BdkI/tMxMrcUcCSG5gSoh8nPkwoGgageSOUnSheB6R3pYXsRjYaDynZSUqE5l6
 Oeag==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3F04rYKYb4/autL8nsTdHZyp4+4Nv+YZf/GKh9SL973gwSNW+ZUmWLBbq7SBr5NKWb4c=@dpdk.org
X-Gm-Message-State: AFq9FYLVubBcCJf+rNxKFNWA2yKfTjkN+aa3vEsPkVmTHAEybztaqPXt
 8fWU6Ps4/AIGDCgeFDpUndz8r/5RH+SnjDSo8aowSmmMrX8nAHbjujyDDWT4OEZlTfM=
X-Gm-Gg: AYBFou2c25V3fqTuI6ATFp1umdC33Rcmop9LcjIQCJt3rJsWY1qDkUF1+HoDSjW3ptX
 FSvJhQ4D807p6TbOjxs7h/nKneijxCX1oNwKMNQMaHQlHvMhIvpf/6UM58KttAKv0W7UdVsHFgc
 MLyLY1N8dQx7qhUhX5UuOkiDy7CQ17xz//r+uazVthrvwPCcVWf40Agl3CVGAPRsDaAKLAoeyuA
 CxCM+kH8xxoKjWGsmo92NNUnX4/xxWqNEiFwVoGnyGbL2hoVsHgh7nutABQozNgbTzMKEVZFNIA
 9PfS74WxcJzd16YHT2BN3Fh+cDGkLSWOr2q6eDw6UIUc7yCGX9jUQTpMqebKrWXvdptZdDaTuuk
 yM300ATPXCXj4tZ0HH2LbJMQsLfsSfWOd0wYgJM7g8KizVroHBvJiEbXxKSgqj67Nb/VwelVxJq
 klPbu9vqSYfeQhvqUT0Wlzw+HXJ86wE3GWqPffjNjtb7D9Phu3ACVRC8yBpTM3okBkfDeyWzXh4
 CW7WeLtECqtUPNoU+l7hq6PXJL/9BGwdxY2XAHmIv2/SS1rbMs=
X-Received: by 2002:a17:903:244d:b0:2e2:bf06:25f3 with SMTP id
 d9443c01a7336-2e49b6e07d8mr101190315ad.38.1791234253176; 
 Mon, 05 Oct 2026 14:04:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a55b6935sm12744175ad.4.2026.10.05.14.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:04:12 -0700 (PDT)
Date: Mon, 5 Oct 2026 14:04:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v20 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261005140410.65caa39d@phoenix.local>
In-Reply-To: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
References: <20261001112430.251845-1-hemant.agrawal@nxp.com>
 <20261005085337.1069213-1-hemant.agrawal@nxp.com>
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

On Mon,  5 Oct 2026 14:23:10 +0530
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
> v20:
> * net/dpaa: propagate the dpaa_port_fmc_init() error instead of
>   returning success with no Rx queues, as a separate fix with a
>   Fixes tag so it can be backported.
> * drivers: drop the unused rte_dpaa_bus_oldev_enabled() and add
>   rte_pmd_dpaa_oldev.h to doc/api/doxy-api-index.md.
> * drivers: use qman_pending_fq_by_cgrid_range() over the whole Rx
>   and Tx CGRID range, so a port close costs two FQID space scans
>   rather than one per congestion group.
> * doc: name the new experimental offline port functions in the
>   release notes, document that drv_oldev switches the bus to
>   allowlist mode, and log an over-long drv_sh_if_name.
> 

Still lots more AI comments. As always, AI is not always right!

Error
-----

Patch 11/27: free_rx/free_tx can crash on a CGR that was never
  created.  If qman_create_cgr() fails in dpaa_rx_queue_init(), it
  goes to without_cgr and can still return 0.  The caller then
  counts the CGR anyway:

	if (dpaa_intf->cgr_rx)
		nb_rx_cgr++;

  A later probe failure calls qman_delete_cgr() on it.
  qman_create_cgr() set cgr->chan before failing, so the channel
  check passes, and list_del(&cgr->node) runs on a node zeroed by
  rte_zmalloc():

	(i)->next->prev = (i)->prev;

  next is NULL.  dpaa_tx_queue_init() has the same shape.  Return
  the qman_create_cgr() failure, or report back to the caller
  whether the CGR was created.

Warning
-------

Patch 04/27: The commit message says the tx_conf_queues leak is
  fixed for every probe failure after the allocation, but three
  such paths still jump past it.  The tx_conf_queues, cgr_tx and Tx
  qman_alloc_cgrid_range() failures all do "goto free_rx", and
  free_rx frees neither tx_queues nor tx_conf_queues.  Make them
  goto free_tx; nb_tx_cgr is 0 and tx_cgrid_allocated is false at
  those points.

Patch 12/27: The second paragraph of the commit message, and the
  new comment in qman_shutdown_fq(), describe dropping an "old
  affinity check" against p->config->channel.  The function this
  patch modifies has no such check.  Remove both.

Patch 18/27: The commit message says dma_pool_alloc() now accepts
  a NULL phy_addr.  The patch does not touch it, and it still does:

	*phy_addr = rte_mem_virt2iova(virt_addr);

Patch 22/27: The first paragraph of the commit message describes
  replacing the hardcoded 8 with FSL_BM_BURST_MAX.  That change is
  in 17/27; this patch has none of it.

Patch 25/27: dpaa_oldev_queues_release() shuts down and rte_free()s
  the Rx and Tx FQs, but never releases them.  Both were created
  with QMAN_FQ_FLAG_DYNAMIC_FQID, so qman_create_fq() allocated an
  FQID and, on 64-bit, a lookup-table entry for each.  Every
  probe/close cycle leaks two of each.  26/27 releases its FQIDs
  after shutdown; do the same here.

Info
----

Patch 01/27: The commit message says "propagate the close status".
  The code logs the dpaa_eth_dev_close() result, then overwrites
  ret with rte_eth_dev_release_port().

Patch 02/27: "num_rx_fqs = 0;" is a dead store.  free_rx reads
  num_rx_fqs only under rx_cgrid_allocated, which is false on this
  path.

Patch 10/27: The commit message says dpaa_sec and the offline port
  now drain on the right portal.  Those callers arrive in 25/27 and
  26/27.

Patch 11/27: qman_release_fqid_range() is exported here, but its
  first user is 26/27.

Patch 15/27: DPAA_1G_MAC_START_IDX and DPAA_2_5G_MAC_START_IDX are
  now unused.

Patch 17/27: RTE_PRIORITY_104 is a driver-local define in the RTE_
  namespace.

Patch 19/27, 20/27: The devarg value is narrowed before the range
  check:

	td_threshold = (unsigned int)td_val;

  so 4294967296 becomes 0 and silently disables taildrop.  The same
  happens with "num_rx_fqs = (int)fmcless_rxq;".  Parse errors are
  also dropped, because callers only test "== 1".  Range-check the
  long first.

Patch 22/27: HI16_OF_U48() and LO32_OF_U48() are moved into
  fsl_bman.h but have no users left.

Patch 25/27: The ioctl error paths log strerror(errno) and then
  return -errno, but the log call can clobber errno.  Save errno
  first.

Pre-existing, not introduced here: in FMCLESS mode net/dpaa never
releases the Rx FQIDs it gets from qman_alloc_fqid_range().  No
DPAA driver calls qman_destroy_fq().
