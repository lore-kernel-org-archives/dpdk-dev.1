Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5CC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3C740653;
	Thu,  2 Jul 2026 18:33:04 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 4D66D40265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:33:03 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-37d82f3a244so1753313a91.2
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783009982;
 x=1783614782; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uO28ewcsVb+GE8Nzod2xICkkl18UiPJaTzUxHqsgUhI=;
 b=M2U2GhjaCWztPYmaWrFb0kaP019fzGu0PTI/WiBz9r0u+XutX0CorTAQ413sfUiusK
 oN8ttPsPdZGV89nKGbhVS26cssd+AbWe+swvuIOVsOMH/uLCMY17YiW0Yy3GjwtkOVnw
 OuWUd8GrhIMKnefqug/bIwIDtiGnkAFUSrrpVklULvupU2D3X8t2QUuPwHg6Dru/E+FI
 a69+To/45v6WYYMKVDd8kWO6qwnyr+W6lubTSGf51lz49F6iE7wSbmbsjpX/9Ubd899l
 jtQQJpbpvs6YTW4r38FOemn+211rdxH7Yst6LnT0hZi9vvoX8am6kTfHjQpZ1aUcFW/k
 mZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009982; x=1783614782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uO28ewcsVb+GE8Nzod2xICkkl18UiPJaTzUxHqsgUhI=;
 b=CldaCsRq0BqD7Ubr3Y5thVOWAnW+I4irnogP0PwwxUwZtDZQth/1nC1bjrygeIpA47
 cyBvglZNji/ljICTQjXNCGlBbJSs+KMGpHXv77ctPHm2agv6ut8MAtISfHRFanlhG5vh
 bUIoodElIq3vSld/4XPjwOf4SJLfd0pqJAU/rVIkhMQe8Iv6oEQKtSu9jDMgsYTzqQet
 bibC41dUrGF6DMg7Qq9k7WWFvxFsGPgwBVUnOB/Hu6Gg9Bm0ttNfY3YGrCJnG3IWqGUP
 XY3xdSNHuYYWQCwoX/SSbbvMa7QXYQWSdYHJba5dG9SA6+GQGEjo4Jb+ugN4d3FwgaIR
 vvBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6vH0ospN+ANLGGHMAkVmr5mjAPqne7dAUSCAOs56hClxDz3nvALGIczpNRsRmpVIld74=@dpdk.org
X-Gm-Message-State: AOJu0YxroGUZSE0di02msYG8+GvbZmZDWVtvD5ltAEVHvJdxLzCvIgPx
 P9ivuGQwfc9m62WGqHXokGjH5NSUtTdTt/wfaHQjEX9Ku7+jW9F/ESdsr2cdEekdWW8=
X-Gm-Gg: AfdE7cmcNLVjiy0km6/c2Sildip5XlwpIzBTVlv78LvVWqemGWJqm6mfXkgIRcVpoyt
 cOTMl1E+OYAF36xXZGNu1tmzjpOjYxH2o6AA8Zg9cU+SLTAw/tbgjGy/wC1QqJaSM7tkpCU0yu6
 n48C+0/geArxkk0X8p0C0TsxbS+b+veEGhM4fGLh2vWJ/7zZUtdkqpgXcFMMigLQkbO8//4cXxI
 XN/J6yr41ENzv3m5/Q2F97sZ/rjH8Ddi2HeGimHewK07fOsoJA42ST8tbtWceEAPlqJM+/1ctPv
 gxZ+aSGAVbblzyUcrufGGrb0eNlqlSV+hH0KZOUnuqS1OOQaqwzsg9e57GRIBmR2AcLulSM7ATG
 3bfRvQ7umcmA9k1/O/Nxl6heQLtfLrshsw2QP78smEEO2g70eNUqwaiT2YJKLsVXsSdR1tQ13H9
 ogVyktB6+NG/JG62BVfY+G3cVPJY3Ij2AAFFWq92uMCq3p7FBQSWlYSV84HyJp8rGo
X-Received: by 2002:a17:90a:d44f:b0:37f:133a:3e07 with SMTP id
 98e67ed59e1d1-380aa0fc88cmr7118441a91.2.1783009982272; 
 Thu, 02 Jul 2026 09:33:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9873sm11362117eec.4.2026.07.02.09.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:33:02 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:32:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v6 00/19] DPAA bus/net/mempool/DMA driver fixes and
 improvements
Message-ID: <20260702093259.33f2151f@phoenix.local>
In-Reply-To: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
References: <20260626065655.279742-1-hemant.agrawal@nxp.com>
 <20260702053359.3243907-1-hemant.agrawal@nxp.com>
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

On Thu,  2 Jul 2026 11:03:40 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of correctness fixes, cleanups and feature
> additions across the NXP DPAA bus, net, mempool and DMA drivers.
> 
> 1. Bus/fman infrastructure cleanups (patches 01, 02, 13)
>    - bus/dpaa: refine fman naming and fix global scope
>    - bus/dpaa: scan max BPID from DTS
>    - bus/dpaa: improve log macro and fix bus detection
> 
> 2. Statistics (patch 03)
>    - net/dpaa: add BMI Tx statistics
> 
> 3. Process-type guards (patch 04)
>    - dpaa: add process-type guards to prevent segfaults in secondary
> 
> 4. FQ shutdown hardening (patches 05-11)
>    - bus/dpaa: define helpers for qman channel and wq
>    - drivers: shutdown DPAA FQ by fq descriptor
>    - bus/dpaa: improve FQ shutdown with channel validation
>    - bus/dpaa: enhance DPAA FQ shutdown
>    - drivers: add DPAA cgrid cleanup support
>    - net/dpaa: clean Tx confirmation FQ on device stop
>    - net/dpaa: remove redundant FQ shutdown from Rx queue setup
> 
> 5. net/dpaa improvements (patches 12, 14, 15)
>    - net/dpaa: optimize FM deconfig
>    - net/dpaa: optimize FMC MAC type parsing
>    - net/dpaa: report error on using deferred start
> 
> 6. mempool/dpaa (patches 16-17)
>    - drivers: optimize DPAA multi-entry buffer pool operations
>    - drivers: release DPAA bpid on driver destructor
> 
> 7. dma/dpaa (patch 18)
>    - dma/dpaa: add SG data validation and ERR050757 fix
> 
> 8. net/dpaa ONIC port support (patch 19)
>    - net/dpaa: add ONIC port checks
> 
> v6 changes:
> - Fix bman_release_fast() in patch 16: replace rte_memcpy() on the
>   small bm_bufs[] stack array with memcpy(); the SIMD implementation
>   of rte_memcpy reads in 32/64-byte chunks and triggers
>   -Warray-bounds with GCC 15 / ASAN builds on the 64-byte array.
>   memcpy() is correct here as this is a local stack buffer with no
>   DMA or multi-process constraints.
> 
> v5 changes:
> - Rebased onto current upstream main; resolved conflict in
>   drivers/crypto/dpaa_sec/dpaa_sec.c where upstream removed the
>   cryptodev_name[] local variable and snprintf() call in
>   cryptodev_dpaa_sec_probe() -- patch 04 now uses dpaa_dev->name
>   directly in rte_cryptodev_pmd_create().
> - Resolved conflict in drivers/net/dpaa/dpaa_ethdev.c where upstream
>   removed rte_dpaa_device.eth_dev -- patch 04 now uses
>   rte_eth_dev_allocated() to look up the Ethernet device by name.
> 
> v4 changes:
> - Fix dpaa_bus_dev_compare() to return the strncmp result (previously
>   always returned 0, breaking device matching).
> - Remove the dead get_tx_port_type() function that triggered a clang
>   -Wunused-function CI failure.
> - Guard all dpaa_fm_deconfig() call sites against NULL port_handle to
>   prevent a NULL dereference on partially initialised interfaces.
> - Move the penv variable declaration in dpaa_qdma_init() to the point of
>   use (C99 inline), fixing a spurious -Wunused-variable warning during
>   bisect of earlier patches in the series.
> 
> Gagandeep Singh (2):
>   bus/dpaa: enhance DPAA FQ shutdown
>   dma/dpaa: add SG data validation and ERR050757 fix
> 
> Hemant Agrawal (5):
>   net/dpaa: clean Tx confirmation FQ on device stop
>   net/dpaa: remove redundant FQ shutdown from Rx queue setup
>   net/dpaa: optimize FM deconfig
>   bus/dpaa: improve log macro and fix bus detection
>   net/dpaa: report error on using deferred start
> 
> Jun Yang (10):
>   bus/dpaa: refine fman naming and fix global scope
>   bus/dpaa: scan max BPID from DTS
>   drivers: add BMI Tx statistics
>   bus/dpaa: define helpers for qman channel and wq
>   drivers: shutdown DPAA FQ by fq descriptor
>   bus/dpaa: improve FQ shutdown with channel validation
>   drivers: add DPAA cgrid cleanup support
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: optimize DPAA multi-entry buffer pool operations
>   drivers: release DPAA bpid on driver destructor
> 
> Prashant Gupta (1):
>   drivers: add process-type guards for secondary process
> 
> Vanshika Shukla (1):
>   net/dpaa: add ONIC port checks
> 
>  drivers/bus/dpaa/base/fman/fman.c         |  23 ++--
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 108 +++++++++----------
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 ++++------
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  48 ++++++---
>  drivers/bus/dpaa/base/qbman/qman.c        | 115 +++++++++++---------
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +++-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 ++++-
>  drivers/bus/dpaa/dpaa_bus.c               |  33 ++++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  30 +++++-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 +++++++--
>  drivers/bus/dpaa/include/fsl_qman.h       |  22 +++-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        |   3 -
>  drivers/dma/dpaa/dpaa_qdma.c              | 102 +++++++++++++-----
>  drivers/mempool/dpaa/dpaa_mempool.c       |  75 +++++++++++--
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 122 ++++++++++++++++++----
>  drivers/net/dpaa/dpaa_ethdev.h            |  22 +++-
>  drivers/net/dpaa/dpaa_flow.c              | 120 +++++++++++----------
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 ++++++++-----
>  21 files changed, 725 insertions(+), 345 deletions(-)
> 

Still see lots of things that need fixing in detailed AI review:

Reviewed the v6 DPAA series (19 patches) against current main: applied
cleanly with git am and traced the affected paths in
drivers/{bus,net,mempool,dma}/dpaa.  Three of the errors from the v3
review are still open, and the v3 fix for patch 04 introduced a new
bisect break.  Details below, by patch.  No Reviewed-by this round.

Resolved since v3: the deconfig NULL deref (old 12/19 interaction).
dpaa_fm_deconfig() now NULLs dpaa_intf->port_handle at the end, and all
three close-path callers plus the two dpaa_flow.c sites guard on
port_handle first.  The double-deconfig/NULL-deref can no longer happen.

Patch 03: drivers: add BMI Tx statistics
  Error: the Tx BMI counters are still not read from Tx registers, and
  the xstats loop miscounts.  fman_if_bmi_stats_get_all() and _reset()
  only touch rx_bmi_map; the new tx_bmi_regs fields and
  FMAN_IF_BMI_TX_STAT_OFFSET_* macros are never read by anything.
  In dpaa_dev_xstats_get() the string table is now 13 standard + 8 Rx
  BMI + 4 Tx BMI = 25, but bmi_count is still
  sizeof(dpaa_if_rx_bmi_stats)/4 == 8, so the split point
  (num - (bmi_count - 1) == 18) treats the first 5 Rx-BMI strings as
  standard stats (read with the wrong offsets into the dpaa_if_stats
  array), and the second loop fills the 4 Tx entries from Rx register
  values.  The counters reported for the tx_* names are Rx data.
  Either wire get_all/reset to also read the tx_bmi_map range
  (FMAN_IF_BMI_TX_STAT_OFFSET_START..END) and fix the standard/Rx/Tx
  split, or drop the Tx entries from this patch.

Patch 04: drivers: add process-type guards for secondary process
  Error: this now fails to build standalone, breaking bisect.  The v3
  fix moved the getenv() block up into dpaa_qdma_init(), but the tunable
  declarations were left in patch 18.  After this patch,
  s_data_validation, s_sg_enable and s_pci_read are used but never
  declared (they are added as static int in patch 18/f4f9e13), so the
  commit does not compile.  The getenv/SG-validation tunables belong in
  patch 18, not here; move the whole block (and s_hw_err_check = 1) into
  18 and leave this patch with only the RTE_PROC_PRIMARY guards.  That
  fixes the build and keeps the commit matching its subject.
  Info: the dpaa_sec hunk removes the RTE_PROC_PRIMARY early-return in
  cryptodev_dpaa_sec_probe().  That is correct (dpaa_sec_dev_init() has
  its own primary-only guard), but the commit message should say so.

Patch 13: bus/dpaa: improve log macro and fix bus detection
  Error: dpaa_bus_dev_compare() still carries probe side effects and
  breaks devargs matching.  It is the bus dev_compare callback; the EAL
  (rte_bus_find_devargs) calls it per devargs entry and treats a 0
  return as a match, returning the first entry that matches.  This
  version returns 0 (match) when the sysfs path is absent, and returns
  0 for every call once dpaa_bus.detected is set - so after the first
  device is detected, every name compares equal and the wrong devargs
  is bound.  It also creates the pthread key and, on failure, calls
  dpaa_clean_device_list() and returns the errno as if it were a
  comparison result, all from inside a comparator.
  On top of that, the detection block (sysfs check + detected guard +
  pthread_key_create) is now duplicated: it is still present in
  rte_dpaa_bus_scan() (unchanged) and copied into dev_compare, so this
  is not the "move" the commit message describes.  Keep dev_compare a
  pure comparator (parse + strncmp, no side effects) and leave detection
  where it already is in scan().  The DPAA_DEV_PATH1/2 #defines should
  also not live inside the function body.
  The DPAA_BUS_LOG -> DPAA_BUS_{INFO,ERR,WARN,DEBUG} conversion is fine.

Patch 18: dma/dpaa: add SG data validation and ERR050757 fix
  Warning: the five getenv() tunables (DPAA_QDMA_DATA_VALIDATION,
  DPAA_QDMA_HW_ERR_CHECK, DPAA_QDMA_SG_ENABLE, DPAA_QDMA_SG_MAX_ENTRY_SIZE,
  DPAA_QDMA_PCI_READ) should be devargs; the driver already uses devargs
  (DPAA_DMA_ERROR_CHECK).  checkpatch will also flag the getenv additions.
  (This is the block that must move back here from patch 04.)
  Info: s_hw_err_check changes from bool to int; it is a pure flag, keep
  bool.

Patch 08: bus/dpaa: enhance DPAA FQ shutdown
  Info: qman_find_fq_by_cgrid() still ends with a "do {...} while (1);"
  whose only exits are returns, followed by an unreachable
  "return -ENODEV;".  Drop the dead return.

Patch 17: drivers: release DPAA bpid on driver destructor
  Info: "#define RTE_PRIORITY_104 104" is still unused;
  RTE_FINI_PRIO(dpaa_mpool_finish, 104) uses the literal.  Use the macro
  or drop it.

Patch 19: net/dpaa: add ONIC port checks
  Info: the subject undersells the change.  Besides the fman_onic
  guards, this reworks the VSP path from the flat vsp_bpid[] array to a
  vsp[].vsp_bp[]/bp_num structure and changes the dpaa_port_vsp_cleanup()
  and dpaa_port_vsp_update() signatures.  Consider splitting the VSP
  refactor out, or at least describe it in the commit message.

No Reviewed-by: patches 03, 04 and 13 are functional/build errors that
need a respin.  04 and 18 should be fixed together (move the tunables);
08, 17 and 19 can ride along.
