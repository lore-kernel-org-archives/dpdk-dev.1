Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC0C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8732340294;
	Tue, 18 Aug 2026 04:28:16 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id A4E6B4028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:28:14 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso5707045ad.0
 for <dev@dpdk.org>; Mon, 17 Aug 2026 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787020093;
 x=1787624893; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E/Pna3BE1fvgncu/rVfbp6otOU5EPKlAyQR0H9p5tgw=;
 b=SulsVQB73avZSJ2+VO0BxTQpydTmBmlTLqq/+3PhsRI+CC4MG2v1vhRpk4po6R1lGE
 KN1ALlw9iCArh13oDgVX38IdcOu489FKNHX+wDM3oC04NJXcPVKD/GBsonQQ5J8dvf2b
 6jB5TPAXVxIQO3GflEqlU12xDv+2yQFWXVYXpipo9sOnd7VVCTaV9MJKOD2mCZP6Z6B6
 gskmSdxTB1aFeykLqhcv4GvVQmxL+eKgWZq5GUOa3PKs4m157RGEBJeuT14rEF/ByOe1
 8HBNOnbKBYGIK12wFZuk+jcsUs7l/rU2CH8HKSjjuEue7k1f3/ZXDxk1oe7DSm43K2VJ
 RVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787020093; x=1787624893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/Pna3BE1fvgncu/rVfbp6otOU5EPKlAyQR0H9p5tgw=;
 b=lEWYZgiEjhiQb3PuRqT/eEJwk/aNiCqRuuYKkKDtQ33NmrBM8GtxuLgMfBPlLBZqbB
 8T7q/3gkZQtV02q00egWl2NAgdSevPTiRhIrp3mplJDmVP4IWJSWEfqG5nUh6YlEXaQ6
 OeATVApqkdQezksma56P6bB/BkywYZsQ0z+tb+yTlK1vUk8pErrQWGQCpZRQvYwxU3xR
 /F6oU9C6jnFhoo4Gc0ynKrDNuIN9yUsF27WmJAgWpS+H4FDrDdP9D1YP9s+BJqHkT1xz
 ppsKwtegU4Xye8QYvYh2euNLIUW7QD0cbnHKcaBzpwTZY2qESloHxlcXJcKejzDZstEr
 u9KA==
X-Gm-Message-State: AOJu0YyiDGLh6LUz56t/hNybtVe14bYgFQUyW4BjjvqiC8zRQZXtKZTj
 aNEWjkaWHdeg+rpd59Yt+UUidcvYx9EWwq3T3eL/kZjHr0dltqIIzVSpr0JwxRZHl2A=
X-Gm-Gg: AR+sD10vUdxAPhejSlMZNYHvXrcGGD5lnjPMp3qWJh1dYifTbSg+MKgtmaE5x14OpJT
 mG07P6rpOoVvovfd+jxM2GbeoxmfzlAF94wn1Wo7oXqbtlvrys+uLPjarkJ2xTL3JCvSFE4K4MY
 IYW5B11UDWfl/oygIDxke2Z6g38NZdTgHq4tWYLJ6BnCg2PzC30KITUB7prAsnmhpm3GFbB89FX
 PmdA64ioWhmLKDQt2aK8550UXP2k1O/W60S7xFllBshbHMxvo4ccwluGrcjpWTDeXMy3Oy1xy8G
 fjQSxfzo7P3U4H55kYgrEr/Y3hG4YgrxSJpbTIsVGgP0BM1R2ujhST/cZ8zsFjCh9IAX9KL/C6q
 e1pw0dw+HzjLP17Agcsht6kIY2WRgOtei8TN1WyWT/UvHGFrZ1fEBx23MK5sB/LEOCBwREXqxfS
 Wgp+TVxY42RlDzvY2S0m/uxvY6MFqNAUNUXw+nAfxJ0iFCyDfZR9HHxkfL/h3ssRbK+VV+86VzD
 6M8CXVk1QdTaB8yjPa90taSm/OVPQ==
X-Received: by 2002:a17:90b:58cb:b0:394:ed5c:ff9f with SMTP id
 98e67ed59e1d1-3955f1b563amr3046711a91.17.1787020093402; 
 Mon, 17 Aug 2026 19:28:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415317054dsm10264263c88.12.2026.08.17.19.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:28:13 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:28:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v10 00/14]  net/enetc: add new features for ENETC4 on
 i.MX95
Message-ID: <20260817192804.1f12d967@phoenix.local>
In-Reply-To: <20260817063454.3290854-1-g.singh@nxp.com>
References: <20260813121358.1321196-1-g.singh@nxp.com>
 <20260817063454.3290854-1-g.singh@nxp.com>
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

On Mon, 17 Aug 2026 12:04:40 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

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
> Gagandeep Singh (14):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
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
>  doc/guides/nics/enetc4.rst             | 100 +++
>  doc/guides/nics/features/enetc4.ini    |   6 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 139 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 132 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 478 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 886 +++++++++++++++++++++----
>  drivers/net/enetc/enetc_rxtx.c         | 530 ++++++++++++++-
>  9 files changed, 2117 insertions(+), 181 deletions(-)
> 

Looks better but AI still sees some things.

ENETC4 v10 series review - 14 patches

No Reviewed-by.  Both v9 errors are fixed and nothing in this revision
looks like a regression, but there is one new problem introduced by the
secondary-process guards and a handful of documentation/API mismatches
that should be sorted before this goes in.  Applied cleanly onto
c1a46b9; source review only, no builds.


On the v9 replies

The nc_mode item is a false positive as you say, dropped.  Both
enetc4_tx_queue_setup() and enetc4_rx_queue_setup() now have an else
branch that reads hw->nc_mode, and queue setup always runs after
dev_configure(), so the configure-time value is what reaches the burst
selection.  Worth noting the argument only became true in this
revision: those else branches are the fix for the other v9 warning.
Before that, the dev_init() assignment really was the last word.

The enetc_rx_crc_trim() item is also a false positive, dropped.  The
unguarded arm is prev_seg == NULL, which only happens on a
single-segment cluster where data_len is the whole frame, and minimum
frame size enforcement puts that well above 4.  One thing to keep in
mind if that ever changes: the Rx clean paths count rxbd.r.error into
ierrors but still hand the mbuf to the application, so a runt that was
flagged rather than dropped would take exactly that path.

On vlan_pvid_set, your explanation is more specific than what the
review inferred from the MAC and VLAN filter shape, and the code is
right if the kernel PF behaves as you describe.  One leftover though:
enetc4_msg_vsi_send() still carries

  case ENETC_CLASS_ID_SI_VLAN_ISO:
          break;

in the non-success whitelist.  Every class_id that is not on that list
already makes send() return an error before vlan_pvid_set() reaches its
own reply check, so 0x24 is now the only value that can ever make the
new check fire.  If 0x24 is genuinely never echoed back, that case is
dead and should go.  If it can come back as a class-specific error,
then the comment above the check is wrong.  Either way the two should
not say different things.


Fixed from v9

enetc4_tx_queue_setup() writes tx_data now, with the scheduler bits
cleared before EN, txq_prior and txq_wrr are OR'd in, so both devargs
reach TBaMR at setup.  The vlan_pvid_set reply check tests against
CMD_SUCCESS.  "VLAN offload = Y" is gone from enetc4.ini.  Both queue
setup paths restore the nc/cacheable burst function in an else branch.

Also addressed without comment: ENETC_TBMR_WRR_MASK and
ENETC_TBMR_PRIO_MASK are literal hex now, so the GENMASK-from-ntmp.h
dependency is gone, and enetc4_vf_rx_queue_intr_enable() guards the
RBICR1 = 0 write with if (!rx_ring->rsc_enable), preserving the RSC
coalesce timer.

The mailbox is serialized by hw->vsi_lock, correctly initialized with
PTHREAD_PROCESS_SHARED (dev_private is hugepage memory, so that is the
right attribute), unlocked on every return path in
enetc4_msg_vsi_send(), and destroyed under a primary-process guard in
dev_close.  No deadlock: enetc4_process_psi_msg() runs from the
interrupt callback outside the lock.  VF stats_reset uses enetc4_rd64()
for the 64-bit SI counters and does the SITDFCR delta in uint32_t, so
the wrap underflow is gone.


Errors

Patch 08 - the secondary-process guards leave the burst function
pointers NULL.

Both enetc4_dev_init() and enetc4_vf_dev_init() now start with

  if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
          eth_dev->dev_ops = &enetc4_ops;
          return 0;
  }

The burst functions are selected in enetc4_rx_queue_setup() and
enetc4_tx_queue_setup(), which a secondary process never calls, so
eth_dev->rx_pkt_burst and tx_pkt_burst stay NULL there.
eth_dev_fp_ops_setup() copies them into rte_eth_fp_ops verbatim, so
rte_eth_rx_burst() in the secondary calls through a NULL pointer.

Before the guard, dev_init() ran enetc4_dev_hw_init() in the secondary
and the pointers were at least set, so this is a step backwards for
multi-process.  Either set the burst functions in the secondary branch
the way most PMDs do, or, if secondary process operation is not
intended to be supported at all, return -ENOTSUP so the probe fails
cleanly instead of succeeding into a crash.

In the PF path the dev_ops assignment is also duplicated immediately
after the guard.


Warnings

Patch 07 - rxq_info_get and txq_info_get report the doubled ring size.

With RSC or LSO enabled, bd_count is 2 * nb_desc, and
qinfo->nb_desc = rxq->bd_count hands that value back to the
application.  An application that reads nb_desc and feeds it into a
later rx_queue_setup() doubles the ring on every pass until
MAX_BD_COUNT rejects it.  Report the count the application asked for,
not the internal slot count.

Patches 05, 06 and 10 - the features matrix is the PF's, but the new
entries are VF-only.

There is no doc/guides/nics/features/enetc4_vf.ini, so everything in
enetc4.ini describes net_enetc4.  "Rx interrupt = Y" requires
rx_queue_intr_enable and rx_queue_intr_disable, and "FW version = Y"
requires fw_version_get; neither is in enetc4_ops, both are VF-only.
A separate enetc4_vf.ini would fix this cleanly and would also let you
untangle the pre-existing entries in that file that are already
VF-only.

Patch 03 - "LRO = Y" without dev->data->lro.

features.rst lists "[implements] rte_eth_dev_data: lro" for that entry
and the driver never sets it.  The same applies to
dev->data->scattered_rx, which stays 0 even though RSC delivers
multi-segment clusters, so enetc4_rxq_info_get() then reports
scattered_rx = 0.  Nothing checks that the application enabled
RTE_ETH_RX_OFFLOAD_SCATTER before RSC starts building chains, and with
max_lro_pkt_size defaulting to the port frame size the chains are
guaranteed once the coalesced frame exceeds one mbuf.

Patch 08 - link-up handling now blocks the EAL interrupt thread.

enetc4_process_psi_msg() calls enetc4_vf_get_link_speed(), a full
mailbox round trip, from inside the interrupt callback with device
interrupts masked.  With the defaults that is up to 100 * 2000 us =
200 ms, during which no other EAL interrupt callback on the process
runs.  Consider deferring the speed refresh to an alarm or to the next
link_update() call.

Patch 13 - link_update() now rewrites RBMR on every Rx ring.

enetc4_vf_link_update() calls enetc4_vf_set_congestion_mode() on both
the up and down paths, which does a read-modify-write of RBMR for every
Rx ring under vsi_lock.  Applications poll rte_eth_link_get_nowait()
frequently (testpmd does), so this turns a status query into a
per-ring register write storm against running rings.  Only touch RBMR
when the pause state actually changed.

Patch 14 - enetc4_txq_wrr is not registered for the VF.

The commit subject and the release note both say the devarg is for VF
rings, and doc/guides/nics/enetc4.rst files it under "PF/Common
devargs", but RTE_PMD_REGISTER_PARAM_STRING(net_enetc4_vf, ...) lists
only vsi_disable, vsi_timeout, vsi_delay, nc and vf_link_legacy.
enetc4_txq_prior has the same gap.  It happens to work because
enetc4_get_devargs() parses with a NULL valid-key list, but the
registration should match.


Info

Patch 09 - enetc4_rd64() still reads low then high with no re-read, so
a carry between the two accesses yields a value 2^32 too large.
Unchanged from v9.

Patch 03 - the rsc_size == 0 fallback in enetc4_rx_queue_setup() is
dead code.  rte_eth_dev_configure() fills rxmode.max_lro_pkt_size with
mtu + overhead when the application leaves it zero, so the field is
never zero by the time the PMD reads it.

Patches 02 and 04 - ENETC4_TXBD_EXT_FLAGS_F and ENETC_SPEED_MAX are
defined but never used.

Patch 06 - enetc4_txbdr_regs and enetc4_rxbdr_regs are declared extern
with an explicit dimension in enetc.h while the definitions in
enetc4_ethdev.c use [].  RTE_DIM() at the use sites in enetc4_vf.c
depends on those staying in sync with no diagnostic if they drift.

Patch 13 - the deferred-start branch of enetc4_rx_queue_setup() writes
RBMR outside vsi_lock and without applying tx_pause_active, so it can
lose a concurrent congestion-mode update.  Harmless in practice since
rx_queue_start() reapplies it, but the locking is inconsistent with the
non-deferred branch three lines above.

Patch 11 - enetc4_vlan_pvid_set() and enetc4_vf_vlan_pvid_set() mask
vlan_id to 12 bits without range checking it, so a caller passing
something above 4095 silently gets a different VLAN.

Pre-existing, noticed while reading patch 14: enetc4_dev_configure()
resets the Tx rings with

  enetc4_rxbdr_wr(enetc_hw, i, ENETC_TBMR, ENETC_BMR_RESET);

ENETC_TBMR and ENETC_RBMR are both offset 0, so this writes the Rx
ring's mode register a second time and the Tx rings are never reset.
Not introduced here, but the loop is immediately above the new devarg
parsing this patch adds.
