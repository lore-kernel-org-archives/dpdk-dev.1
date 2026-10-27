Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D41606A327
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S6qzmd+N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34F4D400D7;
	Wed, 28 Oct 2026 00:46:11 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D1D44003C
 for <dev@dpdk.org>; Wed, 28 Oct 2026 00:46:09 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so176783a12.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793144767;
 x=1793749567; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=68CLdCsDh4YzyHvm5gazLwu3LNTfTpBX1Yu/GVnR96I=;
 b=S6qzmd+NyTLRoN0CF5e20u5ZKzjriciw2Lo3d6xTvdJKsA6M3MzhbUTnVqoKxqAWEG
 DWF/F0UrsMtYAYtHifz/yhV7m2tdiefoVBsfofuV/gkaXGUwdoxNOtUWA8R8cGN5hXKO
 8/4ELAQatiTaPPJjrsgw6KHVYP44AYPPGJFnLWHpOxA8OyC7zHRhR7PUhLHgKZsn+0ad
 EX9d3CG4tf9Mio1H1DsReRRRo87djBx6z7IAx83wP9c/RtlnJMlvzkErrNagWY74M2CV
 ax8Q2uElKIi7NNv+ls43i5L4FC0efEqlPfXzYljWAsYFRTvfGFKwgDPuSBDd9H288Pvq
 vr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793144767; x=1793749567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68CLdCsDh4YzyHvm5gazLwu3LNTfTpBX1Yu/GVnR96I=;
 b=YcOocckgAcrn+NZjyTn7kPgYnpEheN5xhpb99512gLeH1g9OYkL7XnGt5PikNc1BX7
 2owZboxEWLz76vCr51TvvgMIIz1YSS2CXXlwSUx3iyT/zEkf4B6YJBKGIUyaaPEZ8zi8
 z5mbqywQtrsERQA5alG2VR2yHYVj5PA5yINBvNKvDH+Xo0wlz2N46GbkE0Cvv/1ltSuZ
 thFXXQ2jLD64opFo7ilesk1vM7yATZ37y/jWYJG9L1cRBScZz2DbWAUhMxe6j+IeomxI
 92JKkDDUa6tnLnt+ZAnEh2dGisSczKjb3L6Pzd0I02WS+z04MaPY0KfsVqRIO4hw/BZc
 Bp+Q==
X-Gm-Message-State: AFq9FYIEFU1eIuNySOki2O++zq1VQ8JmxyP/VX97pxJp0/LnAXLB9TMa
 EH/WriGzDkaPaJCJ0OqVA3ha3na8ICZdWf9aM3/FmanuW0RfiozM4+vEZGBB9ncNoH8=
X-Gm-Gg: AYBFou2ClAkkMehRTnpmWNOYBxa2zRLJ90rHoDpMr2XeFBgD+hP+fw/ardoT+WN1Drf
 PBBmOG+AskEVI/9NY0c9Zqn18EOU6JPqpGhshg52hGR3p1TVHwhaMxumkg8+j6f9Fck21sIWzVK
 E5DjMgHB0LetVy6boGzQ1pSGm3RQ0s/xi5FtfZ1nSYh1LESNI51gm13hZ/DqLI3jH05lRDq2wCA
 5tg2fHip4cBtuvfPh4DpgM6Y+HQcc/2Pka5UwYlCQjV6HeOMkUaHSv0smYlQ1/A9ZNd5BOI0ZrL
 HkvUK+gvQgA68o0rrbBZ5g7GFRuGMt6UjhVGDfPv40jCYlkuaxM9r9TFWsqxTMhvpMfDIe3mQOd
 vpBXd54+xp1i3EkeAyKIwJVf1KZlIQ99I82iL+MNjF0Z0YsOmEzpD4ez5fm6kmhopli8pea7+72
 15FjSUu+AlnNvVgverKVWYV6/eOLbCfeMUuJTMGU+QsMzsH7ZKzftPjncnjhORjf/YKrkUbqRio
 IAJ86PpDz09nLKPO76hJlE9QwxflCA49oc1hgodd6cIlDlxM5q9BrwM4eoV6IdRP1QOiDvGe5qE
 7Ke5bCkNgrr6ZXpf0OpIdg==
X-Received: by 2002:a17:90b:4c81:b0:3ac:9a03:20bb with SMTP id
 98e67ed59e1d1-3ae57f9b35emr461644a91.18.1793144766418; 
 Tue, 27 Oct 2026 16:46:06 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae579b63aesm383995a91.2.2026.10.27.16.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:46:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:45:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4-S3 00/65] net/dpaa2, event/dpaa2 and fslmc rework
Message-ID: <20261027164555.7517cae9@phoenix.local>
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 19:12:40 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This is the final DPAA2 upstreaming sub-series, applied on top of
> v7-S1 ("dpaa2: bus, DMA and mempool base fixes") and
> v14-S2 ("net/dpaa2 updates").
> 
> The series reworks the DPAA2 datapath, flow steering, metering,
> eventdev integration and fslmc infrastructure. It consolidates
> device configuration handling, improves queue and portal management,
> and adds support for additional DPNI, eventdev and datapath
> capabilities.
> 
> Highlights:
>   - add DMA bypass translation support and table-driven devargs parsing;
>   - optimize Tx queue, channel and dequeue processing paths;
>   - centralize MC version, SoC detection and endpoint handling;
>   - rework RSS, flow steering, QoS and default action programming;
>   - add rte_mtr support and meter rte_flow actions;
>   - improve eventdev scheduling, DPCI support and multi-port operation;
>   - support runtime IEEE1588 timestamping;
>   - rework xstats collection and MAC statistics handling;
>   - unify enqueue/dequeue datapaths across net, crypto and eventdev;
>   - add Tx fast paths and reduce confirmation overhead.
> 
> Every commit builds cleanly with arm64 and -Werror and the
> series remains bisectable.
> 
> Breeson Francis (1):
>   net/dpaa2: rework xstats with page table and MAC support
> 
> Hemant Agrawal (1):
>   net/dpaa2: reject Rx queue deferred start
> 
> Jun Yang (63):
>   net/dpaa2: refactor and optimize Rx parser result decode
>   net/dpaa2: generate devargs table and string from one list
>   crypto/dpaa2_sec: use table-driven devargs parsing
>   dma/dpaa2: use table-driven devargs parsing
>   net/dpaa2: unify debug dump via log based helpers
>   net/dpaa2: expose Rx L3/L4/L5 offsets via mbuf dynfield
>   net/dpaa2: optimize dpaa2 Tx queue and channel mapping
>   bus/fslmc: split bus-level device walk from VFIO primitives
>   bus/fslmc: centralize MC version and SoC detection in the bus layer
>   net/dpaa2: remove unused soft parser loader
>   net/dpaa2: cache per-rxq DPNI queue cfg and share CGID per TC
>   The dpaa2 PMD so far supported only two Tx buffer release schemes:
>     direct release by hardware, and an absolute Tx confirmation mode
>     (drv_tx_conf=1) where every transmitted buffer is returned on a Tx
>     confirmation queue that software must poll to free the buffers.
>     Absolute confirmation adds a confirmation descriptor and a poll cost
>     for all packets, even those the hardware could free on its own.
>   net/dpaa2: support runtime IEEE1588 timestamping
>   bus/fslmc: consume dpaa2 DQRR entries in batches
>   bus/fslmc: align dpaa2 event port depths with hardware rings
>   net/dpaa2: support multi-DPNI FS redirect and QoS table v3
>   net/dpaa2: unify xstats layout and add DPMAC counter struct
>   net/dpaa2: reimplement xstats_get() on top of xstats_get_by_id()
>   net/dpaa2: fetch only requested MAC xstats in one MC call
>   net/dpaa2: rework flow with per-table profile and group types
>   net/dpaa2: reimplement RSS distribution via rte_flow
>   net/dpaa2: expand IP address extracts for RSS hashing
>   net/dpaa2: add policer v2 MC command and L2/L3 byte units
>   net/dpaa2: support rte_mtr and METER rte_flow action
>   net/dpaa2: program flow table miss actions via rte_flow
>   net/dpaa2: support DCB Rx mode via rte_flow
>   bus/fslmc: support DPCI peer and dynamic queues
>   bus/fslmc: add alloc/free DPIO API for non-affine portals
>   event/dpaa2: rework event port model and DPCI handling
>   event/dpaa2: fix Tx adapter enqueue for mixed destinations
>   event/dpaa2: rework self test for dynamic link and balance check
>   event/dpaa2: add DPCON based standalone Rx scheduler
>   event/dpaa2: add push mode to DPCON Rx scheduler
>   event/dpaa2: drain Rx scheduler queues on destroy
>   event/dpaa2: track and detach attached Rx queues
>   net/dpaa2: add multi-port Tx API
>   event/dpaa2: limit attached Rx flows per event queue
>   eventdev: fix port link/unlink callback return documentation
>   event/dpaa2: allow event queue link to multiple ports
>   event/dpaa2: report available DPIO count and fix create cleanup
>   event/dpaa2: use event port DPIO for dequeue wait
>   bus/fslmc: consolidate DPIO interrupt setup and bound coalescing
>   event/dpaa2: honor configured dequeue timeout
>   bus/fslmc: use EAL API for DPIO interrupt
>   bus/fslmc: defer DPIO interrupt setup and bind portal to worker core
>   bus/fslmc: move Tx SG mempool to fslmc bus
>   net/dpaa2: move DPNI endpoint lookup out of the fslmc bus
>   net/dpaa2: add APIs to query device info and set default action
>   net/dpaa2: consolidate dequeue paths and optimize fast path
>   net/dpaa2: bind per-queue DPIO for rx-queue interrupts
>   net/dpaa2: add API to clean Tx confirmation queue
>   event/dpaa2: fix DQRR held buffer accounting on enqueue
>   bus/fslmc: store dequeue dpio in mbuf seq dynfield
>   bus/fslmc: use explicit flags for mbuf seqn encoding
>   net/dpaa2: unify tx burst path for ordered and atomic enqueue
>   crypto/dpaa2_sec: unify enqueue burst path for ordered enqueue
>   bus/fslmc: track atomic DCA context per dequeue dpio
>   bus/fslmc: move enqueue response descriptors to per-queue
>   event/dpaa2: add ordered schedule type support
>   bus/fslmc: make DPAA2 ORP/ODP ordering per-queue instead of per-device
>   event/dpaa2: support multi-port enqueue in selftest random event
>     generator
>   event/dpaa2: do not fail device creation on DPCI errors
>   net/dpaa2: add Tx fast path for no-confirmation case
> 
>  doc/guides/nics/dpaa2.rst                     |   29 +-
>  doc/guides/rel_notes/release_26_11.rst        |   10 +
>  drivers/bus/fslmc/bus_fslmc_driver.h          |   46 +-
>  drivers/bus/fslmc/fslmc_bus.c                 |  321 +-
>  drivers/bus/fslmc/fslmc_logs.h                |    2 +
>  drivers/bus/fslmc/fslmc_vfio.c                |  562 +-
>  drivers/bus/fslmc/fslmc_vfio.h                |   72 +-
>  drivers/bus/fslmc/mc/dpci.c                   |   37 +-
>  drivers/bus/fslmc/mc/fsl_dpci.h               |   12 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  304 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |   25 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  668 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |   37 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   52 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  305 +-
>  drivers/bus/fslmc/private.h                   |   15 +-
>  .../fslmc/qbman/include/fsl_qbman_portal.h    |   24 +-
>  drivers/bus/fslmc/qbman/qbman_portal.c        |  100 +-
>  drivers/bus/fslmc/qbman/qbman_portal.h        |   11 +-
>  drivers/bus/fslmc/qbman/qbman_sys.h           |    4 +-
>  drivers/common/dpaax/dpaax_devarg.h           |   69 +
>  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  559 +-
>  drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h     |   11 +-
>  drivers/dma/dpaa2/dpaa2_qdma.c                |   92 +-
>  drivers/dma/dpaa2/dpaa2_qdma.h                |   15 +-
>  drivers/event/dpaa2/dpaa2_eventdev.c          | 1266 ++-
>  drivers/event/dpaa2/dpaa2_eventdev.h          |   61 +-
>  drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  370 +-
>  drivers/event/dpaa2/dpaa2_scheduler.c         |  673 ++
>  drivers/event/dpaa2/meson.build               |    3 +-
>  drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |  544 --
>  drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c              | 3201 ++++---
>  drivers/net/dpaa2/dpaa2_ethdev.h              |  997 +-
>  drivers/net/dpaa2/dpaa2_flow.c                | 8426 ++++++++---------
>  drivers/net/dpaa2/dpaa2_meter.c               |  584 ++
>  drivers/net/dpaa2/dpaa2_parse_dump.h          |  707 +-
>  drivers/net/dpaa2/dpaa2_parser_decode.h       | 1148 +++
>  drivers/net/dpaa2/dpaa2_pmd_logs.h            |   34 +-
>  drivers/net/dpaa2/dpaa2_ptp.c                 |  177 +-
>  drivers/net/dpaa2/dpaa2_recycle.c             |   18 +-
>  drivers/net/dpaa2/dpaa2_rxtx.c                | 2818 +++---
>  drivers/net/dpaa2/dpaa2_sparser.c             |  137 -
>  drivers/net/dpaa2/dpaa2_sparser.h             |  202 -
>  drivers/net/dpaa2/mc/dpni.c                   |  127 +-
>  drivers/net/dpaa2/mc/fsl_dpni.h               |  378 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |   30 +-
>  drivers/net/dpaa2/mc/fsl_net.h                |    4 +-
>  drivers/net/dpaa2/meson.build                 |    3 +-
>  drivers/net/dpaa2/rte_pmd_dpaa2.h             |  238 +-
>  lib/eventdev/eventdev_pmd.h                   |    9 +-
>  51 files changed, 14514 insertions(+), 11029 deletions(-)
>  create mode 100644 drivers/common/dpaax/dpaax_devarg.h
>  create mode 100644 drivers/event/dpaa2/dpaa2_scheduler.c
>  delete mode 100644 drivers/net/dpaa2/base/dpaa2_hw_dpni.c
>  create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
>  create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h
> 

Still has lots and lots of AI review warnings and errors.
Some maybe false positives but most likely not.

Review: [PATCH v4-S3 00/65] DPAA2 refactor (Jun Yang, Prashant Gupta)

Applied with git am --3way on dpdk-next-net for-main (52ebbf7d9de8),
all 65 apply. Per-commit builds: gcc 13.3, x86_64, -Dwerror=true,
net/event/crypto/dma/raw dpaa2 drivers, with and without
RTE_LIBRTE_IEEE1588. Findings checked against post-apply source.

Series-level
============

1. Bugs in released code are fixed silently inside refactors, or are
   carried forward by them. These need standalone fixes at the head of
   the series with Fixes: and Cc: stable@dpdk.org so they can be
   backported:

   - dpaa2_flow_item_convert() allocates num items, writes
     new_pattern[num] (heap overflow on every flow create). 21 keeps it.
     Fixes: 9ec293434e90 ("net/dpaa2: support tunnel inner protocol flow matching")
   - RAW item length not bounded against the key buffer. 21 keeps it.
     Fixes: 3f881f8d6eb0 ("net/dpaa2: support raw flow classification")
   - dpaa2_sec enqueue: "~(UINT64_C(1) << *dpaa2_seqn(m) & IDXMASK)",
     << binds tighter than &, shift by >= 2^31 is UB. 56 keeps it.
     Fixes: 4562de326d30 ("crypto/dpaa2_sec: support ordered queue")
   - Cross-driver seqn encoding mismatch: dpaa2_sec stores
     "DCA | idx", net/event decode "seqn - 1" (56).
   - eventdev enqueue clears DQRR_HELD/DQRR_SIZE before the enqueue
     succeeds (54).
     Fixes: b75061260c34 ("event/dpaa2: add enqueue and dequeue functionality")
   - dpaa2_eth_eventq_attach(): "LOWEST / queue_conf->ev.priority"
     divides by zero for priority 0 (highest). 34 replaces it with a
     new divide by zero for num_priorities == 1.
     Fixes: 3835cc228f32 ("event/dpaa2: set priority as per DPCON device")
   - priv->ep_dev_type/ep_name are never set in main, so
     rte_pmd_dpaa2_ep_name() returns "" and the speed capability MAC
     check is dead. 49 fixes it without saying so.
     Fixes: a0f8ddc41218 ("net/dpaa2: add API to get endpoint name")
     Fixes: c78fa95fa9b0 ("net/dpaa2: set speed capabilities based on actual MAC")
   - nb_tx_queues = num_tx_tcs * num_channels can exceed tx_vq[16] (07).
     Fixes: 72100f0dee21 ("net/dpaa2: support level 2 in traffic management")
   - dpaax_ptp.h compares be16 udp->dst_port to host order 319/320; UDP
     PTP never matches on LE. 13 makes dpaa2 depend on it.
     Fixes: 6cc1246b3b1a ("net/dpaa: support IEEE 1588 by timesync API")
   - qbman_swp_interrupt_set_inhibit() writes 0xffffffff (44).
     Fixes: 293c0ca94c36 ("bus/fslmc: support memory backed portals with QBMAN 5.0")
   - eventdev create leaks DPCON/DPCI on setup_dpci failure, and
     info_get counts DPIOs already in use (42).
     Fixes: 8a5d7a8ec74b ("event/dpaa2: initialize device")
     Fixes: 342f299568ea ("event/dpaa2: return correct number of event ports")
   - tx_burst returns short on rte_vlan_insert() failure (57 keeps
     it).

2. Build failures on for-main (gcc 13, -Werror):
   - 08..65: fslmc_vfio.h adds #include <rte_vfio.h>, which no longer
     exists after the VFIO rework in main (now dev_vfio.h). Every
     patch from 08 on fails. Rebase on current for-main.
   - 21..65: -Warray-bounds in dpaa2_flow_extract_support():
       uint8_t mask[64], i;
       rte_memcpy(mask, mask_support, size);   /* uint8_t size */
     Bound size (if (size > sizeof(mask)) return -EINVAL;) and use
     memcpy.
   - 42/43: rte_atomic16_read() is gone from for-main; implicit
     declaration. Replaced in 44.
   - 12: DPAA2_TX_CONF_ENABLE removed but still used under
     RTE_LIBRTE_IEEE1588 until 13.
   With the vfio include and the mask bound patched locally, every
   other commit builds and the tip links.

   Functional bisect breaks:
   - 29/30: enqueue checks priv->evq_info[q].event_port which nothing
     sets until 31; no event can be enqueued.
   - 31: dequeue_wait still uses DPAA2_PER_LCORE_DPIO which dequeue no
     longer affines; NULL deref until 43/44.
   - 57/58: dqrr_held[] stores ~(1 << idx) then does HELD &= ~held,
     corrupting held state until 59.
   - 08: MC firmware version check removed, restored in 09.

3. Squash or reorder: 12+13, 17..20 (xstats rewritten four times, 17
   has wrong name/id mapping), 23 before 22, 34+35, 44+47+52 (DPIO intr
   API reworked three times), 49 before 17 (all DPAA2_MAC checks in
   17..20 are dead until 49), 59 into 57/58.

4. Too large to review or bisect: 01 (~1800 lines), 12 (~1400 lines
   in rxtx.c), 21 (10k lines), 31 (4 drivers), 51, 62. Split refactor
   (no behaviour change) from behaviour changes and from new features.
   Several commit logs do not describe the diff (01, 12, 18, 21, 37,
   47, 63).

5. Eventdev API problems: enqueue only accepted to queues linked to
   the calling port (29, 41; main crashes instead, still wrong);
   port_link replaces links instead of
   adding (31); ORDERED dropped (29) and re-added (61); Rx adapter
   queue_id overwritten with the ethdev rxq id (31); 10 ms delay in
   enqueue on unlinked ports (31). The selftest (33) was rewritten
   around these restrictions. Run dpdk-test-eventdev pipeline/perf
   against the series.

6. 47 and 52 write "performance" to cpufreq scaling_governor and
   rewrite /proc/irq/N/smp_affinity_list from the event and Rx fast
   paths, using rte_lcore_id() as a CPU number. Host power policy is
   not a PMD decision. Drop it.

7. getenv() for device config: new DPAA2_SCHEDULE_RX_PREFETCH (34);
   44 extends the existing DPAA2_PORTAL_INTR_* env vars to event and
   rx-intr DPIOs. Use devargs or API arguments. (Removing env vars in
   01, 21, 62 is welcome; note it in release notes.)

8. New PMD-specific API surface: rte_pmd_dpaa2_rx_get_offset,
   flow_table_query, rte_dpaa2_flow_group_set_miss_actions,
   rte_dpaa2_scheduler_*, rte_dpaa2_dev_tx_multi_ports,
   rx_queue_info_get, dev_info_get, configure_default_action,
   clean_tx_conf, and group type bits encoded into rte_flow
   attr->group. None have doxygen or release notes. Mixed rte_dpaa2_
   and rte_pmd_dpaa2_ prefixes. Justify on the list why these cannot
   be done with generic ethdev/rte_flow/eventdev API.

9. Commit 12 has no subject; the first body paragraph became the
   Subject header.

10. 21 rewrites the flow engine on top of the current for-main
   dpaa2_flow.c and drops three fixes just merged there:
   - 5384de9604 MPLS key width 4 bytes: back to 3, every extract
     after MPLS is one byte off.
   - a441f8345c minimum key size only for DPNI >= 8.7: version
     check dropped, older DPNI get 24-byte entries.
   - fa6bed304e default miss queue = last queue of the TC: back to
     the first queue; its 26.11 release note is now wrong.
   Rebase the rework onto these.


Patch findings
==============

[01/65] net/dpaa2: refactor and optimize Rx parser result decode

Error: VLAN ptype wrong, QinQ never detected
  dpaa2_dev_rx_parse_vlan() gets the summary after
  "frc_u.u16 &= ~DPAA2_PKT_TYPE_VLAN", so "sum->vlan > 1" is never
  true. RTE_PTYPE_L2_* is an enumerated field: ETHER(1) | VLAN(6) == 7
  == QINQ, so every single-tagged frame is reported as QinQ. Same for
  VLAN|ARP in parse_frc.
  Fix: pass the unmasked summary;
    *pt = (*pt & ~RTE_PTYPE_L2_MASK) |
          (sum->vlan > 1 ? RTE_PTYPE_L2_ETHER_QINQ
                         : RTE_PTYPE_L2_ETHER_VLAN);

Error: IEEE1588 Rx timestamp no longer recorded
  The RTE_LIBRTE_IEEE1588 block in dpaa2_dev_prefetch_rx_common() is
  deleted and parse_frc() never sets RX_IEEE1588_TMST.
  Fix: keep the block; set PTP|TMST from fas->ptp in parse_frc().

Error: rejected Tx SG FD freed with the Rx SG converter
  dpaa2_dev_free_eqresp_buf() calls dpaa2_eth_sg_fd_to_mbuf() on a Tx
  FD. Tx SGEs hold data addresses, not buffer starts, so
  DPAA2_INLINE_MBUF_FROM_BUF() yields a bogus mbuf that is written and
  freed; inline SGT is freed twice.
  Fix: Tx-specific free (recover the mbuf stored for the FD).

Warning: !by_channel guard on the error queue drain removed from the
  prefetch path; reintroduces the portal conflict the comment in
  main describes. Restore it.

Warning: dpaa2_dump_print() logs to RTE_LOGTYPE_USER1. Use
  dpaa2_logtype_pmd. 05 claims driver-logtype filtering as its goal.

Warning: eCPRI type 4 dump memcpy()s wire bytes into a bitfield over a
  be32 word; rma_id/ele_id are swapped. Main assembled bytes
  explicitly.


[02/65] net/dpaa2: generate devargs table and string from one list

Error: secondary process clears primary's priv->flags
  "priv->flags = 0; dpaax_get_devargs(...)" now runs before the
  secondary early return. priv is shared dev_private.
  Fix: parse/reset flags in the primary only.

Warning: devarg semantics changed (also 03, 04). Old handler accepted
  only "1"; now atoi(): "=0" clears, "=yes" clears silently, key-only
  args pass value == NULL to handlers that atoi() it (03, 06 crash).
  Fix: check pair->value != NULL once in dpaax_get_devargs(), parse
  with strtoul + end check, document the change.


[03/65] crypto/dpaa2_sec: use table-driven devargs parsing

Error: drv_strict_order can never take effect
  dpaax_get_devargs() now runs at the top of dpaa2_sec_dev_init(); the
  primary path later does "internals->en_loose_ordered = true;".
  Fix: set the default before parsing, drop the later assignment.

Error: atoi(pair->value) with value NULL on "drv_strict_order" with no
  "=" crashes probe. Same in 06 (drv_parse_protocol_offset).

Warning: dump_level and en_loose_ordered are written by secondary
  probe into shared dev_private. Primary only.


[06/65] net/dpaa2: expose Rx L3/L4/L5 offsets via mbuf dynfield

Warning: rte_pmd_dpaa2_rx_get_offset() returns stale dynfield data
  for eventdev and loopback Rx paths (never filled there). Per-packet
  DPAA2_PMD_ERR. No doxygen, no doc for drv_parse_protocol_offset.

Warning: dpaa2_dev_rx_parse_offset() runs after
  dpaa2_eth_sg_fd_to_mbuf() and reads the annotation at
  DPAA2_GET_FD_ADDR(fd); for S/G that SGT buffer was already freed
  with rte_pktmbuf_free_seg(). Parse inside the fd_to_mbuf helpers
  before the free. 13 copies the pattern in print_parser_result().


[07/65] net/dpaa2: optimize dpaa2 Tx queue and channel mapping

Error: Tx queue to TC/channel mapping changed, not in log
  "channel_id = tc_id < num_channels ? tx_channels[tc_id] :
  tx_channels[num_channels - 1]": with 2 channels and 8 TCs, TC1..7
  share ch1 and channels 2..N are unused. txq i moves from TC (i % tcs)
  to TC (i / q_per_tc). dpaa2_tm still advertises
  num_tx_tc * num_channels leaves.
  Fix: keep the per-channel mapping or document and update dpaa2_tm.

Warning: the tx_vq[]/rx_vq[] caps fix a released overflow (see
  series item 1). Split out with Fixes/stable.


[08/65] bus/fslmc: split bus-level device walk from VFIO primitives

Error: #include <rte_vfio.h> in fslmc_vfio.h; header no longer exists
  on for-main (dev_vfio.h). Build fails from here to 65.

Warning: MC firmware version check removed here, restored in 09.
  Leave it in place in 08.


[09/65] bus/fslmc: centralize MC version and SoC detection

Warning: fslmc_vfio_core_cluster_sdest() divides by
  dpaa2_cluster_size before checking it for zero. Check first.


[10/65] net/dpaa2: remove unused soft parser loader

Warning: ss_offset/ss_iova/ss_param_iova are now unused; remove.
  The /dev/mem O_RDWR probe moved to bus scan should be O_RDONLY /
  PROT_READ and log errno, not fd.


[11/65] net/dpaa2: cache per-rxq DPNI queue cfg and share CGID per TC

Error: cgid_in_use[] shrunk to MAX_TCS (8), still indexed up to
  max_cgs = attr.num_cgs (up to 255).
  Fix: priv->max_cgs = RTE_MIN(attr.num_cgs, MAX_TCS).

Error: eventq_detach no longer detaches
  Clears DPNI_QUEUE_OPT_DEST from options and then calls
  dpni_set_queue(); MC ignores the destination, FQ stays on the DPCON.
  Still so at 65. cfg is NULL after rx_queue_release or close with no
  re-setup and is dereferenced unchecked.
  Fix: if (!cfg) return -EINVAL; set DEST_NONE and pass
  DPNI_QUEUE_OPT_DEST.

Error: rx_queue_setup err_quit frees a DPCON owned by an earlier setup
  (dpcon_allocated removed). Restore the local flag.

Warning: cgid_in_use[tc]++ not undone on setup failure; CG taildrop
  never programmed for that TC again.


[12/65] (no subject)

Error: subject line missing (see series item 9). Log claims Rx
  FD-to-mbuf helpers are reused, omits IEEE1588 and TM taildrop
  removal.

Error: bisect break with RTE_LIBRTE_IEEE1588 (series item 2).

Error: indirect mbufs sent with parent's data_off/data_len
  "mi = rte_mbuf_from_indirect(mbuf); ... mbuf = mi;" then the FD is
  built from mi. A clone after adj/trim (ip_frag) sends wrong bytes.
  Fix: build FD from rte_pktmbuf_iova(m)/m->data_len of the indirect.

Error: indirect refcount handling is use-after-free
  simple_fd drops a ref on the clone without taking one on mi; sge
  helpers rte_pktmbuf_init()+free_seg() live indirects; conf path
  writes "mi->next = cur_seg->next" into a shared parent.
  Fix: never reinit a live mbuf; take a ref on mi or copy.

Error: NO_CONF single-segment path lets HW free shared buffers
  Shared direct mbufs get mempool_to_bpid(); HW releases a buffer
  others hold. Main set IVP and dropped one ref.
  Fix: if (rte_mbuf_refcnt_read(m) > 1) { DPAA2_SET_FD_IVP(fd);
       rte_mbuf_refcnt_update(m, -1); }

Error: inline SGT buffer gets a BPID in both FD and SGE[0]; released
  twice. Set DPAA2_SET_FLE_IVP for cur_seg == sg_mbuf.

Error: conf S/G with cloned head: sg_mbuf->next points at the freed
  head; double free on confirmation.

Error: per-packet helper failure returns short after the helper
  already freed/relinked the mbuf; caller frees it again. Free the
  packet, count a drop, continue.

Error: Tx-conf VDQ left outstanding when storage is freed; QBMan can
  DMA into freed memory. Drain and dpaa2_clear_queue_active_dps()
  before dpaa2_queue_storage_free().

Warning: TM software taildrop (tm_sw_td) silently removed; dpaa2_tm
  still sets it.

Warning: dpaa2_dev_free_eqresp_buf() rebuilds mbuf via
  rte_dpaa2_bpid_info[256] for conf FDs (BPID MAX_BPID); loopback FDs
  with drv_tx_conf=1 have stash config in FLC, deref'd as mbuf.

Warning: dynamic confirm writes FAEAD at buf_addr + 0x58 with no
  headroom check for foreign/extbuf mbufs.

Warning: tx_ordered "void *mq[nb_pkts]" VLA; multi_txq tx_again never
  taken; tx_conf pulled once per packet.


[13/65] net/dpaa2: support runtime IEEE1588 timestamping

Error: read_tx_timestamp tests txq->ts_to_cnfd on the Tx queue; the
  counter lives on tx_conf_queue. Never waits; returns stale value.
  53 rewrites the line and keeps the bug.
  Fix: txq->tx_conf_queue->ts_to_cnfd, bounded wait, -EAGAIN.

Error: dynfield written at offset 0 when unregistered
  rx_ts_offset is registered only with RX_OFFLOAD_TIMESTAMP; after
  timesync_enable() without it every Rx mbuf's buf_addr is
  overwritten.
  Fix: rx_ts_offset = -1 at init; write only when >= 0.

Error: tx_burst issues dpni_set_single_step_cfg() (global MC lock, up
  to 1 s spin) and races on ptp_correction_offset across lcores.
  Configure one-step from the control path only.

Error: S/G frames get a stale timestamp
  dpaa2_dev_rx_read_timestamp() reads m->buf_addr + PTA after
  dpaa2_eth_sg_fd_to_mbuf(); for S/G the annotation is in the SGT
  buffer (FD addr), already freed. Main read fd_addr + PTA. Read it
  inside the fd_to_mbuf helpers.

Warning: priv->rx_timestamp stored for every packet from every lcore,
  not only FAS_PTP frames. Eventdev Rx paths lose timestamps.

Warning: ts_to_cnfd incremented after enqueue (conf may decrement
  first). Once the wrong-counter bug is fixed, read_tx_timestamp
  drains conf from the control thread with q_storage[rte_lcore_id()]
  (LCORE_ID_ANY out of bounds).

Warning: per-packet WARN/INFO in Tx path. PTP Tx now needs an
  undocumented drv_tx_conf/drv_tx_dyn_conf.


[14/65] bus/fslmc: consume dpaa2 DQRR entries in batches

Warning: released atomic contexts stay held until ci_flush_th is
  reached; if the loop exits on nb_events they block those flows on
  all ports until this lcore polls again. Flush after the release
  loop.


[17/65] net/dpaa2: rework xstats with page table and MAC support

Error: xstats_get(NULL, 0) returns 0 instead of the count, so the
  driver xstats disappear from size queries (telemetry). 19 keeps it;
  n > count returns -EINVAL on non-DPMAC ports.
  Fix: count = dpaa2_xstats_count(dev);
       if (xstats == NULL || n < count) return count;

Warning: stats_get memsets stats (wipes ethdev rx_nombuf), puts HW
  nobuffer in rx_nombuf, counts discards in both ierrors and imissed.
  Keep main's mapping.

Warning: policer page fetched for all 8 TCs ("tc < MAX_TCS" always
  true); MC error on a missing TC fails xstats. Use num_rx_tc.

Info: rte_le_to_cpu_64() dropped on MAC counters read from MC.


[18/65] net/dpaa2: unify xstats layout and add DPMAC counter struct

Warning: log says no behaviour change; all MAC/policer xstat names
  change and DPAA2_MAC_NUM_STATS 46->62 requests new counters from MC.
  User visible: document it.

Warning: ".pg.field = (uint64_t)RTE_STR(field)" stores pointers in
  uint64_t; not a constant expression on 32-bit. Use a separate
  const char * table.


[20/65] net/dpaa2: fetch only requested MAC xstats in one MC call

Error: repeated MAC ids overrun mac_val[62] on stack and the DMA
  buffer; "uint16_t i" vs "uint32_t n" loops forever for n > 65535.
  Fix: bound mac_num, flush in chunks; uint32_t i.

Warning: MAC DMA buffers allocated on every call and every port; an
  alloc failure fails stats_get on non-MAC ports.


[21/65] net/dpaa2: rework flow with per-table profile and group types

Error: -Warray-bounds build failure (series item 2)
  dpaa2_flow_extract_support(): uint8_t mask[64] filled with
  rte_memcpy(mask, mask_support, size) with no bound on size.

Error: reverts for-main 5384de9604, a441f8345c, fa6bed304e (series
  item 10). MPLS field_size "sizeof(uint8_t) * 3" must be 4;
  dpaa2_flow_entry_size() must keep the dpaa2_dev_cmp_dpni_ver(priv,
  8, 7) check; default miss queue must stay the last queue of the TC.

Error: QoS-only flows accept DROP/PORT_ID/REPRESENTED_PORT, but QoS
  entries cannot drop or redirect; traffic is steered to the TC and
  create returns 0. Allow only QUEUE/JUMP for QoS-only flows.

Error: s_dpaa2_flow_proto_handle[64] indexed by user item type; enum
  already goes to 70 and PMD items are negative. Bounds check.

Error: actions_update[4] on stack, check_actions_support() writes one
  entry per matching action plus END with no bound.

Error: dpaa2_flow_actions_update() passes flow->qos_flow to the FS
  update; NULL for FS-only flows. Pass flow->fs_flow.

Error: dpaa2_flow_rss_action_update() tests items[i - 1].type != END
  after the loop: rejects every non-empty pattern, reads items[-1] for
  [END].

Error: RAW extract writes dpkg.extracts[raw_idx] in place and bumps
  num_extracts; overwrites the IP address extract. Use
  dpaa2_dpkg_insert_extract().

Error: group type bits not stripped
  attr->group = id | type << 8 is compared with rxq->tc_index and used
  in "group * qos_entries_per_tc + priority". QUEUE/RSS on QoS/MIX
  groups always rejected; with drv_qos_entries_per_tc, QoS/MIX flows
  (including the PMD's DCB flows from 27) fail with -ENOSPC.
  Fix: tc = RTE_DPAA2_FLOW_GROUP_ID_GET(attr->group) and use it.

Error: IPv6 item sets flow->ip_src/ip_dst = NET_PROT_IPV4; first
  destroy shrinks IPv6 extracts to 4 bytes.

Error: dpaa2_flow_create_*_flow() calls dpaa2_flow_clean() which
  frees application-held flows (UAF on later rte_flow_destroy()),
  before the new flow is even parsed. Return -EEXIST instead.

Error: [JUMP, END] also programs an FS entry with JUMP as its action;
  log says JUMP is QoS-only.

Error: failed create leaves the shared key profile modified (holes
  inserted in every flow's key) with HW not reprogrammed.

Error: PPPoE handler uses DPAA2_PARSER_MPLS_ID, fields_num 1
  (session_id never extracted).

Error: IPv4 fragment_offset: any mask sets the IP_FRAG FAF bit to 1,
  so "spec 0 / mask 0x3fff" (non-fragments) matches fragments only.

Error: remove_invalid_extract() returns 0 when only IP extracts are
  removed; table not reprogrammed, RSS destroy returns -EINVAL and
  leaks.

Error: flow_table_query derefs flow->qos_flow/fs_flow without NULL
  check; crashes on QoS-only/FS-only/RSS flows.

Error: new symbols tagged with old versions
    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_flow_group_set_miss_actions, 23.11)
    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_flow_table_query, 24.11)
  Neither exists in main. Use 26.11.

Error: single-TC ports now always create a QoS entry, but QoS table
  config returns early for num_rx_tc <= 1.

Warning: ip_addr_offset not adjusted when a preceding non-IP extract
  is removed; second IP offset uses ip_addr[1].max_size instead of
  ip_addr[0].max_size.

Warning: flow_destroy does LIST_REMOVE then frees only on full
  success; "ret |= -errno" ORs errnos; error never set.

Warning: query does a table dump, discards it, returns 0 for any
  action. Return -ENOTSUP.

Warning: validate ignores unsupported actions that create rejects;
  out-of-range group silently becomes QoS group 0.

Warning: fprintf(stderr, ...) in dpaa2_extract_ip_addr_add(); ~350
  lines of static inline flow helpers in dpaa2_ethdev.h. Use
  DPAA2_PMD_ERR, move helpers into dpaa2_flow.c.

Warning: dev_init returns 0 on extract_param/entry_map alloc failure.

Warning: drv_qos_entries_per_tc undocumented, atoi() into uint16_t.

Warning: commit log does not match code (env var vs devarg, flag
  names, query, JUMP). Split: data model, handler table, devargs,
  actions_update, miss actions, query, RSS.


[22/65] net/dpaa2: reimplement RSS distribution via rte_flow

Error: tbl_profile->rss_flow is the internal dpaa2_generic_flow, not
  the rte_flow handle; rte_flow_destroy() on it does LIST_REMOVE on the
  wrong type. rss_hash_update/reta_update always -EINVAL once RSS is
  active.

Error: rte_pmd_dpaa2.h now includes <ethdev_driver.h> and the inline
  derefs rte_eth_devices[]; installed header no longer usable by apps.
  The inline also leaks the flow handle and passes queue = NULL with
  queue_num > 0.

Warning: stable symbol rte_pmd_dpaa2_set_custom_hash removed (now an
  experimental inline). 26.11 is an ABI window, but the removal needs
  a deprecation notice in a prior release.

Warning: creating any FS flow destroys the PMD's RSS flow; after that
  rss_hash_update silently returns 0.

Warning: rss_hash_update returns 0 with nothing programmed when no
  RSS flow exists.

Warning: PMD-created RSS/DCB/miss flows live on the user's flow list;
  rte_flow_flush() removes them and leaves rss_flow/dcb_flow[] stale
  (also 26, 27). Use internal helpers.


[25/65] net/dpaa2: support rte_mtr and METER rte_flow action

Error: METER unreachable
    } else if (meter_action->type == RTE_FLOW_ACTION_TYPE_METER_MARK)
  repeats the first test. Compare with RTE_FLOW_ACTION_TYPE_METER.

Error: rte_mtr rates are bytes/s uint64_t; policer cir/eir are
  uint32_t Kbps. Programs 125x too high and truncates.
  Fix: cir_kbps = cir * 8 / 1000; reject > UINT32_MAX at profile_add.

Warning: profile/policy delete frees meters still in use (no -EBUSY),
  duplicate ids accepted, meter_destroy ignores bound flows; objects
  leak on close; rte_zmalloc for CPU-only lists.

Warning: rte_spinlock_init(&priv->meter_lock) in mtr_ops_get, which
  runs on every rte_mtr call. Control ops are not thread safe by
  convention; drop the lock.

Warning: packet_mode > 1 used as a hidden unit selector; meter flow
  accepts any pattern; DO_NOT_RESET_COUNTERS sent to old MC.

Warning: dpaa2_flow_create_rss_flow() destroys user meter flows on
  reconfigure; later rte_flow_destroy() is use-after-free.

Warning: meter_profile_update/meter_policy_update only store the new
  id; the DPNI policer is never reprogrammed, so updating a bound meter
  has no effect. Reprogram or return -ENOTSUP while in use.


[26/65] net/dpaa2: program flow table miss actions via rte_flow

Warning: miss-action errors only logged in dev_configure; QoS call
  made when qos_entries == 0 logs ERR on every configure. Also ~170
  lines of unrelated code motion and errno changes not in the log.


[27/65] net/dpaa2: support DCB Rx mode via rte_flow

Error: dcb_tc[] is indexed by priority and holds the TC; code treats
  it the other way round.
  Fix: for (prio = 0; prio < RTE_ETH_DCB_NUM_USER_PRIORITIES; prio++)
           dpaa2_setup_flow_dcb_dist(dev, prio, dcb_tc[prio]);

Error: dcb_flow[] cleared only at close; stop/configure fails with
  -ENODATA on the second configure.

Warning: dcb_info reports identity mapping, not the configured one.


[29/65] bus/fslmc: support DPCI peer and dynamic queues

Error: "uint16_t expected = 0;" moved out of TAILQ_FOREACH in
  rte_dpaa2_alloc_dpci_dev(); a failed CAS leaves expected == 1, so
  the next in-use DPCI is handed out again. Same in 30 for DPIO.
  Fix: declare expected inside the loop.

Error: dpci_get_peer_attributes() decodes with dpci_rsp_get_attr;
  use dpci_rsp_get_peer_attr (num_of_priorities at byte 8).

Error: DPCI Rx DQ storage alloc removed; raw/dpaa2_cmdif still does
  rxq->q_storage[0]->dq_storage[0] -> NULL deref.

Error: enqueue validation failures "goto send_partial" without
  frames_to_send = loop; garbage descriptors pushed to QBMan (29-30,
  fixed in 31). rte_errno never set (still at 65).

Error: dpaa2_eventdev_create() do/while over free DPCON/DPCI pairs
  has no bound; more than 16 pairs write past priv->evq_info[16].
  Fixed in 41/42; keep the bounded for loop here.

Warning: ORDERED and NONSEQ_MODE dropped while QUEUE_ALL_TYPES still
  advertised; not in log. 61 re-adds them; do not drop them here.

Warning: free does fetch_sub on a 0/1 flag; no detach resets cb/dest,
  so a freed DPCI returns -EBUSY on reuse.


[31/65] event/dpaa2: rework event port model and DPCI handling

Error: DCA consumed on the wrong portal
  Dequeue records held DQRR on portal->dpio_dev; net Tx, Tx adapter
  and dpaa2_sec still use DPAA2_PER_LCORE_PORTAL/DQRR_*.

Error: port_link: "ret = rte_event_port_unlink(...); if (ret) return
  ret;" unlink returns the count unlinked; second link returns it
  without linking (31-40). Linking must add, not replace.

Error: dequeue_wait still uses DPAA2_PER_LCORE_DPIO; dev_stop drains
  with dequeue_burst(.., 1, 1) from the control thread, so
  rte_event_dev_stop() can crash even with timeout 0 (until 43).

Error: dequeue counts an unwritten event when rxq has no cb.

Error: enqueue livelock: after validation error or env_pool empty,
  "while (nb_events)" restarts at the same event forever. Return
  num_tx with rte_errno.

Error: dpaa2_ethq->ev.queue_id = eth_rx_queue_id overrides the Rx
  adapter's event queue id; flow_id forced regardless of
  FLOW_ID_VALID.

Warning: rte_delay_us(10000) in enqueue/dequeue on unlinked ports,
  under port_lock.

Warning: Rx adapter queue_del made a no-op until 37.

Warning: RTE_DPAA2_EVENT_PORT_CFG_ATOMIC uses bit 31 of the library
  owned event_port_cfg, declared in the net header.

Warning: 1024-entry mempool with 512 cache per DPCI Rx queue at probe
  (~1 MB hugepage each), whether used or not; caps in-flight events at
  1024 while max_num_events reports INT32_MAX - 1.


[32/65] event/dpaa2: fix Tx adapter enqueue for mixed destinations

Warning: SAME_DEST guarantees one port/queue; the old code was right.
  Dropping rte_eth_tx_burst() breaks non-dpaa2 ethdevs, which caps
  report as INTERNAL_PORT and get cast to struct dpaa2_queue. Drop or
  restrict caps to dpaa2 ports.


[34/65] event/dpaa2: add DPCON based standalone Rx scheduler

Error: pull size not clamped: nb_pkts passed to the pull descriptor
  instead of pull_size; storage holds dpaa2_dqrr_size entries.

Error: "uint8_t priority_step = 256 / num_priorities" is 0 for
  num_priorities == 1; then divides by it. Use unsigned int.

Warning: getenv("DPAA2_SCHEDULE_RX_PREFETCH"). Use the mode argument
  added in 35.

Warning: destroy leaks DQ storage; q_storage[rte_lcore_id()] with no
  LCORE_ID_ANY check; scheduler API declared in the net header, no
  doxygen; max_prio returns num_priorities not num_priorities - 1.


[35/65] event/dpaa2: add push mode to DPCON Rx scheduler

Error: first rx on each lcore issues MC commands (attach, static
  dequeue channel) and writes shared port_queue[].configured from
  concurrent workers. Attach on the control path.

Error: rte_dpaa2_scheduler_max_prio() derefs dpcon_dev[0], NULL in
  push mode until lcore 0 receives.

Warning: push mode allocates an unused DPCI per lcore.

Warning: push mode leaves queue_conf zeroed; sched_type 0 is ORDERED,
  so every rxq gets the ordered cb and an ORP. Set PARALLEL for both
  modes in scheduler_add().


[36/65] event/dpaa2: drain Rx scheduler queues on destroy

Warning: drains other lcores' portals from the control thread;
  prefetch pulls left by workers never consumed; rte_delay_ms(1) per
  drained packet.


[37/65] event/dpaa2: track and detach attached Rx queues

Error: push detach loops attach_num (lcore count) over port_queue[];
  NULL eth_dev or rxqs left bound to a freed DPCON.

Error: queue_del(-1) detaches every ethdev's rxqs, not this port's.

Error: Rx adapter stop drains all event ports from the control thread
  while workers run, then detaches; start is a no-op, so stop/start
  loses Rx. Log does not match.

Error: evq_info[].dpni_rxqs[] keep rxq pointers past ethdev close;
  eventdev close detaches freed memory with priv->hw NULL.

Warning: attach not idempotent (re-add double counts); close skipped
  when never started (leaks DPIOs).


[38/65] net/dpaa2: add multi-port Tx API

Warning: "struct dpaa2_queue *txq[nb_pkts]" VLA; no port/txq_id
  validation; no doxygen; per-packet failure returns short; copy-path
  mbufs freed before enqueue are reported unsent (double free).


[39/65] event/dpaa2: limit attached Rx flows per event queue

Error: max_event_queue_flows lowered to 1024 while queue_def_conf
  still sets nb_atomic_flows 2048; rte_event_queue_setup() with
  defaults fails. Use a separate attach bound.

Warning: dpni_rxq_num widened to uint16_t but eth_queue_del() loops
  with uint8_t j, k; more than 255 rxqs never terminates.


[40/65] eventdev: fix port link/unlink callback return documentation

Warning: library change in a vendor series; send standalone to the
  eventdev maintainer with Fixes:. "Number of unlinks successfully
  established" reads wrong; drop the NXP copyright on a Cavium header
  for a comment fix.


[41/65] event/dpaa2: allow event queue link to multiple ports

Warning: port_unlink indexes pos[16]/evq_infos[16] by nb_unlinks,
  which can exceed 16 with repeated queue ids. Stack overflow.

Warning: enqueue still rejects queues not linked to the port
  (series item 5). Main crashes there instead; both violate the API.


[42/65] event/dpaa2: report available DPIO count and fix create cleanup

Error: rte_atomic16_read() no longer exists in for-main; 42 and 43
  fail to build (implicit declaration).
  Fix: rte_atomic_load_explicit(&dpio_dev->ref_count,
       rte_memory_order_relaxed)

Warning: failed create still calls event_dev_probing_finish() and
  never releases the eventdev (also 64). The create leak and info_get
  count fixes need Fixes/stable (series item 1).

Warning: DPAA2_EVENTQ_LINK_CONF_MAX rewrite and unused
  DPAA2_EVENT_MAX_PORTS not in log.


[44/65] bus/fslmc: consolidate DPIO interrupt setup

Warning: existing getenv() thresholds now applied in the bus
  allocator to every interrupt DPIO; sscanf return unchecked. The
  set_inhibit change is a fix (series item 1).

Warning: ethrx portals now armed at alloc; net rx_queue_intr_enable
  then returns early and gets holdoff 0xff. 52 reverts it.


[45/65] event/dpaa2: honor configured dequeue timeout

Warning: timeout_ticks honoured without PER_DEQUEUE_TIMEOUT, and in
  global mode timeout_ticks == 0 still waits dequeue_timeout_ns;
  64-bit divide on every burst; ns * event_hz overflows; ms truncated
  to int for epoll_wait.

[46/65] bus/fslmc: use EAL API for DPIO interrupt

Warning: event driver logs with DPAA2_PMD_DP_DEBUG (net logtype,
  reached through an accidental include chain); dpaa2_logtype_pmd is
  not exported, so shared builds with DP debug fail to link. Use the
  eventdev log macro.


[47/65] bus/fslmc: defer DPIO interrupt setup and bind portal to worker

Error: driver writes cpufreq scaling_governor and /proc/irq affinity
  from dpaa2_event_portal_io_prepare() (fast path). Drop the governor
  code; do affinity/stashing at port setup.

Error: "cpu = rte_lcore_id()" used as physical CPU for IRQ affinity,
  governor and stashing. Use dpaa2_get_core_id().

Warning: eventfd leaked per intr init/deinit cycle.

Warning: log mentions an "unlikely" hunk that does not exist; three
  helpers exported then made static in 52.


[48/65] bus/fslmc: move Tx SG mempool to fslmc bus

Error: Rx SG walk bound removed
  -	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
  +	while (!DPAA2_SG_IS_FINAL(sge)) {
  Log claims it is now bounded. Restore the bound.

Warning: SG pool created unconditionally at bus probe, also for
  crypto-only and secondary; NULL result ignored.


[49/65] net/dpaa2: move DPNI endpoint lookup out of the fslmc bus

Warning: fixes ep_dev_type/ep_name never being set in main (series
  item 1). Say so, add Fixes, move before 17.


[50/65] net/dpaa2: add APIs to query device info and set default action

Error: new symbols tagged 25.11
    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_rx_queue_info_get, 25.11)
    RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_info_get, 25.11)
  Use 26.11. No doxygen or release notes for the three functions.


[51/65] net/dpaa2: consolidate dequeue paths and optimize fast path

Error: scheduler prefetch priming inverted
  "if (likely(q_storage->active_dqs))" never primes on first call,
  then derefs NULL dq_storage. Use if (unlikely(!...)).

Warning: tx_conf "if (refcnt_read > 1) refcnt_update(-1)" races with
  the other owner and skips chained segments. Use rte_pktmbuf_free().

Warning: error queue dump uses q_storage[0] from all lcores.


[52/65] net/dpaa2: bind per-queue DPIO for rx-queue interrupts

Error: Rx burst now sets IRQ affinity, stashing and governor on first
  call (see 47). Releasing a queue or port never polled passes
  cpu_affine -1 to the governor restore, which restores every CPU,
  including ones other queues still use.

Warning: intr_enable returns early when napi_armed, CDAN is one-shot;
  dev_started check removed. Holdoff default changed from 0 to 0xff.


[53/65] net/dpaa2: add API to clean Tx confirmation queue

Error: rte_pmd_dpaa2_clean_tx_conf() uses tx_queues[txq_id] without
  checking txq_id < nb_tx_queues or NULL.

Warning: no doxygen; must run on the lcore owning the Tx queue (races
  with tx_burst).


[54/65] event/dpaa2: fix DQRR held buffer accounting on enqueue

Warning: bug is in released code. Add
  Fixes: b75061260c34 ("event/dpaa2: add enqueue and dequeue functionality")
  Cc: stable@dpdk.org
  and send ahead of the refactor.


[55/65] bus/fslmc: store dequeue dpio in mbuf seq dynfield

Warning: seqn dynfield grows to 16 bytes, 8-aligned, registered at
  bus probe for every user. Store a DPIO index, not a pointer.


[56/65] bus/fslmc: use explicit flags for mbuf seqn encoding

Error: rewrites the UB shift in dpaa2_sec and keeps it (series 1).
  Fix: ~(UINT64_C(1) << (*dpaa2_seqn(m) & QBMAN_EQCR_DCA_IDXMASK))

Warning: cross-driver encoding mismatch is a real bug; log calls it
  "fragile". dpaa2_sec is even inconsistent with itself (ordered path
  decodes seqn - 1, dequeue stores DCA | idx). Describe it,
  Fixes/stable.


[57/65] net/dpaa2: unify tx burst path for ordered and atomic enqueue

Error: dqrr_held[loop] = ~(1 << idx) then HELD &= ~dqrr_held[i];
  clears all other held bits. Fixed in 59; fold it here.

Error: "uint32_t flags[MAX_TX_RING_SLOTS]" uninitialized, restored
  into seqn of every unsent mbuf. Zero per slot, restore only if set.

Error: enqueue retry exhaustion: break with ret == 0, then
  "if (nb_pkts > 0 && !ret && !order) goto tx_again" skips the unsent
  prepared frames, which the copy path already freed. Return value is
  no longer a prefix. Same in 65.

Info: rte_vlan_insert() failure still returns short (pre-existing,
  series item 1).


[58/65] crypto/dpaa2_sec: unify enqueue burst path for ordered enqueue

Error: "int32_t ret, order = false;" then "if (ret >= 0 && order)"
  reads ret uninitialized when ops[0] is ordered. int32_t ret = 0.


[59/65] bus/fslmc: track atomic DCA context per dequeue dpio

Error: on DPIO mismatch the mbuf keeps DCA|idx and the origin portal
  keeps HELD and held_bufs.mbuf[idx]; origin later writes through a
  freed/reused mbuf. Clear seqn on mismatch, release by index only.

Warning: statement-expression macros test &eqdesc[loop]/&flags[loop]
  for NULL and assign unparenthesized args. Make them static inline
  functions.


[60/65] bus/fslmc: move enqueue response descriptors to per-queue

Error: every ORP frame uses priv->tx_vq[0]->eq_resp from all lcores
  without a lock; the old ring was per DPIO.

Error: responses recorded on tx_vq[0] but only the caller's queues
  are drained; Tx on queue != 0 stops after 127 ORP frames.

Error: slots reserved at build time never complete for frames not
  enqueued; queue runs out and dpaa2_queue_eqresp_free() spins forever.

Error: dpaa2_sec_queue_pair_release() frees fle_pool, then
  dpaa2_queue_eqresp_free() puts FLEs back into it. Swap the order.

Warning: eqresp pool leaked on tx_queue_setup re-setup;
  DPAA2_ORDER_DEBUG dead code and USER1 logger in bus header; add
  RTE_BUILD_BUG_ON(!rte_is_power_of_2(DPAA2_EQRESP_MAX_NUM)).


[61/65] event/dpaa2: add ordered schedule type support

Warning: ORP restore keyed on event->sched_type (the next queue's
  type); ordered -> atomic skips restoration, ordered -> parallel or
  direct Tx leaks the ORP flag. Decide on the seqn flag.

Warning: ORDERED accepted but RTE_EVENT_DEV_CAP_ORDERED not set and
  ordered_scheduling not in features/dpaa2.ini.

Warning: dpaa2_dq_order_save() writes the mbuf dynfield for non-mbuf
  events.


[62/65] bus/fslmc: make DPAA2 ORP/ODP ordering per-queue

Error: strict ORP on a DPCI queue uses a NULL eq_resp pool
  The strict bit now comes from the mbuf. An event from a strict-ORP
  DPNI or dpaa2_sec queue forwarded to an ORDERED event queue reaches
  dpaa2_eq_set_order_desc() with a DPCI tx queue, which never got
  dpaa2_queue_eqresp_create(): pool_len 0, mask 0xffffffff, and QBMan
  DMAs the response to IOVA(NULL + n * 64). Nothing drains it.
  Fix: no response (loose) on the eventdev path; return -EINVAL when
  eqresp_pool is NULL.

Warning: odpid not masked; bits 13..15 land in STRICT/ORP/DCA.
    ((id) & DPAA2_EQCR_OPRID_MASK) << DPAA2_EQCR_OPRID_SHIFT

Warning: bus, net, crypto, event and a devarg in one patch. Removing
  DPAA2_STRICT_ORDERING_ENABLE silently drops strict ordering for
  existing users (the log claims it is still honoured); new devarg
  name differs from dpaa2_sec's drv_strict_order. Split, reuse the
  name, release note.


[64/65] event/dpaa2: do not fail device creation on DPCI errors

Warning: -ENODEV path leaves a registered, probed eventdev. Release
  before event_dev_probing_finish(). Partially attached queues still
  accept all sched types in queue_setup.


[65/65] net/dpaa2: add Tx fast path for no-confirmation case

Error: dpaa2_dev_tx_fast() ignores DPAA2_IEEE1588_TX_TS_FLAG; one-step
  PTP stops working on the default NO_CONF config. Take the fast path
  only when the flag is clear.

Error: retry exhaustion hole duplicated from 57.

Warning: "struct qbman_fd fd_arr[MAX_TX_RING_SLOTS] = {0};" zeroes
  1 KiB per burst before dispatching to the fast path. Move it.
