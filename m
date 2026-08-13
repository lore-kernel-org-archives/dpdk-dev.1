Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B53C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF8684026E;
	Thu, 13 Aug 2026 04:23:30 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id ED2FE40265
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:23:29 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cab973140bso4366205ad.3
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786587809;
 x=1787192609; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mF2az91cHtkN0vvRo5LiPtmuSCqAXKA8qfArQLaV1ac=;
 b=r/jHxEixR68vmmYSswSo4gl1RUMUXsKi8GRbINx9QBhW2XMt5t6zn9xejFtTDgcmyb
 MKPB+F/HKy47s65zsmOEKf0r79Xap0WT+m0y9Qsx/vY6pS44BWy8WlPnG9DT0D17ErGV
 9IGKhcRFLBXDSB/pSI81VLbOr13CfHAMH0w20/ed7g+cO0wnVcH41hmRIK6rejhMcZ7x
 Fp5mu/PpPZRGqimKgEwiwT5p6zqwoxZUg4h/4/gwGAB9YWD7cCXlp6qjV/CS0hBR9PTw
 0cjqRQuoP82cfFC1T7/5oq/MVKzOFp6ktPMqmW9dJ5B41+DGTLWghm2RdRKtGgjTlgfP
 3Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786587809; x=1787192609;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mF2az91cHtkN0vvRo5LiPtmuSCqAXKA8qfArQLaV1ac=;
 b=A8WhOIpV5PLJPDRA8X5NW52kkSvf73rkP+0BkM3iHKV2lRYD3SRLNpOrQq1MmYM+Ak
 N/XEVaVM0B8u7Fd10NA/mdjcr/mVdLcxfKBhYdIBcQjnBDaG/8lz9xTarrCzd/csYTY3
 jS79xNMrgWin/ud7CK36YNsRUV90nBqz+UExdcNiW6/FNNj+SZ9ELxUhILD0vk+3QUs3
 nQijSLr6ZnTUcyhZc3GBECpUWl493ZfKdLZGRZrmXyWFPM2wwOIga1GN0QXGmw3Ec4oy
 gAIo0wwuMhihquca/4QE8sNXOmbh+Q1kSQKZefAY0FzmJf+etjHvufU014+/EZJ3FWD6
 a+UQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyzjVFI6glvXVgAZuU67P0gN4ZXoY+hCztSSfl1yjcQVYphM3EzjkVEDem/WGQqGnoehE=@dpdk.org
X-Gm-Message-State: AOJu0YyVWFaR/ksHYMt3/hThT1J90/zngVTnZ4jOmHQBrEH+gHfQOQdW
 0rd8kjqsVaYwakwiaTF+51HU+bznTYQDxXdaFiJnKK2IwDzxAllBIBtLXtXAoXtoFUE=
X-Gm-Gg: AR+sD126Hhkh29pZQEQbTjbXCokQmuIk2Ve+3cQwIGIdYF7t9G+4q4zo7FCCfWqGnIC
 UId5XRvgdM2/pnw6O11LklZP0kUBnUrrN/iQ1j1XmEQG+nvc5SItWMg82iIwIKQFmyVp7e+ZweT
 p3vbtvpevrhu1KlCcwDTGi8PGMgB22M529VGtls0GPEeFFk+SBfbrS+j2dosGGpJjRjmEh68VFv
 sy6ltgeExX8FT5+s33KsJ9hx0BynQOUbBRZ3A775ioGjifljp8/3bn3EOT38DIV2iYmd9psI1Wb
 +1XgdCsErAjHguenXqLhPDpTGSNkXiDjZwIAJYFkTlb4u6Bji9D4Yak0nyJWRe+7JPjpgYHugir
 VfaivEpKqiP+OoNWY85E0v7i2mjFywrPY4oJPhL5CT2My7pRAAVaIp72eucAqsDbQ7tc/0GhIr8
 4dS3W1ASx47UL5hwa1kTG8sO+ya0d0raMks0Tq5db4TcmAaopd3nJiuad8WAmFFpyEk6H20ukrW
 2pu/+uc3Zk9+FXaDAUWEUfWTWaDdA==
X-Received: by 2002:a05:6a21:999d:b0:3c3:9a7f:7307 with SMTP id
 adf61e73a8af0-3cc55319ed3mr2717199637.24.1786587808507; 
 Wed, 12 Aug 2026 19:23:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf732166sm2775914eec.18.2026.08.12.19.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:23:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:23:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v9 00/25] DPAA driver fixes and improvements
Message-ID: <20260812192318.1187a3ce@phoenix.local>
In-Reply-To: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
References: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-1-hemant.agrawal@nxp.com>
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

On Wed, 12 Aug 2026 23:15:43 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

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
>    - bus/dpaa: define helpers for qman channel and wq
>    - bus/dpaa: shutdown DPAA FQ by fq descriptor
>    - bus/dpaa: improve FQ shutdown with channel validation
>    - bus/dpaa: enhance DPAA FQ shutdown
>    - bus/dpaa: add DPAA cgrid cleanup support
> 
> 4. net/dpaa improvements (patches 09, 11, 13)
>    - net/dpaa: add ONIC port checks
>    - net/dpaa: optimize FM deconfig
>    - net/dpaa: optimize FMC MAC type parsing
> 
> 5. Statistics (patch 10)
>    - drivers: add BMI Tx statistics
> 
> 6. mempool/dpaa (patches 14-15)
>    - drivers: optimize DPAA multi-entry buffer pool operations
>    - drivers: release DPAA bpid on driver destructor
> 
> 7. dma/dpaa (patch 16)
>    - dma/dpaa: add SG data validation and ERR050757 fix
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
>   doc: add 26.11 release notes for NXP DPAA new features
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
>   drivers: add dpaax destructor to gate EAL memory frees
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
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  45 +-
>  drivers/bus/dpaa/base/qbman/qman.c        | 200 ++++--
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
>  drivers/crypto/dpaa_sec/dpaa_sec.c        | 106 +++-
>  drivers/dma/dpaa/dpaa_qdma.c              | 110 +++-
>  drivers/mempool/dpaa/dpaa_mempool.c       |  62 +-
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 301 ++++++++--
>  drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
>  drivers/net/dpaa/dpaa_flow.c              | 221 +++++--
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
>  drivers/net/dpaa/dpaa_oldev.c             | 701 ++++++++++++++++++++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
>  drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
>  drivers/net/dpaa/meson.build              |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h           |  22 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  92 +++
>  33 files changed, 2254 insertions(+), 452 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Still lots of problems here. The AI review with coaching is.
Note: AI is much more polite here than I would be...

Thanks for the respin. A number of the v8 findings are addressed: the
crypto patch has moved after the qman_shutdown_fq() signature change, the
BMI Tx registers are actually read now and the xstats bound matches, both
ORP enqueue bugs are fixed, the mempool cache tuning is gone, and the rate
limit API has its export macro, experimental tag and leak fix. Comments
below on what is left.

Mechanical issues
-----------------

The series does not apply. There are 26 messages for a 25-patch series and
two of them are numbered 24/25:

  [PATCH v9 24/25] common/dpaax: add dpaax_enter_destructor() to gate ...
  [PATCH v9 24/25] drivers: add dpaax destructor to gate EAL memory frees

The diffs are byte-identical, so git am fails on the second and needs
--skip. Please regenerate the series with git format-patch so the numbering
is consistent.

check-git-log.sh reports:

  Wrong headline format:
      common/dpaax: add dpaax_enter_destructor() to gate EAL memory frees
  Wrong headline prefix: expected prefix "drivers:"
  Headline too long
  Wrong 'Fixes' reference:
      Fixes: 78ea4b4fcb52 ("bus/dpaa: improve cleanup")

The release notes are a single trailing patch rather than being updated in
the patch that adds each feature. Documentation and code should be updated
atomically. The commit message for that patch lists eight features but the
.rst documents five: VSP port enhancements, BMI Tx statistics and the ORP
burst enqueue API are not covered.

In doc/guides/nics/dpaa.rst the new "Device Arguments" heading is 16
characters with a 17-character underline. The six entries under it are
term-and-description pairs and would read better as an RST definition list
than as a bullet list.

Commit message body typo in patch 4: "dma/dpaa and net/dpaa rivers".

New code
--------

Patch 6, qman_shutdown_fq(). The pool-channel branch cannot be taken:

  if (channel >= pool_ch_start && channel < pool_ch_end) {
          if (p->config->channel != channel) {
                  ...
                  ret = -EINVAL;

config->channel is documented in qman_priv.h as the portal's dedicated
channel id and is assigned from q_map.channel in qman_driver.c. Dedicated
channels start at QM_CHANNEL_SWPORTAL0 (0); pool channels start at 0x21 or
0x401. The two ranges do not overlap, so the comparison always fails and
every pool-channel FQ shutdown returns -EINVAL. The
QM_SDQCR_CHANNELS_POOL_CONV(channel) drain that the old code did on this
path was removed and not replaced. This is still the state of the code at
the end of the series.

Patch 3, bman_driver.c. of_get_property() is called with a NULL length and
the result is then indexed twice:

  range = of_get_property(dt_node, "fsl,bpid-range", NULL);
  if (!range)
          continue;
  start = rte_be_to_cpu_32(range[BPID_RANGE_START_INDEX]);
  count = rte_be_to_cpu_32(range[BPID_RANGE_COUNT_INDEX]);

A short property in the DTS gives an out-of-bounds read. The equivalent
code for fsl,pool-channel-range in qman_driver.c passes &lenp and rejects
lenp != sizeof(rte_be32_t) * 2; please do the same here.

In the same function, start and count are initialised to 0 and only
assigned inside the loop, so "if (!(start + count))" after the loop is
unreachable whenever the property was found and is a confusing spelling of
"if (!found)".

Patch 2 commit message says "Make fman_ccsr_map_fd static as it is only
used within fman.c". The variable is still non-static at fman.c:19 with an
extern in fman.h, and cannot be made static while fman_hw.c references it.

Patch 6 commit message describes "better handling of ORL (Order Restoration
List) presence and improved error recovery paths"; I do not see that in the
diff. Patch 19 then re-touches the same region of qman_shutdown_fq() that
patch 6 restructured, converting the two ifs into if/else-if. Those two
changes would be clearer squashed.

Several symbols added by the series have no user anywhere in the tree:
qman_enqueue_multi_orp() has no caller, ORP_RWS_WIN_*, ORP_AUTO_ADVANCE_*
and ORP_LATE_ARRIVE_* are unreferenced, and so are DPAA_INVALID_BPID,
MEMMAC_REG_OFFSET and FMAN_IF_BMI_RX/TX_STAT_OFFSET_*. Note that
FMAN_IF_BMI_TX_STAT_OFFSET_START/END reference fmbm_tfrc and fmbm_tbdc,
which are not members of struct tx_bmi_regs, so those two macros will not
compile if anyone uses them. Please add these along with the code that
needs them.

Patch 12 keeps the DPAA_TX_TAILDROP_THRESHOLD environment variable as a
fallback when drv_tx_taildrop is not given, while the Rx path has no
equivalent fallback. If the devargs are the supported interface, the
environment variable should go; if it is being kept for compatibility, that
should be stated in the release notes and the Rx side should match. Also,
when the Tx value exceeds UINT16_MAX it falls back to CGR_RX_PERFQ_THRESH,
an Rx constant, where td_tx_threshold otherwise defaults to 0.

Patch 15, dpaa_get_devargs_int() returns a long that is assigned to an int
without a range check, and a negative drv_fmcless_rxq is only compared
against the upper bound, so a negative value passes through to num_rx_fqs.

Patch 7 adds qman_find_fq_by_cgrid(), used in dpaa_eth_dev_close() with the
comment "Should be FQ not cleaned in previous program." The cgrids being
checked come from this process's own qman_alloc_cgrid_range() at probe, so
at close time any FQ bound to them belongs to this process, not a previous
one. If the intent is to detect state left by an earlier run, that check
belongs at probe before allocation, not at close.

The destructor as presented
---------------------------

Patch 24 does not do what the commit message describes, and I do not think
the approach can work as written.

The commit for the bus destructor says it is "for double check in case
non-gracefully exit", and the body comment repeats "cleanup portals in case
non-graceful exit". RTE_FINI_PRIO is __attribute__((destructor)), which
runs from the ELF fini array on exit() or return from main(). A process
killed by a signal with default disposition is torn down by the kernel and
the fini array never runs. So in the case the comment names, the destructor
does not execute.

The remaining case is a signal handler that calls exit(). There the
destructor path is not async-signal-safe: dpaa_fm_term() calls access(),
remove(), fm_pcd_disable() and DPAA_PMD_ERR (rte_log, vfprintf);
rte_dpaa_portal_fq_close() reaches process_portal_unmap() and kfree(),
which is rte_free() taking heap->lock. If the signal arrives while a thread
holds that lock, the handler deadlocks.

The gating itself is also inconsistent. is_dpaax_in_destructor() only gates
the kfree() macro. dpaa_mpool_finish() sets the flag and then calls
rte_free(rte_dpaa_bpid_info) directly four lines later, which is the exact
operation the flag exists to prevent. And because s_dpaax_in_destructor is
a one-way latch and the destructors run 104, 103, 102 (lowest last, per
rte_common.h), whichever runs first disables kfree() for the other two, so
calling dpaax_enter_destructor() from three drivers is equivalent to
calling it from one.

Separately, the portal-freeing loop in dpaa_finish() is the same loop that
already exists at the end of dpaa_eth_dev_close(), and rte_dpaa_bus has
.cleanup = dpaa_bus_cleanup, which walks the bus calling drv->remove() ->
dpaa_eth_dev_close() and then dpaa_portal_finish(). On a graceful exit that
path has already run and cleared dpaa_bus_global_init, so the destructor
returns immediately. On a non-graceful exit the destructor does not run at
all.

What would help
---------------

Rather than guess at the fix, can you describe the failure this is meant to
address? Specifically:

- What is the observable symptom, and on which exit path does it occur?
  Application returning from main without rte_eal_cleanup(), a signal,
  rte_eal_cleanup() itself leaving something behind, or something else?

- Which resource is not being released, and how is that observed? Note that
  the /dev/fsl-usdpaa fd in process.c is opened lazily and never closed by
  DPDK, so FQIDs, BPIDs and CGRIDs allocated through it should be reclaimed
  by the kernel when the process exits.

- Is there hardware or kernel-side state that genuinely survives process
  exit and blocks a restart? The FMAN PCD deconfig for shared MAC and the
  link autoneg restore are the two candidates I can see, and both are
  already done in dpaa_eth_dev_close().

If the answer is that dpaa_eth_dev_close() or rte_dpaa_remove() is missing
a release on some path, that is a targeted fix with a Fixes: tag and does
not need destructors.

For anything that must be reclaimed after an abnormal exit, my
recommendation is to put it in the kernel driver rather than in DPDK. DPAA
has a kernel driver behind it, and that driver is the natural watchdog
here. The kernel is notified when any process dies, by any means, and gets
to run the release path for /dev/fsl-usdpaa unconditionally -- on exit(),
on SIGKILL, on a segfault, on an OOM kill. No userspace code can offer
that, because in the cases that matter no userspace code runs. A release
handler also cannot itself be killed, cannot deadlock on a heap lock, and
does not care what order anything ran in.

That gives a clean split: rte_eal_cleanup() drives dev_close()/remove() for
the graceful path, and the kernel reclaims everything else when the fd goes
away. Both paths are then reliable in the cases they cover, and neither one
needs a flag to tell it which situation it is in. If the fsl-usdpaa release
handler is not currently reclaiming something it should, fixing it there is
the smaller change and helps every userspace consumer, not just DPDK.

Leaking memory at process exit is not by itself a defect worth this
machinery, so if the trigger is a report from a leak checker, say so and we
can decide whether anything is needed at all.
