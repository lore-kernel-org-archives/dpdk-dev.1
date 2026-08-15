Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B0C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1573940272;
	Sat, 15 Aug 2026 17:14:48 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 8BFF14026C
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:14:46 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3055078a91.1
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786806885;
 x=1787411685; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5kSjy5+LXJOgKvLMMoVPwAHtqmOADwUhZNHJANclGP8=;
 b=kTZm2L7sh9BpI8QkR/ztFz1snCK8a7fvpBVh8vj6mYNCAp/BuBY/0yNbzdL3LADbUH
 PG8xSYwR/ocp3+rLeIt9mV8zUYmmzBqrkK+L77949HMoaIWfcwrM74fKTa8mnqFtBpdN
 snwCdRyghhT5Oe3HGv5OcvIBkRpIp9BXAJfUbFi2kp7F+nuTNsdeS9Gmulr3rOASWjWn
 vtJmSotgR4Kdf3lYK2NOfKHsp04c37JJRcOY94e8kIzRzq9dXu9UlPeCAH02CKaL9WYQ
 nyXQIGIg6BFKafp8UM1QnyB36q9mESuzPiOeIxgUZvZg9Wcbb5XyAWwhAYKv4G7sV+1n
 r8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786806885; x=1787411685;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5kSjy5+LXJOgKvLMMoVPwAHtqmOADwUhZNHJANclGP8=;
 b=V1kxzny8M6XgdhdWVbxuzhYgNtnAOPD/Fta1RGgTNiyt/3+qaAjL5yqFP0lhRqSJz5
 kaH+T43c2lsvw3puCqZaQpWuyrTtMbH9WZBTC9oEoOw9Zo3l00KnpdzTPykxyYgOROV3
 nZuh/WguZWubbyWjo65hReNEtyXFDatlroDzn6XMTNsdfhd1nPCwmqfpzCBUI4dnhtSs
 nX2R35yUb35xXVnrbguXnfr6XwGdW2pIubIHoHdImAg857yzAWZcZjSaFVaIDErvdETl
 Lh5zCkjeTdodqsSYRvyWbcWlOXyeM6gxCHksQcBV+U6sh+bu1xu7zysC1lW6oTgBEtdj
 NrFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcDjg/StuRaQlkDd/50UJKzvzcPCRfIiQ43OID0/0x7VL8ac2J2Qc0PbvbFTqeXmcPKT0=@dpdk.org
X-Gm-Message-State: AOJu0YwJS3XW01XzrnZoJ/fZs1dvWG2gZOdyeZb4nvep3FCqSj9bPmnr
 xm9/d/0lI2lCDf/ZgZEZ47M/PsG6YqguZ3m4wIkCD7un4ppPANfTughbLiICqKamlIs=
X-Gm-Gg: AR+sD1387Uc9Nr6nFYYTFVudqslsmRnyyXTcQIO2dygUgorrl9LJ2U+kyTM10dBJw73
 XjGn0s8qd1JTXAeoVak1aodKRhj/N9sLffWK/zl0mPUNPP8Qim2xj3xWU1inmJYchOykfdfzIjr
 SsFzHBFVVfmVGmyovLmW7yA2rDFK4IL2tlIfmmEBPUPFbMZd/uBcjAvaK4ybkzm7u5SJSGoikFu
 M6W4Qel8jrEqr7Ywr19okkaeCrvvTPDPIYNjDcQQbZUBDTStSzMUwq4nxfyyE7aqzIHD+v0Z6HF
 DpIGq3folCuyWpZhe+ipJk5nGlRfxcDvC/upi7M/10LYif3ISLbGUzCV0KFWegKoI/Q4X0ND0f4
 JmlCjqqcceE518LHILb8rlU2PGTkhHuRb19p3/iiDOImbRoQWOhKPubo7tqDJVH5nebra4r4T9n
 28luP1MOnKjPNxTe9dTuciLtcMA7s3TVjjJ0nIslgeVmmSgRlSvL4Jlm8TGYXXw1U7cErPcEOcw
 4mAqz4jQumVYUldzHvBdEgs+txr91zACdkwBIEu
X-Received: by 2002:a17:90b:520d:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-3933b6d0171mr16010294a91.3.1786806885117; 
 Sat, 15 Aug 2026 08:14:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d61e1cccsm14376281eec.8.2026.08.15.08.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:14:44 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:14:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v11 00/25] DPAA driver fixes and improvements
Message-ID: <20260815081436.0acb8976@phoenix.local>
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
 <20260813144205.2505031-1-hemant.agrawal@nxp.com>
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

On Thu, 13 Aug 2026 20:11:40 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> v11: address AI review comments; skipping false positive ones.
>   - net/dpaa: fix lost close error in rte_dpaa_remove()
>   - net/dpaa: fix NULL dereference on rte_dpaa_bpid_info in oldev rx
>     queue setup
>   - net/dpaa: fix error logging in oldev tx queue setup to include
>     return code and return proper -EINVAL
> 
> v10: address further AI review comments
>   - dma/dpaa: expose compile-time static flags (sg_enable,
>     data_validation, pci_read) as probe-time devargs with corrected
>     logic and updated documentation
>   - bus/dpaa: fix pool-channel FQ shutdown always returning -EINVAL
>     (wrong affinity check; dedicated and pool channel ranges never
>     overlap)
>   - mempool/dpaa: fix double-free of bpid_info on pool release
> 
> v9: fix bissect issue and other AI review comments
> 
> This series collects a set of correctness fixes, cleanups and feature
> additions across the NXP DPAA bus, net, mempool and DMA drivers.
> 
> 1. Bus/fman infrastructure cleanups (patches 01, 02, 12)
>    - bus/dpaa: refine fman naming and fix global scope
>    - bus/dpaa: scan max BPID from DTS
>    - bus/dpaa: improve log macro and fix bus detection
> 
> 2. Process-type guards (patch 03)
>    - drivers: add process-type guards to prevent segfaults in secondary
> 
> 3. FQ shutdown hardening (patches 04-08)
>    - bus/dpaa: shutdown DPAA FQ by fq descriptor
>    - bus/dpaa: improve FQ shutdown with channel validation
>    - bus/dpaa: add DPAA cgrid cleanup support
> 
> 4. net/dpaa improvements (patches 09, 11, 13)
>    - net/dpaa: optimize FM deconfig
>    - net/dpaa: optimize FMC MAC type parsing
> 
> 5. Statistics (patch 10)
>    - drivers: add BMI Tx statistics
> 
> 6. mempool/dpaa (patch 14)
>    - drivers: release DPAA bpid on driver destructor
> 
> 7. dma/dpaa (patches 15-16)
>    - dma/dpaa: add SG data validation and ERR050757 fix
>    - dma/dpaa: expose static flags as probe-time devargs
> 
> 8. net/dpaa features (patches 17-22)
>    - net/dpaa: support Rx/Tx taildrop threshold devarg
>    - net/dpaa: add Tx rate limiting API
>    - bus/dpaa: orp queue create and burst enqueue
>    - net/dpaa: support fmcless rxq number as devargs
>    - net/dpaa: support non fmX-macY type of shared Ethernet name
>    - bus/dpaa: optimize DPAA multi-entry buffer pool operations
> 
> 9. Shutdown and cleanup (patches 23-24)
>    - drivers: improve shutdown fq with channel
>    - drivers: improve crypto fq resource handling
>    - net/dpaa: enhance VSP port support
>    - drivers: add offline (O/H) port device support
>    - drivers: add dpaax enter destructor to gate EAL memory frees
> 
> 10. Documentation and release notes (patch 25)
>     - doc: update release notes with NXP DPAA changes
> 
> Gagandeep Singh (3):
>   net/dpaa: fix device remove
>   dma/dpaa: add SG data validation and ERR050757
>   drivers: add offline (O/H) port device support
> 
> Hemant Agrawal (6):
>   net/dpaa: optimize FM deconfig
>   net/dpaa: support Rx/Tx taildrop threshold devarg
>   net/dpaa: add Tx rate limiting API
>   net/dpaa: support non fmX-macY type of shared Ethernet name
>   bus/dpaa: improve log macro and fix bus detection
>   doc: update release notes with NXP DPAA changes
> 
> Jun Yang (14):
>   bus/dpaa: refine fman naming and fix global scope
>   bus/dpaa: scan max BPID from DTS
>   drivers: shutdown DPAA FQ by fq descriptor
>   bus/dpaa: improve FQ shutdown with channel validation
>   bus/dpaa: add DPAA cgrid cleanup support
>   drivers: add BMI Tx statistics
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: release DPAA bpid on driver destructor
>   bus/dpaa: orp queue create and burst enqueue
>   net/dpaa: support fmcless rxq number as devargs
>   bus/dpaa: optimize DPAA multi-entry buffer pool operations
>   drivers: improve shutdown fq with channel
>   drivers: improve  crypto fq resource handling
>   drivers: add dpaax enter destructor to gate EAL memory frees
> 
> Prashant Gupta (1):
>   drivers: add process-type guards for secondary process
> 
> Vanshika Shukla (1):
>   net/dpaa: enhance VSP port support
> 
>  doc/guides/dmadevs/dpaa.rst               |  29 +-
>  doc/guides/nics/dpaa.rst                  |  39 +-
>  doc/guides/rel_notes/release_26_11.rst    |  29 +
>  drivers/bus/dpaa/base/fman/fman.c         |  23 +-
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 111 ++--
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
>  drivers/bus/dpaa/base/qbman/qman.c        | 207 +++++--
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 164 +++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  20 +-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |  54 +-
>  drivers/common/dpaax/compat.h             |  22 +-
>  drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 +++-
>  drivers/dma/dpaa/dpaa_qdma.c              | 110 +++-
>  drivers/mempool/dpaa/dpaa_mempool.c       |  64 +-
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 310 ++++++++--
>  drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
>  drivers/net/dpaa/dpaa_flow.c              | 221 +++++--
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
>  drivers/net/dpaa/dpaa_oldev.c             | 705 ++++++++++++++++++++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
>  drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
>  drivers/net/dpaa/meson.build              |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h           |  23 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  93 +++
>  33 files changed, 2282 insertions(+), 457 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Using Claude Opus 5 and latest AGENTS.md, it still sees some
issues worth investigating.

Errors

Patch 04/25: drivers: add process-type guards for secondary process

  The qman.c hunk is an unrelated, undocumented bug fix.  The old code
  read the FQD dest_wq as:

      channel = dest_wq & 0x7;
      wq      = dest_wq >> 3;

  and the new qm_fqd_get_chan()/qm_fqd_get_wq() helpers reverse that:
  channel is bits 15:3, wq is bits 2:0.  The new split is the correct
  one -- qman_shutdown_fq() compares channel against the pool-channel
  range, which cannot work with a 0-7 value -- but this is a real
  functional fix landing in a patch whose subject and body describe
  only RTE_PROC_PRIMARY guards.  Split it into its own commit with a
  Fixes: tag and Cc: stable@dpdk.org.

  Info: qm_fqd_get_wq(), qm_fqid_set() and QM_FQID_MASK are added but
  never used anywhere in the tree.  Commit message says "rivers".

Patch 08/25: drivers: add BMI Tx statistics

  The Tx BMI counters are never enabled and never reset.  get_all()
  now correctly reads tx_regs, but:

    fman_if_bmi_stats_enable()  -> writes only regs->fmbm_rstc
    fman_if_bmi_stats_disable() -> writes only regs->fmbm_rstc
    fman_if_bmi_stats_reset()   -> zeroes only the eight Rx counters

  FMBM_TSTC has the same counters-enable bit as FMBM_RSTC, so with the
  bit clear the four new tx_* xstats read 0 for the lifetime of the
  port.  Even if the hardware counted unconditionally,
  rte_eth_xstats_reset() would still leave tx_bad_frames_count,
  tx_frame_length_discard, tx_frames_unsupported_format and
  tx_buf_deallocate at their old values -- a stats_reset that silently
  resets only part of the set.

  Apply FMAN_BMI_COUNTERS_EN to tx_regs->fmbm_tstc in enable/disable,
  and zero the four Tx counters in reset.  The register offsets
  themselves check out: fmbm_tstc lands at 0x200, matching fmbm_rstc.

Warnings

Patch 06/25: bus/dpaa: improve FQ shutdown with channel validation

  The commit message describes the opposite of the code.  It claims
  "add validation that the portal's affine channel matches the FQ's
  channel for pool-channel FQs, and only restore SDQCR when it was
  actually changed."  The diff removes the affinity check (the inline
  comment explains, correctly, that it could never pass) and restores
  SDQCR unconditionally.  Rewrite the message to match.

  Info: pr_warn("Pool channel(%04x) configured != default(0x%04x)")
  -- the first value is missing its 0x prefix.

Patch 07/25: bus/dpaa: add DPAA cgrid cleanup support

  qman_find_fq_by_cgrid() is a linear MC-command scan of the FQID
  space, and dpaa_eth_dev_close() calls it once per Rx CGR and once
  per Tx CGR.  Each iteration is a QUERYFQ_NP hardware round trip,
  plus a QUERYFQ for every non-OOS FQ.  It terminates early on
  ERR_FQID, so the bound is the provisioned FQD count rather than
  2^24, but on a 16+16 queue port that is still 32 full scans of every
  FQ on the SoC on each port close.  Consider tracking CGR->FQ
  association in software, or at minimum bounding the scan to the
  FQID range the driver itself allocated.

  Second issue: the function returns on the first match.  If more than
  one FQ is bound to the CGR, only one is shut down and the CGR is
  deleted with the others still attached -- which is the exact
  condition the patch is trying to prevent.  It needs to loop until no
  FQ remains.

Patch 10/25: net/dpaa: optimize FMC MAC type parsing

  Unknown mac_type values now fall through to a bare index compare.
  The old code ended with an explicit
  "Invalid MAC(mac_idx=%d) type(%d)" / -EINVAL for any type outside
  {1g, 2.5g, 10g}.  In the new form those types skip all three
  pport->type filters and match on fif->mac_idx == num alone, so an
  fman_onic or fman_offline_internal interface can bind to a port
  entry of any direction or speed.  Restore the explicit reject.

  dpaa_port_fmc_get_idx_from_name() uses atoi() with no validation --
  a malformed suffix yields index 0, which silently matches mac_idx 0.
  Use strtol() and check the end pointer.

  DPAA_PMD_INFO("MAC index of %s is %d") fires for every port entry on
  every interface during FMC parse.  This belongs at DEBUG.

  Info: the && continuations are indented one tab, level with the
  statement body:

      if (fif->mac_type == fman_mac_1g &&
              pport->type != e_FM_PORT_TYPE_RX)
              return -ENODEV;

  DPDK style wants a double-indent continuation here.

Patch 02/25: bus/dpaa: refine fman naming and fix global scope

  Subject promises a global-scope fix; the patch is a pure rename of
  ccsr_map -> memac_map and bmi_map -> rx_bmi_map.  Drop the second
  clause from the subject.

Patch 11/25: drivers: release DPAA bpid on driver destructor

  dpaa_mbuf_free_pool() now frees rte_dpaa_bpid_info and NULLs it once
  the last mempool is gone.  That pointer is cached in
  rxq->bp_array by both dpaa_ethdev.c and dpaa_oldev.c at queue-setup
  time, and dpaa_rxtx.c reads rte_dpaa_bpid_info on the fast path.
  Freeing an mbuf pool while any port still holds a queue set up
  against it leaves those bp_array pointers dangling.  Either
  reference-count the table or leave it allocated until the
  destructor.

  Info: #define RTE_PRIORITY_104 104 puts a new RTE_-prefixed macro in
  a driver .c file.  dpaa_finish() in net/dpaa passes 103 as a literal;
  match that.

Not yet covered: patches 12-25 (DMA SG validation, taildrop devargs, Tx
rate limiting, ORP enqueue, fmcless/shared-MAC devargs, bpool
optimization, the log-macro/bus-detection patch that carried the v6
dpaa_bus_dev_compare error, VSP, the 705-line offline-port driver,
crypto FQ handling, the dpaax destructor gate, and the release notes).
