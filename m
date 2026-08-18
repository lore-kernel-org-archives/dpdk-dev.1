Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFAFC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 14:27:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 432C44027C;
	Tue, 18 Aug 2026 16:27:17 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id A9E9940269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 16:27:15 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso3427123a12.3
 for <dev@dpdk.org>; Tue, 18 Aug 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787063234;
 x=1787668034; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=21hSrN6XA5Ga9Dsub4BDuLet5F89x/6nPSxSZ29aptg=;
 b=X6q27nCNhCnva1B5tYCOueRcez5IvGBUvsJAW74yyKkUOp1xvh5qJSUiQmJyOlYbic
 0lJC5peJk2NrVwBjnvDXz07GAIE7YUbnyEsYDUec8N2TunL59qf3/9zJTUU5rX3RCazg
 M6iqLb5a0OCaV+KNScd7sxTmvWctHRdCl1gz2arnkvsYjtQeIH1Qku/KYnuBYEWZTu7v
 9Zl6dF7lH3G18QuoszuSluUEpBwwS/TwXiGj6PhHiC97Y6SI+NCcnDVCZF1f4zwa22oC
 ENzE0/QgIMvX25gY59xnBniTuwyHAEDEld833gded22lpCZYhOU9iXKBA1hV+jVt3j1R
 hiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787063234; x=1787668034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=21hSrN6XA5Ga9Dsub4BDuLet5F89x/6nPSxSZ29aptg=;
 b=MA81PycT7AHWgTW2OOTWfqKKslWDM+FZD5gTdc/TG3o4+5f4iOW1+H9jbBtd0jZqI1
 Ggq02FX/w25WWKlpniqja/9dsFbjROxUVnRPl4tkjeEfCdJV1jwqptojXlJL8UntcLV2
 hn8mXPWJTkA3MmSRiI3ynye6B4p5m26yKuenu+kpwKhthGu8VpLzOJPVFb3vsbvUYqGN
 w73bAZmtoGlprI3ZRaIelnwnl5xhdN06X+FDcRRwejWrBugq3cNAwxrg2J4FGtiqC58t
 0jQoWhuAvHuHdDq4w4gycaWbkZXe47WTP6ENZdWFUH2P+ZmPe8eIlnbiTv23wPo9BO8H
 oZlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrtp336uEEvYYRqNbI8O81lETVpzEhcNhLGZggX4Sc1hJXNXDgJI02l8DYSpv4QkgdEmjs=@dpdk.org
X-Gm-Message-State: AOJu0YxQDiCKI3VCwpdqUV5xHzpZRqfDV4KgHew1PAZT9fRQmwl7GJkD
 oA4nl2BBbI9h4LjBiI90YxJfC6LSkq5uW1SuJ43RcBJCCUIU42u0oEJeNvypXvFAW4o=
X-Gm-Gg: AR+sD12z6ch8uZ2uKnPgbMou7B7kfsfUpllETYil08xb42aMiQLNiHXj/zrYgMQMO8i
 AsnB4XV6Mje0Uvs1KXkkyCsaoYD56wEMWQGB1I5Rr8HDSyt4dKcVl+ey9VD2AchnElX0pT8jM+D
 vEX3vjAOpKTcMeNrj/UDo/acjsNaGTxMOnAYoHmp17NBSIUTImIPZnl/M9/zL21i5q9QpDR8kvE
 MxfD6PlPYfVIBX1yky5ggARnvi1PUUIpqfK+kFSI8SJngO0BiUNn6Tiqo31AF1LeE2KymhIbv5i
 CJdoVYMoN9sf4LuPc7uKOBySXUDV5lST5QCBcLaEaPldWVEbM/XB1EOzICYq36IQfmEWI6AaRrZ
 xc8hjalEt1kmQggr+2nmSdurLudXRKZHAHLxW1WzLeyvKzqliY+F3pWSGEui5K6kV0KDOAT3fji
 Qn/o51froqyZ/rrU2+prCQtr6jU7zDRgi/W6jpmkiANyTw8PqJ5GZ0JWV67blR9Q2/ZBdpMGckN
 osZl4IL0gKFxGHx7JUQZZ2xuNT8/Q==
X-Received: by 2002:a05:6a20:3c8d:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3cc71881d83mr40066467637.0.1787063234280; 
 Tue, 18 Aug 2026 07:27:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14157e53079sm9136177c88.1.2026.08.18.07.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:27:13 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:27:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v12 00/26] NXP DPAA driver fixes and enhancements
Message-ID: <20260818072704.176b9dfd@phoenix.local>
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
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

On Tue, 18 Aug 2026 16:47:04 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series contains a collection of fixes and enhancements for the NXP
> DPAA bus, mempool, dma, crypto and net drivers. It addresses several
> resource cleanup and shutdown issues, adds new offline (O/H) port device
> support, and introduces a number of performance and usability
> improvements.
> 
> Highlights:
> - Fix device remove, Tx confirmation queue leak and FQD dest wq decoding.
> - Add process-type guards for secondary process and improve FQ shutdown
>   and cgrid cleanup handling.
> - Add offline (O/H) port device support with a new PMD-specific API.
> - Add Tx rate limiting API, Rx/Tx taildrop threshold devarg, fmcless rxq
>   number devarg and non fmX-macY shared Ethernet name support.
> - Optimize FMAN deconfig, FMC MAC type parsing and buffer pool
>   operations.
> 
> v11 -> v12:
> - fixed recent AI review comments


There are still more AI review comments to address here:

Reviewed the v12 series (26 patches) applied on c1a46b9.  Series
applies cleanly with git am.  This is a source review of the applied
tree; I did not build it this time.

All the blocking items from v11 are addressed.  Thanks for splitting
the FQD decoding fix out into its own patch.  What is left is mostly
commit messages that describe something other than what the patch
does, plus the offline port driver and the destructor patch.

Fixed since v11
---------------

  - FQD dest_wq decoding is now patch 03 with a Fixes: tag and
    Cc: stable@dpdk.org.  The wq/channel split is correct.
  - BMI Tx counters are enabled and reset via fmbm_tstc, so the four
    new tx_* xstats will actually count (patch 10).
  - rte_pmd_dpaa_port_set_rate_limit() guards with is_dpaa_supported()
    and always opens the Tx port (patch 16).
  - dev_init error paths delete every created CGR before freeing
    cgr_rx/cgr_tx and release the CGRID range, tracked by nb_rx_cgr /
    nb_tx_cgr and the *_cgrid_allocated flags (patch 08).
  - qman_enqueue_multi_orp() now writes all frame data, then lwsync(),
    then the verb bytes, then dcbf, matching qman_enqueue_multi()
    (patch 17).
  - dpaa_eth_rx_queue_bp_check() checks vsp_bp[0] before dereferencing
    it, and dpaa_port_vsp_configure() has the DPAA_VSP_PROFILE_MAX_NUM
    bound back (patch 22).
  - dpaa_create_device_list() no longer returns before creating the OL
    device, and dpaa_ol_remove() releases queues, closes the fd and
    releases the port (patch 23).
  - rte_pmd_dpaa_oldev.h has Doxygen throughout and the two API structs
    are prefixed (patch 23).

Errors
------

Patch 23/26: drivers: add offline (O/H) port device support

  All four OL exports still carry 25.11:

      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_set_classif_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_reset_classif_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_set_lgw_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_reset_lgw_info, 25.11)

  The series targets 26.11; patch 26 adds to release_26_11.rst and
  patch 16 uses 26.11 correctly.

  Only queue index 0 is ever initialized.  dpaa_oldev_init() sets

      /* num_fqs is DPAA_DEFAULT_NUM_PCD_QUEUES */
      dpaa_intf->nb_rx_queues = num_fqs;
      dpaa_intf->nb_tx_queues = num_fqs;

  but calls dpaa_ol_rx_queue_init(&rx_queues[0], 0) and
  dpaa_ol_tx_queue_init(&tx_queues[0], 0) only.  dpaa_ol_dev_info()
  reports the full count in max_rx_queues/max_tx_queues, so an
  application that configures queue 1 gets a zeroed qman_fq, and
  dpaa_ol_tx_queue_setup() passes fq_info.tx_fq_id = 0 to the kernel
  ioctl.  Either initialize all num_fqs queues or advertise 1.

  dpaa_ol_dev_close() is still a bare "return 0".  All the cleanup
  lives in dpaa_ol_remove(), so an application that calls
  rte_eth_dev_close() without removing the device leaves the FQs live
  in hardware and the rx/tx queue allocations in place.

Warnings
--------

Patch 02/26: net/dpaa: fix Tx confirmation queue memory leak

  The free is placed after the early return for offline ports:

      if (fif->mac_type == fman_offline_internal ||
          fif->mac_type == fman_onic)
              return 0;
      ...
      rte_free(dpaa_intf->tx_conf_queues);

  so for those two MAC types the leak the commit message describes is
  still there, along with rx_queues, tx_queues, cgr_rx, cgr_tx and
  fc_conf.  The early return predates the series, but patch 23 makes
  offline ports a lot more interesting, so it is worth fixing here or
  in a follow-up.

Patch 08/26: drivers: add DPAA cgrid cleanup support

  qman_pending_fq_by_cgrid() walks the FQID space from 1 upward, one
  qman_query_fq_np() per FQID plus a qman_query_fq() for every FQ not
  in OOS state, and stops only when QMan answers -ERANGE.  It is called
  from dpaa_cgr_stale_fq_cleanup() once per CGR, and that in turn is
  called once per Rx queue and once per Tx queue in
  dpaa_eth_dev_close().  Worse, the caller loops:

      while (qman_pending_fq_by_cgrid(cgrid, &fqid) == 0)

  and each call restarts the scan at fqid = 1, so N stale FQs cost N
  full scans.

  The cgrd.i_bcnt idle check keeps this off the clean-shutdown path,
  which is the common case, but the situation this code exists for is
  precisely the one where the CGR is not idle.  Consider passing a
  start FQID into the function so the caller can resume the scan, or
  querying the congestion state once and walking only the FQs this
  process knows about.

Patch 13/26: drivers: release DPAA bpid on driver destructor

  rte_dpaa_bpid_info is freed once no pool holds it:

      for (i = 0; i < DPAA_MAX_BPOOLS; i++)
              if (rte_dpaa_bpid_info[i].mp)
                      break;
      if (i == DPAA_MAX_BPOOLS) {
              rte_free(rte_dpaa_bpid_info);
              rte_dpaa_bpid_info = NULL;
      }

  but every Rx queue still holds a copy of that pointer in
  fq->bp_array (dpaa_ethdev.c and dpaa_oldev.c both do
  "rxq->bp_array = rte_dpaa_bpid_info"), and dpaa_eth_queue_rx() /
  dpaa_rx_cb() reinstall it:

      if (unlikely(rte_dpaa_bpid_info == NULL &&
                   rte_eal_process_type() == RTE_PROC_SECONDARY))
              rte_dpaa_bpid_info = fq->bp_array;

  The array is rte_zmalloc'd, so it is shared.  A primary that frees
  its last mempool while a secondary still has ports open leaves the
  secondary reinstalling a dangling pointer on the fast path.  Freeing
  it only from the destructor, or refcounting against open ports rather
  than against live mempools, would avoid this.

  The "if (!rte_dpaa_bpid_info) return;" guard is below the block that
  already dereferenced rte_dpaa_bpid_info, so it does not protect
  anything.

Patch 14/26: dma/dpaa: add SG data validation and ERR050757

  The commit message describes work the patch does not do.  SG support
  and the ERR050757 workaround both already exist upstream;
  fsl_qdma_enqueue_desc_sg() and the sdf->ssen/sss/ssd programming are
  pre-existing.  What this patch actually adds is three devargs to turn
  those off, plus a gate on the existing data-validation helper.  The
  body should say that.

  s_sg_enable, s_data_validation and s_pci_read are file-scope statics
  written from per-device devargs in dpaa_qdma_init().  With more than
  one QDMA device the last one probed silently sets the behaviour for
  all of them.  These belong in struct fsl_qdma_engine.  (s_hw_err_check
  has the same problem already, so this is three more of the same.)

  s_data_validation, s_sg_enable and s_pci_read are int used purely as
  booleans; s_hw_err_check next to them is already bool.

Patch 15/26: net/dpaa: support Rx/Tx taildrop threshold devarg

  The getenv is kept as a fallback:

      if (dpaa_get_devargs_int(dev->devargs, DRIVER_TX_TAILDROP, ...)
              ...
      else if (getenv("DPAA_TX_TAILDROP_THRESHOLD"))

  The point of the patch is to replace the environment variable with a
  devarg.  Drop the getenv in the same patch, and note the removal in
  the release notes if you are worried about existing users.

  The new "Device Arguments" section in doc/guides/nics/dpaa.rst is a
  bullet list where each item is a term followed by a description
  paragraph.  A definition list reads better and produces better
  output:

      ``drv_rx_taildrop`` / ``drv_tx_taildrop``
         Configure the Rx / Tx frame queue taildrop congestion
         threshold.  A value of ``0`` disables taildrop.

Patch 17/26: bus/dpaa: orp queue create and burst enqueue

  Still no consumer.  qman_enqueue_multi_orp() has no caller in the
  tree, force_ooo is only ever set false in qman_create_fq(), and the
  ORP_RWS_WIN_*, ORP_AUTO_ADVANCE_* and ORP_LATE_ARRIVE_* enums added
  to fsl_qman.h are unreferenced.  The subject says "orp queue create"
  but there is no create path in the diff.  Please land this with the
  code that uses it, or hold it until that code is ready.

Patch 20/26: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  The commit message says the first descriptor is initialized and
  copied to the remaining entries.  The code does the reverse: entry 0
  is written on its own precisely because copying it would trip the
  valid bit, and entries 1..n-1 are the ones memcpy'd.

      r->bufs[0].opaque = bm_bufs[0].opaque;
      if (num > 1)
              memcpy(&r->bufs[1], &bm_bufs[1],
                     sizeof(struct bm_buffer) * (num - 1));

  BIT_SIZE, MAX_U48, HI16_OF_U48, LO32_OF_U48 and U48_BY_HI16_LO32
  move from bman.c file scope into fsl_bman.h, where they are now
  visible to everything that includes it, with no BM_ or RTE_ prefix.
  BIT_SIZE in particular is generic and is wrapped in #ifndef, so it
  will silently pick up somebody else's definition rather than warn.

  U48_BY_HI16_LO32() shifts hi left by 32 with no cast:

      #define U48_BY_HI16_LO32(hi, lo) \
              (((hi) << BIT_SIZE(uint32_t)) | (lo))

  The one caller declares hi as uint64_t so it is fine today, but as a
  header macro it will be undefined behaviour the first time somebody
  passes a 32-bit value.  Cast inside the macro.

Patch 21/26: bus/dpaa: improve log macro and fix bus detection

  The subject promises a bus detection fix that is not in the patch.
  Both access(DPAA_DEV_PATH1/2) checks exist upstream unchanged, and
  DPAA_DEV_PATH1/DPAA_DEV_PATH2 were already defined ahead of both.
  The only change is moving the two #defines to the top of the file.
  The commit body mentions only the log macro conversion, which is
  what the patch does.

  The conversion is also incomplete: 12 DPAA_BUS_LOG() call sites
  remain, including two in the function the patch edits
  (rte_dpaa_bus_scan) and three in netcfg_layer.c.

Patch 23/26: drivers: add offline (O/H) port device support

  rte_pmd_dpaa_oldev.h is installed as public API (it is in the
  headers list in meson.build) and still puts unprefixed names in the
  application namespace:

      MAX_NUM_PORTS, MAX_NUM_SUBNETS
      struct ip_pair_s, struct lgw_subnet_s
      DPA_ISC_IPV4_ADDR_TYPE, DPA_ISC_IPV6_ADDR_TYPE
      DPA_ISC_IPV4_SUBNET_TYPE, DPA_ISC_IPV6_SUBNET_TYPE
      DPDK_CLASSIF_*, DPDK_TELECOM_*

  MAX_NUM_PORTS is the one that will actually bite; plenty of
  applications define that themselves.  The DPDK_ prefix is worse than
  none since it implies these are project-wide.  Please give everything
  in this header the rte_pmd_dpaa_ / RTE_PMD_DPAA_ prefix you already
  used for the two structs.

  struct dpaa_ip4_addr_s holds uint32_t ip_addr[4] and is used for v6
  addresses too, so the ip4 in the name is misleading.

Patch 25/26: drivers: add dpaax enter destructor

  This is the same mechanism as v9 in a different shape, and it still
  does not hold together.

  dpaa_mpool_finish() (patch 13, priority 104, so it runs first) calls
  dpaax_enter_destructor() and then, eleven lines later, calls
  rte_free(rte_dpaa_bpid_info) directly.  It also calls
  bman_free_bpid(), which writes CCSR through bm_pool_set().  The latch
  gates kfree() only, so the two things in the teardown path that
  actually touch EAL memory and hardware are not gated by it.

  Gating kfree() also changes the meaning of that macro for every
  DPAA, BMan and QMan call site, not just the teardown ones, and turns
  it into a silent leak with a pr_debug.

  If the conclusion is that freeing on the way out is not worth doing,
  then say that directly and stop calling the frees in the destructors,
  rather than making free a no-op globally.  Leaking at exit is fine;
  it only shows up under a leak checker.  If the concern is hardware
  state left behind by a process that died, the destructor cannot help
  you there either, since it does not run on a signal kill and is not
  async-signal-safe when it does run.  DPAA has a kernel driver behind
  it, so the fd release handler is the natural place for that cleanup.

  Could you describe the failure you are actually seeing?  If there is
  a crash in a specific teardown ordering it would be easier to fix
  that ordering than to add a global latch.

  Minor: double blank line added in dpaax_iova_table.c before the
  dpaax_handle_memevents() declaration, and is_dpaax_in_destructor()
  would read better as dpaax_is_in_destructor().

Info
----

Patch 03/26: bus/dpaa: fix FQD dest wq channel decoding

  qm_fqid_set() and QM_FQID_MASK are added but unused; only
  qm_fqid_get() has a caller.

Patch 05/26: bus/dpaa: scan max BPID from DTS

  "if (!(start + count))" as the not-found test also fires on a
  malformed DTS entry with start = 0 and count = 0, which then takes
  the warning path silently.  A bool found set inside the loop would be
  clearer and would separate "no node" from "bad node".

Patch 12/26: net/dpaa: optimize FMC MAC type parsing

  dpaa_port_fmc_get_idx_from_name() now runs for every port, including
  the OH/offline early-return case that does not use its result, and
  logs DPAA_PMD_ERR for any port name that contains neither "MAC/" nor
  "OFFLINE/".  Moving the call below the OH check would avoid the
  spurious error on configs that used to work.

  DPAA_1G_MAC_START_IDX and DPAA_2_5G_MAC_START_IDX are now unused.

Patch 13/26: drivers: release DPAA bpid on driver destructor

  #define RTE_PRIORITY_104 in dpaa_mempool.c squats on the EAL macro
  namespace, as do RTE_PRIORITY_102 in dpaa_bus.c and RTE_PRIORITY_103
  in dpaa_ethdev.c.  rte_common.h owns RTE_PRIORITY_*.  The three call
  sites are also inconsistent: two pass a bare number to
  RTE_FINI_PRIO() and this one passes the macro.  (Both expand
  correctly, since RTE_FINI_PRIO's argument is expanded before it
  reaches the ## in RTE_PRIO, so this is style not breakage.)

Patch 15/26: net/dpaa: support Rx/Tx taildrop threshold devarg

  td_threshold and td_tx_threshold are file-scope statics assigned
  per-port in dpaa_dev_init().  This works today only because
  dpaa_rx_queue_init() and dpaa_tx_queue_init() are called from
  dpaa_dev_init() and nowhere else.  Passing the values down as
  arguments, or storing them in struct dpaa_if, would make that
  robust.

Patch 18/26: net/dpaa: support fmcless rxq number as devargs

  The FMCLESS default changes from rte_lcore_count() to
  DPAA_MAX_NUM_PCD_QUEUES, which raises the default FQ and CGRID
  consumption per port on any system with fewer than 8 lcores.  Worth
  a line in the release notes since it changes existing behaviour
  without a devarg being set.

Build notes
-----------

I did not build this revision.  Two things worth covering when you do:

  - Per-commit build with -Dwerror=true.  Patch 07 adds a memset() to
    an inline function in fsl_qman.h, which does not include
    <string.h> and is relying on transitive inclusion.
  - Patch 20 adds struct bm_hw_buf_desc as a __rte_packed_begin member
    of the __rte_aligned(8) bm_buffer union; worth confirming no
    packed/alignment warnings on arm64.

No Reviewed-by on this revision.
