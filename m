Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E716C5DF88
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 05:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1E940609;
	Fri, 21 Aug 2026 07:56:49 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4623C4028C
 for <dev@dpdk.org>; Fri, 21 Aug 2026 07:56:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 03AC11A024E;
 Fri, 21 Aug 2026 07:56:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C87E11A024B;
 Fri, 21 Aug 2026 07:56:47 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C1A018000B0;
 Fri, 21 Aug 2026 13:56:47 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Date: Fri, 21 Aug 2026 11:26:28 +0530
Message-Id: <20260821055643.1359277-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819053415.645865-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

V12-Changes:
 - Fixed documentation for:
   - missing double quotes for enetc4_txq_prior
   - In accurate comment related to secondary process burst functions.
   - Added a note related to LRO and its BD size chosen.
 - Fixed secondary process burst functions selection.
 - Removed "Unicast MAC filter" from vf, but comment regarding "RSS
   hash" is false positive as or RSS hash, the only mandatory
   requirement is `[provides] rte_eth_dev_info: flow_type_rss_offloads
   , which the VF sets in enetc4_vf_dev_infos_get
   (`dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL`).
 - Fixed lro and scattered_rx configuration by enabling only after
   rsc_enable branch.

V11-Changes:
 - Added enetc4_vf.ini for VF only features.
 - Fixed the secondary-process guards leave the burst function
   pointers NULL
 - Fixed rxq_info_get and txq_info_get report the doubled ring size
 - Move the VFs only features to enetc4_vf.ini
 - Setting the dev->data->lro
 - Added a comment to use devargs to change delay and timeout to process
   PSI message to avoid any interrupts stall.
 - Fixed link_update() now rewrites RBMR on every Rx ring.
 - Regestering - enetc4_txq_wr in VF
 - Updated enetc4_rd64 with re-read to confirm the correctness.
 - Removed the dead code and un-used macros.
 - Added Vlan check for maximum allowed value.
 - fixed pre-existing ring write function for TX path.

V10-Changes:
 - Fixed enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
   setup issue.
 - Updated ENETC_CLASS_ID_SI_VLAN_ISO reply check.
 - Updated enetc4.ini for VLAN offload.
 - Added else part for burst functions selection for RSC and TSO.
 - Updated enetc4_rd64()
 - Fixed RBICR0 issue.
 - Removed GENMASK.

V9-Changes:
 - Mid-body variable declaration moved to top of the function.
 - ret=0 dead code is removed.
 - Added check on return value of rte_intr_callback_unregister()
 - The pre-existing reply_msg leak fixed.
 - Added primary-process guard in enetc4_vf_dev_init
 - Removed Flow control from enetc4.ini
 - Fixed VF stats_reset baseline underflows on counter wrap
 - Fixed VF vlan_pvid_set fails on every successful command

V8-changes:
 - Fixed Warning RBMR RMW races between threads by adding lock
 - Fixed `static const` arrays in `enetc.h`
 - Proper pthread_mutexattr_t initialization added as suggested by AI
 - VSIMSGSR stale re-read race is eliminated

V7-changes:
 - added missing 14th patch.

V6-changes:
 - fixed free() on memory allocated with rte_zmalloc().
 - fixed eventfd and vector-list leak on interrupt teardown
 - fixed Rx ring doubling still bypasses
 - fixed VSI-PSI transaction issued from the interrupt handler
 - fixed the free-and-reallocate of msg is unnecessary churn
 - fixed unsynchronized access to tx_pause_active and RBMR
 - fixed signed shift overflow in the register-dump version field
 - fixed the fw_size == 0 early return reports the length of "0.0"
 - unwanted blank lines removed.
 - parse_txq_prior() returns updated.

V5-changes:
 - Patch 1 Build fixes which includes:
    'prev_seg' undeclared fixed.
    redefinition of 'dev_rx_offloads_sup' fixed.
    Error: duplicate rx_enable declaration fixed.
   PF loses Scattered Rx and Multi-segment Tx
 - mbuf leak in enetc_xmit_pkts_lso() fixed.
 - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
 - fixed link speed decode has no upper bound.
 - fixed mailbox ops added to the no-VSI ops table.
 - new devargs documented.

V4-changes:
 - fix doc build issue: WARNING: undefined label: pmd_build_and_test

v3-changes:
 - fix doc build issue.
 - fix compilation issue on fedore:43-gcc-minsize

V2-changes:
 - compilation fixes.

V1-changes:
This series adds new PMD features to the ENETC4 driver targeting the
NXP i.MX95 NETC IP.

The series covers:

 - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
 - TSO: TCP Segmentation Offload for the VF Tx path.
 - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
 - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
   8-bit to support speeds beyond 10G.
 - Firmware version: report the NETC IP version via fw_version_get.
 - Register dump: dump SI, port (PF) and BD ring registers.
 - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
 - Link-up interrupt: refresh the cached link speed on each VF link-up
   interrupt so that link_update returns the current speed immediately.
 - Stats reset: software snapshot/delta approach for VF counter reset.
 - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
   enabling interrupt-driven receive with l3fwd-power.
 - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
 - VF link status bitmask: switch VF link status to bitmask encoding
   to align with the PF and newer kernel driver conventions.
 - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
   negotiated on the wire; adds Flow control = Y to enetc4.ini.
 - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.

Gagandeep Singh (15):
  net/enetc: add keep-CRC Rx offload for ENETC4
  net/enetc: add TSO support for ENETC4 VF
  net/enetc: add RSC (hardware LRO) support for ENETC4
  net/enetc: extend PF-VF link speed field to 8 bits
  net/enetc: add VF supported features file
  net/enetc: support firmware version get for VF
  net/enetc: support registers dump
  net/enetc: support ethtool ring parameters
  net/enetc: refresh link speed on VF link-up interrupt
  net/enetc: support stats reset for VF
  net/enetc4: add per-queue Rx interrupt support for VF
  net/enetc4: add SI-based port VLAN insertion and removal
  net/enetc4: update VF link status to bitmask encoding
  net/enetc4: enable Tx PAUSE via VF Rx congestion mode
  net/enetc4: add WRR Tx scheduler devarg for VF rings

 MAINTAINERS                            |   1 +
 doc/guides/nics/enetc4.rst             | 114 ++-
 doc/guides/nics/features/enetc4.ini    |   4 +
 doc/guides/nics/features/enetc4_vf.ini |  28 +
 doc/guides/rel_notes/release_26_11.rst |  21 +
 drivers/net/enetc/base/enetc4_hw.h     | 148 +++-
 drivers/net/enetc/base/enetc_hw.h      |   6 +
 drivers/net/enetc/enetc.h              | 133 +++-
 drivers/net/enetc/enetc4_ethdev.c      | 527 ++++++++++++--
 drivers/net/enetc/enetc4_vf.c          | 928 ++++++++++++++++++++++---
 drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++-
 11 files changed, 2254 insertions(+), 186 deletions(-)
 create mode 100644 doc/guides/nics/features/enetc4_vf.ini

-- 
2.25.1

