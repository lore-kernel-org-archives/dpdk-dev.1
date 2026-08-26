Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A2C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 734A240268;
	Wed, 26 Aug 2026 19:07:53 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6310140264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:07:52 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8525efa7274so1016285b3a.2
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787764071;
 x=1788368871; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D0IALEe3fkI/930lrIWWYyU54/ZKmAJYVnOlyC4343w=;
 b=VI1hI+GblJdNI1VfjBOh9Fsyoe9Yan7BuimA323vicbqQlg1Lqlu5xaeEnAnPZTdLQ
 pCv+A1ENMgeDZDcXg8aBewQPijMaEj3YUD9AALCsoJA0QdqefHRAs8PvPmWBrqDSfRj1
 svP671g3MgczT7EDipAqKoAIBgAVVDBNhvqNCmg6Ov00oWO5TLx6EjvyEtIBIaeIMvCV
 CaJOS/XV4/gO8fEOKaaWhaPj5Kt3lIFlNA6zt8tQ11Omom/6IxlGWB41XH4pVmR6GnR0
 i1h0+ZXCOepQu7mN2c1orDnrAm1XwCsBmjByYubKlHrzyD2yMQuxmovelP55U6Kzh+Xo
 C2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764071; x=1788368871;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D0IALEe3fkI/930lrIWWYyU54/ZKmAJYVnOlyC4343w=;
 b=XyfJdn1WJ1tMxFIZW2EbIXDiTvB/xit69w8aUWCFYQEQ4VX6MmCyufKWROxP+QHiw0
 HWfBB1SGtFOcZlUDj9JKPwN35OJW2byrR6z9IVHhSnXw+m+LnnqFQd0NVKb10VRD0bAQ
 EPlse6qmabKa63WAl3NxjDNoyPaz5X1+TmIwc64EMEwCJxjYC5CaGeym67FQPfjIGsgB
 3pEvotXXst2eB+Eyr9tl6jc4DrIpjHAYV8BrdZS4uDy+KxAWqlUpMrO/wJ62aFhLbhT5
 xn/NukGCLFeEk0F6UhN6n7jW8zgk9OIexwBUbqtkQibn34dMB9SByp4K+yQWWhl1dEUt
 T7/g==
X-Gm-Message-State: AFuF++kq6gMb4S4LKDda+01jQSlzQUCLIMwfidUf6LcdeP/17egCd8GT
 6psFNsHYfGwRRPld09IJX/RtQn1wxS1yWga/T3KBsFlYvN5y5gRGomMLc+yEwXsXphf49h0q1TD
 SQCEh
X-Gm-Gg: AR+sD10VRqM3X+RBricw0AoGvCQoedZ3fiHNeuXczhg90wGP9DOha4qjPQVbHlmEpHb
 yPdB/7xF0Y+zLjDKLnKsy/70LoyRqD45fJFFMdjYby0q0RrA4jgo+D7BSrAzRdgoBbv7sJ5hqi9
 EDnT/R/nXmyBxcUHXVhxSkXqJETlmohlxD8f+KX2HATezOi2hm+1FnTkdEuSfw/EtVG39otEeht
 luw3+dz6vMHHawcfGPBvGQDvbkWi11slPIW+LyhRl7q9srtk7szuUqSwbhL2wRwGpZjX/5vPkTX
 Lz7u8Pf7w4Yw8IcE52GOORKJg8MSTnhP+RhZQudxfdQ0dHpjNKpoMUb1MguxVzvzEz0RGekP13j
 IkqoGtOYkpUgSnJM4iyF9+k+eyJbIqpnSv3YFTTrjIf0UQpaHiJx4PZLvSG4zOkXHuYLn9rH7IT
 yyaIauyBHO+QiMUBNOylEN8UJdPDUz0mF31PIqsZKoohYHMqsWXt9Lv/j1tE+QO3OL2XZ8/TA3r
 VpRhjQtFAAWMeJFHiTo/qnpbWw7dg==
X-Received: by 2002:a05:6a00:2341:b0:847:9aa8:d3ce with SMTP id
 d2e1a72fcca58-85371ba8c6cmr14334245b3a.2.1787764071060; 
 Wed, 26 Aug 2026 10:07:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ceee96fsm1188779b3a.41.2026.08.26.10.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:07:50 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:07:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/51] net/sxe2: add Stars SXE2 net driver with fixes
Message-ID: <20260826100741.68443a1e@phoenix.local>
In-Reply-To: <20260826085332.989952-1-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
 <20260826085332.989952-1-liujie5@linkdatatechnology.com>
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

On Wed, 26 Aug 2026 16:53:32 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series adds the Stars SXE2 (Wuxi Stars Micro System) Ethernet
> driver, including the common driver (drivers/common/sxe2), the net
> driver (drivers/net/sxe2), and its documentation.
> 
> The driver supports:
> - Legacy and switchdev modes with VF representors
> - Scalar and vectorized (SSE/AVX2/AVX512/NEON) Rx/Tx paths
> - FNAV and ACL flow engines with per-flow statistics
> - RSS, QinQ, IPsec, Traffic Management and multi-process support
> 
> In addition to the driver functionality, the series fixes a number of
> correctness issues found during review, including a security context
> leak in the device init error path, a NULL dereference in the
> vectorized Tx mbuf release path, an out-of-bounds representor ID
> access, and a representor LSC loop counter type mismatch. The command
> channel log messages and ioctl channel handling are also aligned with
> the reference implementation.
> 
> This is v3 of the series, incorporating review feedback. All patches
> build independently and no ABI changes are introduced.

Although I appreciate having each part broken into a patch for review;
this large a series gets a little hard to review.

You are posting large series where one patch is fixing a bug which was
introduced by an earlier patch. That is a good way to do development but
is not best practice for final submission. Please consolidate and reorder
patches so that each patch builds, and after each patch there are no
new bugs.

The more verbose (sorry) AI review highlights this.

Findings below come from applying the series and reading the
resulting source.  Numbers are the v3 patch numbers.


Patches that fix earlier patches in the same series
---------------------------------------------------

  09/51  fixed by  49/51  uint8_t vf_id vs uint16_t nb_repr_vf
  15/51  fixed by  48/51  no_of_elements counts the terminator
  22/51  fixed by  48/51  init_rss_err label placement
  23/51  fixed by  48/51  PF match: all ports vs any port
  27/51  fixed by  47/51  stat_index truncation, list handling
  31/51  fixed by  50/51  NULL check in vec Tx mbuf release
  40/51  fixed by  51/51  sxe2_rxq_buf_split_fill rewritten

Please squash each fix into the patch that introduced the bug.
48/51 mixes three unrelated fixes, so split it first.


Errors
------

24/51  probe all requested PF ports

  sxe2_eth_pmd_probe_pf() has "uint16_t owner_id __rte_unused".
  The new loop calls it N times with nothing varying.  The
  function calls rte_eth_dev_pci_allocate(pci_dev, ...), which
  derives the port name from the PCI device, so iteration 2
  fails with -ENOMEM.  The error path then calls
  sxe2_eth_pmd_remove(cdev), destroying the port that did probe.
  Multi-port devargs go from working to failing.  Use owner_id,
  or drop the patch.

33/51  fix RSS action attribute validation

  sxe2_flow_check_rss_action_attr() starts with
  "int32_t ret = ENOTSUP" (no minus), so the three new goto
  l_end paths return a positive errno.  The default: case above
  returns -EINVAL.  Use -ENOTSUP.

44/51  align command structs with historical kernel layout

  Removing __rte_packed_begin moves fields in wire structures:

    sxe2_tm_add_mid_msg    info offset 3 -> 4
    sxe2_tm_add_queue_msg  info offset 5 -> 8
    sxe2_tm_res            size 4 -> 2

  The commit says members are kept as-is, but offsets change.
  If these are the offsets firmware expects, put the numbers in
  the commit message.  Otherwise this breaks TM commands.

46/51  remove drv-sw-stats parameter documentation

  Removing the drv-sw-stats devarg text is right, the devarg is
  gone.  Removing the "Receive Software Statistics" section is
  not: sxe2_stats.c still registers rx_sw_unicast_packets,
  rx_sw_broadcast_packets, rx_sw_multicast_packets,
  rx_sw_drop_packets and rx_sw_drop_bytes, and
  sxe2_rx_sw_stats_update() still runs.  Keep that section, or
  remove the xstats too.


Warnings
--------

Tags

  20 patches have Cc: stable with no Fixes: tag (05/51, and
  33/51 through 51/51).  sxe2 shipped in 26.07, so stable is
  correct, but each needs a Fixes: line.

  Seven Fixes: hashes are 10 characters; DPDK requires 12.  All
  resolve to real commits:

    635084db5d -> 635084db5d57    ac60f302cb -> ac60f302cbef
    66a10eb60e -> 66a10eb60ebe    d8e4e075ac -> d8e4e075acb4
    83866f8d76 -> 83866f8d7638    8cebf80f1e -> 8cebf80f1eda
    a2b79a9351 -> a2b79a93515e

  17/51, 30/51 and 39/51 are refactors carrying Fixes: and
  Cc: stable.  They are not bug fixes; drop the tags.

  35/51 has no functional change (else if -> nested else { if }).
  Please drop the patch.

Commit message does not match the diff

  31/51 describes a buffer ring union and a rename.  It also
  removes #ifndef SXE2_TEST from the AVX512 file, deletes the
  AVX512 bulk free path, rewrites the NEON Rx path (ptype
  extraction, staterr, DD counting, shuffle masks) and adds
  sxe2_tx_desc_fill_4_neon_simple().  It also drops the per-load
  rte_atomic_thread_fence() calls in the NEON Rx loop.  The
  result matches the ixgbe/i40e NEON idiom and looks correct,
  but a fast path memory ordering change must be described.
  This is four or more patches.

  27/51 also sets rxq->fnav_enable in sxe2_queue.c, which is
  unrelated to ACL statistics.

  32/51 bundles four changes: tx_pkt_prepare_dummy, the NEON
  simple/offload split, two debug logs, and the rx_free_thresh
  default.

Other

  27/51 is a new feature (acl-stat-type devarg) inside a fix
  series and has no release notes.  No patch in the series
  touches doc/guides/rel_notes/.

  15/51 sets RTE_ETH_RX_OFFLOAD_RSS_HASH twice: unconditionally,
  then again under SXE2_DEV_CAPS_OFFLOAD_RSS.  One is dead.  The
  same patch moves the PTP block below the IPsec block with no
  effect.

  14/51 sets dev_info->nb_rx_queues and nb_tx_queues, but
  rte_eth_dev_info_get() overwrites both right after the PMD
  callback (lib/ethdev/rte_ethdev.c:4146).  Keep the
  max_mac_addrs part, drop the queue counts.


Info
----

  08/51  "vf" is passed as a %s argument; put it in the format
         string.  Keying the name on cdev->dev->name means two
         PF ports on one PCI function would collide.
  23/51  port_idx = UINT16_MAX is overwritten by the for loop.
  25/51  rename left "sxe2_fnav_cid_mgr" in rte_zmalloc() and
         "sxe2vf_fnav_cid_mgr" in a log message.
  27/51  the ACL devarg is range checked against
         SXE2_FNAV_STAT_ENA_*, and reuses the fnav req/resp
         structs.
  31/51  continuation lines in sxe2_rx_desc_ptype_fill_neon()
         use tabs for alignment.  DPDK uses tabs to indent and
         spaces to align.
  32/51  0x%016x on a uint32_t is misleading.
  36/51  sxe2_drv_mac_link_status_get() now reaches into
         rte_eth_devices[] and calls sxe2_link_update() from the
         command channel.  It is safe, but it inverts layering.

  sxe2.ini lists only x86-32 and x86-64, although
  sxe2_txrx_vec_neon.c is built on arm.  Pre-existing, but this
  series reworks NEON heavily.

  Several commit messages justify a change as "matching the V3
  implementation".  Reviewers cannot see V3.  Please state what
  the code should do and why.

