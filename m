Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24CC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 11:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32299402F1;
	Thu,  6 Aug 2026 13:28:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id E93B9402BB
 for <dev@dpdk.org>; Thu,  6 Aug 2026 13:28:40 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B59D01A00AE;
 Thu,  6 Aug 2026 13:28:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DA661A009D;
 Thu,  6 Aug 2026 13:28:40 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B1D861800088;
 Thu,  6 Aug 2026 19:28:39 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 00/14] net/enetc: add new features for ENETC4 VF on i.MX95
Date: Thu,  6 Aug 2026 16:58:22 +0530
Message-Id: <20260806112836.707921-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
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

Gagandeep Singh (14):
  net/enetc: add KEEP_CRC offload support for ENETC4
  net/enetc: add TSO support for ENETC4 VF
  net/enetc: add RSC (hardware LRO) support for ENETC4
  net/enetc: extend link speed code field to 8-bit for PF-to-VF message
  net/enetc: support firmware version get for VF
  net/enetc: support registers dump
  net/enetc: support ethtool ring parameters
  net/enetc: refresh link speed on VF link-up interrupt
  net/enetc: support stats reset for VF
  net/enetc4: add per-queue Rx interrupt support for VF
  net/enetc4: add SI-based port VLAN insertion and removal
  net/enetc4: update VF link status to bitmask encoding
  net/enetc4: enable TX PAUSE via VF RX congestion mode
  net/enetc4: add WRR Tx scheduler devarg for VF rings

 doc/guides/nics/enetc4.rst             |  81 ++-
 doc/guides/nics/features/enetc4.ini    |   8 +
 doc/guides/rel_notes/release_26_11.rst |  19 +
 drivers/net/enetc/base/enetc4_hw.h     | 129 +++-
 drivers/net/enetc/base/enetc_hw.h      |   6 +
 drivers/net/enetc/enetc.h              | 135 ++++-
 drivers/net/enetc/enetc4_ethdev.c      | 394 ++++++++++++-
 drivers/net/enetc/enetc4_vf.c          | 780 ++++++++++++++++++++++---
 drivers/net/enetc/enetc_rxtx.c         | 531 ++++++++++++++++-
 9 files changed, 1950 insertions(+), 133 deletions(-)

