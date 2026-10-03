Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD2CA5FEC
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ABB64028D;
	Sat,  3 Oct 2026 18:51:24 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 69D244028C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 18:51:23 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc4aa02a269so210254a12.2
 for <dev@dpdk.org>; Sat, 03 Oct 2026 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791046282;
 x=1791651082; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bBDUoSivOY6Cot2sKpbFVj2uE9gRjaCmEnTs7xCSk3w=;
 b=irvhg/+x/Coo7nG5U4DyFC6OgonzNtt3mNfFUVWRpGyKNJZ05l+dGZruKW/PndEGMM
 KpEjR8bChs6iyTU4ialQAZjp/rqWmHOj8KLyHWkcU8u1cXl+TuQ76pd3Y6w/LspdOg4s
 TQnmi1rlr1zVbcF6Xi6YNd0BeIT/FDNm8sBSeMY4NwkyrcX81Rg0bOdow0ahlOsDQMxV
 fdEGlE6SM1m2Z8Xjp/e+cK0p4NGsEA27p3jPZaw18AQMtZdjBLJcGaXgk1VWCC6bqhUC
 I46Z3Z9znSYCfDkpAwAJo//B11YASGlkE9egNmsz6MenUEbg/5UUWeXk4U+m3dxqzwCO
 WjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791046282; x=1791651082;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bBDUoSivOY6Cot2sKpbFVj2uE9gRjaCmEnTs7xCSk3w=;
 b=09pneTBSiMeSuu1QwzXrkQ6b818ujuG6fu63L0wqGLw6RoU7FMn/qgPr5UDjDsY8Tu
 8Cu+oB1pitL6fPM+iJKx12hXB0QTDRbdhPv6Iu+usNTeU4Z6CLwVs8d/qzIOT6d+CLD1
 /IoCamnfJwgUPaCpLk02M2vnobPTxUd7CDtWib8FPQTJsUZE+4JItYZm30qzX+jZUTIk
 7SuUU8dc+IP5S9iVUJtnP/W81V5gw31y8qlcT4V3gkgpJpCbV0oeYgGCV3iXpqxhs7zm
 xe/2hXfESKiKhkwZZ7QQj+ZNBwoVRae5lgApgwdBjnY2WU9oRZWW46S8aTUAC2gvW39v
 qpGw==
X-Gm-Message-State: AFuF++k6cm91WDZPZOwcZVjm/JmFsp0PsXY+NyQSeF0K5fy9ETGCRUxU
 ofn3PwR6M2SlQ6sc+BeuyCeDmGgTMSQKWx9sD0UKvs7ed+XQzXYAOtWZMWCFhtCouy4=
X-Gm-Gg: AYBFou2jhM4y9Hq9UW5b75LXcCZVieeko5fCdBX6uJe43+fF3t6alPZghNuehmkLCyR
 YHq20EZ4A31TK76GNpq/SPPJxXeKY2/suBVXS/b1PSIO+u3OjUISSEzb5oDTG8Hy0mOrM2HkqzC
 I/Vn5Y9zPBSZuoA51KWJDmR7gipuCC3jMRicxgPDtjgm/seLQ/GZDMfA1Nr3wgmWuZkDtrpfDed
 HQOyrZ+fNVUA0E7XjPzsFmoRKmMKkpnlC0ZPOU8Rnon7DNF8YJ0YUlEB61Eo/DtHVABiJli/YUi
 dR3hLMVRvZ5D9KDuEzSo75lFKJzihh29TWo54kQ4TtL1DedTNgARMI+Hq09f3sjvC7meWIc0r2O
 qzAIykA58N+7AJzjwlc5LB3xJJ8iXUDuYHstVxnevMqMyqcoD+TM3uqhRrl571hfzKbqbHpd86q
 zVdpbBWhFEcqvQ7B1MdVRJlMtrUVW32FcR6Cu3Kvf6DQ1eF6Hc+IW+4bB3HxmlJpyzHLuXGwsAr
 IzXRh80yX3q1TQ5cW9+Y8qaPh6RPLX0JgebE2qJ
X-Received: by 2002:a05:6a00:4398:b0:886:77eb:38fb with SMTP id
 d2e1a72fcca58-88c6379ebdemr2776527b3a.25.1791046282129; 
 Sat, 03 Oct 2026 09:51:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0bfc3dcbsm1939649b3a.24.2026.10.03.09.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:51:21 -0700 (PDT)
Date: Sat, 3 Oct 2026 09:51:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Md Rayhanul Islam <r97yhan@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/2] per-device DMA properties, with igb as the
 first user
Message-ID: <20261003095119.3f951a86@phoenix.local>
In-Reply-To: <20261002200927.6235-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20261002200927.6235-1-r97yhan@gmail.com>
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

On Fri,  2 Oct 2026 16:09:25 -0400
Md Rayhanul Islam <r97yhan@gmail.com> wrote:

> This RFC reworks the BCM2711 DMA fix around a per-device DMA context and
> an EAL sync API, after the feedback on the first posting [1].
> 
> On Raspberry Pi 4 / Compute Module 4 the PCIe host bridge translates DMA
> addresses and is not cache coherent, so a device such as the Intel I210
> cannot DMA at all without both being handled.
> 
> What changed since the first posting:
> 
> * The translation and the coherency are read per device from its own
>   bridge, not kept as one process-wide offset.  EAL no longer rewrites
>   IOVAs; the driver translates where it programs the hardware.
> * A driver opts in with RTE_PCI_DRV_DMA_NONCOHERENT, and the bus refuses
>   such a device to any driver that has not.  That replaces the refusal
>   written into em by hand.
> * The cache maintenance is an experimental EAL interface with explicit
>   directions, and the loops end in DSB SY.
> * Completion comes from the Done bits, not the head register.
> * Both environment variables are gone.
> 
> Tested between two Compute Module 4 boards with Intel I210s, both running
> this series: testpmd txonly holds 1.42 Mpps with 64-byte frames, and a
> 512 MB UDP transfer with DPDK at both ends arrives byte-identical.  Built
> with GCC and with clang 14 -Werror.

More detailed review with AI, I had to direct it to ignore using AF_XDP
in this case.

Native PMDs on Raspberry Pi class boards are a reasonable goal, and the
analysis of descriptor line sharing is good. Needs rework before a
non-RFC version.

Direction
- Split the series: (1) detection and refusing to probe, which is a fix
  on its own since igb on a CM4 today DMAs to bus address 0; (2) the EAL
  cache maintenance API; (3) driver support.
- Coherency detection should not depend on the bridge allowlist, only
  window parsing does. On arm64 DT, no dma-coherent means non-coherent
  (same as of_dma_is_coherent()). At least warn for any DT host bridge
  without it.
- igb will not be the last PMD (igc is next). Line ownership rules for
  rings, mempool validation against the window and burst variant
  selection belong in common code, not copied per driver.
- An address limit is a property of memory. Enforce it at hugepage
  allocation (extend rte_mem_set_dma_mask(); a bit mask can't express
  3 GB) and keep only the offset add in the datapath.
- Document that this needs uio_pci_generic or vfio-noiommu. VFIO with an
  IOMMU refuses non-coherent devices.

Translation
- BCM2711 does not translate: pcie0 dma-ranges is 1:1 with a 3 GB limit.
- BCM2712 (Pi 5, CM5) does (PCIe 0x10_0000_0000 maps to CPU 0), but the
  parser rejects it: 64-bit memory space code, more than one dma-ranges
  entry (MSI window, plus a 32-bit window on pcie2), and
  brcm,bcm2712-pcie is not in the table. The offset path has never run.

Bus and EAL
- PCI_LOG uses dev->name before pci_common_set() sets it.
- --iova-mode=va overrides the forced PA. Probe must check
  rte_eal_iova_mode() == RTE_IOVA_PA.
- The DT walk runs for every PCI device on every platform. Skip it when
  /sys/firmware/devicetree does not exist.
- rte_pci_dma_info is driver-only API; it goes in bus_pci_driver.h.
- rte_mem_sync.h: arch code goes in lib/eal/arm/include behind a
  generic/ header. "Empty on coherent platforms" is wrong (it is empty
  on non-arm64). Read CTR_EL0 once at init, since it can trap. Stride by
  the CTR_EL0 line size, not RTE_CACHE_LINE_MIN_SIZE. for_cpu is
  clean+invalidate, so RTE_ASSERT alignment. Add a test in app/test.

igb
- Per-packet validation (igb_tx_pkt_reachable, igb_rx_buf_usable)
  belongs at queue setup or in tx_prepare. TX silently stops the burst,
  so retrying applications spin. RX stalls and counts as mbuf allocation
  failure.
- Context descriptors are written before the segment loop, so their
  lines are never acquired.
- The acquire narrows the DD loss window but does not close it.
  Correctness rests on the last_rs fallback; document that.
- last_rs is updated per packet, so the in-burst fallback checks a
  descriptor not yet posted. Snapshot it at burst entry and reset it in
  igb_reset_tx_queue().
- The dma_per_line fallback to 1 is dead code, and if ever reached it
  would reintroduce the bug. Make it an error.
- The new fields at the head of the queue structs push the coherent
  path's hot fields down. Move them to the end and show pahole.
- TXDCTL: if OR-ing into WTHRESH is wrong, it is wrong on every
  platform. Fix it separately with a Fixes: tag, and explain forcing
  wthresh to 0.
- Nits: limits.h and unistd.h are unused, igb_dma_set_burst() in the
  igbvf path is dead, and the error on 32-bit Arm is misleading.

Testing
- 1.42 Mpps is not 64 byte line rate (1.488). What frame size?
- Need RX and io/mac fwd numbers, runs with checksum, VLAN insert and
  TSO offloads, and a Pi 5.
- Board RAM size? On a 4 or 8 GB CM4, hugepages can land above 3 GB.
