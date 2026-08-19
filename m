Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A5C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 20:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBA30402BD;
	Wed, 19 Aug 2026 22:23:30 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 1F3F5400D5
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:30 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1031008a91.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787171009;
 x=1787775809; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Sr5Tf3dtds5QcT071WaPw3xUKMFvLvKigc6MTPuayc=;
 b=COETVs2qAXGdUJ615YfG12c6L92IqXg1sRHJa6Wlpqks4saG7tKx/62fw2MqC2FqOv
 yv4ZcW0LBQzLmw89BYBUnaWbtNxvsXSG5y5hV/DFow5bF/2AIUxoYYYLj7fWIa3SyGW1
 9Fbz5Idk0XLSlhL8Cja+FE18fm3fu5RmxTFQYd34lS6nvnMUB/DSDjUsn7IOJBIoXYns
 MRWdEpc9Liv86TyKsuWz/UhBPqQ8DXLdahljzTz7Ecdst4XacMtLtBEaNMRr2QXuKfV3
 3NtMd6IErzlTpTjHBlphfNJKXw51O6roazxEcxtMqMv9aNzxnwwjh+lJRR06UjPYBBfM
 DYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787171009; x=1787775809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Sr5Tf3dtds5QcT071WaPw3xUKMFvLvKigc6MTPuayc=;
 b=K1YkiBBMYg5LacMoeAv8y/gh55Lva7tEwaonxLrCFRKOizt0AP4MeNWreTu1+GYYjv
 z+6xbO5IVGVjuI8kBpJAVVpyAUdXlhGNbj01ANustaA0u1zW6X7KFedBh0WVEdQyYshQ
 +jFROJmQckqCrIoI6jZg12nkyhAyUJ968zlHuZlAsX1GjLmVXxjtY2opoO7H6J0Dkngm
 1Rw42nE2dqTw8hHtJB/zKEWJ3uhg8jIN0Q6eBHcqPdnHStUhfT9ZR3Fy214LPfQtiIGJ
 b0hl0EziojiyG4oXMKE4dpK3x1f9dYCMlCv8Xj/F8Tj6BmEP4L5zHgasPnRkqGOMvU0+
 rjxg==
X-Gm-Message-State: AFuF++lLLg+vSsmZEw3XoZ02qVFCbg3pdAQG3jYxmMZh7ZJpf22KmT+C
 0qZ/1tFcpXiOhxvedTUY7z1Gj+IBAjswr5jYYOXIiG2sw1h921K2e2dUiUnGRvAu0DI=
X-Gm-Gg: AR+sD133/DD1Hld8/FXwV6eK0THgUkYL4wtNbUv2gi7Hjr5rZa4fkwiL3I2UxCcLc9G
 odDkIuwKpJwCyMqhwuDVl9btdMiLXZSHVmhTJjrCjcbeOjKnY1rtocbYKTmLclHqcv6ABcTvPm9
 AKK8cfjbCKDxs+efHZsxGJanwgtw82EvsOcEcQnRljbRyVzAelfy0rabaVvJk9h0SJXhdUahmat
 RzgPsT69uSYs3PBjS7oJgx79oR1zQSBm/d1QhdGiTnainBoqHQir9hC1tWT1PGNHRbF72ICGHbo
 a74C6n1p5idjEoZHnu/rrgPpgjtkt6TDLtFYjKeiuFaVCi2q88R5P60/eh52vB6PQ0jBPjfffbp
 Q/81LBX0dsBDljj05YpzMWeJ1sJv/JJwCkLk4IZF+Y0K+cY696OsQ1T5lLGPBcgOPzuag7WakYs
 h4lAnO4RB9aM3pfzJTQ5fDv4lvk0/Nbxe+6t1yExDPJ7i7eqca+n2W0szL+9LIq6Yev/Y4WwEHI
 WhwTV5NvNUBG7amEdduM6lj+6ydBg==
X-Received: by 2002:a17:90b:3c46:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-39580aa420cmr13353556a91.8.1787171008783; 
 Wed, 19 Aug 2026 13:23:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17f48sm4433404a91.2.2026.08.19.13.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 13:23:28 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:23:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v11 00/15] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260819132318.25d3fd7f@phoenix.local>
In-Reply-To: <20260819053415.645865-1-g.singh@nxp.com>
References: <20260817063454.3290854-1-g.singh@nxp.com>
 <20260819053415.645865-1-g.singh@nxp.com>
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

On Wed, 19 Aug 2026 11:04:00 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V11-Changes:
>  - Added enetc4_vf.ini for VF only features.
>  - Fixed the secondary-process guards leave the burst function
>    pointers NULL
>  - Fixed rxq_info_get and txq_info_get report the doubled ring size
>  - Move the VFs only features to enetc4_vf.ini
>  - Setting the dev->data->lro
>  - Added a comment to use devargs to change delay and timeout to process
>    PSI message to avoid any interrupts stall.
>  - Fixed link_update() now rewrites RBMR on every Rx ring.
>  - Regestering - enetc4_txq_wr in VF
>  - Updated enetc4_rd64 with re-read to confirm the correctness.
>  - Removed the dead code and un-used macros.
>  - Added Vlan check for maximum allowed value.
>  - fixed pre-existing ring write function for TX path.
> 
> V10-Changes:
>  - Fixed enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
>    setup issue.
>  - Updated ENETC_CLASS_ID_SI_VLAN_ISO reply check.
>  - Updated enetc4.ini for VLAN offload.
>  - Added else part for burst functions selection for RSC and TSO.
>  - Updated enetc4_rd64()
>  - Fixed RBICR0 issue.
>  - Removed GENMASK.
> 
> V9-Changes:
>  - Mid-body variable declaration moved to top of the function.
>  - ret=0 dead code is removed.
>  - Added check on return value of rte_intr_callback_unregister()
>  - The pre-existing reply_msg leak fixed.
>  - Added primary-process guard in enetc4_vf_dev_init
>  - Removed Flow control from enetc4.ini
>  - Fixed VF stats_reset baseline underflows on counter wrap
>  - Fixed VF vlan_pvid_set fails on every successful command
> 
> V8-changes:
>  - Fixed Warning RBMR RMW races between threads by adding lock
>  - Fixed `static const` arrays in `enetc.h`
>  - Proper pthread_mutexattr_t initialization added as suggested by AI
>  - VSIMSGSR stale re-read race is eliminated
> 
> V7-changes:
>  - added missing 14th patch.
> 
> V6-changes:
>  - fixed free() on memory allocated with rte_zmalloc().
>  - fixed eventfd and vector-list leak on interrupt teardown
>  - fixed Rx ring doubling still bypasses
>  - fixed VSI-PSI transaction issued from the interrupt handler
>  - fixed the free-and-reallocate of msg is unnecessary churn
>  - fixed unsynchronized access to tx_pause_active and RBMR
>  - fixed signed shift overflow in the register-dump version field
>  - fixed the fw_size == 0 early return reports the length of "0.0"
>  - unwanted blank lines removed.
>  - parse_txq_prior() returns updated.
> 
> V5-changes:
>  - Patch 1 Build fixes which includes:
>     'prev_seg' undeclared fixed.
>     redefinition of 'dev_rx_offloads_sup' fixed.
>     Error: duplicate rx_enable declaration fixed.
>    PF loses Scattered Rx and Multi-segment Tx
>  - mbuf leak in enetc_xmit_pkts_lso() fixed.
>  - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
>  - fixed link speed decode has no upper bound.
>  - fixed mailbox ops added to the no-VSI ops table.
>  - new devargs documented.
> 
> V4-changes:
>  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
> 
> v3-changes:
>  - fix doc build issue.
>  - fix compilation issue on fedore:43-gcc-minsize
> 
> V2-changes:
>  - compilation fixes.
> 
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
> 
> The series covers:
> 
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control = Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> 
> Gagandeep Singh (15):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
>   net/enetc: add VF supported features file
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable Tx PAUSE via VF Rx congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
> 
>  MAINTAINERS                            |   1 +
>  doc/guides/nics/enetc4.rst             | 100 +++
>  doc/guides/nics/features/enetc4.ini    |   4 +
>  doc/guides/nics/features/enetc4_vf.ini |  29 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 148 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 133 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 517 ++++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 919 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++-
>  11 files changed, 2223 insertions(+), 185 deletions(-)
>  create mode 100644 doc/guides/nics/features/enetc4_vf.ini
> 

Almost there, just a few small bits of AI review.

ENETC4 v11 series review - 15 patches

No Reviewed-by, but this is close.  Everything reported against v10 is
addressed and nothing new is broken; what remains is four
documentation/state-hygiene warnings and no errors.  Applied cleanly
onto c1a46b9.  Built this time: full driver build with
-Dwerror=true -Denable_drivers=common/dpaax,bus/pci,bus/vdev,
mempool/ring,net/enetc is clean, and all five enetc translation units
compile with no diagnostics at every one of the 15 commits, so the
series bisects.


Fixed from v10

The features matrix is split.  enetc4_vf.ini is a new file added in
patch 05 with only the entries that hold at that point; FW version,
Registers dump and Rx interrupt are added by the later patches that
implement them, so doc and code land together.  "Rx interrupt" and
"FW version" are out of enetc4.ini, and MAINTAINERS covers the new
file.

rxq_info_get and txq_info_get divide by two when rsc_enable /
lso_enable is set, so the application gets back the descriptor count it
asked for.  enetc4_rd64() reads high / low / high again and retries on a
carry.  enetc4_dev_configure() resets the Tx rings with
enetc4_txbdr_wr() instead of enetc4_rxbdr_wr(), which also fixes the
pre-existing bug where the Tx rings were never reset.
enetc4_vf_set_congestion_mode() returns early when tx_pause_active
already matches, so link_update() no longer rewrites RBMR on every
poll.  Both pvid setters range-check vlan_id.  enetc4_txq_prior and
enetc4_txq_wrr are in the VF param string.  ENETC4_TXBD_EXT_FLAGS_F and
ENETC_SPEED_MAX are gone, the rsc_size == 0 fallback is gone, and the
BDR register arrays carry explicit dimensions in both the declaration
and the definition so a drift becomes a compile error.

ENETC_CLASS_ID_SI_VLAN_ISO is out of the enetc4_msg_vsi_send()
whitelist, which is now consistent with the reply handling in
enetc4_vf_vlan_pvid_set() and with your explanation that 0x24 is never
echoed back.

The 200 ms interrupt-thread stall is documented rather than changed.
That is a reasonable call, and the devarg names in the new comment
("enetc4_vsi_timeout", "enetc4_vsi_delay") do match the macros, so the
advice is actionable.

RSC now refuses to start unless the application asked for
RTE_ETH_RX_OFFLOAD_SCATTER, and sets dev->data->lro and
dev->data->scattered_rx.  That closes the gap where the driver built
multi-segment clusters for an application that had not opted in.


Warnings

Patch 09 - the secondary-process burst pointers still do not match what
the primary is running.

The NULL dereference is gone, which was the point.  But both branches
hardcode enetc_recv_pkts_cacheable / enetc_xmit_pkts_cacheable, and the
comment claims this "matches the pre-guard behaviour where
enetc4_dev_hw_init() set these defaults in both processes".  It does
not: dev_hw_init() parses the nc devarg and switches to
enetc_recv_pkts_nc / enetc_xmit_pkts_nc when nc_mode is set, and the
guard returns before that.

For nc the mismatch is the harmless direction.  For RSC and LSO it is
not: those rings are 2 slots per descriptor, and a secondary polling
one with the 16-byte-stride cacheable burst reads the extension half as
a descriptor.  That is silent garbage rather than a crash.

hw->nc_mode lives in dev_private, which is shared, so the secondary can
at least honour it.  RSC and LSO cannot be resolved at probe time,
since they come from offloads chosen later by the primary.  If
multi-process is meant to work here, the burst selection needs to
happen after the primary has configured; if it is not, saying so in
enetc4.rst and rejecting LRO/TSO in that case would be clearer than
handing the secondary a burst function for the wrong ring layout.

Patch 03 - the new RSC restrictions are not in enetc4.rst.

enetc4_rx_queue_setup() now returns -EINVAL for LRO in three cases:
with KEEP_CRC, with nc=1, and without RTE_ETH_RX_OFFLOAD_SCATTER.  The
guide documents only the first.  An application that enables LRO
without SCATTER now fails queue setup with no hint in the docs; both of
the new conditions belong in the LRO bullet next to the FCS one.

Patch 03 - dev->data->lro and dev->data->scattered_rx are set but never
cleared.

Both are assigned 1 in enetc4_rx_queue_setup() when RSC is on, and
nothing assigns 0 anywhere.  After dev_stop plus a reconfigure without
LRO, they keep the stale value, so rxq_info_get() reports
scattered_rx = 1 on a non-scattered ring and telemetry reports lro = 1
for a port that is not doing LRO.  Assign from rsc_enable
unconditionally rather than only in the rsc_enable branch, or clear
both in dev_configure().

Patch 05 - two entries in the new enetc4_vf.ini do not hold.

"Unicast MAC filter" requires mac_addr_set, mac_addr_add and
mac_addr_remove per features.rst; enetc4_vf_ops has the first two and
no mac_addr_remove.  "RSS hash" lists
offloads:RTE_ETH_RX_OFFLOAD_RSS_HASH, which is not in the VF
dev_rx_offloads_sup, though flow_type_rss_offloads is provided.  Both
were inherited from enetc4.ini, so they are not new claims, but a new
file is the right moment to drop the ones that do not match.


Info

doc/guides/nics/enetc4.rst line 167 still has

  dpdk-testpmd -a 0000:00:00.0,enetc4_txq_prior=1|2|3 -- -i

Unquoted, the shell reads the pipes as a pipeline.  Pre-existing, but
the enetc4_txq_wrr example added twelve lines below quotes its value,
so the two now disagree on the same page.
