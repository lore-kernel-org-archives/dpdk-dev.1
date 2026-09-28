Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23ADCA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D88B402F0;
	Mon, 28 Sep 2026 20:23:44 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 6333040275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:23:43 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc78dd54610so1141426a12.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790619822;
 x=1791224622; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ByAJupeDfYsMvyifdOVCMtndZRoZ71J8dSSz5TUbsrs=;
 b=zFFPyE9MXJROTzo2aD/ytqa63tjEZ1qtTJAaY96QHV0bKFuIDN9tg/vDqL+4wt6FfS
 9qsl0QelM7AmKNTy02y7rZMI7GxNLzqxl0Hxa4DMSbueG5a9Rwv1pqtmyyJZnyvGJIcp
 9u2x3P5yCo01ui3ZIkSp+LY0iJbNq04Bc/xPtuvynRF8NKiO0HKJqjb0pvAWz/dSiqZ6
 IqawZd9qI3CRgmiP7ORiQfsCa2UoFq8Co6aohKdwQt4zZ1foSqHIQZhIxnl7nDaP2JMW
 e+jfJFrhiPnegK++unZ88zs64Kf4r2/RhDtB+ucdgCtCcUvR2aIsrA6WznL0a4h3si4X
 jHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619822; x=1791224622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ByAJupeDfYsMvyifdOVCMtndZRoZ71J8dSSz5TUbsrs=;
 b=W/oitsgTmLu1rhwSwgRTvXTE6qxT2wqRhRJniWkgrLnrW8Bi8kox3eDgGpjvAY+l6I
 Szd4w3vV4J3U6z6cc168ubiT9kGsl0zWroqwu99ridBG4PxDnFhlul8u1qOs12ceNB0h
 /C7jGQuTTBG4YA68OUFrSJQ7t0IOa0EFMq4QP4DXRNoUfWCdanmZUoczSydcrLpeo1YI
 spwHCS8w5ifBHs/3L/xMuJU9BraTlyqN4KgMdvmp8oqvjU+RcrId/6fnqAVXFrwFPdOe
 vz7SqVw++SCs9tQsSu/mcci8cC8CNoY6RewNNdh5cln5QyEwwz3K0yWP5m6wxiWk2z1k
 W9Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoD8hwwsGhMEHo+BhLYWsvaiLe2RxFHljKSqjbLkwN95OyqlBMp7AC6NSD91Wl+gfaCMM=@dpdk.org
X-Gm-Message-State: AFuF++ka8HttW5aPzZ/cvtd9zwRU0IixrOGkABxiz7MuD/gvzD8s4p6j
 n4U9LAXeGMLhDpSblU2viJRjc8jkBZfUhLmHckGXjbuXITBXqe8JHZy52lnE7laRJfol+CtUAM4
 v9cdLTCs=
X-Gm-Gg: AYBFou2lZmGNRB/ebJrzZnw2k9JgBVFNabOEQMTvuO6ETVxqpSfMeqgiTYXbK3VgO3V
 YMEJQlAUPiwuUSN63dMlkTCVE5nX8WQyA/ZejNm1EKWTFIqCccGUE4T4dmy5ELDavrgxPs6SQo3
 3F23kWHvIMIpiT8T9cs40T4RJBPZBAiYk6Z1ED356tjOPcTc5QjCeaXCkVi/uhkKAA95XdsNvFR
 rt7m+8YL4zWbvTvvNA0B4l0hS9PHjEFk09wLgt7eL4QrM7YREkFW0R2Od55rD8eOwRpTIDYSA9A
 8W68CNtzOfrSPlArwb8xGWm30MucPTIJtNRMN2Z2xflDjs0J2sYlfqgmN8vgWEDenJTeHXBs7ef
 JZS11xLON0q7QEQpG7ejlX2N04ZgdweqLHUGVbhWaB9omlJV4ZkP/+GKSH5W78Aubdav30TQSf+
 JUP9bomygdBi8CC7WKIGGgit4fox0koIALOWtH6OLYWQ03OSAe2xpH2zP5yX587Z0rdfXNbZkJe
 /rR6IoTm/w7qskqvgb+6g60a5nmupQSDwmSXE7e8CP9vy9TXoE=
X-Received: by 2002:a05:6a21:7104:b0:3dd:85a8:cacc with SMTP id
 adf61e73a8af0-3de0e79886amr12039524637.35.1790619814558; 
 Mon, 28 Sep 2026 11:23:34 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7879438a0sm5037413a12.22.2026.09.28.11.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:23:34 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:23:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v16 00/23] NXP DPAA driver enhancements and fixes
Message-ID: <20260928112332.29633a34@phoenix.local>
In-Reply-To: <20260928065849.126909-1-hemant.agrawal@nxp.com>
References: <20260901101926.1574209-1-hemant.agrawal@nxp.com>
 <20260928065849.126909-1-hemant.agrawal@nxp.com>
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

On Mon, 28 Sep 2026 12:28:26 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
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
> v16:
> * rebased on main

More AI review feedback.

Subject: Re: [PATCH v16 00/23] NXP DPAA driver updates

v16 applies cleanly to main (edd57b2).  Every commit builds with
-Dwerror=true: gcc 13.3 on x86, covering bus/dpaa, common/dpaax,
mempool/dpaa, net/dpaa, crypto/dpaa_sec, dma/dpaa and event/dpaa.
dma/dpaa was also built with RTE_DMA_DPAA_ERRATA_ERR050757 defined.
Not built for arm64.

The v14 errors are fixed: bman_release_fast() no longer publishes
stack bytes, and dpaa_ol_remove() no longer double frees dev_private.
Also resolved: fmbm_tfrc is exposed and the BMI static_assert is exact,
the unused VSP fields are gone, dma/dpaa rejects secondary probe, and
check_fd() is race free.  The taildrop getenv() fallback is now
justified in the commit message; dropping that item.

What remains blocking: the O/H port in patch 21 cannot be enabled or
configured as submitted, and the new mempool destructor in patch 13
frees EAL memory at process exit.

Errors
------

Patch 13/23: drivers: release DPAA bpid on driver destructor

  dpaa_mpool_finish() is an RTE_FINI destructor that does

      rte_free(rte_dpaa_bpid_info);

  The commit message says the destructor must not touch bman_pool
  because EAL memory may already be gone, and then frees EAL memory.
  rte_eal_cleanup() calls rte_eal_memory_detach() before returning
  ("after this point, any DPDK pointers will become dangling").  Any
  application that calls rte_eal_cleanup() before exit, testpmd
  included, will rte_free() unmapped memory in this destructor.

  It is also wrong in a secondary.  There rte_dpaa_bpid_info is not a
  local allocation; the Rx path installs the primary's shared array:

      rte_dpaa_bpid_info = fq->bp_array;   /* dpaa_rxtx.c:924, :1449 */

  A secondary that exits frees the primary's live BPID table.

  Releasing the BPIDs from the static flag table is fine.  Drop the
  rte_free() from the destructor.

Patch 21/23: drivers: add offline (O/H) port device support

  drv_oldev can never be enabled.  dpaa_bus_parse_bus_args() does

      RTE_EAL_DEVARGS_FOREACH("dpaa", devargs)

  but the bus is registered as RTE_REGISTER_BUS(dpaa_bus, ...), so its
  name is "dpaa_bus".  rte_devargs_next() compares against
  da->bus->name, never matches, and oldev_enabled stays 0.  The dpaa.rst
  example "bus=dpaa,drv_oldev=1" is worse: rte_devargs_layers_parse()
  fails with "Could not find bus" and EAL init aborts.

  Even with that fixed, drv_bh_port cannot reach the device.  The OL
  block in dpaa_create_device_list() never sets dev->device.devargs,
  unlike the ETH, SEC and QDMA blocks, which use
  rte_bus_find_devargs().  A lookup would not match anyway:
  rte_dpaa_bus_parse() only accepts fmX-macY, fmX-ohY, fmX-onicY and
  dpaa_sec-N, and the device is named "oldev1".  So
  dpaa_ol_get_bh_port_name() always returns 0, and
  dpaa_ol_tx_queue_setup() fails with -EINVAL once Rx is set up.

  This needs to be tested end to end.

Warnings
--------

Patch 05/23: bus/dpaa: scan max BPID from DTS

  bman_pool_max = start + count is taken from fsl,bpid-range without a
  bound.  bman_create_portal() does

      u8 bpid = 0;
      while (bpid < bman_pool_max) {
              bm_isr_bscn_mask(p, bpid, 0);
              bpid++;
      }

  A value above 255 never terminates.  A value above 64 writes past
  BM_REG_SCN(1); bm_isr_bscn_mask() only covers bpid 0..63, and struct
  bman_depletion is 64 bits.  Clamp to 64 and reject count == 0.

Patch 08/23: drivers: add DPAA cgrid cleanup support

  The CGR created for a queue whose FQ init fails is still leaked.
  dpaa_rx_queue_init() and dpaa_tx_queue_init() call qman_create_cgr()
  and then qman_init_fq().  If qman_init_fq() fails they return an
  error, and nb_rx_cgr / nb_tx_cgr is only incremented on success.
  The error path then skips qman_delete_cgr() for that entry, and
  rte_free(cgr_rx) leaves it linked on cgr_cbs.  That is the same
  dangling pointer this patch sets out to fix.  Count the CGR when
  qman_create_cgr() succeeds, or delete it in the helper on failure.

  qman_pending_fq_by_cgrid() returns -ERANGE ("none left") whenever the
  CGR byte count is zero.  A scheduled FQ with CGE set and a matching
  cgid is a member whether or not it holds frames.  So an empty stale
  FQ survives, and its CGRID is deleted and released while still
  referenced, contrary to the rule stated in the commit message.
  Close is not a fast path; scan unconditionally there.

Patch 09/23: bus/dpaa: improve FQ shutdown with channel validation

  The commit message describes things not in the diff.  The
  pool-channel-range parsing is added here, not "in an earlier patch".
  Nothing here cleans up CGRID or other queue parameters on shutdown.
  The base code has no portal affinity check for pool channels to
  remove.

  The FQRN drain loop is unbounded:

      do {
              qm_dqrr_drain_nomatch(&p->p);
              found_fqrn = qm_mr_drain(&p->p, FQRN);
              cpu_relax();
      } while (!found_fqrn);

  With QM_SDQCR_CHANNELS_DEDICATED the portal only dequeues its own
  channel.  If the FQ is scheduled on another portal's dedicated
  channel, FQRN never arrives and this spins forever.  That is
  pre-existing, but patch 08 now calls qman_shutdown_fq_by_fqid()
  (qp == NULL, so the caller's affine portal) on stale FQs left by a
  previous run.  Push-mode Rx queues are exactly FQs on another
  portal's dedicated channel.  Return -EBUSY when a dedicated channel
  is not p->config->channel, or bound the loop.

Patch 14/23: dma/dpaa: add devargs for SG and errata workaround

  RTE_PMD_REGISTER_PARAM_STRING() is invoked with an #ifdef inside its
  argument list.  Directives inside macro arguments are undefined
  behaviour (C11 6.10.3p11).  GCC accepts it; other compilers need
  not.  Build the string with a separate macro defined under the
  #ifdef.

Patch 20/23: net/dpaa: enhance VSP port support

  dpaa_eth_rx_queue_setup() now writes

      dpaa_intf->vsp[vsp_id].vsp_bp[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp);

  before any bound check.  dpaa_port_vsp_update() then reads
  vsp[vsp_id].vsp_handle; only dpaa_port_vsp_configure() checks
  vsp_id < DPAA_VSP_PROFILE_MAX_NUM.  vsp_id comes from the FMC
  direct_relative_profile_id.  The check in update was also loosened
  from vsp_id >= num_profiles to vsp_id >= base_profile_id +
  num_profiles, both of which come from the DTS vsp-window.  Check
  against DPAA_VSP_PROFILE_MAX_NUM before first use.

  The commit message covers the ONIC port type and the cleanup
  signature.  It does not mention several other changes:

  - struct dpaa_if_vsp replaces the per-profile arrays.
  - dpaa_eth_dev_stop() changes for ONIC.
  - dpaa_port_vsp_update() now returns -EINVAL where it returned 0.
  - The same-bpid shortcut is removed, so every Rx queue setup frees
    and reconfigures the VSP.

Patch 21/23: drivers: add offline (O/H) port device support

  dpaa_ol_tx_queue_setup() silently skips ASK_CTRL_SET_DPDK_INFO when
  Rx has not been set up yet:

      if (dpaa_intf->bp_info == NULL || dpaa_intf->rx_queues == NULL)
              return 0;

  testpmd start_port() sets up Tx queues before Rx, so on first start
  the kernel is never told the FQs.  ethdev does not order queue
  setup.  Issue the ioctl from dev_start, where both are known.

  dpaa_ol_probe() has no process-type handling.  A secondary runs
  dpaa_oldev_init(), creating dynamic FQs and issuing ioctls against
  state the primary owns.  Either attach with
  rte_eth_dev_attach_secondary() or reject the secondary as patch 06
  does for dma/dpaa.  As written, the secondary branch in
  dpaa_ol_remove() is unreachable.

Info
----

Patch 05/23: "if (!bman_ip_rev)" is dead now that the else branch
  sets BMAN_REV21.

Patch 07/23: The stated motivation is push-mode Rx queue shutdown, but
  nothing in the series shuts down a net/dpaa Rx queue by descriptor.
  The only callers of qman_shutdown_fq(fq) are dpaa_sec and oldev.

Patch 08/23: __rte_internal appears twice on
  qman_pending_fq_by_cgrid().  RTE_EXPORT_INTERNAL_SYMBOL(
  qman_release_fqid_range) is added here, but its first user outside
  the bus is patch 22.

Patch 12/23: dpaa_port_fmc_port_parse() parses the name before the
  OH check, which does not use the result.  It logs DPAA_PMD_ERR for
  any port name without "MAC/" or "OFFLINE/", although the caller
  treats that as "not this port".  It also logs DPAA_PMD_INFO for
  every port on every probe.  Both should be DEBUG.

Patch 13/23: RTE_PRIORITY_104 is a driver-local define in the RTE_
  namespace.

Patch 21/23:
  - rte_pmd_dpaa_ol_*() and ask_set_fq_info() return the raw ioctl()
    result (-1) on failure, mixed with -ENODEV from check_fd().
    Return -errno.
  - rte_dpaa_bus_oldev_enabled() is exported and has no users.
  - dpaa_ol_devops can be const.
  - The meson.build copyright changes to 2018-2021 in a 2026 patch.
  - rte_pmd_dpaa_oldev.h is not in doc/api/doxy-api-index.md and has
    no extern "C" guard.

Patch 23/23:
  - The FMCLESS default Rx queue count change in patch 16
    (rte_lcore_count() to DPAA_MAX_NUM_PCD_QUEUES) is user visible and
    not in the release notes.
  - The new rte_pmd_dpaa_ol_* API is not listed.
  - Five top-level entries for one driver family; fold them into one
    "Updated NXP DPAA drivers" entry with sub-bullets.

Pre-existing, not introduced here: in dpaa_dev_init() the "FMC
initializes failed" path does goto free_rx with ret still 0, so probe
succeeds with no Rx queues.
