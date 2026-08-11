Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC216C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBBC427BC;
	Tue, 11 Aug 2026 19:49:52 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B7EC5427B1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:49:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 0BC73E054D;
 Tue, 11 Aug 2026 21:49:50 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 0BC73E054D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470591;
 bh=y9ECDbKTtuz2byA9FhndNzHROCG3Gpe/e/BF11nAyE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XYC4cPeZREc1GHMrKfm0iypEv67MBUlXV5hqXfM1806KzGQMW6MeCQMO+x4BNYWsJ
 ntmkOOSBeGEKo+y6HJfCqZ4SXIyirY6HhYr0fIsmGkHc5ya1uC3SgIUBzjZkmyNEZW
 5ILd1MxReVP8tIBUwfntpvYz8bpPv1mkpBK7nX2qoljf/Xd7T+RFU9eK0dDRWcGhHL
 jL93ClzcHJEverKzoimO13GlR4lcQyoLpoHxNUPTJjJOIvgOmf84eOijsqTqb9pu5u
 OYz39EyjkXfE/MGy3goc/7f2fDRQSSOe8d7FoSrrB8phhZnfODIZlN3VaPspn1gomp
 JYdMbvgfw2JvA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/3] common/sfc_efx/base: update MCDI headers
Date: Tue, 11 Aug 2026 21:49:47 +0400
Message-ID: <20260811174949.8993-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174949.8993-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Selectively import MCDI changes from the in-house libefx repository
to meet the needs of the feature support patches that will follow.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_regs_mcdi.h | 313 +++++++++++++++++++-
 1 file changed, 306 insertions(+), 7 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_regs_mcdi.h b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
index 259af6a0df..69d17aa255 100644
--- a/drivers/common/sfc_efx/base/efx_regs_mcdi.h
+++ b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
@@ -6952,7 +6952,7 @@
 #define	MC_CMD_LINK_STATE_MSGSET 0x6c
 #undef	MC_CMD_0x6c_PRIVILEGE_CTG
 
-#define	MC_CMD_0x6c_PRIVILEGE_CTG SRIOV_CTG_LINK
+#define	MC_CMD_0x6c_PRIVILEGE_CTG SRIOV_CTG_GENERAL
 
 /* MC_CMD_LINK_STATE_IN msgrequest */
 #define	MC_CMD_LINK_STATE_IN_LEN 4
@@ -12323,13 +12323,15 @@
 
 /***********************************/
 /* MC_CMD_MAC_CTRL
- * Set MAC configuration. Return code: 0, EINVAL, ENOTSUP
+ * Set MAC configuration. Requires LINK privilege. The only exception is when
+ * the only request is MTU change and the new MTU <= the current setting. In
+ * such case we do nothing and return 0. Return code: 0, EINVAL, ENOTSUP
  */
 #define	MC_CMD_MAC_CTRL 0x1df
 #define	MC_CMD_MAC_CTRL_MSGSET 0x1df
 #undef	MC_CMD_0x1df_PRIVILEGE_CTG
 
-#define	MC_CMD_0x1df_PRIVILEGE_CTG SRIOV_CTG_LINK
+#define	MC_CMD_0x1df_PRIVILEGE_CTG SRIOV_CTG_GENERAL
 
 /* MC_CMD_MAC_CTRL_IN msgrequest */
 #define	MC_CMD_MAC_CTRL_IN_LEN 32
@@ -12454,7 +12456,7 @@
 #define	MC_CMD_MAC_STATE_MSGSET 0x1e0
 #undef	MC_CMD_0x1e0_PRIVILEGE_CTG
 
-#define	MC_CMD_0x1e0_PRIVILEGE_CTG SRIOV_CTG_LINK
+#define	MC_CMD_0x1e0_PRIVILEGE_CTG SRIOV_CTG_GENERAL
 
 /* MC_CMD_MAC_STATE_IN msgrequest */
 #define	MC_CMD_MAC_STATE_IN_LEN 4
@@ -12609,6 +12611,16 @@
 #define	MC_CMD_STAT_ID_MAC 0x2
 /* enum: Network port PHY statistics. */
 #define	MC_CMD_STAT_ID_PHY 0x3
+/* enum: Network port packet memory (PM) statistics. */
+#define	MC_CMD_STAT_ID_PM 0x4
+/* enum: Network port RXDP statistics. */
+#define	MC_CMD_STAT_ID_RXDP 0x5
+/* enum: Low Latency datapath statistics. */
+#define	MC_CMD_STAT_ID_LL 0x6
+/* enum: Fast Classifier statistics. */
+#define	MC_CMD_STAT_ID_FC 0x7
+/* enum: Vadapter statistics. */
+#define	MC_CMD_STAT_ID_VADAPTER 0x8
 #define	MC_CMD_STAT_ID_SOURCE_ID_LBN 0
 #define	MC_CMD_STAT_ID_SOURCE_ID_WIDTH 16
 #define	MC_CMD_STAT_ID_MARKER_STAT_ID_OFST 2
@@ -12620,7 +12632,7 @@
  */
 #define	MC_CMD_STAT_ID_GENERATION_START 0x1
 /* enum: This value is used to mark the end of a generation of statistics for
- * DMA synchronizaion. Always the last entry in the DMA buffer and set to the
+ * DMA synchronization. Always the last entry in the DMA buffer and set to the
  * same value as GENERATION_START. The host driver must compare the
  * GENERATION_START and GENERATION_END values to verify that the DMA buffer is
  * consistent upon copying the the DMA buffer. If they do not match, it means
@@ -12769,6 +12781,207 @@
 #define	MC_CMD_STAT_ID_FEC_CORRECTED_SYMBOLS_LANE3 0x6
 #define	MC_CMD_STAT_ID_PHY_STAT_ID_LBN 16
 #define	MC_CMD_STAT_ID_PHY_STAT_ID_WIDTH 16
+/* Include packet memory (PM) stats. */
+#define	MC_CMD_STAT_ID_PM_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_PM_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: PM discard_vfifo_full counter. */
+#define	MC_CMD_STAT_ID_PM_DISCARD_VFIFO_FULL 0x1
+/* enum: PM discard_qbb counter. */
+#define	MC_CMD_STAT_ID_PM_DISCARD_QBB 0x2
+/* enum: PM discard_mapping counter. */
+#define	MC_CMD_STAT_ID_PM_DISCARD_MAPPING 0x3
+#define	MC_CMD_STAT_ID_PM_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_PM_STAT_ID_WIDTH 16
+/* Include RXDP stats. */
+#define	MC_CMD_STAT_ID_RXDP_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_RXDP_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: RXDP counter: Number of packets dropped due to the queue being
+ * disabled.
+ */
+#define	MC_CMD_STAT_ID_RXDP_Q_DISABLED_PKTS 0x1
+/* enum: RXDP counter: Number of packets dropped by the DICPU. */
+#define	MC_CMD_STAT_ID_RXDP_DI_DROPPED_PKTS 0x2
+/* enum: RXDP counter: Number of non-host packets. */
+#define	MC_CMD_STAT_ID_RXDP_STREAMING_PKTS 0x3
+/* enum: RXDP counter: Number of times an hlb descriptor fetch was performed.
+ */
+#define	MC_CMD_STAT_ID_RXDP_HLB_FETCH_CONDITIONS 0x4
+/* enum: RXDP counter: Number of times the DPCPU waited for an existing
+ * descriptor fetch.
+ */
+#define	MC_CMD_STAT_ID_RXDP_HLB_WAIT_CONDITIONS 0x5
+/* enum: RXDP counter: Number of packets truncated because scattering was
+ * disabled.
+ */
+#define	MC_CMD_STAT_ID_RXDP_SCATTER_DISABLED_TRUNC 0x6
+/* enum: RXDP counter: Number of times the RXDP head of line blocked waiting
+ * for descriptors. Will be zero unless RXDP_HLB_IDLE capability is set.
+ */
+#define	MC_CMD_STAT_ID_RXDP_HLB_IDLE 0x7
+/* enum: RXDP counter: Number of times the RXDP timed out while head of line
+ * blocking. Will be zero unless RXDP_HLB_IDLE capability is set.
+ */
+#define	MC_CMD_STAT_ID_RXDP_HLB_TIMEOUT 0x8
+#define	MC_CMD_STAT_ID_RXDP_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_RXDP_STAT_ID_WIDTH 16
+/* Include Low Latency datapath stats */
+#define	MC_CMD_STAT_ID_LL_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_LL_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: BIU Host CTPIO Write Byte Count, x3_ctpio_xfr_if vld & rdy & wr_req &
+ * sot & CTPIO_WINDOW_ADDR, increment by bcnt.
+ */
+#define	MC_CMD_STAT_ID_LL_CTPIO_WIN_BYTES 0x1
+/* enum: CTPIO TX Warm Packet Count, internal warm flag drop count per port. */
+#define	MC_CMD_STAT_ID_LL_CTPIO_WIN_WARM_PKTS 0x2
+/* enum: CTPIO TX Warm Packet Byte Count, internal warm flag byte drop count
+ * per port.
+ */
+#define	MC_CMD_STAT_ID_LL_CTPIO_WIN_WARM_BYTES 0x3
+/* enum: ETH_TX valid & ready. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_ACTIVE 0x4
+/* enum: ETH_TX !ready. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_PAUSE 0x5
+/* enum: ETH_TX valid & ready & last. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_PKTS 0x6
+/* enum: ETH_TX valid & ready & last, count bytes. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_BYTES 0x7
+/* enum: ETH_TX valid & ready & last & bad. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_CTUR_PKTS 0x8
+/* enum: ETH_TX valid & ready & last & bad, count bytes. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_CTUR_BYTES 0x9
+/* enum: ETH_RX_RSP valid. */
+#define	MC_CMD_STAT_ID_LL_ETH_TX_RSP 0xa
+/* enum: TX Events Coalesed. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_TXEV_COAL 0xb
+/* enum: biu_ini_dma_req & biu_ini_grant & txev data for the port. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_TXEV_PKTS 0xc
+/* enum: biu_ini_dma_req & biu_ini_grant & txev data for the port, increment by
+ * biu_ini_len.
+ */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_TXEV_BYTES 0xd
+/* enum: ETH_RX valid & ready. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_ACTIVE 0xe
+/* enum: ETH_RX !ready. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_PAUSE 0xf
+/* enum: ETH_RX valid & ready & last. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_PKTS 0x10
+/* enum: ETH_RX valid & ready & last & bad. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_BAD_PKTS 0x11
+/* enum: ETH_RX valid & ready & last, count bytes. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_BYTES 0x12
+/* enum: ETH_RX packets dropped because RX for port traffic not enabled. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_EN_DROPPED_PKTS 0x13
+/* enum: ETH_RX bytes dropped because RX for port traffic not enabled. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_EN_DROPPED_BYTES 0x14
+/* enum: ETH_RX packets dropped because RX Buffer full. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_FULL_DROPPED_PKTS 0x15
+/* enum: ETH_RX bytes dropped because RX Buffer full. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_FULL_DROPPED_BYTES 0x16
+/* enum: ETH_RX packets dropped because RX Queue not enabled. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_QEN_DROPPED_PKTS 0x17
+/* enum: ETH_RX bytes dropped because RX Queue not enabled. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_QEN_DROPPED_BYTES 0x18
+/* enum: ETH_RX packets dropped because RX Queue descriptor not available. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_NODSC_DROPPED_PKTS 0x19
+/* enum: ETH_RX bytes dropped because RX Queue descriptor not available. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_NODSC_DROPPED_BYTES 0x1a
+/* enum: biu_ini_dma_req & biu_ini_grant & rxpkt data for the port. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXPKT_PKTS 0x1b
+/* enum: biu_ini_dma_req & biu_ini_grant & rxpkt data for the port, increment
+ * by biu_ini_len.
+ */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXPKT_BYTES 0x1c
+/* enum: biu_ini_dma_req & biu_ini_grant & rxmeta data for the port. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXMETA 0x1d
+/* enum: RX Events Coalesed. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXEV_COAL 0x1e
+/* enum: biu_ini_dma_req & biu_ini_grant & rxev data for the port. */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXEV_PKTS 0x1f
+/* enum: biu_ini_dma_req & biu_ini_grant & rxev data for the port, increment by
+ * biu_ini_len.
+ */
+#define	MC_CMD_STAT_ID_LL_INI_REQ_RXEV_BYTES 0x20
+/* enum: ETH_RX bytes dropped because packet was truncated by LL. */
+#define	MC_CMD_STAT_ID_LL_ETH_RX_TRUNC_DROPPED_BYTES 0x21
+/* enum: CTPIO TX Drain Packet Count, internal drain drop count per port, TX
+ * packet is dropped.
+ */
+#define	MC_CMD_STAT_ID_LL_CTPIO_WIN_DRAIN_PKTS 0x22
+/* enum: CTPIO TX Drain Packet Byte Count, internal drain byte drop count per
+ * port, TX packet is dropped.
+ */
+#define	MC_CMD_STAT_ID_LL_CTPIO_WIN_DRAIN_BYTES 0x23
+/* enum: cycle count when backpressure high from EV Send block to TX. */
+#define	MC_CMD_STAT_ID_LL_TX_EV_BACKPRESSURE 0x24
+/* enum: cycle count when backpressure high from EV Send block to RX. */
+#define	MC_CMD_STAT_ID_LL_RX_EV_BACKPRESSURE 0x25
+#define	MC_CMD_STAT_ID_LL_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_LL_STAT_ID_WIDTH 16
+/* Fast Classifier stats */
+#define	MC_CMD_STAT_ID_FC_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_FC_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: Number of detected ECC errors in the fast classifier result memory.
+ * This is a global stat and will only be reported for port 0.
+ */
+#define	MC_CMD_STAT_ID_FC_ECC_ERRORS 0x1
+/* enum: A non-zero number here indicates that an unknown number of additional
+ * single-bit errors have occurred in addition to those reported under
+ * FC_ECC_ERRORS. This is a global stat and will only be reported for port 0.
+ */
+#define	MC_CMD_STAT_ID_FC_ECC_OVERFLOW 0x2
+/* enum: Number of corrected errors in the fast classifier TCAM lookup data,
+ * i.e. filter key/mask. This is a global stat and will only be reported for
+ * port 0.
+ */
+#define	MC_CMD_STAT_ID_FC_TCAM_ERRORS 0x3
+#define	MC_CMD_STAT_ID_FC_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_FC_STAT_ID_WIDTH 16
+/* Vadapter stats for SR-IOV */
+#define	MC_CMD_STAT_ID_VADAPTER_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_VADAPTER_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: Unicast packets received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_UNICAST_PACKETS 0x1
+/* enum: Unicast bytes received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_UNICAST_BYTES 0x2
+/* enum: Multicast packets received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_MULTICAST_PACKETS 0x3
+/* enum: Multicast bytes received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_MULTICAST_BYTES 0x4
+/* enum: Broadcast packets received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_BROADCAST_PACKETS 0x5
+/* enum: Broadcast bytes received for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_BROADCAST_BYTES 0x6
+/* enum: Total number of packets received with bad CRC for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_BAD_PACKETS 0x7
+/* enum: Total number of bytes received with bad CRC for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_BAD_BYTES 0x8
+/* enum: Packets received with overflow for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_RX_OVERFLOW 0x9
+/* enum: Unicast packets transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_UNICAST_PACKETS 0xa
+/* enum: Unicast bytes transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_UNICAST_BYTES 0xb
+/* enum: Multicast packets transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_MULTICAST_PACKETS 0xc
+/* enum: Multicast bytes transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_MULTICAST_BYTES 0xd
+/* enum: Broadcast packets transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_BROADCAST_PACKETS 0xe
+/* enum: Broadcast bytes transmitted for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_BROADCAST_BYTES 0xf
+/* enum: Packets transmitted with bad FCS for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_BAD_PACKETS 0x10
+/* enum: Bytes transmitted with bad FCS for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_BAD_BYTES 0x11
+/* enum: Packets transmitted with overflow for vadapter. */
+#define	MC_CMD_STAT_ID_VADAPTER_TX_OVERFLOW 0x12
+#define	MC_CMD_STAT_ID_VADAPTER_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_VADAPTER_STAT_ID_WIDTH 16
 
 /* MC_CMD_STAT_DESC structuredef: Structure describing the layout and size of
  * the stats DMA buffer descriptor.
@@ -12796,6 +13009,26 @@
 #define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_LEN 2
 #define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_LBN 16
 #define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_PM_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_PM_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_PM_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_PM_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_RXDP_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_RXDP_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_RXDP_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_RXDP_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_LL_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_LL_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_LL_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_LL_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_FC_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_FC_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_FC_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_FC_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_VADAPTER_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_VADAPTER_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_VADAPTER_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_VADAPTER_STAT_ID_WIDTH 16
 /* Index of the statistic in the DMA buffer. */
 #define	MC_CMD_STAT_DESC_STAT_INDEX_OFST 4
 #define	MC_CMD_STAT_DESC_STAT_INDEX_LEN 2
@@ -13247,7 +13480,11 @@
 
 /* MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT msgresponse */
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_LEN 36
-/* Supported capabilities of the port in its current configuration. */
+/* Supported capabilities of the port in its current configuration. NOTE: The
+ * FEC_REQ field is to be ignored for FIXED_PORT_PROPERTIES, as it is a
+ * property that depends on the link configuration. The FEC_MASK field should
+ * be used to query for the fixed FEC modes supported by a port.
+ */
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_OFST 0
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_LEN 25
 /* See structuredef: MC_CMD_ETH_AN_FIELDS */
@@ -13288,7 +13525,11 @@
 
 /* MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2 msgresponse */
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN 48
-/* Supported capabilities of the port in its current configuration. */
+/* Supported capabilities of the port in its current configuration. NOTE: The
+ * FEC_REQ field is to be ignored for FIXED_PORT_PROPERTIES, as it is a
+ * property that depends on the link configuration. The FEC_MASK field should
+ * be used to query for the fixed FEC modes supported by a port.
+ */
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_ABILITIES_OFST 0
 #define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_ABILITIES_LEN 25
 /* Number of lanes supported by the port in its current configuration. */
@@ -14253,6 +14494,64 @@
 #define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_LEN_OFST 16
 #define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_LEN_LEN 4
 
+/* MC_CMD_GET_NETPORT_STATISTICS_V2_IN msgrequest */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_LEN 24
+/* Handle of port to get MAC statistics for. */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PORT_HANDLE_LEN 4
+/* Contains options for querying the MAC statistics. */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_CMD_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_CMD_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_LBN 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_CLEAR_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_CLEAR_LBN 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_CLEAR_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_CHANGE_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_CHANGE_LBN 2
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_CHANGE_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_ENABLE_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_ENABLE_LBN 3
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_ENABLE_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_NOEVENT_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_NOEVENT_LBN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIODIC_NOEVENT_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIOD_MS_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIOD_MS_LBN 15
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PERIOD_MS_WIDTH 17
+/* Specifies the physical address of the DMA buffer to use for statistics
+ * transfer. This field must contain a valid address under either of these
+ * conditions: 1. DMA flag is set (immediate DMA requested) 2. Both
+ * PERIODIC_CHANGE and PERIODIC_ENABLE are set (periodic DMA configured)
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_OFST 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_LEN 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_LO_OFST 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_LO_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_LO_LBN 64
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_LO_WIDTH 32
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_HI_OFST 12
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_HI_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_HI_LBN 96
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_ADDR_HI_WIDTH 32
+/* Specifies the length of the DMA buffer in bytes for statistics transfer. The
+ * buffer size must be at least DMA_BUFFER_SIZE bytes (as returned by
+ * MC_CMD_MAC_STATISTICS_DESCRIPTOR). Providing an insufficient buffer size
+ * will result in an EINVAL error. This field must contain a valid length under
+ * either of these conditions: 1. DMA flag is set (immediate DMA requested) 2.
+ * Both PERIODIC_CHANGE and PERIODIC_ENABLE are set (periodic DMA configured)
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_LEN_OFST 16
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_DMA_LEN_LEN 4
+/* Port ID mapping to an EVB port, used for reporting vadapter stats. If this
+ * value is not provided or invalid, and vadapter stats are supported by the
+ * NIC then the vadapter values will be reported as 0s to maintain a consistent
+ * statistics descriptor layout.
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PORT_ID_OFST 20
+#define	MC_CMD_GET_NETPORT_STATISTICS_V2_IN_PORT_ID_LEN 4
+
 /* MC_CMD_GET_NETPORT_STATISTICS_OUT msgresponse */
 #define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN 0
 #define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMAX 248
-- 
2.47.3

