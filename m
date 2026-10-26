Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12A606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tIBLviOa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA4DC402A3;
	Mon, 26 Oct 2026 18:00:41 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 9A40840275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 18:00:40 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso2544413a91.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793034039;
 x=1793638839; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rLG/yA2/36StbCWowjLhM4Vs73NxV+8hBVh+S4BIuIs=;
 b=tIBLviOatpknmENQrs53aEcFYCOd6KX/RAD2yY8UZ/ZUPqfm8wT1HLyjZVXRQglqwK
 IALPXLn+ZRl4PmXhIPw6kI6i9uWEzU7ydstC85N+nqOOmp0WpuReJSC3uHzqi6VM3vII
 7mCAiJOPt7WBFKg3MYCUD0Ucc5aylPBfmF5OV3fKf7niAFsO+x5U3GB/EEhmZYE4hB2l
 arvhSh/HNRdPaoIeRqFUMp6+iwYMb/jSl3eOimL2AggJdMYGwsuC+TGtv2X128lOy7Sa
 1FLCPGycKx7YBJhGlvXhB86mlW8D8PXc3T7nESIJXNLclSRmPXXerhvRFI+9rCBqARws
 zLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034039; x=1793638839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rLG/yA2/36StbCWowjLhM4Vs73NxV+8hBVh+S4BIuIs=;
 b=yxOM5OZBMCoAPjRoaUu8wT7JSBZDwYM/HC7PlOFthhdenqDpJL2109fk1z2T9m+W5x
 9GnbioZ7QnQxsKkicH/7WRJpPdmrkXGMbMgqnaRU23iSzrXGH+NskeW1C1fOIZQF1CCU
 KdfKHcCYJeGxypomxxx6vAOcXsmDVdAaLu672kV37/dAFbPyakevTliMn4O61ZysTRH+
 p2mksRnWuy+AfX5W+61wagOhedFJnYsnjcW3Es52bbOqb97Lf+7Hfz7QJKKVnS2EGW0S
 tJ10Hs8t1Qt15qO4NRthwpiJwGPY6q+NJ3kkGj99Jc9uPKZzRPzPCZQyHXB5Hq7vEACU
 yjcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6+FqvxWHh6cJlpVoTFL5/cwOW56LLTtWD5OcstxSeaH1QEyY/tl7b7VeJh+XE1ysHyAo=@dpdk.org
X-Gm-Message-State: AFq9FYJLY4KNfDdFB7axnGMcRZCz+Myf5D6WRDmpX4kCzXfF7UY2AFBi
 NA34acwbo3Og/yfpwDvGe+vPmKA+nUHKsoTyMQ7LkVP2k8etsL3kErFsVUhjKT9bzGU=
X-Gm-Gg: AYBFou3nsaY//9YxrPd0bLv/fhPIUiTyZRbg0S79jwBAkP2ztyekIT9lF8Wsy0jxDt+
 d2sO4xZcBef0PIOcUEynuM+I1qTrZL/VJO2t33MNBHYzJBt/8hN44jZGuhkvGJujJqEuUUvTWkX
 F6Hv19gsHnusyjDDNZjqTkTwhbCzfx1z+IJyYc28GjYhMHXosxtFbrVeDZDLXkoYNRKuH8Ash8I
 pjJcBqXjZnWUpcx5K+Mg+PVudQU6UBR3SsR0v2YV5/3ddDz+ExrJCEMaQiTRxui5Os0yxVYHEpK
 4+Rv6OYyKBZSVQlsoWe6LbIfYLumrj6267uXKVXv1HEBcH/vBchQ74+G18dQglmYs9o9Gt6Kb0x
 d3WQuFf47LGxv47TsfHkhGrzGMd7yZDb7Ju00IKeqnx1brG+PKjoUZAFbqL6mBI0uPv3Mxk3GIT
 QBjySlSMWSFNW3giw6QbK9Yrnz+Q71FQhAfliL2CTgG38uz729lde0IL1dEWBhB2bVoaToruFE4
 sei75X/u8EJzRCzWOmoKQeygfr0RLonq9E0C5RbVuhwncnd6lHpMlHmQ0M6HGC2bqsIN3GXUUgP
 UwWzXbGX9Y8LuDRA+6AUIA==
X-Received: by 2002:a17:90b:518d:b0:3ac:8897:7ba9 with SMTP id
 98e67ed59e1d1-3adeafd64d8mr5909031a91.56.1793034038447; 
 Mon, 26 Oct 2026 10:00:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae406153fesm190263a91.5.2026.10.26.10.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:00:37 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:00:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, dev@dpdk.org,
 jingjing.wu@intel.com, thomas@monjalon.net, selwin.sebastian@amd.com,
 bhagyada.modali@amd.com, bruce.richardson@intel.com,
 sachin.saxena@oss.nxp.com, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 0/3] raw/ntb: add AMD NTB support
Message-ID: <20261026100034.0e4497e0@phoenix.local>
In-Reply-To: <CAJFAV8zYm79ZyWOSP4UNjk7AGo+J4Bor_hk+JoSryZKEdZD0CA@mail.gmail.com>
References: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
 <CAJFAV8zYm79ZyWOSP4UNjk7AGo+J4Bor_hk+JoSryZKEdZD0CA@mail.gmail.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 11:26:01 -0400
David Marchand <david.marchand@redhat.com> wrote:

> >
> > The common NTB code validates the vendor ops once at probe time, and the
> > vendor abstraction is built around a small set of mandatory ops instead
> > of optional hooks with built-in fallbacks:
> >
> > - Patch 1 is a preparation commit that enforces the vendor ops once, at
> >   probe time, and removes the per-call NULL checks that are scattered
> >   throughout the common code.
> >
> > - Patch 2 generalizes the framework for multiple vendors. The link
> >   bring-up/tear-down is now expressed through mandatory ops
> >   (dev_handshake, peer_mw_validate, read_peer_config, link_cleanup); the
> >   former built-in scratchpad logic moved into the Intel driver. The
> >   mw_set_trans op is gone (it is now a vendor-internal concern of the
> >   handshake), and there is a single common interrupt handler with just
> >   one optional op (handle_hw_event) for vendor-specific hardware events.
> >
> > - Patch 3 adds the AMD hardware driver, its documentation, release note
> >   and MAINTAINERS entry.
> >
> > A few AMD-specific hardware details worth noting for reviewers:
> >
> > - Primary/secondary topology. One endpoint enumerates as the primary
> >   (device ID 0x14c0) and the other as the secondary (0x14c3), rather
> >   than the Intel back-to-back model.
> >
> > - Packed scratchpad handshake. The hardware exposes a single shared
> >   16-register scratchpad bank split into two disjoint 8-register sets
> >   (one per side), so the driver uses a packed handshake layout that
> >   fits in 8 registers, plugged in through the dev_handshake,
> >   peer_mw_validate and read_peer_config ops.
> >
> > - Outbound translation window. AMD NTB uses an outbound translation
> >   window: a write to a BARxx memory-window offset is forwarded to
> >   (xlat_base | offset) in the peer's memory rather than
> >   (xlat_base + offset). The translation base must therefore be aligned
> >   to a power of two >= the window length so that no offset bit collides
> >   with a set bit in the base. This is reported to applications through
> >   the rte_pmd_ntb_get_mem_align() API and honoured by the ntb example
> >   when reserving the memory window memzone.
> >
> > - Secondary-side link status. On the secondary side the device's own
> >   PCIe link status does not reflect the true inter-host link, so the
> >   speed and width are read from the upstream switch port via sysfs.
> >
> > Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
> > with the dpdk-ntb example: the link comes up at the expected speed and
> > width on both sides, and file transfers are byte-correct end to end for
> > both small and large files.
> >
> > Changes since v3:
> >
> > - Simplified the probe-time vendor ops check (patch 1) to a plain
> >   per-member macro instead of an offsetof() table.
> >
> > - Removed the mw_size_align field from struct ntb_dev_info entirely
> >   (patch 2): applications must now use rte_pmd_ntb_get_mem_align(). This
> >   is documented in the API changes section of the release notes.
> >
> > - Removed the unused pmd_private field from struct ntb_hw and the whole
> >   struct amd_ntb_hw (patch 3): self_mmio is just ntb->hw_addr, peer_mmio
> >   becomes AMD_PEER_MMIO(ntb), the scratchpad offsets become an
> >   AMD_SPAD_BASE(ntb, peer) macro, and int_mask/peer_status/ctl_status
> >   were unused.
> >
> > - Sorted AMD alphabetically before Intel in meson.build, the ntb_hw
> >   header include, the PCI id mapping table and usertools/dpdk-devbind.py.
> >
> > - Moved the primary/secondary topology definitions (NTB_TOPO_PRI/SEC)
> >   from patch 2 to patch 3 where they are first used.
> >
> > - Updated the Limitation section of doc/guides/rawdevs/ntb.rst to list
> >   the supported AMD processors.  
> 
> - "external" build was broken for the example as spotted by the CI.
>   https://github.com/ovsrobot/dpdk/actions/runs/40296962846/job/121485246438
>   This is a known limitation of the .pc provided by DPDK (which Robin
> recently tried to fix).
>   I tested and squashed a simple fix:
> https://github.com/david-marchand/dpdk/commit/16b0d741ebf39b22ebb696c07f2ed44ad383bfc9
> 
> - Some commitlogs were not updated after the v4 changes, fixed.
> 
> - Some strange indentation issues were still there, fixed.
> 
> With all those fixes applied, I pushed this driver update.
> Thanks.


I think merge was premature. More detailed AI review reports:

Subject: Re: [PATCH 0/4] raw/ntb: AMD NTB support

Post-merge review of the raw/ntb series (1/4 - 3/4) against current
main. Findings below are for follow-up fixes.

Series summary
--------------
The ops-table refactor in 1/4 and 2/4 is reasonable. The main problems
are a type-confusion hole in the new public API, an unbounded
peer-supplied loop count that writes past peer_mw_base[], and AMD event
handling that cannot actually run as wired.


[PATCH 2/4] raw/ntb: generalize framework for multiple vendors
--------------------------------------------------------------

Error: rte_pmd_ntb_get_mem_align() trusts any rawdev id.

  It checks only dev_id < RTE_RAWDEV_MAX_DEVS and dev_private != NULL,
  then casts dev_private to struct ntb_hw. Passing the id of an
  unattached slot or of a non-NTB rawdev (dpaa2, ifpga, cnxk...) calls
  through a garbage ntb_ops pointer. Check the device is valid and is
  ours:

	if (!rte_rawdev_pmd_is_valid_dev(dev_id))
		return 0;
	dev = rte_rawdev_pmd_get_dev(dev_id);
	if (dev->dev_ops != &ntb_ops)
		return 0;

  Also, an out of range mw_id returns RTE_CACHE_LINE_SIZE, which
  contradicts the doxygen ("0 on error"). Return 0.

Warning: Rx EOP guard leaks the partial chain and desyncs the ring.

  On the new "Malformed rx stream" path the descriptors already walked
  have advanced last_used/last_avail and been chained under `first`,
  but nb_rx is not incremented, so the chain is never returned or
  freed. If nb_rx == 0 the refilled descriptors are not published
  either (avail_cnt not written) while rxq->last_avail has moved.
  The mbuf-alloc failure path has the same bug already; the guard
  copies it. Free the partial chain and only advance ring indexes for
  completed packets.

  The guard also bounds on nb_rx_desc, not on the descriptors the peer
  actually published (used_cnt - last_used), so it still reads entries
  the peer has not written. This is a fix for code in released
  versions; it should be its own patch with Fixes: and
  Cc: stable@dpdk.org, not folded into the refactor.

Info: removing mw_size_align changes the layout of the installed
  struct ntb_dev_info; note it under ABI Changes as well.

Info: examples/ntb/Makefile adds -lrte_raw_ntb to LDFLAGS, which also
  hits the static target. Other examples (l2fwd-crypto,
  vm_power_manager) use LDFLAGS_SHARED.


[PATCH 3/4] raw/ntb: support AMD NTB
------------------------------------

Error: peer_used_mws from the scratchpad overflows peer_mw_base[].

  amd_ntb_read_peer_config():

	ntb->peer_used_mws = (info >> 16) & 0xff;
	for (i = 0; i < ntb->peer_used_mws; i++)
		...
		ntb->peer_mw_base[i] = ...

  peer_mw_base is rte_zmalloc'd with mw_cnt (2) entries. A peer
  advertising more than 2 (bug, version skew, or just garbage in an
  uninitialised scratchpad) writes past the allocation. Intel has the
  same pattern; fix both:

	if (peer_used_mws > ntb->mw_cnt) {
		NTB_LOG(ERR, "Peer used mws %u > mw cnt %u",
			peer_used_mws, ntb->mw_cnt);
		return -EINVAL;
	}

Warning: hardware events are never delivered.

  - AMD_INTMASK_OFFSET is defined but never written, so event
    delivery depends on the reset default.
  - ntb_init_hw() enables db_cnt (16) eventfds; the comment in
    amd_ntb_vector_bind() says events have their own MSI-X vectors
    (AMD_MSIX_VECTOR_COUNT is 24), and those are never enabled.
  - handle_hw_event is only called at the bottom of
    ntb_dev_intr_handler(), after doorbells 0/1/2 have already
    returned early, so it runs only on a stray doorbell.

  As written amd_ntb_handle_hw_event() is effectively dead code.
  Either wire up the event vector and INTMASK, or drop it.

Warning: doorbell interrupts with vfio-pci MSI-X.

  amd_ntb_vector_bind() is a no-op and doorbells map 1:1 to MSI-X
  vectors. The callback is registered on the device intr handle only,
  so with vfio-pci only vector 0 (DB0) reaches ntb_dev_intr_handler().
  DB1 (peer going down) and DB2 are lost, so the stop handshake in
  ntb_dev_stop() never completes. Was this tested with vfio-pci, or
  only igb_uio? If uio only, say so in ntb.rst.

Warning: amd_ntb_handle_hw_event() switches on a bitmask.

  INTSTAT can have several bits set at once; any combination falls to
  default and is logged as unknown and never acked to the SMU. Loop
  over the set bits, or ack all of (event & AMD_EVENT_INTMASK) after
  handling D0. Also drop the duplicated fallthrough comment; one
  /* fallthrough */ is enough.

Warning: ioremap range check is off by one.

	addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]

  accepts one past the end of the window. Should be <. Copied from
  intel_ntb_ioremap(), which needs the same fix.

Warning: ntb->mw_size is never freed.

  Allocated in amd_ntb_dev_init(), not freed on later ntb_init_hw()
  failure or in ntb_destroy(). Same leak exists on the Intel side;
  free it in common code at release.

Info: unused defines in ntb_hw_amd.h: AMD_SPADMUTEX_OFFSET,
  AMD_DBFM_OFFSET, AMD_INTMASK_OFFSET, AMD_MSIX_VECTOR_COUNT.

Info: amd_ntb_mw_set_trans() checks IOVA alignment, but
  rte_memzone_reserve_aligned() aligns the VA. With IOVA as PA and a
  window larger than the hugepage size the IOVA is not guaranteed to
  be aligned, and configure fails with -EINVAL. Worth a line in
  ntb.rst that large windows need IOVA as VA (or 1G pages).

Info: amd_ntb_peer_mw_validate() only compares the window count; the
  Intel version also checks sizes. Mismatched BAR sizes between hosts
  go undetected.
