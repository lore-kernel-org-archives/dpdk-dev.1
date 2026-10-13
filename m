Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C3FCC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6EDA40274;
	Tue, 13 Oct 2026 16:28:05 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 77E6240272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:28:04 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e87c66e556so13106895ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791901683;
 x=1792506483; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YugxlnypRTaIgeiEeR4Lc2XE6JVNniYdMnTwS0WInIk=;
 b=wyFF5VwqUswGSMjSGGb7kgEg0uffNOUfhXaAEtuxhFmE4EdSmSq+2Ai3xIJ+nOe9YO
 yODVMIYCKXoXxB9r1reTBGozcDRxlMDilI0a5cd0mcblmDbIzEx9TDTn7XiT1Zu/sGux
 F1BbB4ZlByj9l671MbfFeRMf+KMFa3C5l+HKRhMDToR9JpuIJrXCh/oIqpWPtD4gfIqn
 3KH8VEcG8ZsmjImAqyrZRtNuSqlzno98lVpPvQwhUe54CNLlBJ5ukTGagl1ugq2MrtpM
 MHyAPE+s9ObpnIWyJepIFyWYKj8u5wEAEU8EhzimEskqeLFQb5dXoXyPzDAxJ8QDTmXa
 vBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901683; x=1792506483;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YugxlnypRTaIgeiEeR4Lc2XE6JVNniYdMnTwS0WInIk=;
 b=YVTkV/Cumbjt/47qVKVvOl03SvL6rxPcxEWSFXgDeD7CZF9mtPXCeZIyyYidWdIAee
 M+4phXba+RISu4NODiQuVURJpoKZwnqRbQQTTNpg2UccMJruA1ArLRibXnh1Qu2yGVmj
 /PprL5OiBHqjqUdHrwZk67yrvo3YU6DEZunjKIAQ7qsW0Gh5B9T4aBQQQCC4htvOrlM+
 RoX/SSyHtva7kY3Y0T9buqCi+oY+ScmoXLgJc2/gwU1UMaRPhnGg897D0vAuMfqyxQtO
 5chBBBCY7Os6HwPAbl5dMRjVX79eRm25jT0OmCk/0+YjD2GqMkJriJClgPiS1mYZKalM
 X4Dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM7ZoHBTxRVzR3AYM44CZKpAVEWj+CE0fkUUSYve0KWPPw8CZbVu+0zZk8ruFKSotvGGM=@dpdk.org
X-Gm-Message-State: AFq9FYLmFfmwCN4St28dDiHy2fkg1+yJDnr8xzH3kk+9gD0Egr/42Pro
 6WZz0whrU6n6CFqyMW8yex6fe8eHauFxERr7e8XT/Z9h54vMagPOHdZ8ndI0vnEQOU0=
X-Gm-Gg: AYBFou0anSvpoPvVl3HKh8e+uIUh9Ul82WORWRNai7mzVPbXYk+oeghQftpL0f/36/3
 FA6+sQ5CsMyEO8onfFpTE0/E3bobGo0JWcx/kl9Xshr7VhGQGxXZy2QtXGfYqMMqT5tcQD740On
 aUSlNSH+dwG2c3fCLRVeHHXeIRMkF0rr1USON/sDckifLi9+IZKRqJhQN07EVpTlpGalVDFwsTh
 jGsgnA7eEQEY24giYnPkKMdBGfDzqvhxqd7ID6MxBjGA0ZJ79XCkPPfwWrdau+RyleHtLu7QoFM
 aFfTDC7c+ojHmnigzuC/OwGqFkgIT6hmkaqLNoiWu+YcXkKx3Sn/gIlZcdbZVMvrLfcMzmyD36Q
 1fbcW91EuRSoGksCefo/cgG3ewpYut+ZK4izW8DsOAILj7yjXzlUCoFOe7IDn9vZ5nDTBXFRqre
 x6qaUjc7QxsgFdiFzcyk5wsZDL6YLAb6HFdvmxdjFOMl0m0TzNT+IxvHBu/9YJzVIV4MMQ3Td2I
 x/iBAPxohX9PsMrVFHRyayLYnhACTg8QckdWT9k
X-Received: by 2002:a17:902:dace:b0:2e2:dc54:3145 with SMTP id
 d9443c01a7336-2e842cf98fcmr81261275ad.25.1791901683231; 
 Tue, 13 Oct 2026 07:28:03 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8483c3dfcsm55403625ad.24.2026.10.13.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:28:03 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:27:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v25 00/24] NXP DPAA driver enhancements and fixes
Message-ID: <20261013072759.5e8787df@phoenix.local>
In-Reply-To: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
References: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
 <20261013103833.3822265-1-hemant.agrawal@nxp.com>
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

On Tue, 13 Oct 2026 16:08:09 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue shutdown, secondary-process
> safety guards, BPID lifecycle handling, and several new features:
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, non fmX-macY shared Ethernet naming, and DMA
> scatter-gather and errata-workaround devargs. Documentation and release
> notes are updated accordingly.
> 
> v25:
> * Dropped the offline (O/H) port and DPAA cgrid cleanup patches, and
>   the Rx/Tx taildrop devargs patch whose Rx threshold was overwritten
>   by nb_desc at queue setup. Now 24 patches.
> * net/dpaa: keep the shared MAC base profile exempt from the one pool
>   per VSP check; it is identified by bp_num, not by vsp_bp[0].

Still seeing errors and warnings in manually run AI review.

Review of [PATCH v25 00/24] NXP DPAA fixes and enhancements

Series applies cleanly to main and every commit builds with
-Dwerror=true. Fixes: hashes in 01-06 and 15 resolve correctly.

Series-level: new code comments are long and repeat the commit message
(16 has the same ten-line paragraph twice, 23 a fourteen-line block in
uninit). Cut them to what the code does not already say.


Error
=====

[PATCH v25 22/24] net/dpaa: enhance VSP port support

The VSP now keeps a pointer to the mempool's private data instead of
the BPID value:

  dpaa_intf->vsp[vsp_id].vsp_bp[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp);

and dpaa_eth_rx_queue_bp_check() dereferences it on the next queue
setup:

  bpid != dpaa_intf->vsp[vsp_id].vsp_bp[0]->bpid

dpaa_mbuf_free_pool() does rte_free(bp_info). Stop the port, free the
mempool, set up the Rx queue again with a new pool, and this reads
freed memory. Nothing clears vsp[] on queue release or close. Store
the values, not the pointer:

  struct dpaa_if_vsp {
          uint32_t bpid[FMAN_PORT_MAX_EXT_POOLS_NUM];
          uint32_t size[FMAN_PORT_MAX_EXT_POOLS_NUM];
          uint8_t bp_num;
          void *vsp_handle;
  };


Warning
=======

[PATCH v25 11/24] bus/dpaa: improve FQ shutdown with channel validation

The unbounded do { } while (!found_fqrn) spin and the hang on another
portal's dedicated channel date back to c47ff048b99a and are in every
LTS. That part is a fix: split it out with

  Fixes: c47ff048b99a ("bus/dpaa: add QMAN driver core routines")
  Cc: stable@dpdk.org

and keep the DTS pool-channel-range parsing as a separate feature
patch.

[PATCH v25 17/24] dma/dpaa: add devargs for SG and errata workaround

Before this patch fsl_qdma_data_validation() ran unconditionally on
every completion, a byte-by-byte software compare in the datapath.
Adding the s_data_validation early return is a bug fix, not a new
option. Split it out:

  Fixes: f1d30e2786b6 ("dma/dpaa: refactor driver")
  Cc: stable@dpdk.org

The new !s_sg_enable loop turns a transient ring-full return from
fsl_qdma_enqueue_desc_single() into -EIO with an ERR log on the fast
path. The SG path propagates ret. Do the same:

          } else {
                  return ret;
          }

[PATCH v25 18/24] net/dpaa: support fmcless rxq number as devargs

drv_fmcless_rxq duplicates what rte_eth_dev_configure() already
decides. The default is now DPAA_MAX_NUM_PCD_QUEUES FQs, max_rx_queues
reports that, and dpaa_fm_config() distributes over
dev->data->nb_rx_queues. If the goal is to save FQIDs and CGRIDs,
allocate them at configure time when nb_rx_queues is known, rather
than adding a driver-specific knob. Drop the devarg.

[PATCH v25 19/24] net/dpaa: support non fmX-macY type of shared Ethernet name

Asking the user to supply the kernel name is another per-driver
special. The kernel netdev is bound to the same dpa-ethernet node the
driver already has (__fif->node_path); look it up from the platform
device's net/ directory in sysfs instead.

If the devarg stays: an invalid value is logged and ignored, where 18
fails the probe for a bad drv_fmcless_rxq. Parse it once in
dpaa_dev_init(), fail there, and store the name in dpaa_intf rather
than re-parsing devargs on every configure.

[PATCH v25 20/24] bus/dpaa: optimize DPAA multi-entry buffer pool operations

The comment and the commit message say entry 0 is written separately
to avoid the valid bit, but

  r->bufs[0].opaque = bm_bufs[0].opaque;

is an 8-byte store that includes byte 0, the verb. Write only the
fields that are not the verb:

  r->bpid = bpid;
  r->bufs[0].be_desc.hi = bm_bufs[0].be_desc.hi;
  r->bufs[0].be_desc.lo = bm_bufs[0].be_desc.lo;

[PATCH v25 23/24] drivers: improve DPAA crypto fq resource handling

dpaa_sec_uninit() now calls qman_shutdown_fq(), which uses
get_affine_portal() when fq->qp is NULL. Remove via rte_dev_remove()
from a thread that never ran rte_dpaa_portal_init() gets a zeroed TLS
portal and qm_mc_start() faults. Do what probe does:

  if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
          ret = rte_dpaa_portal_init((void *)0);
          if (ret)
                  return ret;
  }

The init_error1/init_error3 paths release the whole FQID range even
when qman_shutdown_fq() failed, which is exactly what the new comment
in uninit says must not happen. Apply the same rule on the error path.

[PATCH v25 24/24] doc: update release notes with NXP DPAA changes

The commit message lists drv_oldev, drv_rx_taildrop and
drv_tx_taildrop. None of these exist in the series or the tree, and
the release notes have three bullets, not five. Update the message.


Info
====

[PATCH v25 04/24] net/dpaa: fix free port resources on close

Pre-existing, not introduced here: the dpaa_dev_init() error path
does rte_free(dpaa_intf->cgr_rx) without qman_delete_cgr() for queues
already set up by dpaa_rx_queue_init(), whose qman_create_cgr() did
list_add(&cgr->node, &p->cgr_cbs). The portal list is left pointing at
freed memory. Same for cgr_tx after dpaa_tx_queue_init().

[PATCH v25 08/24] bus/dpaa: scan max BPID from DTS

The message says "update the default BMAN HW version", the code
removes bman_ip_rev. It also makes a missing fsl,bman node and a
failed CCSR map fatal, which were only logged before. Say so.

  pr_info("Max BPID: %d, fixed BPID < %d", bman_pool_max, start);

prints to stdout on every start with no newline. Use DPAA_BUS_DEBUG().

[PATCH v25 09/24] drivers: add process-type guards for secondary process

Returning -ENOTSUP from dpaa_qdma_probe() logs three errors on every
secondary start (driver, "unable to probe", "Failed to probe
device"). A positive return tells the generic bus probe to skip the
device quietly.

[PATCH v25 11/24] bus/dpaa: improve FQ shutdown with channel validation

Leftovers: QMAN_MAX_FQID is unused; qm_fqd_get_wq() from 05 has no
user after this patch; QMAN_CHANNEL_PME and QMAN_CHANNEL_PME_REV3 are
unused once qm_channel_pme is gone. dpaa_get_qm_channel_pool_num() is
only called inside bus/dpaa, so it needs neither __rte_internal nor
RTE_EXPORT_INTERNAL_SYMBOL.

[PATCH v25 13/24] net/dpaa: optimize FM deconfig

The new comment says "For FMCLESS mode of share MAC ... before fq
shutdown", but the condition is not limited to shared MAC and close
does no FQ shutdown. With dpaa_fm_deconfig() now returning 0 when
port_handle is NULL, the port_handle test in close is redundant.

[PATCH v25 14/24] net/dpaa: optimize FMC MAC type parsing

The FMC_PORT_NAME_OFFLINE branch in dpaa_port_fmc_get_idx_from_name()
is unreachable: offline/ONIC fifs never get past the mac_type checks.
Those fifs instead log "Unknown mac_type" at ERR for every FMC port
that is not theirs. Return -ENODEV for them after the number check and
drop the OFFLINE parsing.

[PATCH v25 20/24] bus/dpaa: optimize DPAA multi-entry buffer pool operations

bm_buffer_get64_from_be() as a statement-expression macro should be a
static inline function.

[PATCH v25 21/24] bus/dpaa: improve log macro usages

Beyond the macro conversion this changes return values (-1 to -ENOMEM
in dpaa_create_device_list(), of_init() error propagated) and drops
the FMan version message from NOTICE to INFO. Mention it in the
commit message.

[PATCH v25 23/24] drivers: improve DPAA crypto fq resource handling

fqids[RTE_DPAA_MAX_RX_QUEUE] is 16 KB on the probe stack. Allocate it,
or reuse it for the Tx range which only needs max_nb_queue_pairs.
