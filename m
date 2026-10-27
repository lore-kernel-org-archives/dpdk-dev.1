Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FF606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKN3CTXN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 955B4400D7;
	Tue, 27 Oct 2026 10:09:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id A7FE4400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793092147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4FuxUT2YA8/Rtnmzkz3yYZRH+SvAi9oditCrZ1WzTA=;
 b=fKN3CTXN0oHVizUk3Qcr9DDnMOvV8XSyj1Xbf1SdZWrjBlPMCrchi+ob7et3XQN5u/v2ua
 x693MagQscA1YFZqXtEgSwX4d9MmVvmWV5JWq/qwKfkc9tsdXBa1DdHGrVVVO1Det79vBe
 rGTrGwOv7Xj0C0xC1yBVfsz9HTfCI0U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-T4znde9jOq6J5uYQLk8S8A-1; Tue, 27 Oct 2026 05:09:06 -0400
X-MC-Unique: T4znde9jOq6J5uYQLk8S8A-1
X-Mimecast-MFC-AGG-ID: T4znde9jOq6J5uYQLk8S8A_1793092145
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab2cf30ab5so28476941fa.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 02:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793092144; x=1793696944;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K4FuxUT2YA8/Rtnmzkz3yYZRH+SvAi9oditCrZ1WzTA=;
 b=nYAvfTRWMzmPwoBrKLPPLp0vYzrXRKWJsP6wLYQTzGLc7mRvW7m9IiJGvcYmMy5KNg
 /EKgK5edrJiJTVN8s22yoKn8eWxL9wJpwng/7sfE8DaxyaFOebuWJvCw9NieP4aWgFsc
 G8isYduVNseG080wiOqER8gtf4Ep7Fd1PZzNHXHJxsspuwaTM/iL9vspHqwk/SK0A1IN
 lzl9wgTTj3ZkMaMqGvsQ0IHSZP3duhWFdMHiqnXyai+hFSIFQOjUaUVZewueylX2a4fj
 7yc0Wd/qI/kgWFwKFbdNXoLSYft7NtiS66fU0HUwyEm3b2MAfd3iKl6fnt3asu1TIRvF
 jIOg==
X-Gm-Message-State: AFq9FYIiRx8RakYpBdOLCobo1RaRYXzm9+LMb6t3vL3Dk0coL/qw6Esd
 p+1HpeMMwTk1P5cwcibAwB/+ZcXW5QCLO6o6juJHxcSu29Cu1qLmEWfaln5gdv+VsVtj6G4imy2
 PlprLDLubxO73/fyrPf1G1F/PpSP4fWTHMEiHDtj9Ai6m0ZTF3r+pKtjrYdhFKmJ5TrCs8wBm+8
 JmdWu5IHH8KCcc/YYZ4r4=
X-Gm-Gg: AYBFou27eFri6KYdpn0sFWx9Kj1zdfG6psH96RC/lwIIi5Umc08EhtpNlhkNXDcqtQ3
 UuNcNXJWiDAxkUByMd8se/F/vSwi9dJ9CziDcTsqK3IeV2k69BY3VkYtQY93+lF/dOW0dTU4rrw
 1bbtHmPE+5lRp8c5jvL+f9ovbNx4c37OKA1WHmf123ruoIazU6zeCdseIs2K1LXFCfZ82s+aVQ2
 cvXhi6lyVqjD4WbdPy/3BAy72iKEOJtjyiVuBNH2c6xeIjI
X-Received: by 2002:a05:651c:31c7:b0:3a9:d756:bfdd with SMTP id
 38308e7fff4ca-3ac6fd1467bmr21478451fa.7.1793092144408; 
 Tue, 27 Oct 2026 02:09:04 -0700 (PDT)
X-Received: by 2002:a05:651c:31c7:b0:3a9:d756:bfdd with SMTP id
 38308e7fff4ca-3ac6fd1467bmr21478311fa.7.1793092143844; Tue, 27 Oct 2026
 02:09:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
 <CAJFAV8zYm79ZyWOSP4UNjk7AGo+J4Bor_hk+JoSryZKEdZD0CA@mail.gmail.com>
 <20261026100034.0e4497e0@phoenix.local>
In-Reply-To: <20261026100034.0e4497e0@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 27 Oct 2026 10:08:52 +0100
X-Gm-Features: AclHuK8WYEnlhOXXnk-IA0MoaxXUv_KFK4o9aGBH--ahRgwejL9DBUKujsOpwSM
Message-ID: <CAJFAV8w21JOt7c5p3XA6-nLNb1BcCAWM9DBP3mj2BfkyE6rx6g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] raw/ntb: add AMD NTB support
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, jingjing.wu@intel.com, thomas@monjalon.net, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, bruce.richardson@intel.com, 
 sachin.saxena@oss.nxp.com, hemant.agrawal@nxp.com, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lNJ7ZoVzBE6CTPVHFTM3eQlEENr2Y1-k7T3OupT6wNc_1793092145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Mon, 26 Oct 2026 at 18:00, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Subject: Re: [PATCH 0/4] raw/ntb: AMD NTB support
>
> Post-merge review of the raw/ntb series (1/4 - 3/4) against current
> main. Findings below are for follow-up fixes.
>
> Series summary
> --------------
> The ops-table refactor in 1/4 and 2/4 is reasonable. The main problems
> are a type-confusion hole in the new public API, an unbounded
> peer-supplied loop count that writes past peer_mw_base[], and AMD event
> handling that cannot actually run as wired.
>
>
> [PATCH 2/4] raw/ntb: generalize framework for multiple vendors
> --------------------------------------------------------------
>
> Error: rte_pmd_ntb_get_mem_align() trusts any rawdev id.
>
>   It checks only dev_id < RTE_RAWDEV_MAX_DEVS and dev_private != NULL,
>   then casts dev_private to struct ntb_hw. Passing the id of an
>   unattached slot or of a non-NTB rawdev (dpaa2, ifpga, cnxk...) calls
>   through a garbage ntb_ops pointer. Check the device is valid and is
>   ours:
>
>         if (!rte_rawdev_pmd_is_valid_dev(dev_id))
>                 return 0;
>         dev = rte_rawdev_pmd_get_dev(dev_id);
>         if (dev->dev_ops != &ntb_ops)
>                 return 0;
>
>   Also, an out of range mw_id returns RTE_CACHE_LINE_SIZE, which
>   contradicts the doxygen ("0 on error"). Return 0.
>
> Warning: Rx EOP guard leaks the partial chain and desyncs the ring.
>
>   On the new "Malformed rx stream" path the descriptors already walked
>   have advanced last_used/last_avail and been chained under `first`,
>   but nb_rx is not incremented, so the chain is never returned or
>   freed. If nb_rx == 0 the refilled descriptors are not published
>   either (avail_cnt not written) while rxq->last_avail has moved.
>   The mbuf-alloc failure path has the same bug already; the guard
>   copies it. Free the partial chain and only advance ring indexes for
>   completed packets.
>
>   The guard also bounds on nb_rx_desc, not on the descriptors the peer
>   actually published (used_cnt - last_used), so it still reads entries
>   the peer has not written. This is a fix for code in released
>   versions; it should be its own patch with Fixes: and
>   Cc: stable@dpdk.org, not folded into the refactor.
>
> Info: removing mw_size_align changes the layout of the installed
>   struct ntb_dev_info; note it under ABI Changes as well.
>
> Info: examples/ntb/Makefile adds -lrte_raw_ntb to LDFLAGS, which also
>   hits the static target. Other examples (l2fwd-crypto,
>   vm_power_manager) use LDFLAGS_SHARED.
>
>
> [PATCH 3/4] raw/ntb: support AMD NTB
> ------------------------------------
>
> Error: peer_used_mws from the scratchpad overflows peer_mw_base[].
>
>   amd_ntb_read_peer_config():
>
>         ntb->peer_used_mws = (info >> 16) & 0xff;
>         for (i = 0; i < ntb->peer_used_mws; i++)
>                 ...
>                 ntb->peer_mw_base[i] = ...
>
>   peer_mw_base is rte_zmalloc'd with mw_cnt (2) entries. A peer
>   advertising more than 2 (bug, version skew, or just garbage in an
>   uninitialised scratchpad) writes past the allocation. Intel has the
>   same pattern; fix both:
>
>         if (peer_used_mws > ntb->mw_cnt) {
>                 NTB_LOG(ERR, "Peer used mws %u > mw cnt %u",
>                         peer_used_mws, ntb->mw_cnt);
>                 return -EINVAL;
>         }
>
> Warning: hardware events are never delivered.
>
>   - AMD_INTMASK_OFFSET is defined but never written, so event
>     delivery depends on the reset default.
>   - ntb_init_hw() enables db_cnt (16) eventfds; the comment in
>     amd_ntb_vector_bind() says events have their own MSI-X vectors
>     (AMD_MSIX_VECTOR_COUNT is 24), and those are never enabled.
>   - handle_hw_event is only called at the bottom of
>     ntb_dev_intr_handler(), after doorbells 0/1/2 have already
>     returned early, so it runs only on a stray doorbell.
>
>   As written amd_ntb_handle_hw_event() is effectively dead code.
>   Either wire up the event vector and INTMASK, or drop it.
>
> Warning: doorbell interrupts with vfio-pci MSI-X.
>
>   amd_ntb_vector_bind() is a no-op and doorbells map 1:1 to MSI-X
>   vectors. The callback is registered on the device intr handle only,
>   so with vfio-pci only vector 0 (DB0) reaches ntb_dev_intr_handler().
>   DB1 (peer going down) and DB2 are lost, so the stop handshake in
>   ntb_dev_stop() never completes. Was this tested with vfio-pci, or
>   only igb_uio? If uio only, say so in ntb.rst.
>
> Warning: amd_ntb_handle_hw_event() switches on a bitmask.
>
>   INTSTAT can have several bits set at once; any combination falls to
>   default and is logged as unknown and never acked to the SMU. Loop
>   over the set bits, or ack all of (event & AMD_EVENT_INTMASK) after
>   handling D0. Also drop the duplicated fallthrough comment; one
>   /* fallthrough */ is enough.
>
> Warning: ioremap range check is off by one.
>
>         addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]
>
>   accepts one past the end of the window. Should be <. Copied from
>   intel_ntb_ioremap(), which needs the same fix.
>
> Warning: ntb->mw_size is never freed.
>
>   Allocated in amd_ntb_dev_init(), not freed on later ntb_init_hw()
>   failure or in ntb_destroy(). Same leak exists on the Intel side;
>   free it in common code at release.
>
> Info: unused defines in ntb_hw_amd.h: AMD_SPADMUTEX_OFFSET,
>   AMD_DBFM_OFFSET, AMD_INTMASK_OFFSET, AMD_MSIX_VECTOR_COUNT.
>
> Info: amd_ntb_mw_set_trans() checks IOVA alignment, but
>   rte_memzone_reserve_aligned() aligns the VA. With IOVA as PA and a
>   window larger than the hugepage size the IOVA is not guaranteed to
>   be aligned, and configure fails with -EINVAL. Worth a line in
>   ntb.rst that large windows need IOVA as VA (or 1G pages).
>
> Info: amd_ntb_peer_mw_validate() only compares the window count; the
>   Intel version also checks sizes. Mismatched BAR sizes between hosts
>   go undetected.

Please look into those warnings and send fixes if confirmed.

Thanks.


-- 
David Marchand

