Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69968C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4454A4028B;
	Sat, 15 Aug 2026 17:17:31 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 39EFE40272
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:17:30 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so2092976b3a.3
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786807049;
 x=1787411849; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r4B7LARVTJY2wdimKIu/yf+LSrsRhxkzwnjsJpUBKrI=;
 b=HZdX27hoAnsvmz++xE91ulVWsniBzKVuFZlmoJZDMpADhnypCmyvG3aMcmGpVRSYl8
 4mxJ/wk4Uug+VbeDJ1gNYfSGXMMfseqiYfkrtuuxBmf7SxkzRAnrLM41ZUBAvgh0cvM2
 5F3acnsBaWIW5H7ETH4OWnmUbn4wPK/XehKG3Qt0ghr+zzOe4Z8CxZzRcHjOsRfVTjzR
 uAuvDzifTd39GT+rLlzwFjxN8FWuTza1d9ITcFfiCXV8UOPGYIZBtYTN8H8bhbzP9H8w
 DHj2Dm/ncXvhTlsEciju0s5JFlC8fRyW9HKsaYwIB5q2fYeqKT8NqR+W6VA0XsArWmRY
 914Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786807049; x=1787411849;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r4B7LARVTJY2wdimKIu/yf+LSrsRhxkzwnjsJpUBKrI=;
 b=lwjL8rm2OHIci8/a1qfVpOU56gaNx7KveDQ3uGGtyv97xQ+Qs2HEpe5+LPaHIeKktR
 BCOSnPhxW+rYISOEti8zeCLiXNSL35t8iQ4cj13V11vSd63yhkCRS0zRt6WGMPo6Qaj2
 uucU7yG2aaHntFUPA7349qV6DBdi0FhKZ4PoTfvy0NQePQR6NxKKOeguIPQKLZgLe6we
 b124i8ava43v/l4+wqMnzlam3udNEueHoSDNPOh9w71lEV2gyrUEInbVPY3WB96HRFvj
 r7xt7nNOUvBY+5QfHWbF0r3CQtohWMeONVzTuxJVML2xTHAt8o9HRuDmPorKMtilLg6O
 mRUQ==
X-Gm-Message-State: AOJu0Yxja0DoU0XRcjwMxYldOSN4v9dgyuYdfhr9zsS/dqz+DaOFVIRG
 LHnHeaBWgnkP6HiZh8vdc6+Kp45SAgb5jDnWGce8XkylVir0CqXhaKn3U84I572yHJQ=
X-Gm-Gg: AR+sD13VryqWLzlYtqb3EsWFQ1oSXV3US2D1B0bwD0ywr8Id2FQrfVVYDumtt5QgqLi
 /EQAowSegm/pEbtK7UYp6hWFs0gyO6Drqhj+zqpJ6iiH2q92wMoyAjP3KkSqKsjM5Ext+RPJvtr
 D5R6e2BVgbcee5wJ2AfcrhaQuoaqElILNrurV+1RiIoWHERP64WXC5y1u8krWygeoyuhxse4ZuX
 ZlvxFiCXiPQ+msRgofjgppmdiWH2FwaeF3a17ZwWyqebGELz0bsFtubogcCLgdllS4uSInjeg6U
 KUPU4sct/NtPtTpRy5QaYAIbGLDJ5O3ERpbp8HTbRC8I9ozyoboBDxYtggYrweGbXy1aBgU7IHd
 ECgwgCk1nV8YTWw1bHaTsaNQrsKcJGKWjzIWrXijdnpjTecvoGzMeClch017kvBX1jW5MDBzEG+
 73NK2GQ4xTBW3rxTFRm9m6J/ZBMDJmiHrq8usptzL3AsHwt/JOARBVrNOvNldvuPoW0CT8g7wIj
 UTD/yAUP7kQsIYZCa4pbx9VWhKpUOZxAUIhyuMZq8hVRcCX/FqB
X-Received: by 2002:a05:6a20:914c:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3cc71da42f8mr12100748637.25.1786807049089; 
 Sat, 15 Aug 2026 08:17:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea804233sm14627458eec.26.2026.08.15.08.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:17:28 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:17:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v9-1 00/14]  net/enetc: add new features for ENETC4 on
 i.MX95
Message-ID: <20260815081717.6c93387d@phoenix.local>
In-Reply-To: <20260813121358.1321196-1-g.singh@nxp.com>
References: <20260812113317.693144-1-g.singh@nxp.com>
 <20260813121358.1321196-1-g.singh@nxp.com>
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

On Thu, 13 Aug 2026 17:43:44 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

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
>  doc/guides/nics/features/enetc4.ini    |   7 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 137 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 132 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 459 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 870 +++++++++++++++++++++----
>  drivers/net/enetc/enetc_rxtx.c         | 530 ++++++++++++++-
>  9 files changed, 2084 insertions(+), 178 deletions(-)
> 

Still some AI review feedback items that need addressing.
I say addressing because AI can and does spot things that are not
a real problem.

ENETC4 v9 series review - 14 patches

No Reviewed-by.  The two v8 errors are fixed, but this revision
introduces a regression in patch 14 that silently disables the existing
enetc4_txq_prior devarg, and the patch 11 reply check looks inverted
rather than fixed.  Applied cleanly onto c1a46b9; source review only,
no builds.


Fixed from v8

enetc4_rd64() now reads the 64-bit SI counters as a high/low pair and
oerrors is masked to 32 bits before the subtraction, so the stats_reset
delta no longer underflows on counter wrap.  "Flow control = Y" is gone
from enetc4.ini.  The ring-doubling paths validate the doubled count
against MAX_BD_COUNT.  enetc4_vf_link_update() frees reply_msg on both
"Wrong reply message" paths.  Interrupt teardown frees the vector list
and disables the efds.  txq_prior moved to rte_zmalloc/rte_free
consistently, with the old allocation released before re-parsing.


Errors

Patch 14 - enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
setup.

In enetc4_tx_queue_setup() the hunk changed the target variable but not
the register write:

  uint32_t tx_en = ENETC_TBMR_EN;

  if (priv->hw.txq_prior)
          tx_data |= priv->hw.txq_prior[tx_ring->index];
  if (priv->hw.txq_wrr)
          tx_data |= priv->hw.txq_wrr[tx_ring->index];
  /* enable ring */
  enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index, ENETC_TBMR, tx_en);

tx_data is never read again, so both the priority and the WRR weight are
dropped and only ENETC_TBMR_EN reaches TBaMR.  This is a regression: v8
had "tx_en |= priv->hw.txq_prior[...]", which worked.  The scheduler
bits now only get programmed through enetc4_tx_queue_start(), which
non-deferred queues never go through.  Either OR into tx_en, or drop
tx_en and write tx_data | ENETC_TBMR_EN.

Patch 11 - the vlan_pvid_set reply check is inverted, not fixed.

  if (reply_msg->class_id != ENETC_CLASS_ID_SI_VLAN_ISO) {
          ENETC_PMD_ERR("SI VLAN isolation command failed: ...");
          err = -EINVAL;
  }

For the configuration command classes the driver already handles,
class_id equal to the command class is the failure indication and
ENETC_MSG_CLASS_ID_CMD_SUCCESS (0x1) is success.  Both MAC and VLAN
filter follow that shape:

  if (class_id == ENETC_CLASS_ID_MAC_FILTER) {
          switch (status) { ... default: err = -EINVAL; }
  }

that is, every status under 0x20 is an error.  If 0x20 were also
returned on success, set_mac_addr could never succeed.

SI VLAN isolation (0x24) is a set-type command in the same 0x2x family,
so success should arrive as 0x1 and 0x24 should carry a class-specific
error status.  As written the function still returns -EINVAL on every
successful command, the same symptom as v8 with a different comparand.
The shape to match is:

  if (reply_msg->class_id == ENETC_CLASS_ID_SI_VLAN_ISO) {
          /* class-specific failure: inspect reply_msg->status */
          err = -EINVAL;
  }

The classes where class_id == command class *is* the success reply are
the query classes - LINK_STATUS (0x80), LINK_SPEED (0x81), GET_IP_VER
(0xF0) - which return data in the status byte.  If the PSI really does
return 0x24 on success for this command, please say so in the commit
message, since it contradicts the convention every other setter in the
file uses.


Warnings

Patch 11 - "VLAN offload = Y" added to enetc4.ini for a pvid change.

doc/guides/nics/features.rst lists vlan_pvid_set under "Other dev ops
not represented by a Feature"; pvid has no matrix entry.  The VLAN
offload entry requires vlan_offload_set plus
RTE_ETH_RX_OFFLOAD_VLAN_STRIP / RTE_ETH_TX_OFFLOAD_VLAN_INSERT in
rx_offload_capa / tx_offload_capa.  The PF ops table has no
vlan_offload_set at all and neither offload flag is in
dev_rx_offloads_sup / dev_tx_offloads_sup.  Drop the line.

Patches 02 and 03 - the burst function is selected on enable but never
restored.

enetc4_rx_queue_setup() sets dev->rx_pkt_burst = &enetc_recv_pkts_rsc
when LRO is requested and enetc4_tx_queue_setup() sets
dev->tx_pkt_burst = &enetc_xmit_pkts_lso when TSO is requested; neither
has an else branch.  The defaults are assigned once at probe in
enetc4_dev_hw_init().  After a dev_stop plus rte_eth_dev_configure()
without those offloads the pointers keep their previous values, and
enetc_clean_rx_ring_rsc() then walks a 16B-descriptor ring as if it
were 32B (i += 2, bd_count not doubled, extension slot read from the
neighbouring descriptor).  The RSC assignment also happens before
enetc4_alloc_rxbdr(), so it survives a failed setup.


Info

Patch 09 - enetc4_rd64() reads high and low with no re-read of the low
word, so a carry between the two accesses yields a value 2^32 too
large.  The window is tiny but the error is not; the usual form is
read-high / read-low / read-high-again and retry if the high word
moved.  Related: the operands of | have unspecified evaluation order,
so which half is fetched first is up to the compiler.

Patch 10 - enetc4_vf_rx_queue_intr_enable() writes RBICR1 = 0 and
RBICR0 = ICEN | ICPT(1), overwriting the coalescing timer that patch 03
programs for RSC (ENETC4_RSC_DEF_ICTT).  An application enabling both
LRO and intr_conf.rxq gets per-frame flushes and no coalescing, with no
diagnostic.

Patch 14 - ENETC_TBMR_WRR_MASK and ENETC_TBMR_PRIO_MASK use GENMASK,
which is defined in ntmp.h, not in base/enetc_hw.h where the macros
live.  It works only because enetc.h pulls in both and the expansion is
deferred to the use site; enetc_rxtx.c includes base/enetc_hw.h
directly and would break if it ever used them.

Patch 14 - devargs are now parsed in both enetc4_dev_init()
(priorities, nc) and enetc4_dev_configure() (priorities, wrr, nc).  The
duplicate parse is harmless since parse_txq_prior() frees the previous
array, but hw->nc_mode is reset and re-parsed in configure after the
burst functions were already chosen in init, so an nc change there
cannot take effect.

Patch 01 - enetc_rx_crc_trim() decrements first_seg->pkt_len
unconditionally; if a single-segment cluster ever arrived with
data_len <= crc_len and prev_seg == NULL, pkt_len would wrap.  Not
reachable for valid Ethernet frames, but a data_len > crc_len guard on
the pkt_len adjustment would make it total.
