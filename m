Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371E606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UPPXg2ts
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76B14402A3;
	Mon, 26 Oct 2026 16:26:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id B50D140275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 16:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793028378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBNhXVLajksuQmTo7qvL0+8Mq+6PB8Jyq2C1vGUme4I=;
 b=UPPXg2tsMcYIm0EPvBIzVvLyNeT7vOANbv8+Z7FVYgoR7zIHm73vzYntobeWa45Y9i6XFv
 dbnavc0GU4ZD4lH2Ily8jzjKlOzNMFtgzRkA5HqZhAh8g292fouzCHi5F9BzHQH0ZhU1Jp
 De3M3s1op8kofCzVFK92nuyYNLAgyo0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-0deiVwmTNEeCbIcmLJRG_w-1; Mon, 26 Oct 2026 11:26:15 -0400
X-MC-Unique: 0deiVwmTNEeCbIcmLJRG_w-1
X-Mimecast-MFC-AGG-ID: 0deiVwmTNEeCbIcmLJRG_w_1793028374
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bb78051100so1544998e87.3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 08:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028374; x=1793633174;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GBNhXVLajksuQmTo7qvL0+8Mq+6PB8Jyq2C1vGUme4I=;
 b=zDRspINfek5T7e5TCUrVooQNuCkVS6YqeD5ZpOlQjRQ7IQ9aVWSyMrSaaqzt0ZYerk
 FCwDfd1kIlc0ch/qfYOwksb02X/iKTURvTMxeZ1ph3RTRcurTOZj4GdsqgXwUTJ605HE
 RjCVHui5TLo6lByTBwkAhsVnTQaDegyK4m4E182RskvndwNX9yMWp3mrNHX9rJc4LpFU
 7y/qMIBHydarNF8WEXL3PrchlYDZ7R9IjR3CB9T/0FgmHDn+CfZ8i0rXR9XimnVnavCK
 5PHDxeXi3lVVgQ8WPDsY5SKGicEwO4EKbx22cTrTT00bUpg/iKn98Gum8ZegX6a0JYnb
 LcIw==
X-Gm-Message-State: AFq9FYKF/IZX/iE2IKiD/VLRqvkB08lAuChFUAO+zWACvRZQnnDbgjuq
 k+em+YMVICY1iN02CNKG1rtsacVV5jxnCy9UjIc9bpLPkoDclepwIi3zfctcWsKIB6z3j3doDsO
 ppkvtZ/fK1d/EaYE7aq4TVymOXMg4isswi9egv1dlZAUhpORs9K9RqXKCO8EDZi95iaBcN/A0Nf
 ltomIKzHgfa9oXU9phkdw=
X-Gm-Gg: AYBFou27csH5qH6ABrrOQY/qe5slz6uLekir5kkOmxTp+hyzcvJ4/9VKXq1PbNWlLeG
 nRL37YP9sO8BotgdjwF/itIRqXLRL30Vw6CwCIamhb7VKdckc5t09HxOUGZwmtmF7f1DSyP6G7X
 rs4l7Rfu63xFumD452wi9dMMulV3Y7bW9iGtLLSoFog28lBq+uJzrbU7YWrNPkXOm/PmIuqgsZN
 5EN5dMax9sU1skxKg+5riw2lripf2ruoTLFzX30yI8jUhgg
X-Received: by 2002:a05:6512:6885:20b0:5bf:b95a:29ce with SMTP id
 2adb3069b0e04-5bfb95a2acbmr1274509e87.4.1793028373590; 
 Mon, 26 Oct 2026 08:26:13 -0700 (PDT)
X-Received: by 2002:a05:6512:6885:20b0:5bf:b95a:29ce with SMTP id
 2adb3069b0e04-5bfb95a2acbmr1274502e87.4.1793028373112; Mon, 26 Oct 2026
 08:26:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 26 Oct 2026 11:26:01 -0400
X-Gm-Features: AclHuK_986Zeq_aZadDcL_Y-_kREJpId3ph9Ri8yiKCXA3PAYnX3OF8iRKjZAPs
Message-ID: <CAJFAV8zYm79ZyWOSP4UNjk7AGo+J4Bor_hk+JoSryZKEdZD0CA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] raw/ntb: add AMD NTB support
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, jingjing.wu@intel.com, thomas@monjalon.net, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, bruce.richardson@intel.com, 
 sachin.saxena@oss.nxp.com, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MeQI1jPWL_k7xhFg3CzfFzDUsuHSoT368rROkRTAOr0_1793028374
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Mon, 26 Oct 2026 at 09:55, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds support for the Non-Transparent Bridge (NTB) endpoints
> integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
> to the raw/ntb driver.
>
> The common NTB code validates the vendor ops once at probe time, and the
> vendor abstraction is built around a small set of mandatory ops instead
> of optional hooks with built-in fallbacks:
>
> - Patch 1 is a preparation commit that enforces the vendor ops once, at
>   probe time, and removes the per-call NULL checks that are scattered
>   throughout the common code.
>
> - Patch 2 generalizes the framework for multiple vendors. The link
>   bring-up/tear-down is now expressed through mandatory ops
>   (dev_handshake, peer_mw_validate, read_peer_config, link_cleanup); the
>   former built-in scratchpad logic moved into the Intel driver. The
>   mw_set_trans op is gone (it is now a vendor-internal concern of the
>   handshake), and there is a single common interrupt handler with just
>   one optional op (handle_hw_event) for vendor-specific hardware events.
>
> - Patch 3 adds the AMD hardware driver, its documentation, release note
>   and MAINTAINERS entry.
>
> A few AMD-specific hardware details worth noting for reviewers:
>
> - Primary/secondary topology. One endpoint enumerates as the primary
>   (device ID 0x14c0) and the other as the secondary (0x14c3), rather
>   than the Intel back-to-back model.
>
> - Packed scratchpad handshake. The hardware exposes a single shared
>   16-register scratchpad bank split into two disjoint 8-register sets
>   (one per side), so the driver uses a packed handshake layout that
>   fits in 8 registers, plugged in through the dev_handshake,
>   peer_mw_validate and read_peer_config ops.
>
> - Outbound translation window. AMD NTB uses an outbound translation
>   window: a write to a BARxx memory-window offset is forwarded to
>   (xlat_base | offset) in the peer's memory rather than
>   (xlat_base + offset). The translation base must therefore be aligned
>   to a power of two >= the window length so that no offset bit collides
>   with a set bit in the base. This is reported to applications through
>   the rte_pmd_ntb_get_mem_align() API and honoured by the ntb example
>   when reserving the memory window memzone.
>
> - Secondary-side link status. On the secondary side the device's own
>   PCIe link status does not reflect the true inter-host link, so the
>   speed and width are read from the upstream switch port via sysfs.
>
> Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
> with the dpdk-ntb example: the link comes up at the expected speed and
> width on both sides, and file transfers are byte-correct end to end for
> both small and large files.
>
> Changes since v3:
>
> - Simplified the probe-time vendor ops check (patch 1) to a plain
>   per-member macro instead of an offsetof() table.
>
> - Removed the mw_size_align field from struct ntb_dev_info entirely
>   (patch 2): applications must now use rte_pmd_ntb_get_mem_align(). This
>   is documented in the API changes section of the release notes.
>
> - Removed the unused pmd_private field from struct ntb_hw and the whole
>   struct amd_ntb_hw (patch 3): self_mmio is just ntb->hw_addr, peer_mmio
>   becomes AMD_PEER_MMIO(ntb), the scratchpad offsets become an
>   AMD_SPAD_BASE(ntb, peer) macro, and int_mask/peer_status/ctl_status
>   were unused.
>
> - Sorted AMD alphabetically before Intel in meson.build, the ntb_hw
>   header include, the PCI id mapping table and usertools/dpdk-devbind.py.
>
> - Moved the primary/secondary topology definitions (NTB_TOPO_PRI/SEC)
>   from patch 2 to patch 3 where they are first used.
>
> - Updated the Limitation section of doc/guides/rawdevs/ntb.rst to list
>   the supported AMD processors.

- "external" build was broken for the example as spotted by the CI.
  https://github.com/ovsrobot/dpdk/actions/runs/40296962846/job/121485246438
  This is a known limitation of the .pc provided by DPDK (which Robin
recently tried to fix).
  I tested and squashed a simple fix:
https://github.com/david-marchand/dpdk/commit/16b0d741ebf39b22ebb696c07f2ed44ad383bfc9

- Some commitlogs were not updated after the v4 changes, fixed.

- Some strange indentation issues were still there, fixed.

With all those fixes applied, I pushed this driver update.
Thanks.


-- 
David Marchand

