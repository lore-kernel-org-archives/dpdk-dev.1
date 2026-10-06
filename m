Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C651CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B10BA427B9;
	Tue,  6 Oct 2026 17:10:27 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D94F0410FA
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:10:23 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 977AA1A0015;
 Tue,  6 Oct 2026 17:10:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF73F1A01BB;
 Tue,  6 Oct 2026 17:10:22 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B09B01800226;
 Tue,  6 Oct 2026 23:10:21 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v6-S2 10/13] net/dpaa2: restructure dpaa2 parser processing
Date: Tue,  6 Oct 2026 20:40:06 +0530
Message-ID: <20261006151009.3593348-11-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
References: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
 <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Move parse-result decoding into dpaa2_parser_decode.h, shared between
the flow code and the Rx path.

IPV4/6_EXT, SCTP and ICMP ptypes are removed from the rx_parse_new
fast-path switch and now go through dpaa2_dev_rx_parse_frc().

Also included in this commit are
- Restore Rx timestamp: write annotation->word2 into the dynfield in
  dpaa2_dev_rx_parse_new() when dpaa2_enable_ts[] is set.
- Drop RTE_MBUF_F_RX_FDIR from dpaa2_dev_rx_mbuf_sched_set(): hash.sched
  overlaps hash.fdir; only hash.sched is written via rte_mbuf_sched_set().
- Parser dump wired up -- set DPAA2_RX_PRINT_PSR_RESULT_FLAG in priv->flags
  from the DPAA2_PRINT_RX_PARSER_RESULT env var so the dump helper fires.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c        |    2 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  176 ++-
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1551 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
 drivers/net/dpaa2/dpaa2_rxtx.c          |  323 +++--
 6 files changed, 1938 insertions(+), 555 deletions(-)
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 70f271ec45..8b43b2e1eb 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3594,7 +3594,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (getenv("DPAA2_PRINT_RX_PARSER_RESULT"))
-		dpaa2_print_parser_result = 1;
+		priv->flags |= DPAA2_RX_PRINT_PSR_RESULT_FLAG;
 
 	/* Allocate memory for hardware structure for queues */
 	ret = dpaa2_alloc_rx_tx_queues(eth_dev);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 76a04c5858..01e5bcbe78 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -21,6 +21,8 @@
 #include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
+#include "dpaa2_parser_decode.h"
+
 
 #define DPAA2_MIN_RX_BUF_SIZE 512
 #define DPAA2_MAX_RX_PKT_LEN  10240 /*WRIOP support*/
@@ -101,6 +103,7 @@
 #define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
 
 #define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+#define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
 
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
@@ -124,31 +127,62 @@
 	RTE_ETH_RSS_PPPOE)
 
 /* LX2 FRC Parsed values (Little Endian) */
-#define DPAA2_PKT_TYPE_ETHER		0x0060
-#define DPAA2_PKT_TYPE_IPV4		0x0000
-#define DPAA2_PKT_TYPE_IPV6		0x0020
+#define DPAA2_PKT_TYPE_ETHER \
+	(DPAA2_PSR_SUMMARY_NONIP << DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE)
+#define DPAA2_PKT_TYPE_IPV4 \
+	(DPAA2_PSR_SUMMARY_IPV4 << DPAA2_PSR_SUMMARY_L4_BIT_SIZE)
+#define DPAA2_PKT_TYPE_IPV6 \
+	(DPAA2_PSR_SUMMARY_IPV6 << DPAA2_PSR_SUMMARY_L4_BIT_SIZE)
+
+/**Tunnel*/
+#define DPAA2_PKT_TYPE_L3_EXT \
+	(DPAA2_PSR_SUMMARY_L4_EXT << DPAA2_PSR_SUMMARY_L4_EXT_L3_POS)
+#define DPAA2_PKT_TYPE_L3_EXT_IPV4 \
+	(DPAA2_PSR_SUMMARY_IPV4 << DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE)
+#define DPAA2_PKT_TYPE_L3_EXT_IPV6 \
+	(DPAA2_PSR_SUMMARY_IPV6 << DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE)
 #define DPAA2_PKT_TYPE_IPV4_EXT \
-			(0x0001 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PKT_TYPE_L3_EXT | DPAA2_PKT_TYPE_L3_EXT_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_EXT \
-			(0x0001 | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PKT_TYPE_L3_EXT | DPAA2_PKT_TYPE_L3_EXT_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV4 \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV4_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV6 \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV6_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV4 \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV4_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV6 \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV6_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+
 #define DPAA2_PKT_TYPE_IPV4_TCP \
-			(0x000e | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_TCP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_TCP \
-			(0x000e | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_TCP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_UDP \
-			(0x0010 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_UDP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_UDP \
-			(0x0010 | DPAA2_PKT_TYPE_IPV6)
-#define DPAA2_PKT_TYPE_IPV4_SCTP	\
-			(0x000f | DPAA2_PKT_TYPE_IPV4)
-#define DPAA2_PKT_TYPE_IPV6_SCTP	\
-			(0x000f | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_UDP | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_SCTP \
+	(DPAA2_PSR_SUMMARY_SCTP | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_SCTP \
+	(DPAA2_PSR_SUMMARY_SCTP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV4_EXT)
+	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV6_EXT)
-#define DPAA2_PKT_TYPE_VLAN_1		0x0160
-#define DPAA2_PKT_TYPE_VLAN_2		0x0260
+	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV6)
+
+#define DPAA2_PKT_TYPE_VLAN_1	0x0100
+#define DPAA2_PKT_TYPE_VLAN_2	0x0200
+#define DPAA2_PKT_TYPE_VLAN \
+	(DPAA2_PKT_TYPE_VLAN_1 | DPAA2_PKT_TYPE_VLAN_2)
 
 /* mac counters */
 #define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
@@ -173,18 +207,40 @@ struct sw_buf_free {
 	struct rte_mbuf *seg;
 };
 
-/* enable timestamp in mbuf*/
-extern bool dpaa2_enable_ts[];
-extern uint64_t dpaa2_timestamp_rx_dynflag;
-extern int dpaa2_timestamp_dynfield_offset;
-
 /* Externally defined */
 extern const struct rte_flow_ops dpaa2_flow_ops;
 
 extern const struct rte_tm_ops dpaa2_tm_ops;
 
+extern bool dpaa2_enable_ts[];
+extern uint64_t dpaa2_timestamp_rx_dynflag;
+extern int dpaa2_timestamp_dynfield_offset;
+
 extern bool dpaa2_print_parser_result;
 
+struct dpaa2_dyn_rx_protocol_pos {
+	uint8_t l3_offset;
+	uint8_t l4_offset;
+	uint8_t l5_offset;
+	uint8_t rsv;
+};
+
+#define L3_OFFSET_OF_MBUF_DYN 0
+#define L4_OFFSET_OF_MBUF_DYN 1
+#define L5_OFFSET_OF_MBUF_DYN 2
+
+#define DPAA2_FS_FLC_FS_MARK_OFFSET \
+	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_OFFSET \
+	(DPAA2_FS_FLC_FS_MARK_OFFSET + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_BIT_SIZE (sizeof(uint8_t) * 8)
+#define DPAA2_FS_FLC_TC_MASK ((1 << DPAA2_FS_FLC_TC_BIT_SIZE) - 1)
+
+#define DPAA2_FS_FLC_FLOW_OFFSET \
+	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
+
 #define DPAA2_FAPR_SIZE \
 	(sizeof(struct dpaa2_annot_hdr) - \
 	offsetof(struct dpaa2_annot_hdr, word3))
@@ -258,42 +314,6 @@ enum dpaa2_ecpri_fafe_type {
 #define DPAA2_PR_L5_OFF_OFFSET 31
 #define DPAA2_PR_NXTHDR_OFF_OFFSET 34
 
-/* Set by SP for vxlan distribution start*/
-#define DPAA2_VXLAN_IN_TCI_OFFSET 16
-
-#define DPAA2_VXLAN_IN_DADDR0_OFFSET 20
-#define DPAA2_VXLAN_IN_DADDR1_OFFSET 22
-#define DPAA2_VXLAN_IN_DADDR2_OFFSET 24
-#define DPAA2_VXLAN_IN_DADDR3_OFFSET 25
-#define DPAA2_VXLAN_IN_DADDR4_OFFSET 26
-#define DPAA2_VXLAN_IN_DADDR5_OFFSET 28
-
-#define DPAA2_VXLAN_IN_SADDR0_OFFSET 29
-#define DPAA2_VXLAN_IN_SADDR1_OFFSET 32
-#define DPAA2_VXLAN_IN_SADDR2_OFFSET 33
-#define DPAA2_VXLAN_IN_SADDR3_OFFSET 35
-#define DPAA2_VXLAN_IN_SADDR4_OFFSET 41
-#define DPAA2_VXLAN_IN_SADDR5_OFFSET 42
-
-#define DPAA2_VXLAN_VNI_OFFSET 43
-#define DPAA2_VXLAN_IN_TYPE_OFFSET 46
-/* Set by SP for vxlan distribution end*/
-
-/* ECPRI shares SP context with VXLAN*/
-#define DPAA2_ECPRI_MSG_OFFSET DPAA2_VXLAN_VNI_OFFSET
-
-#define DPAA2_FS_FLC_FS_MARK_OFFSET \
-	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
-
-#define DPAA2_FS_FLC_TC_OFFSET \
-	(DPAA2_FS_FLC_FS_MARK_OFFSET + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
-
-#define DPAA2_FS_FLC_TC_BIT_SIZE (sizeof(uint8_t) * 8)
-#define DPAA2_FS_FLC_TC_MASK ((1 << DPAA2_FS_FLC_TC_BIT_SIZE) - 1)
-
-#define DPAA2_FS_FLC_FLOW_OFFSET \
-	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
-
 #define DPAA2_ECPRI_MAX_EXTRACT_NB 8
 
 struct ipv4_sd_addr_extract_rule {
@@ -435,6 +455,7 @@ struct dpaa2_dev_priv {
 	void *tx_conf_vq[MAX_TX_QUEUES * DPAA2_MAX_CHANNELS];
 	void *rx_err_vq;
 	uint32_t flags; /*dpaa2 config flags */
+	int psr_dynfield_offset;
 	uint8_t max_mac_filters;
 	uint8_t max_vlan_filters;
 	uint8_t num_rx_tc;
@@ -474,6 +495,9 @@ struct dpaa2_dev_priv {
 	uint64_t rx_timestamp;
 	/*stores timestamp of last received tx confirmation packet on dev*/
 	uint64_t tx_timestamp;
+
+	int rx_ts_offset;
+	uint64_t rx_ts_flag;
 	/* stores pointer to next tx_conf queue that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
@@ -482,6 +506,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool sp_protocol;
 	uint8_t channel_inuse;
 	/* Rx-interrupt mode latched at the first dev_configure */
 	uint8_t intr_mode;
@@ -513,6 +538,41 @@ static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
 	return priv->dpni_ver_major - ver_major;
 }
 
+static inline void
+dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
+	const struct qbman_fd *fd, const struct rte_mbuf *m)
+{
+	size_t fd_addr;
+	void *hw_annot_addr;
+
+	if (likely(!(priv->flags & DPAA2_RX_PRINT_PSR_RESULT_FLAG)))
+		return;
+
+	if (dpaa2_svr_family == SVR_LX2160A)
+		dpaa2_print_fd_frc(fd);
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	hw_annot_addr = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+	dpaa2_print_parse_result(hw_annot_addr, priv->sp_protocol);
+	if (m->ol_flags & RTE_MBUF_F_RX_FDIR) {
+		const struct rte_mbuf_sched *sched;
+		uint16_t i;
+		struct dpaa2_queue *rxq;
+
+		sched = &m->hash.sched;
+		for (i = 0; i < MAX_RX_QUEUES; i++) {
+			rxq = priv->rx_vq[i];
+			if (rxq->tc_index == sched->traffic_class &&
+				rxq->flow_id == sched->queue_id)
+				break;
+		}
+		DPAA2_PMD_DEBUG("Directed to TC%d-flow%d(rxq%d), color(%d)",
+			sched->traffic_class, sched->queue_id, i, sched->color);
+	} else if (m->ol_flags & RTE_MBUF_F_RX_RSS_HASH) {
+		DPAA2_PMD_DEBUG("Balanced with hash(0x%08x)", m->hash.rss);
+	}
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
diff --git a/drivers/net/dpaa2/dpaa2_parse_dump.h b/drivers/net/dpaa2/dpaa2_parse_dump.h
deleted file mode 100644
index bcab3bf0cb..0000000000
--- a/drivers/net/dpaa2/dpaa2_parse_dump.h
+++ /dev/null
@@ -1,374 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- *
- *   Copyright 2022 NXP
- *
- */
-
-#ifndef _DPAA2_PARSE_DUMP_H
-#define _DPAA2_PARSE_DUMP_H
-
-#include <rte_event_eth_rx_adapter.h>
-#include <rte_pmd_dpaa2.h>
-
-#include <dpaa2_hw_pvt.h>
-#include "dpaa2_tm.h"
-
-#include <mc/fsl_dpni.h>
-#include <mc/fsl_mc_sys.h>
-
-#include "base/dpaa2_hw_dpni_annot.h"
-
-#define DPAA2_PR_PRINT printf
-
-struct dpaa2_faf_bit_info {
-	const char *name;
-	int position;
-};
-
-struct dpaa2_fapr_field_info {
-	const char *name;
-	uint16_t value;
-};
-
-struct dpaa2_fapr_array {
-	union {
-		uint64_t pr_64[DPAA2_FAPR_SIZE / 8];
-		uint8_t pr[DPAA2_FAPR_SIZE];
-	};
-};
-
-#define NEXT_HEADER_NAME "Next Header"
-#define ETH_OFF_NAME "ETH OFFSET"
-#define VLAN_TCI_OFF_NAME "VLAN TCI OFFSET"
-#define LAST_ENTRY_OFF_NAME "LAST ETYPE Offset"
-#define L3_OFF_NAME "L3 Offset"
-#define L4_OFF_NAME "L4 Offset"
-#define L5_OFF_NAME "L5 Offset"
-#define NEXT_HEADER_OFF_NAME "Next Header Offset"
-
-static const
-struct dpaa2_fapr_field_info support_dump_fields[] = {
-	{
-		.name = NEXT_HEADER_NAME,
-	},
-	{
-		.name = ETH_OFF_NAME,
-	},
-	{
-		.name = VLAN_TCI_OFF_NAME,
-	},
-	{
-		.name = LAST_ENTRY_OFF_NAME,
-	},
-	{
-		.name = L3_OFF_NAME,
-	},
-	{
-		.name = L4_OFF_NAME,
-	},
-	{
-		.name = L5_OFF_NAME,
-	},
-	{
-		.name = NEXT_HEADER_OFF_NAME,
-	}
-};
-
-static inline void
-dpaa2_print_ecpri(struct dpaa2_fapr_array *fapr)
-{
-	uint8_t ecpri_type;
-	struct rte_ecpri_combined_msg_hdr ecpri_msg;
-
-	ecpri_type = fapr->pr[DPAA2_FAFE_PSR_OFFSET];
-	if ((ecpri_type >> 1) > 7) {
-		DPAA2_PR_PRINT("Invalid ECPRI type(0x%02x)\r\n",
-			ecpri_type);
-	} else {
-		DPAA2_PR_PRINT("ECPRI type %d present\r\n",
-			ecpri_type >> 1);
-		if (ecpri_type == ECPRI_FAFE_TYPE_0 ||
-			ecpri_type == ECPRI_FAFE_TYPE_1) {
-			/* Type 0 is identical to type1*/
-			ecpri_msg.type0.pc_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type0.pc_id =
-				ecpri_msg.type0.pc_id << 8;
-			ecpri_msg.type0.pc_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type0.seq_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type0.seq_id =
-				ecpri_msg.type0.seq_id << 8;
-			ecpri_msg.type0.seq_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("pc_id(0x%04x) seq_id(0x%04x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type0.pc_id),
-				rte_be_to_cpu_16(ecpri_msg.type0.seq_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_2) {
-			ecpri_msg.type2.rtc_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type2.rtc_id =
-				ecpri_msg.type2.rtc_id << 8;
-			ecpri_msg.type2.rtc_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type2.seq_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type2.seq_id =
-				ecpri_msg.type2.seq_id << 8;
-			ecpri_msg.type2.seq_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rtc_id(0x%04x) seq_id(0x%04x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type2.rtc_id),
-				rte_be_to_cpu_16(ecpri_msg.type2.seq_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_3) {
-			DPAA2_PR_PRINT("ECPRI type3 extract not support\r\n");
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_4) {
-			ecpri_msg.type4.rma_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type4.rw =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] >> 4;
-			ecpri_msg.type4.rr =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] & 0xf;
-
-			ecpri_msg.type4.ele_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type4.ele_id =
-				ecpri_msg.type4.ele_id << 8;
-			ecpri_msg.type4.ele_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)",
-				ecpri_msg.type4.rma_id, ecpri_msg.type4.rw);
-			DPAA2_PR_PRINT(" rr(0x%02x) ele_id(0x%04x)\r\n",
-				ecpri_msg.type4.rr,
-				rte_be_to_cpu_16(ecpri_msg.type4.ele_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_5) {
-			ecpri_msg.type5.msr_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type5.act_type =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-
-			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)\r\n",
-				ecpri_msg.type5.msr_id,
-				ecpri_msg.type5.act_type);
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_6) {
-			ecpri_msg.type6.rst_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type6.rst_id =
-				ecpri_msg.type6.rst_id << 8;
-			ecpri_msg.type6.rst_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type6.rst_op =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rst_id(0x%04x) rst_op(0x%02x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type6.rst_id),
-				ecpri_msg.type6.rst_op);
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_7) {
-			ecpri_msg.type7.evt_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type7.evt_type =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type7.seq =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-			ecpri_msg.type7.number =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-
-			DPAA2_PR_PRINT("evt_id(0x%02x) evt_type(0x%02x)",
-				ecpri_msg.type7.evt_id,
-				ecpri_msg.type7.evt_type);
-			DPAA2_PR_PRINT(" seq(0x%02x) number(0x%02x)\r\n",
-				ecpri_msg.type7.seq,
-				ecpri_msg.type7.number);
-		}
-	}
-}
-
-static inline void
-dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
-{
-	const int faf_bit_len = DPAA2_FAF_TOTAL_SIZE * 8;
-	struct dpaa2_faf_bit_info faf_bits[faf_bit_len];
-	int i, byte_pos, bit_pos, vxlan = 0, vxlan_vlan = 0;
-	struct rte_ether_hdr vxlan_in_eth;
-	uint16_t vxlan_vlan_tci;
-	int ecpri = 0;
-
-	for (i = 0; i < faf_bit_len; i++) {
-		faf_bits[i].position = i;
-		if (i == FAFE_VXLAN_IN_VLAN_FRAM)
-			faf_bits[i].name = "VXLAN VLAN Present";
-		else if (i == FAFE_VXLAN_IN_IPV4_FRAM)
-			faf_bits[i].name = "VXLAN IPV4 Present";
-		else if (i == FAFE_VXLAN_IN_IPV6_FRAM)
-			faf_bits[i].name = "VXLAN IPV6 Present";
-		else if (i == FAFE_VXLAN_IN_UDP_FRAM)
-			faf_bits[i].name = "VXLAN UDP Present";
-		else if (i == FAFE_VXLAN_IN_TCP_FRAM)
-			faf_bits[i].name = "VXLAN TCP Present";
-		else if (i == FAF_VXLAN_FRAM)
-			faf_bits[i].name = "VXLAN Present";
-		else if (i == FAF_ETH_FRAM)
-			faf_bits[i].name = "Ethernet MAC Present";
-		else if (i == FAF_VLAN_FRAM)
-			faf_bits[i].name = "VLAN 1 Present";
-		else if (i == FAF_IPV4_FRAM)
-			faf_bits[i].name = "IPv4 1 Present";
-		else if (i == FAF_IPV6_FRAM)
-			faf_bits[i].name = "IPv6 1 Present";
-		else if (i == FAF_IP_FRAG_FRAM)
-			faf_bits[i].name = "IP fragment Present";
-		else if (i == FAF_UDP_FRAM)
-			faf_bits[i].name = "UDP Present";
-		else if (i == FAF_TCP_FRAM)
-			faf_bits[i].name = "TCP Present";
-		else if (i == FAFE_ECPRI_FRAM)
-			faf_bits[i].name = "ECPRI Present";
-		else
-			faf_bits[i].name = "Check RM for this unusual frame";
-	}
-
-	DPAA2_PR_PRINT("Frame Annotation Flags:\r\n");
-	for (i = 0; i < faf_bit_len; i++) {
-		byte_pos = i / 8 + DPAA2_FAFE_PSR_OFFSET;
-		bit_pos = i % 8;
-		if (fapr->pr[byte_pos] & (1 << (7 - bit_pos))) {
-			DPAA2_PR_PRINT("FAF bit %d : %s\r\n",
-				faf_bits[i].position, faf_bits[i].name);
-			if (i == FAF_VXLAN_FRAM)
-				vxlan = 1;
-			else if (i == FAFE_ECPRI_FRAM)
-				ecpri = 1;
-		}
-	}
-
-	if (vxlan) {
-		vxlan_in_eth.dst_addr.addr_bytes[0] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR0_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[1] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR1_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[2] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR2_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[3] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR3_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[4] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR4_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[5] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR5_OFFSET];
-
-		vxlan_in_eth.src_addr.addr_bytes[0] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR0_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[1] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR1_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[2] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR2_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[3] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR3_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[4] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR4_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[5] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR5_OFFSET];
-
-		vxlan_in_eth.ether_type =
-			fapr->pr[DPAA2_VXLAN_IN_TYPE_OFFSET];
-		vxlan_in_eth.ether_type =
-			vxlan_in_eth.ether_type << 8;
-		vxlan_in_eth.ether_type |=
-			fapr->pr[DPAA2_VXLAN_IN_TYPE_OFFSET + 1];
-
-		if (vxlan_in_eth.ether_type == RTE_ETHER_TYPE_VLAN)
-			vxlan_vlan = 1;
-		DPAA2_PR_PRINT("VXLAN inner eth:\r\n");
-		DPAA2_PR_PRINT("dst addr: ");
-		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
-			if (i != 0)
-				DPAA2_PR_PRINT(":");
-			DPAA2_PR_PRINT("%02x",
-				vxlan_in_eth.dst_addr.addr_bytes[i]);
-		}
-		DPAA2_PR_PRINT("\r\n");
-		DPAA2_PR_PRINT("src addr: ");
-		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
-			if (i != 0)
-				DPAA2_PR_PRINT(":");
-			DPAA2_PR_PRINT("%02x",
-				vxlan_in_eth.src_addr.addr_bytes[i]);
-		}
-		DPAA2_PR_PRINT("\r\n");
-		DPAA2_PR_PRINT("type: 0x%04x\r\n",
-			vxlan_in_eth.ether_type);
-		if (vxlan_vlan) {
-			vxlan_vlan_tci = fapr->pr[DPAA2_VXLAN_IN_TCI_OFFSET];
-			vxlan_vlan_tci = vxlan_vlan_tci << 8;
-			vxlan_vlan_tci |=
-				fapr->pr[DPAA2_VXLAN_IN_TCI_OFFSET + 1];
-
-			DPAA2_PR_PRINT("vlan tci: 0x%04x\r\n",
-				vxlan_vlan_tci);
-		}
-	}
-
-	if (ecpri)
-		dpaa2_print_ecpri(fapr);
-}
-
-static inline void
-dpaa2_print_parse_result(struct dpaa2_annot_hdr *annotation)
-{
-	struct dpaa2_fapr_array fapr;
-	struct dpaa2_fapr_field_info
-		fapr_fields[sizeof(support_dump_fields) /
-		sizeof(struct dpaa2_fapr_field_info)];
-	uint64_t len, i;
-
-	memcpy(&fapr, &annotation->word3, DPAA2_FAPR_SIZE);
-	for (i = 0; i < (DPAA2_FAPR_SIZE / 8); i++)
-		fapr.pr_64[i] = rte_cpu_to_be_64(fapr.pr_64[i]);
-
-	memcpy(fapr_fields, support_dump_fields,
-		sizeof(support_dump_fields));
-
-	for (i = 0;
-		i < sizeof(fapr_fields) /
-		sizeof(struct dpaa2_fapr_field_info);
-		i++) {
-		if (!strcmp(fapr_fields[i].name, NEXT_HEADER_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_NXTHDR_OFFSET];
-			fapr_fields[i].value = fapr_fields[i].value << 8;
-			fapr_fields[i].value |=
-				fapr.pr[DPAA2_PR_NXTHDR_OFFSET + 1];
-		} else if (!strcmp(fapr_fields[i].name, ETH_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_ETH_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, VLAN_TCI_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_TCI_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, LAST_ENTRY_OFF_NAME)) {
-			fapr_fields[i].value =
-				fapr.pr[DPAA2_PR_LAST_ETYPE_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L3_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L3_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L4_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L4_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L5_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L5_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, NEXT_HEADER_OFF_NAME)) {
-			fapr_fields[i].value =
-				fapr.pr[DPAA2_PR_NXTHDR_OFF_OFFSET];
-		}
-	}
-
-	len = sizeof(fapr_fields) / sizeof(struct dpaa2_fapr_field_info);
-	DPAA2_PR_PRINT("Parse Result:\r\n");
-	for (i = 0; i < len; i++) {
-		DPAA2_PR_PRINT("%21s : 0x%02x\r\n",
-			fapr_fields[i].name, fapr_fields[i].value);
-	}
-	dpaa2_print_faf(&fapr);
-}
-
-#endif
diff --git a/drivers/net/dpaa2/dpaa2_parser_decode.h b/drivers/net/dpaa2/dpaa2_parser_decode.h
new file mode 100644
index 0000000000..c57f08ae8c
--- /dev/null
+++ b/drivers/net/dpaa2/dpaa2_parser_decode.h
@@ -0,0 +1,1551 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ *   Copyright 2022-2026 NXP
+ *
+ */
+
+#ifndef _DPAA2_PARSE_DECODE_H
+#define _DPAA2_PARSE_DECODE_H
+
+#include <rte_flow.h>
+#include <rte_event_eth_rx_adapter.h>
+#include <rte_pmd_dpaa2.h>
+
+#include <bus_fslmc_driver.h>
+#include <dpaa2_hw_pvt.h>
+#include "dpaa2_tm.h"
+
+#include <mc/fsl_dpni.h>
+#include <mc/fsl_mc_sys.h>
+
+#include "base/dpaa2_hw_dpni_annot.h"
+#include "dpaa2_pmd_logs.h"
+
+#define DPAA2_PR_PRINT dpaa2_dump_print
+
+#define BIT_SIZE(t) (sizeof(t) * 8)
+#define BIT_OFFSET(t, m) (offsetof(t, m) * 8)
+#define BIT_LAST_OFFSET(t) (BIT_SIZE(t) - 1)
+
+#define ROCEV2_DEST_QP_SIZE	3
+
+enum dpaa2_parser_protocol_id {
+	DPAA2_PARSER_MAC_ID,
+	DPAA2_PARSER_VLAN_ID,
+	DPAA2_PARSER_ICMP_ID,
+	DPAA2_PARSER_IP_ID,
+	DPAA2_PARSER_IPV4_ID,
+	DPAA2_PARSER_IPV6_ID,
+	DPAA2_PARSER_IP_FRAG_ID,
+	DPAA2_PARSER_GRE_ID,
+	DPAA2_PARSER_UDP_ID,
+	DPAA2_PARSER_TCP_ID,
+	DPAA2_PARSER_SCTP_ID,
+	DPAA2_PARSER_GTP_ID,
+	DPAA2_PARSER_IPSEC_AH_ID,
+	DPAA2_PARSER_IPSEC_ESP_ID,
+	DPAA2_PARSER_VXLAN_ID,
+	DPAA2_PARSER_TUNNEL_VLAN_ID,
+	DPAA2_PARSER_TUNNEL_IPV4_ID,
+	DPAA2_PARSER_TUNNEL_IPV6_ID,
+	DPAA2_PARSER_TUNNEL_UDP_ID,
+	DPAA2_PARSER_TUNNEL_TCP_ID,
+	DPAA2_PARSER_ECPRI_ID,
+	DPAA2_PARSER_ROCEV2_ID,
+	DPAA2_PARSER_GENEVE_ID
+};
+
+#define DPAA2_PSR_SUMMARY_NONIP 6
+#define DPAA2_PSR_SUMMARY_ARP 3
+#define DPAA2_PSR_SUMMARY_NONIP_PTP 4
+#define DPAA2_PSR_SUMMARY_MPLS 6
+
+#define DPAA2_PSR_SUMMARY_L4_EXT 2
+#define DPAA2_PSR_SUMMARY_IPV4 0
+#define DPAA2_PSR_SUMMARY_IPV6 1
+
+#define DPAA2_PSR_SUMMARY_GRE_IPV4 0
+#define DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP 1
+#define DPAA2_PSR_SUMMARY_GRE_IPV6 2
+#define DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP 3
+
+#define DPAA2_PSR_SUMMARY_IP_FRAG 1
+#define DPAA2_PSR_SUMMARY_ICMP 3
+#define DPAA2_PSR_SUMMARY_IPSEC_ESP 5
+#define DPAA2_PSR_SUMMARY_TCP 14
+#define DPAA2_PSR_SUMMARY_SCTP 15
+#define DPAA2_PSR_SUMMARY_UDP 16
+#define DPAA2_PSR_SUMMARY_PTP 18
+#define DPAA2_PSR_SUMMARY_UDP_ESP_IKE 19
+#define DPAA2_PSR_SUMMARY_GTPU 20
+#define DPAA2_PSR_SUMMARY_GTPC 21
+#define DPAA2_PSR_SUMMARY_VXLAN 27
+
+#define DPAA2_PSR_SUMMARY_L4_BIT_SIZE 5
+#define DPAA2_PSR_SUMMARY_L3_BIT_SIZE 2
+
+#define DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE 4
+#define DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE 1
+#define DPAA2_PSR_SUMMARY_L4_EXT_L3_BIT_SIZE 2
+#define DPAA2_PSR_SUMMARY_L4_EXT_L3_POS \
+	(DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE + \
+	DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE)
+
+#define DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE 4
+#define DPAA2_PSR_SUMMARY_NON_IP_NON_IP_BIT_SIZE 3
+
+union __rte_packed_begin dpaa2_psr_summary_l {
+	struct {
+		uint8_t l4:DPAA2_PSR_SUMMARY_L4_BIT_SIZE;
+		uint8_t l3:DPAA2_PSR_SUMMARY_L3_BIT_SIZE;
+		uint8_t fafe3:1;
+	} l4;
+	struct {
+		uint8_t l4_ext:DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE;
+		uint8_t ip:DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE;
+		uint8_t l3:DPAA2_PSR_SUMMARY_L4_EXT_L3_BIT_SIZE;
+		uint8_t fafe3:1;
+	} l4_ext;
+	struct {
+		uint8_t l2:DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE;
+		uint8_t non_ip:DPAA2_PSR_SUMMARY_NON_IP_NON_IP_BIT_SIZE;
+		uint8_t fafe3:1;
+	} non_ip;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_psr_summary {
+	union dpaa2_psr_summary_l sum_l;
+	uint8_t vlan:2;
+	uint8_t l2_l2_ext:2;
+	uint8_t fafe2:1;
+	uint8_t fafe1:1;
+	uint8_t fafe0:1;
+	uint8_t checksum_err:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_psr_sum_16b {
+	uint16_t sum_16b;
+	struct dpaa2_psr_summary sum;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_ingress_frc {
+	uint32_t rsv0:10;
+
+	uint32_t faicfdv:1;
+	uint32_t faswov:1;
+	uint32_t faiadv:1;
+	uint32_t faprv:1;
+	uint32_t faeadv:1;
+	uint32_t fasv:1;
+	union dpaa2_psr_sum_16b psr_sum;
+} __rte_packed_end;
+
+/* Frame annotation status */
+struct __rte_packed_begin dpaa2_fas_parse {
+	uint32_t status:8;
+	uint32_t ppid:6;
+	uint32_t rsv4:2;
+	uint32_t ifpid:12;
+	uint32_t rsv3:4;
+	uint32_t l4ce:1;
+	uint32_t l4cv:1;
+	uint32_t l3ce:1;
+	uint32_t l3cv:1;
+	uint32_t ble:1;
+	uint32_t phe:1;
+	uint32_t isp:1;
+	uint32_t pte:1;
+	uint32_t rsv2:4;
+	uint32_t fpe:1;
+	uint32_t fle:1;
+	uint32_t piee:1;
+	uint32_t tide:1;
+	uint32_t mnle:1;
+	uint32_t eofhe:1;
+	uint32_t kse:1;
+	uint32_t rsv1:6;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t ptp:1;
+	uint32_t rsv0:2;
+	uint32_t macsec:1;
+	uint32_t discard:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_fas_parse_32b {
+	uint32_t fas_32b;
+	struct dpaa2_fas_parse fas;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_fafe_ecpri {
+	uint8_t msg_type:5;
+	uint8_t non_used:2;
+	uint8_t ecpri:1; /**Always 1, FRC FAFE0*/
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_fafe_rocev2_tunnel {
+	uint8_t in_vlan:1;
+	uint8_t in_udp:1;
+	uint8_t in_tcp:1;
+	uint8_t in_ipv6:1;
+	uint8_t in_ipv4:1; /**FRC FAFE3*/
+	uint8_t geneve:1; /**FRC FAFE2*/
+	uint8_t rocev2:1; /**FRC FAFE1*/
+	uint8_t non_used:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_sp_fafe_parse {
+	struct dpaa2_sp_fafe_ecpri ecpri;
+	struct dpaa2_sp_fafe_rocev2_tunnel rocev2_tunnel;
+	uint8_t fafe_8b;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_l_parse {
+	uint32_t arp_err:1;
+	uint32_t arp:1;
+	uint32_t mpls_err:1;
+	uint32_t mpls_n:1;
+	uint32_t mpls_1:1;
+	uint32_t pppoe_ppp_err:1;
+	uint32_t pppoe_ppp:1;
+	uint32_t vlan_err:1;
+
+	uint32_t gre_eth:1;
+	uint32_t vlan_n:1;
+	uint32_t vlan_1:1;
+	uint32_t llc_snap_err:1;
+	uint32_t unknown_llc_oui:1;
+	uint32_t llc_snap:1;
+	uint32_t eth_err:1;
+	uint32_t fip:1;
+
+	uint32_t fcoe:1;
+	uint32_t bpdu:1;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t unicast:1;
+	uint32_t mac:1;
+	uint32_t psr_err:1;
+	uint32_t spsr_err:1;
+
+	uint32_t ike:1;
+	uint32_t eth_slow:1;
+	uint32_t vxlan_err:1;
+	uint32_t vxlan:1;
+	uint32_t ptp:1;
+	uint32_t vlan_prio:1;
+	uint32_t gtp_prim:1;
+	uint32_t i6_r_hdr2:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_l_parse_be {
+	uint32_t ike:1;
+	uint32_t eth_slow:1;
+	uint32_t vxlan_err:1;
+	uint32_t vxlan:1;
+	uint32_t ptp:1;
+	uint32_t vlan_prio:1;
+	uint32_t gtp_prim:1;
+	uint32_t i6_r_hdr2:1;
+
+	uint32_t fcoe:1;
+	uint32_t bpdu:1;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t unicast:1;
+	uint32_t mac:1;
+	uint32_t psr_err:1;
+	uint32_t spsr_err:1;
+
+	uint32_t gre_eth:1;
+	uint32_t vlan_n:1;
+	uint32_t vlan_1:1;
+	uint32_t llc_snap_err:1;
+	uint32_t unknown_llc_oui:1;
+	uint32_t llc_snap:1;
+	uint32_t eth_err:1;
+	uint32_t fip:1;
+
+	uint32_t arp_err:1;
+	uint32_t arp:1;
+	uint32_t mpls_err:1;
+	uint32_t mpls_n:1;
+	uint32_t mpls_1:1;
+	uint32_t pppoe_ppp_err:1;
+	uint32_t pppoe_ppp:1;
+	uint32_t vlan_err:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_h_parse {
+	uint32_t i6_r_hdr1:1;
+	uint32_t l5_spsr:1;
+	uint32_t capwap_data:1;
+	uint32_t capwap_ctl:1;
+	uint32_t iscsi:1;
+	uint32_t esp_err:1;
+	uint32_t esp:1;
+	uint32_t gtp_err:1;
+
+	uint32_t gtp:1;
+	uint32_t l4_spsr_err:1;
+	uint32_t l4_unknown:1;
+	uint32_t dccp_err:1;
+	uint32_t dccp:1;
+	uint32_t sctp_err:1;
+	uint32_t sctp:1;
+	uint32_t ipsec_err:1;
+
+	uint32_t ipsec_ah:1;
+	uint32_t ipsec_esp:1;
+	uint32_t ipsec:1;
+	uint32_t tcp_err:1;
+	uint32_t tcp_3_5:1;
+	uint32_t tcp_6_11:1;
+	uint32_t tcp_opt:1;
+	uint32_t tcp:1;
+
+	uint32_t udp_err:1;
+	uint32_t udp:1;
+	uint32_t l3_spsr_err:1;
+	uint32_t l3_unknown:1;
+	uint32_t gre_err:1;
+	uint32_t gre_k:1;
+	uint32_t gre:1;
+	uint32_t min_encp_err:1;
+
+	uint32_t min_encp_s:1;
+	uint32_t min_encp:1;
+	uint32_t ip_n_err:1;
+	uint32_t udp_light:1;
+	uint32_t icmp_v6:1;
+	uint32_t igmp:1;
+	uint32_t icmp:1;
+	uint32_t ip_n_init_frag:1;
+
+	uint32_t ip_n_frag:1;
+	uint32_t ip_n_unknown:1;
+	uint32_t ip_n_opt:1;
+	uint32_t ip_1_err:1;
+	uint32_t ip_1_init_frag:1;
+	uint32_t ip_1_frag:1;
+	uint32_t ip_1_unknown:1;
+	uint32_t ip_1_opt:1;
+
+	uint32_t ipv6_n_multicast:1;
+	uint32_t ipv6_n_unicast:1;
+	uint32_t ipv6_n:1;
+	uint32_t ipv6_1_multicast:1;
+	uint32_t ipv6_1_unicast:1;
+	uint32_t ipv6_1:1;
+	uint32_t ipv4_n_broadcast:1;
+	uint32_t ipv4_n_multicast:1;
+
+	uint32_t ipv4_n_unicast:1;
+	uint32_t ipv4_n:1;
+	uint32_t ipv4_1_broadcast:1;
+	uint32_t ipv4_1_multicast:1;
+	uint32_t ipv4_1_unicast:1;
+	uint32_t ipv4_1:1;
+	uint32_t l2_spsr_err:1;
+	uint32_t l2_unknown:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_h_parse_be {
+	uint32_t ipv4_n_unicast:1;
+	uint32_t ipv4_n:1;
+	uint32_t ipv4_1_broadcast:1;
+	uint32_t ipv4_1_multicast:1;
+	uint32_t ipv4_1_unicast:1;
+	uint32_t ipv4_1:1;
+	uint32_t l2_spsr_err:1;
+	uint32_t l2_unknown:1;
+
+	uint32_t ipv6_n_multicast:1;
+	uint32_t ipv6_n_unicast:1;
+	uint32_t ipv6_n:1;
+	uint32_t ipv6_1_multicast:1;
+	uint32_t ipv6_1_unicast:1;
+	uint32_t ipv6_1:1;
+	uint32_t ipv4_n_broadcast:1;
+	uint32_t ipv4_n_multicast:1;
+
+	uint32_t ip_n_frag:1;
+	uint32_t ip_n_unknown:1;
+	uint32_t ip_n_opt:1;
+	uint32_t ip_1_err:1;
+	uint32_t ip_1_init_frag:1;
+	uint32_t ip_1_frag:1;
+	uint32_t ip_1_unknown:1;
+	uint32_t ip_1_opt:1;
+
+	uint32_t min_encp_s:1;
+	uint32_t min_encp:1;
+	uint32_t ip_n_err:1;
+	uint32_t udp_light:1;
+	uint32_t icmp_v6:1;
+	uint32_t igmp:1;
+	uint32_t icmp:1;
+	uint32_t ip_n_init_frag:1;
+
+	uint32_t udp_err:1;
+	uint32_t udp:1;
+	uint32_t l3_spsr_err:1;
+	uint32_t l3_unknown:1;
+	uint32_t gre_err:1;
+	uint32_t gre_k:1;
+	uint32_t gre:1;
+	uint32_t min_encp_err:1;
+
+	uint32_t ipsec_ah:1;
+	uint32_t ipsec_esp:1;
+	uint32_t ipsec:1;
+	uint32_t tcp_err:1;
+	uint32_t tcp_3_5:1;
+	uint32_t tcp_6_11:1;
+	uint32_t tcp_opt:1;
+	uint32_t tcp:1;
+
+	uint32_t gtp:1;
+	uint32_t l4_spsr_err:1;
+	uint32_t l4_unknown:1;
+	uint32_t dccp_err:1;
+	uint32_t dccp:1;
+	uint32_t sctp_err:1;
+	uint32_t sctp:1;
+	uint32_t ipsec_err:1;
+
+	uint32_t i6_r_hdr1:1;
+	uint32_t l5_spsr:1;
+	uint32_t capwap_data:1;
+	uint32_t capwap_ctl:1;
+	uint32_t iscsi:1;
+	uint32_t esp_err:1;
+	uint32_t esp:1;
+	uint32_t gtp_err:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_annot_word3_parse {
+	struct dpaa2_faf_l_parse faf_l;
+	uint8_t rsv;
+	union dpaa2_sp_fafe_parse fafe;
+	rte_be16_t nxthdr;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_ecpri_msg_rm_access {
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+	uint32_t ele_id:16;		/**< Element ID */
+	uint32_t rr:4;			/**< Req/Resp */
+	uint32_t rw:4;			/**< Read/Write */
+	uint32_t rma_id:8;		/**< Remote Memory Access ID */
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	uint32_t rma_id:8;		/**< Remote Memory Access ID */
+	uint32_t rw:4;			/**< Read/Write */
+	uint32_t rr:4;			/**< Req/Resp */
+	uint32_t ele_id:16;		/**< Element ID */
+#endif
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_sp_ecpri_msg {
+	struct rte_ecpri_msg_iq_data type0;
+	struct rte_ecpri_msg_bit_seq type1;
+	struct rte_ecpri_msg_rtc_ctrl type2;
+	struct rte_ecpri_msg_bit_seq type3;
+	struct dpaa2_ecpri_msg_rm_access type4;
+	struct rte_ecpri_msg_delay_measure type5;
+	struct rte_ecpri_msg_remote_reset type6;
+	struct rte_ecpri_msg_event_ind type7;
+} __rte_packed_end;
+
+#define DPAA2_SP_PSR_CTX_LEN 5
+
+struct __rte_packed_begin dpaa2_sp_rocev2 {
+	uint8_t opcode;
+	uint8_t dest_qp[ROCEV2_DEST_QP_SIZE];
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_geneve {
+	rte_be16_t protocol;
+	uint8_t geneve_vni[3];
+} __rte_packed_end;
+
+struct dpaa2_psr_result_word3 {
+	rte_be16_t nxthdr;
+	union dpaa2_sp_fafe_parse fafe;
+	uint8_t rsv;
+	struct dpaa2_faf_l_parse_be faf_l_be;
+};
+
+struct dpaa2_psr_result_word4 {
+	struct dpaa2_faf_h_parse_be faf_h_be;
+};
+
+struct dpaa2_psr_result_word5 {
+	union {
+		struct {
+			uint8_t shim_off1;
+			uint8_t shim_off2;
+		};
+		rte_be16_t vxlan_vlan_tci;
+	};
+	uint8_t ip_1_pid_off;
+	uint8_t eth_off;
+	union {
+		uint8_t llc_snap_off;
+		uint8_t vxlan_in_daddr0;
+	};
+	uint8_t vlan_tci_1_off;
+	union {
+		uint8_t vlan_tci_n_off;
+		uint8_t vxlan_in_daddr1;
+	};
+	uint8_t last_etype_off;
+};
+
+struct dpaa2_psr_result_word6 {
+	union {
+		uint8_t pppoe_off;
+		uint8_t vxlan_in_daddr2;
+	};
+	union {
+		uint8_t mpls_1_off;
+		uint8_t vxlan_in_daddr3;
+	};
+	union {
+		uint8_t mpls_n_off;
+		uint8_t vxlan_in_daddr4;
+	};
+	uint8_t l3_off;
+	union {
+		uint8_t ip_n_off;
+		uint8_t vxlan_in_daddr5;
+	};
+	union {
+		uint8_t gre_off;
+		uint8_t vxlan_in_saddr0;
+	};
+	uint8_t l4_off;
+	uint8_t l5_off;
+};
+
+struct dpaa2_psr_result_word7 {
+	union {
+		uint8_t route_hdr1_off;
+		uint8_t vxlan_in_saddr1;
+	};
+	union {
+		uint8_t route_hdr2_off;
+		uint8_t vxlan_in_saddr2;
+	};
+	uint8_t nxthdr_off;
+	union {
+		uint8_t ipv6_frag_off;
+		uint8_t vxlan_in_saddr3;
+	};
+	rte_be16_t gross_running_sum;
+	rte_be16_t running_sum;
+};
+
+struct dpaa2_psr_result_word8 {
+	uint8_t psr_err;
+	union {
+		uint8_t nxthdr_frag_off;
+		uint8_t vxlan_in_saddr4;
+	};
+	union {
+		uint8_t ip_n_pid_off;
+		uint8_t vxlan_in_saddr5;
+	};
+	union __rte_packed_begin {
+		uint8_t sp_psr_ctx[DPAA2_SP_PSR_CTX_LEN];
+		struct __rte_packed_begin {
+			uint8_t vxlan_vni[3];
+			rte_be16_t vxlan_eth_type;
+		} __rte_packed_end;
+		union dpaa2_sp_ecpri_msg ecpri_msg;
+		struct dpaa2_sp_rocev2 rocev2;
+		struct dpaa2_sp_geneve geneve;
+	} __rte_packed_end;
+};
+
+struct __rte_packed_begin dpaa2_psr_result_parse {
+	struct dpaa2_psr_result_word3 word3;
+	struct dpaa2_psr_result_word4 word4;
+	struct dpaa2_psr_result_word5 word5;
+	struct dpaa2_psr_result_word6 word6;
+	struct dpaa2_psr_result_word7 word7;
+	struct dpaa2_psr_result_word8 word8;
+} __rte_packed_end;
+
+#define DPAA2_PSR_RESULT_SIZE sizeof(struct dpaa2_psr_result_parse)
+
+#define DPAA2_FAFE_PSR_RESULT_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word3.fafe)
+
+union __rte_packed_begin dpaa2_sp_fafe_parse_8b {
+	uint8_t fafe_8b;
+	union dpaa2_sp_fafe_parse fafe;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_faf_l_parse_32b {
+	uint32_t faf_l_32b;
+	struct dpaa2_faf_l_parse faf_l;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_faf_h_parse_64b {
+	uint64_t faf_h_64b;
+	struct dpaa2_faf_h_parse faf_h;
+} __rte_packed_end;
+
+/* Set by SP for vxlan distribution start*/
+#define DPAA2_VXLAN_IN_TCI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_vlan_tci)
+#define DPAA2_VXLAN_IN_DADDR0_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_in_daddr0)
+#define DPAA2_VXLAN_IN_DADDR1_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_in_daddr1)
+#define DPAA2_VXLAN_IN_DADDR2_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr2)
+#define DPAA2_VXLAN_IN_DADDR3_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr3)
+#define DPAA2_VXLAN_IN_DADDR4_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr4)
+#define DPAA2_VXLAN_IN_DADDR5_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr5)
+
+#define DPAA2_VXLAN_IN_SADDR0_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_saddr0)
+#define DPAA2_VXLAN_IN_SADDR1_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr1)
+#define DPAA2_VXLAN_IN_SADDR2_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr2)
+#define DPAA2_VXLAN_IN_SADDR3_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr3)
+#define DPAA2_VXLAN_IN_SADDR4_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_in_saddr4)
+#define DPAA2_VXLAN_IN_SADDR5_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_in_saddr5)
+
+#define DPAA2_VXLAN_VNI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_vni[0])
+#define DPAA2_VXLAN_IN_TYPE_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_eth_type)
+/* Set by SP for vxlan distribution end*/
+
+#define DPAA2_ECPRI_MSG_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.ecpri_msg)
+
+#define DPAA2_ROCEV2_OPCODE_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.rocev2.opcode)
+
+#define DPAA2_ROCEV2_DST_QP_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.rocev2.dest_qp[0])
+
+#define DPAA2_GENEVE_PROTOCOL_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.geneve.protocol)
+
+#define DPAA2_GENEVE_VNI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.geneve.geneve_vni[0])
+
+static inline uint32_t
+dpaa2_spsr_fafe_bit_offset(union dpaa2_sp_fafe_parse fafe)
+{
+	union dpaa2_sp_fafe_parse_8b fafe_tmp;
+	uint32_t offset = BIT_LAST_OFFSET(union dpaa2_sp_fafe_parse_8b);
+
+	memset(&fafe_tmp, 0, sizeof(union dpaa2_sp_fafe_parse_8b));
+	fafe_tmp.fafe_8b = 1;
+	while (memcmp(&fafe_tmp.fafe, &fafe,
+		sizeof(union dpaa2_sp_fafe_parse))) {
+		fafe_tmp.fafe_8b = fafe_tmp.fafe_8b << 1;
+		offset--;
+	}
+	return offset + BIT_OFFSET(struct dpaa2_psr_result_parse, word3.fafe);
+}
+
+static inline uint32_t
+dpaa2_psr_faf_l_bit_offset(struct dpaa2_faf_l_parse *faf_l)
+{
+	union dpaa2_faf_l_parse_32b faf_l_tmp;
+	uint32_t offset = BIT_LAST_OFFSET(union dpaa2_faf_l_parse_32b);
+
+	memset(&faf_l_tmp, 0, sizeof(union dpaa2_faf_l_parse_32b));
+	faf_l_tmp.faf_l_32b = 1;
+	while (memcmp(&faf_l_tmp.faf_l, faf_l,
+		sizeof(struct dpaa2_faf_l_parse))) {
+		faf_l_tmp.faf_l_32b = faf_l_tmp.faf_l_32b << 1;
+		offset--;
+	}
+	return offset + BIT_OFFSET(struct dpaa2_psr_result_parse,
+		word3.faf_l_be);
+}
+
+static inline uint32_t
+dpaa2_psr_faf_h_bit_offset(struct dpaa2_faf_h_parse *faf_h)
+{
+	union dpaa2_faf_h_parse_64b faf_h_tmp;
+	uint32_t offset = BIT_LAST_OFFSET(union dpaa2_faf_h_parse_64b);
+
+	memset(&faf_h_tmp, 0, sizeof(union dpaa2_faf_h_parse_64b));
+	faf_h_tmp.faf_h_64b = 1;
+	while (memcmp(&faf_h_tmp.faf_h, faf_h,
+		sizeof(struct dpaa2_faf_h_parse))) {
+		faf_h_tmp.faf_h_64b = faf_h_tmp.faf_h_64b << 1;
+		offset--;
+	}
+	return offset + BIT_OFFSET(struct dpaa2_psr_result_parse,
+		word4.faf_h_be);
+}
+
+static inline int
+dpaa2_protocol_psr_bit_offset(uint32_t *bit_offset,
+	enum dpaa2_parser_protocol_id protocol)
+{
+	struct dpaa2_faf_l_parse faf_l;
+	struct dpaa2_faf_h_parse faf_h;
+	union dpaa2_sp_fafe_parse fafe;
+
+	memset(&faf_l, 0, sizeof(faf_l));
+	memset(&faf_h, 0, sizeof(faf_h));
+	memset(&fafe, 0, sizeof(fafe));
+
+	if (protocol == DPAA2_PARSER_MAC_ID) {
+		faf_l.mac = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_VLAN_ID) {
+		faf_l.vlan_1 = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_ICMP_ID) {
+		faf_h.icmp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IP_ID) {
+		faf_h.ip_1_opt = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPV4_ID) {
+		faf_h.ipv4_1 = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IP_FRAG_ID) {
+		faf_h.ip_1_frag = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPV6_ID) {
+		faf_h.ipv6_1 = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_GRE_ID) {
+		faf_h.gre = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_UDP_ID) {
+		faf_h.udp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_TCP_ID) {
+		faf_h.tcp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_SCTP_ID) {
+		faf_h.sctp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_GTP_ID) {
+		faf_h.gtp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPSEC_ESP_ID) {
+		faf_h.ipsec_esp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPSEC_AH_ID) {
+		faf_h.ipsec_ah = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_VXLAN_ID) {
+		faf_l.vxlan = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_VLAN_ID) {
+		fafe.rocev2_tunnel.in_vlan = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_IPV4_ID) {
+		fafe.rocev2_tunnel.in_ipv4 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_IPV6_ID) {
+		fafe.rocev2_tunnel.in_ipv6 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_UDP_ID) {
+		fafe.rocev2_tunnel.in_udp = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_TCP_ID) {
+		fafe.rocev2_tunnel.in_tcp = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_ECPRI_ID) {
+		fafe.ecpri.ecpri = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_ROCEV2_ID) {
+		fafe.rocev2_tunnel.rocev2 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_GENEVE_ID) {
+		fafe.rocev2_tunnel.geneve = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else {
+		DPAA2_PMD_ERR("Unsupported parser protocol(%d)", protocol);
+		return -ENOTSUP;
+	}
+
+	return 0;
+}
+
+static inline uint32_t __rte_hot
+dpaa2_dev_rx_parse_frc(const struct qbman_fd *fd,
+	struct rte_mbuf *m,
+	const struct dpaa2_annot_hdr *annotation)
+{
+	const struct dpaa2_ingress_frc *frc = (const void *)&fd->simple.frc;
+	const struct dpaa2_psr_summary *sum = &frc->psr_sum.sum;
+	const union dpaa2_psr_summary_l *sum_l = &sum->sum_l;
+	int ip4_6 = 0, vxlan = 0;
+	struct dpaa2_annot_hdr annot_convert;
+	const struct dpaa2_psr_result_parse *psr;
+	const struct dpaa2_fas_parse *fas;
+	uint32_t packet_type = RTE_PTYPE_UNKNOWN;
+	uint8_t vlan_offset;
+	rte_be16_t *vlan_tci;
+
+	/**Access annotation only for vlan and checksum error.*/
+
+	if (sum->vlan) {
+		annot_convert.word5 = annotation->word5;
+		annot_convert.word5 = rte_cpu_to_be_64(annot_convert.word5);
+		psr = (const void *)&annot_convert.word3;
+		packet_type |= RTE_PTYPE_L2_ETHER_VLAN;
+		m->ol_flags |= RTE_MBUF_F_RX_VLAN;
+		if (sum->vlan > 1) {
+			vlan_offset = psr->word5.vlan_tci_n_off;
+			packet_type |= RTE_PTYPE_L2_ETHER_QINQ;
+			m->ol_flags |= RTE_MBUF_F_RX_QINQ;
+		} else {
+			vlan_offset = psr->word5.vlan_tci_1_off;
+		}
+		vlan_tci = rte_pktmbuf_mtod_offset(m, void *, vlan_offset);
+		m->vlan_tci = rte_be_to_cpu_16(*vlan_tci);
+	}
+	if (sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV4) {
+		packet_type |= RTE_PTYPE_L3_IPV4;
+		ip4_6 = 1;
+	} else if (sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV6) {
+		packet_type |= RTE_PTYPE_L3_IPV6;
+		ip4_6 = 1;
+	}
+
+	/* Non-VLAN IP frames need RTE_PTYPE_L2_ETHER; VLAN frames
+	 * already have L2_ETHER_VLAN set above.
+	 */
+	if (ip4_6 && !sum->vlan)
+		packet_type |= RTE_PTYPE_L2_ETHER;
+
+	if (ip4_6) {
+		if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IP_FRAG) {
+			packet_type |= RTE_PTYPE_L4_FRAG;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_ICMP) {
+			packet_type |= RTE_PTYPE_L4_ICMP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IPSEC_ESP) {
+			packet_type |= RTE_PTYPE_TUNNEL_ESP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_TCP) {
+			packet_type |= RTE_PTYPE_L4_TCP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP) {
+			packet_type |= RTE_PTYPE_L4_UDP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_SCTP) {
+			packet_type |= RTE_PTYPE_L4_SCTP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPU) {
+			packet_type |= RTE_PTYPE_L4_UDP |
+				RTE_PTYPE_TUNNEL_GTPU;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPC) {
+			packet_type |= RTE_PTYPE_L4_UDP |
+				RTE_PTYPE_TUNNEL_GTPC;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_VXLAN) {
+			packet_type |= RTE_PTYPE_L4_UDP |
+				RTE_PTYPE_TUNNEL_VXLAN;
+			vxlan = 1;
+		} else {
+			packet_type |= RTE_PTYPE_L4_NONFRAG;
+		}
+	} else if (sum_l->l4_ext.l3 == DPAA2_PSR_SUMMARY_L4_EXT) {
+		if (!sum->vlan)
+			packet_type |= RTE_PTYPE_L2_ETHER;
+		if (sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV4)
+			packet_type |= RTE_PTYPE_L3_IPV4;
+		else if (sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV6)
+			packet_type |= RTE_PTYPE_L3_IPV6;
+		if (sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV4 ||
+			sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV6)
+			packet_type |= RTE_PTYPE_TUNNEL_GRE;
+		else if (sum_l->l4_ext.l4_ext ==
+			DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP ||
+			sum_l->l4_ext.l4_ext ==
+			DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+			packet_type |= RTE_PTYPE_TUNNEL_NVGRE;
+	} else if (sum_l->non_ip.non_ip == DPAA2_PSR_SUMMARY_NONIP) {
+		if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_ARP) {
+			packet_type |= RTE_PTYPE_L2_ETHER_ARP;
+		} else if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_NONIP_PTP) {
+			packet_type |= RTE_PTYPE_L2_ETHER_TIMESYNC;
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+		} else if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_MPLS) {
+			packet_type |= RTE_PTYPE_L2_ETHER_MPLS;
+		}
+	}
+
+	if (unlikely(sum->checksum_err)) {
+		fas = (const void *)&annotation->word1;
+		if (fas->l3ce)
+			m->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
+		if (fas->l4ce)
+			m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+	}
+
+	/*
+	 * fafe0 (eCPRI) and fafe1 (RoCEv2) are reported by the soft parser but
+	 * have no matching RTE_PTYPE value, so only the VXLAN inner types are
+	 * translated here.
+	 */
+	if (!sum->fafe0 && !sum->fafe1 && vxlan) {
+		if (sum->fafe2) {
+			packet_type |= RTE_PTYPE_INNER_L2_ETHER;
+			packet_type |= RTE_PTYPE_INNER_L3_IPV4;
+		} else if (sum_l->l4.fafe3) {
+			packet_type |= RTE_PTYPE_INNER_L2_ETHER;
+			packet_type |= RTE_PTYPE_INNER_L3_IPV6;
+		}
+	}
+
+	return packet_type;
+}
+
+#define DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule, mask, size, offset, nb, max, \
+	rule_val, mask_val, size_val, offset_val) \
+({ \
+	uint64_t *_rule = (rule); \
+	uint64_t *_mask = (mask); \
+	uint8_t *_size = (size); \
+	uint8_t *_offset = (offset); \
+	int _ecpri_ret = 0; \
+	int _nb = (nb); \
+	\
+	if (_nb >= (max)) { \
+		_ecpri_ret = -ENOSPC; \
+	} else { \
+		_rule[_nb] = (rule_val); \
+		_mask[_nb] = (mask_val); \
+		_size[_nb] = (size_val); \
+		_offset[_nb] = (offset_val); \
+	} \
+	_ecpri_ret; \
+})
+
+static inline int
+dpaa2_parser_ecpri_extract(const struct rte_flow_item_ecpri *spec,
+	const struct rte_flow_item_ecpri *mask,
+	uint64_t rule_data[], uint64_t mask_data[],
+	uint8_t extract_size[], uint8_t extract_off[],
+	union dpaa2_sp_fafe_parse *fafe, uint8_t max_nb)
+{
+	int extract_nb = 0, ret;
+
+	if (mask->hdr.common.type != 0xff) {
+		DPAA2_PR_PRINT("ECPRI header type not specified.");
+
+		return -EINVAL;
+	}
+
+	if (spec->hdr.common.type > RTE_ECPRI_MSG_TYPE_IWF_DCTRL) {
+		DPAA2_PR_PRINT("ECPRI header type(%d) not supported.",
+			spec->hdr.common.type);
+
+		return -ENOTSUP;
+	}
+
+	/** Extract eCPRI type from FAFE.*/
+	fafe->ecpri.ecpri = 1;
+	fafe->ecpri.msg_type = spec->hdr.common.type;
+	ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+		extract_off, extract_nb, max_nb, fafe->fafe_8b, 0xff, sizeof(uint8_t),
+		DPAA2_FAFE_PSR_RESULT_OFFSET);
+	if (ret)
+		return ret;
+	extract_nb++;
+
+	if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA) {
+		if (mask->hdr.type0.pc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type0.pc_id,
+				mask->hdr.type0.pc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_iq_data, pc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type0.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type0.seq_id,
+				mask->hdr.type0.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_iq_data, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
+		if (mask->hdr.type1.pc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type1.pc_id,
+				mask->hdr.type1.pc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_bit_seq, pc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type1.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type1.seq_id,
+				mask->hdr.type1.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_bit_seq, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
+		if (mask->hdr.type2.rtc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type2.rtc_id,
+				mask->hdr.type2.rtc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_rtc_ctrl, rtc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type2.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type2.seq_id,
+				mask->hdr.type2.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_rtc_ctrl, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
+		if (mask->hdr.type3.pc_id || mask->hdr.type3.seq_id)
+			DPAA2_PMD_WARN("Extract type3 msg not support.");
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
+		if (mask->hdr.type4.rma_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type4.rma_id,
+				mask->hdr.type4.rma_id, sizeof(uint8_t),
+				/** Compiler can't support to take address
+				 * of bit-field
+				 * offsetof(struct rte_ecpri_msg_rm_access,
+				 * rma_id);
+				 */
+				DPAA2_ECPRI_MSG_OFFSET + 0);
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type4.ele_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type4.ele_id,
+				mask->hdr.type4.ele_id, sizeof(rte_be16_t),
+				/** Compiler can't support to take address
+				 * of bit-field
+				 * offsetof(struct rte_ecpri_msg_rm_access,
+				 * rma_id);
+				 */
+				DPAA2_ECPRI_MSG_OFFSET + 2);
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
+		if (mask->hdr.type5.msr_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type5.msr_id,
+				mask->hdr.type5.msr_id, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_delay_measure, msr_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type5.act_type) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type5.act_type,
+				mask->hdr.type5.act_type, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_delay_measure, act_type));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
+		if (mask->hdr.type6.rst_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type6.rst_id,
+				mask->hdr.type6.rst_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_remote_reset, rst_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type6.rst_op) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type6.rst_op,
+				mask->hdr.type6.rst_op, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_remote_reset, rst_op));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
+		if (mask->hdr.type7.evt_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.evt_id,
+				mask->hdr.type7.evt_id, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, evt_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.evt_type) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.evt_type,
+				mask->hdr.type7.evt_type, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, evt_type));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.seq) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.seq,
+				mask->hdr.type7.seq, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, seq));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.number) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.number,
+				mask->hdr.type7.number, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, number));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else {
+		DPAA2_PR_PRINT("Unsupported ecpri header type(%d)",
+			spec->hdr.common.type);
+		return -ENOTSUP;
+	}
+
+	return extract_nb;
+}
+
+static inline void
+dpaa2_print_rocev2_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	int i;
+
+	DPAA2_PR_PRINT("ROCEv2 opcode: 0x%02x\r\n", psr->word8.rocev2.opcode);
+	DPAA2_PR_PRINT("ROCEv2 qp: ");
+	for (i = 0; i < ROCEV2_DEST_QP_SIZE; i++)
+		DPAA2_PR_PRINT("0x%02x ", psr->word8.rocev2.dest_qp[i]);
+
+	DPAA2_PR_PRINT("\r\n");
+}
+
+static inline void
+dpaa2_print_geneve_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	DPAA2_PR_PRINT("GENEVE protocol: 0x%04x\r\n",
+		rte_be_to_cpu_16(psr->word8.geneve.protocol));
+	DPAA2_PR_PRINT("GENEVE vni: %02x %02x %02x\r\n",
+		psr->word8.geneve.geneve_vni[0],
+		psr->word8.geneve.geneve_vni[1],
+		psr->word8.geneve.geneve_vni[2]);
+}
+
+static inline void
+dpaa2_print_vxlan_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	struct rte_ether_hdr vxlan_in_eth;
+	uint16_t vxlan_vlan_tci, i;
+
+	vxlan_in_eth.dst_addr.addr_bytes[0] = psr->word5.vxlan_in_daddr0;
+	vxlan_in_eth.dst_addr.addr_bytes[1] = psr->word5.vxlan_in_daddr1;
+	vxlan_in_eth.dst_addr.addr_bytes[2] = psr->word6.vxlan_in_daddr2;
+	vxlan_in_eth.dst_addr.addr_bytes[3] = psr->word6.vxlan_in_daddr3;
+	vxlan_in_eth.dst_addr.addr_bytes[4] = psr->word6.vxlan_in_daddr4;
+	vxlan_in_eth.dst_addr.addr_bytes[5] = psr->word6.vxlan_in_daddr5;
+
+	vxlan_in_eth.src_addr.addr_bytes[0] = psr->word6.vxlan_in_saddr0;
+	vxlan_in_eth.src_addr.addr_bytes[1] = psr->word7.vxlan_in_saddr1;
+	vxlan_in_eth.src_addr.addr_bytes[2] = psr->word7.vxlan_in_saddr2;
+	vxlan_in_eth.src_addr.addr_bytes[3] = psr->word7.vxlan_in_saddr3;
+	vxlan_in_eth.src_addr.addr_bytes[4] = psr->word8.vxlan_in_saddr4;
+	vxlan_in_eth.src_addr.addr_bytes[5] = psr->word8.vxlan_in_saddr5;
+
+	vxlan_in_eth.ether_type = psr->word8.vxlan_eth_type;
+	vxlan_in_eth.ether_type = rte_be_to_cpu_16(vxlan_in_eth.ether_type);
+
+	DPAA2_PR_PRINT("VXLAN inner eth:\r\n");
+	DPAA2_PR_PRINT("dst addr: ");
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
+		if (i != 0)
+			DPAA2_PR_PRINT(":");
+		DPAA2_PR_PRINT("%02x", vxlan_in_eth.dst_addr.addr_bytes[i]);
+	}
+	DPAA2_PR_PRINT("\r\n");
+	DPAA2_PR_PRINT("src addr: ");
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
+		if (i != 0)
+			DPAA2_PR_PRINT(":");
+		DPAA2_PR_PRINT("%02x", vxlan_in_eth.src_addr.addr_bytes[i]);
+	}
+	DPAA2_PR_PRINT("\r\n");
+	DPAA2_PR_PRINT("type: 0x%04x\r\n", vxlan_in_eth.ether_type);
+	if (vxlan_in_eth.ether_type == RTE_ETHER_TYPE_VLAN) {
+		rte_memcpy(&vxlan_vlan_tci,
+			&psr->word5.vxlan_vlan_tci, sizeof(uint16_t));
+		vxlan_vlan_tci = rte_be_to_cpu_16(vxlan_vlan_tci);
+		DPAA2_PR_PRINT("vlan tci: 0x%04x\r\n", vxlan_vlan_tci);
+	}
+}
+
+static inline void
+dpaa2_print_ecpri_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	uint8_t msg_type;
+	struct rte_ecpri_combined_msg_hdr ecpri_msg;
+
+	msg_type = psr->word3.fafe.ecpri.msg_type;
+	if (msg_type > RTE_ECPRI_MSG_TYPE_IWF_DCTRL) {
+		DPAA2_PR_PRINT("Invalid ECPRI message type(0x%02x)\r\n",
+			msg_type);
+		return;
+	}
+
+	DPAA2_PR_PRINT("ECPRI type %d present\r\n", msg_type);
+	rte_memcpy(ecpri_msg.dummy, psr->word8.sp_psr_ctx,
+		DPAA2_SP_PSR_CTX_LEN);
+	if (msg_type == RTE_ECPRI_MSG_TYPE_IQ_DATA ||
+		msg_type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
+		DPAA2_PR_PRINT("pc_id(0x%04x) seq_id(0x%04x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type0.pc_id),
+			rte_be_to_cpu_16(ecpri_msg.type0.seq_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
+		DPAA2_PR_PRINT("rtc_id(0x%04x) seq_id(0x%04x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type2.rtc_id),
+			rte_be_to_cpu_16(ecpri_msg.type2.seq_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
+		DPAA2_PR_PRINT("ECPRI type3 extract not support\r\n");
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
+		DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)",
+			ecpri_msg.type4.rma_id, ecpri_msg.type4.rw);
+		DPAA2_PR_PRINT(" rr(0x%02x) ele_id(0x%04x)\r\n",
+			ecpri_msg.type4.rr,
+			rte_be_to_cpu_16(ecpri_msg.type4.ele_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
+		DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)\r\n",
+			ecpri_msg.type5.msr_id,
+			ecpri_msg.type5.act_type);
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
+		DPAA2_PR_PRINT("rst_id(0x%04x) rst_op(0x%02x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type6.rst_id),
+			ecpri_msg.type6.rst_op);
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
+		DPAA2_PR_PRINT("evt_id(0x%02x) evt_type(0x%02x)",
+			ecpri_msg.type7.evt_id,
+			ecpri_msg.type7.evt_type);
+		DPAA2_PR_PRINT(" seq(0x%02x) number(0x%02x)\r\n",
+			ecpri_msg.type7.seq,
+			ecpri_msg.type7.number);
+	}
+}
+
+static inline void
+dpaa2_print_fd_frc(const struct qbman_fd *fd)
+{
+	const struct dpaa2_ingress_frc *frc;
+	const struct dpaa2_psr_summary *sum;
+	const union dpaa2_psr_summary_l *sum_l;
+	const char *l4_nm;
+
+	frc = (const void *)&fd->simple.frc;
+	DPAA2_PR_PRINT("FRC faicfdv: %d\r\n", frc->faicfdv);
+	DPAA2_PR_PRINT("FRC faswov: %d\r\n", frc->faswov);
+	DPAA2_PR_PRINT("FRC faiadv: %d\r\n", frc->faiadv);
+	DPAA2_PR_PRINT("FRC faprv: %d\r\n", frc->faprv);
+	DPAA2_PR_PRINT("FRC faeadv: %d\r\n", frc->faeadv);
+	DPAA2_PR_PRINT("FRC fasv: %d\r\n", frc->fasv);
+
+	sum = &frc->psr_sum.sum;
+	sum_l = &sum->sum_l;
+	DPAA2_PR_PRINT("FRC Check sum err: %d\r\n", sum->checksum_err);
+	DPAA2_PR_PRINT("FRC vlan: %d\r\n", sum->vlan);
+	if (sum_l->non_ip.non_ip == DPAA2_PSR_SUMMARY_NONIP) {
+		DPAA2_PR_PRINT("FRC NON IP %s detected, l2: %d\r\n",
+			sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_ARP ?
+			"arp" :
+			sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_NONIP_PTP ?
+			"ptp" : "",
+			sum_l->non_ip.l2);
+	} else if (sum_l->l4_ext.l3 == DPAA2_PSR_SUMMARY_L4_EXT) {
+		DPAA2_PR_PRINT("FRC L4 ext %s (%d) detected\r\n",
+			sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV4 ?
+			"ipv4" : "ipv6", sum_l->l4_ext.l4_ext);
+	} else {
+		if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IP_FRAG)
+			l4_nm = "fragment";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_ICMP)
+			l4_nm = "icmp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IPSEC_ESP)
+			l4_nm = "IPSec ESP";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_TCP)
+			l4_nm = "tcp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_SCTP)
+			l4_nm = "sctp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP)
+			l4_nm = "udp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_PTP)
+			l4_nm = "ptp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP_ESP_IKE)
+			l4_nm = "udp/esp/ike";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPU)
+			l4_nm = "gtpu";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPC)
+			l4_nm = "gtpc";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_VXLAN)
+			l4_nm = "vxlan";
+		else
+			l4_nm = "";
+		DPAA2_PR_PRINT("FRC %s(%d) %s(%d) detected\r\n",
+			sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV4 ?
+			"ipv4" : "ipv6", sum_l->l4.l3,
+			l4_nm, sum_l->l4.l4);
+	}
+
+	DPAA2_PR_PRINT("FRC FAFE bit0~3: %d%d%d%d\r\n",
+		sum->fafe0, sum->fafe1, sum->fafe2, sum_l->l4.fafe3);
+}
+
+static inline void
+dpaa2_print_parse_result(const struct dpaa2_annot_hdr *annotation,
+	int is_sp)
+{
+	struct dpaa2_annot_hdr annot_convert;
+	uint64_t annot_size = sizeof(struct dpaa2_annot_hdr), offset = 0;
+	uint64_t *word;
+	const struct dpaa2_psr_result_parse *psr;
+	const struct dpaa2_fas_parse *fas;
+
+	rte_memcpy(&annot_convert, annotation, sizeof(struct dpaa2_annot_hdr));
+	while (annot_size) {
+		word = (uint64_t *)&annot_convert + offset;
+		*word = rte_cpu_to_be_64(*word);
+		offset++;
+		annot_size -= sizeof(uint64_t);
+	}
+	fas = (const void *)&annotation->word1;
+	psr = (const void *)&annot_convert.word3;
+
+	if (fas->discard)
+		DPAA2_PR_PRINT("FAS discard\r\n");
+	if (fas->macsec)
+		DPAA2_PR_PRINT("FAS MACSEC present\r\n");
+	if (fas->ptp)
+		DPAA2_PR_PRINT("FAS PTP present\r\n");
+	if (fas->multicast)
+		DPAA2_PR_PRINT("FAS Multicast present\r\n");
+	if (fas->broadcast)
+		DPAA2_PR_PRINT("FAS Broadcast present\r\n");
+	if (fas->kse)
+		DPAA2_PR_PRINT("FAS Invalid key or key size error\r\n");
+	if (fas->eofhe)
+		DPAA2_PR_PRINT("FAS extract out of frame header\r\n");
+	if (fas->mnle)
+		DPAA2_PR_PRINT("FAS Max number of chained lookups reached\r\n");
+	if (fas->tide)
+		DPAA2_PR_PRINT("FAS Invalid table ID\r\n");
+	if (fas->piee)
+		DPAA2_PR_PRINT("FAS Policer Initialization Entry Error\r\n");
+	if (fas->fle)
+		DPAA2_PR_PRINT("FAS Frame Length Error\r\n");
+	if (fas->fpe)
+		DPAA2_PR_PRINT("FAS Frame physical Error\r\n");
+	if (fas->pte)
+		DPAA2_PR_PRINT("FAS Parser terminate early\r\n");
+	if (fas->isp)
+		DPAA2_PR_PRINT("FAS Invalid SP instruction is encountered\r\n");
+	if (fas->phe)
+		DPAA2_PR_PRINT("FAS Error during parsing\r\n");
+	if (fas->ble)
+		DPAA2_PR_PRINT("FAS block limit is exceeded\r\n");
+	if (fas->l3cv)
+		DPAA2_PR_PRINT("FAS L3 checksum validation is performed\r\n");
+	if (fas->l3ce)
+		DPAA2_PR_PRINT("FAS L3 checksum error detected\r\n");
+	if (fas->l4cv)
+		DPAA2_PR_PRINT("FAS L4 checksum validation is performed\r\n");
+	if (fas->l4ce)
+		DPAA2_PR_PRINT("FAS L4 checksum error detected\r\n");
+	DPAA2_PR_PRINT("FAS IFPID:%d PPID:%d, status:%02x\r\n",
+		fas->ifpid, fas->ppid, fas->status);
+
+	/** FAF error dump.*/
+	if (psr->word3.faf_l_be.arp_err)
+		DPAA2_PR_PRINT("FAF ARP error detected\r\n");
+	if (psr->word3.faf_l_be.mpls_err)
+		DPAA2_PR_PRINT("FAF MPLS error detected\r\n");
+	if (psr->word3.faf_l_be.pppoe_ppp_err)
+		DPAA2_PR_PRINT("FAF PPPOE/PPP error detected\r\n");
+	if (psr->word3.faf_l_be.vlan_err)
+		DPAA2_PR_PRINT("FAF vLAN error detected\r\n");
+	if (psr->word3.faf_l_be.llc_snap_err)
+		DPAA2_PR_PRINT("FAF LLC/SNAP error detected\r\n");
+	if (psr->word3.faf_l_be.eth_err)
+		DPAA2_PR_PRINT("FAF Ethernet error detected\r\n");
+	if (psr->word3.faf_l_be.psr_err)
+		DPAA2_PR_PRINT("FAF Parser error detected\r\n");
+	if (psr->word3.faf_l_be.spsr_err)
+		DPAA2_PR_PRINT("FAF Soft Parser error detected\r\n");
+	if (psr->word3.faf_l_be.vxlan_err)
+		DPAA2_PR_PRINT("FAF VXLan error detected\r\n");
+	if (psr->word4.faf_h_be.esp_err)
+		DPAA2_PR_PRINT("FAF ESP error detected\r\n");
+	if (psr->word4.faf_h_be.gtp_err)
+		DPAA2_PR_PRINT("FAF GTP error detected\r\n");
+	if (psr->word4.faf_h_be.gtp_err)
+		DPAA2_PR_PRINT("FAF GTP error detected\r\n");
+	if (psr->word4.faf_h_be.l4_spsr_err)
+		DPAA2_PR_PRINT("FAF L4 soft Parser error detected\r\n");
+	if (psr->word4.faf_h_be.sctp_err)
+		DPAA2_PR_PRINT("FAF SCTP error detected\r\n");
+	if (psr->word4.faf_h_be.ipsec_err)
+		DPAA2_PR_PRINT("FAF IPSec error detected\r\n");
+	if (psr->word4.faf_h_be.tcp_err)
+		DPAA2_PR_PRINT("FAF TCP error detected\r\n");
+	if (psr->word4.faf_h_be.udp_err)
+		DPAA2_PR_PRINT("FAF UDP error detected\r\n");
+	if (psr->word4.faf_h_be.l3_spsr_err)
+		DPAA2_PR_PRINT("FAF L3 soft Parser error detected\r\n");
+	if (psr->word4.faf_h_be.gre_err)
+		DPAA2_PR_PRINT("FAF GRE error detected\r\n");
+	if (psr->word4.faf_h_be.min_encp_err)
+		DPAA2_PR_PRINT("FAF Min.Encap error detected\r\n");
+	if (psr->word4.faf_h_be.ip_n_err)
+		DPAA2_PR_PRINT("FAF IP.n error detected\r\n");
+	if (psr->word4.faf_h_be.ip_1_err)
+		DPAA2_PR_PRINT("FAF IP.1 error detected\r\n");
+	if (psr->word4.faf_h_be.l2_spsr_err)
+		DPAA2_PR_PRINT("FAF L2 soft parser error detected\r\n");
+
+	DPAA2_PR_PRINT("Next Header: %04x\r\n",
+		rte_be_to_cpu_16(psr->word3.nxthdr));
+
+	if (is_sp) {
+		if (psr->word3.fafe.ecpri.ecpri) {
+			DPAA2_PR_PRINT("FAFE ECPRI present, msg: %d\r\n",
+				psr->word3.fafe.ecpri.msg_type);
+		} else if (psr->word3.fafe.rocev2_tunnel.rocev2) {
+			DPAA2_PR_PRINT("FAFE ROCEV2 present\r\n");
+		} else if (psr->word3.fafe.rocev2_tunnel.geneve) {
+			DPAA2_PR_PRINT("FAFE GENEVE present\r\n");
+		} else {
+			if (psr->word3.fafe.rocev2_tunnel.in_vlan)
+				DPAA2_PR_PRINT("FAFE TUNNEL vLAN present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_ipv4)
+				DPAA2_PR_PRINT("FAFE TUNNEL IPv4 present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_ipv6)
+				DPAA2_PR_PRINT("FAFE TUNNEL IPv6 present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_udp)
+				DPAA2_PR_PRINT("FAFE TUNNEL UDP present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_tcp)
+				DPAA2_PR_PRINT("FAFE TUNNEL TCP present\r\n");
+		}
+	} else {
+		DPAA2_PR_PRINT("FAFE: 0x%02x\r\n", psr->word3.fafe.fafe_8b);
+	}
+
+	/** FAF popular protocol dump.*/
+	if (psr->word3.faf_l_be.arp)
+		DPAA2_PR_PRINT("FAF ARP Present\r\n");
+	if (psr->word3.faf_l_be.mac)
+		DPAA2_PR_PRINT("FAF Ethernet MAC Present\r\n");
+	if (psr->word3.faf_l_be.vxlan)
+		DPAA2_PR_PRINT("FAF VXLan Present\r\n");
+	if (psr->word3.faf_l_be.ike)
+		DPAA2_PR_PRINT("FAF IKE Present\r\n");
+	if (psr->word3.faf_l_be.ptp)
+		DPAA2_PR_PRINT("FAF PTP Present\r\n");
+	if (psr->word4.faf_h_be.gtp)
+		DPAA2_PR_PRINT("FAF GTP Present\r\n");
+	if (psr->word4.faf_h_be.sctp)
+		DPAA2_PR_PRINT("FAF SCTP Present\r\n");
+	if (psr->word4.faf_h_be.ipsec)
+		DPAA2_PR_PRINT("FAF IPSec Present\r\n");
+	if (psr->word4.faf_h_be.ipsec_esp)
+		DPAA2_PR_PRINT("FAF IPSec ESP Present\r\n");
+	if (psr->word4.faf_h_be.ipsec_ah)
+		DPAA2_PR_PRINT("FAF IPSec AH Present\r\n");
+	if (psr->word4.faf_h_be.gre)
+		DPAA2_PR_PRINT("FAF GRE Present\r\n");
+	if (psr->word4.faf_h_be.icmp)
+		DPAA2_PR_PRINT("FAF ICMP Present\r\n");
+	if (psr->word4.faf_h_be.ipv6_1)
+		DPAA2_PR_PRINT("FAF IPv6 Present\r\n");
+	if (psr->word4.faf_h_be.ipv6_n)
+		DPAA2_PR_PRINT("FAF last IPv6 Present\r\n");
+	if (psr->word4.faf_h_be.ipv4_1)
+		DPAA2_PR_PRINT("FAF IPv4 Present\r\n");
+	if (psr->word4.faf_h_be.ipv4_n)
+		DPAA2_PR_PRINT("FAF last IPv4 Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_opt)
+		DPAA2_PR_PRINT("FAF IP Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_init_frag)
+		DPAA2_PR_PRINT("FAF IP first fragment Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_frag)
+		DPAA2_PR_PRINT("FAF IP fragment Present\r\n");
+	if (psr->word4.faf_h_be.tcp)
+		DPAA2_PR_PRINT("FAF TCP Present\r\n");
+	if (psr->word4.faf_h_be.udp)
+		DPAA2_PR_PRINT("FAF UDP Present\r\n");
+
+	DPAA2_PR_PRINT("Parser result eth header offset: %02x\r\n",
+		psr->word5.eth_off);
+	DPAA2_PR_PRINT("Parser result TCI1 offset: %02x\r\n",
+		psr->word5.vlan_tci_1_off);
+	DPAA2_PR_PRINT("Parser result last eth type offset: %02x\r\n",
+		psr->word5.last_etype_off);
+	DPAA2_PR_PRINT("Parser result l3 header offset: %02x\r\n",
+		psr->word6.l3_off);
+	DPAA2_PR_PRINT("Parser result l4 header offset: %02x\r\n",
+		psr->word6.l4_off);
+	DPAA2_PR_PRINT("Parser result l5 header offset: %02x\r\n",
+		psr->word6.l5_off);
+	DPAA2_PR_PRINT("Parser result next header offset: %02x\r\n",
+		psr->word7.nxthdr_off);
+
+	if (is_sp) {
+		if (psr->word3.faf_l_be.vxlan)
+			dpaa2_print_vxlan_parse_result(psr);
+		if (psr->word3.fafe.ecpri.ecpri)
+			dpaa2_print_ecpri_parse_result(psr);
+		if (psr->word3.fafe.rocev2_tunnel.rocev2)
+			dpaa2_print_rocev2_parse_result(psr);
+		if (psr->word3.fafe.rocev2_tunnel.geneve)
+			dpaa2_print_geneve_parse_result(psr);
+	}
+}
+
+#endif /* _DPAA2_PARSE_DECODE_H */
diff --git a/drivers/net/dpaa2/dpaa2_pmd_logs.h b/drivers/net/dpaa2/dpaa2_pmd_logs.h
index 28c9bed1ae..f1148f5b8d 100644
--- a/drivers/net/dpaa2/dpaa2_pmd_logs.h
+++ b/drivers/net/dpaa2/dpaa2_pmd_logs.h
@@ -5,6 +5,13 @@
 #ifndef _DPAA2_PMD_LOGS_H_
 #define _DPAA2_PMD_LOGS_H_
 
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_log.h>
+
 extern int dpaa2_logtype_pmd;
 #define RTE_LOGTYPE_DPAA2_NET dpaa2_logtype_pmd
 
@@ -36,4 +43,64 @@ extern int dpaa2_logtype_pmd;
 #define DPAA2_PMD_DP_WARN(fmt, ...) \
 	DPAA2_PMD_DP_LOG(WARNING, fmt, ## __VA_ARGS__)
 
+/** Maximum length of a single debug dump line. */
+#define DPAA2_DUMP_LINE_SIZE 512
+
+/**
+ * Append formatted text to the per-thread debug dump line buffer.
+ *
+ * The parse result and flow dump helpers build a line from several
+ * fragments, so the text is accumulated here and handed to the regular
+ * logging framework one complete line at a time. This keeps the dump
+ * readable without writing to stdout or stderr from the driver.
+ *
+ * Carriage returns and newlines terminate a line and are not logged.
+ */
+static inline void
+dpaa2_dump_print(const char *fmt, ...) __rte_format_printf(1, 2);
+
+static inline void
+dpaa2_dump_print(const char *fmt, ...)
+{
+	static __thread char line[DPAA2_DUMP_LINE_SIZE];
+	static __thread size_t used;
+	size_t start, i;
+	va_list ap;
+	int len;
+
+	va_start(ap, fmt);
+	len = vsnprintf(line + used, sizeof(line) - used, fmt, ap);
+	va_end(ap);
+
+	if (len > 0) {
+		used += (size_t)len;
+		/* Output was truncated, keep the buffer consistent. */
+		if (used >= sizeof(line))
+			used = sizeof(line) - 1;
+	}
+
+	/* Log every complete line held in the buffer. */
+	start = 0;
+	for (i = 0; i < used; i++) {
+		if (line[i] != '\n' && line[i] != '\r')
+			continue;
+		line[i] = '\0';
+		if (i != start)
+			DPAA2_PMD_DEBUG("%s", &line[start]);
+		start = i + 1;
+	}
+
+	if (start) {
+		used -= start;
+		memmove(line, &line[start], used);
+	}
+
+	/* Flush a full buffer even without a line terminator. */
+	if (used >= sizeof(line) - 1) {
+		line[used] = '\0';
+		DPAA2_PMD_DEBUG("%s", line);
+		used = 0;
+	}
+}
+
 #endif /* _DPAA2_PMD_LOGS_H_ */
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 7ba6a4563f..0cfced6525 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -26,13 +26,7 @@
 #include "dpaa2_pmd_logs.h"
 #include "dpaa2_ethdev.h"
 #include "base/dpaa2_hw_dpni_annot.h"
-#include "dpaa2_parse_dump.h"
-
-static inline uint32_t __rte_hot
-dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
-			struct dpaa2_annot_hdr *annotation);
-
-static void enable_tx_tstamp(struct qbman_fd *fd) __rte_unused;
+#include "dpaa2_parser_decode.h"
 
 static inline rte_mbuf_timestamp_t *
 dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
@@ -41,6 +35,43 @@ dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
 		dpaa2_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
 }
 
+static inline void
+dpaa2_dev_rx_annot_prefetch(const struct qbman_fd *fd)
+{
+	size_t fd_addr;
+	void *hw_annot_addr;
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	hw_annot_addr = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+	rte_prefetch0(hw_annot_addr);
+}
+
+static inline void
+dpaa2_dev_rx_parse_offset(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *mbuf, const struct qbman_fd *fd)
+{
+	size_t fd_addr;
+	const struct dpaa2_annot_hdr *annotation;
+	uint64_t word6;
+	struct dpaa2_psr_result_word6 *decoded;
+	struct dpaa2_dyn_rx_protocol_pos *pos;
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	annotation = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+
+	RTE_ASSERT(priv->psr_dynfield_offset >=
+		offsetof(struct rte_mbuf, dynfield1[0]) &&
+		priv->psr_dynfield_offset < (sizeof(struct rte_mbuf) -
+		sizeof(struct dpaa2_dyn_rx_protocol_pos)));
+	pos = (void *)((uint8_t *)mbuf + priv->psr_dynfield_offset);
+
+	word6 = rte_be_to_cpu_64(annotation->word6);
+	decoded = (void *)&word6;
+	pos->l3_offset = decoded->l3_off;
+	pos->l4_offset = decoded->l4_off;
+	pos->l5_offset = decoded->l5_off;
+}
+
 #define DPAA2_MBUF_TO_CONTIG_FD(_mbuf, _fd, _bpid)  do { \
 	DPAA2_SET_FD_ADDR(_fd, DPAA2_MBUF_VADDR_TO_IOVA(_mbuf)); \
 	DPAA2_SET_FD_LEN(_fd, _mbuf->data_len); \
@@ -51,95 +82,121 @@ dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
 	DPAA2_RESET_FD_FLC(_fd);		\
 } while (0)
 
-static inline void __rte_hot
-dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
-		       void *hw_annot_addr)
+
+static inline void
+dpaa2_dev_rx_mbuf_sched_set(struct rte_mbuf *m,
+	const struct qbman_fd *fd)
 {
-	uint16_t frc = DPAA2_GET_FD_FRC_PARSE_SUM(fd);
-	struct dpaa2_annot_hdr *annotation =
-			(struct dpaa2_annot_hdr *)hw_annot_addr;
 	uint32_t flc_lo, tc, flow;
 
-	if (unlikely(dpaa2_print_parser_result))
-		dpaa2_print_parse_result(annotation);
+	flc_lo = fd->simple.flc_lo;
+	if (flc_lo & (1 << DPAA2_FS_FLC_FS_MARK_OFFSET)) {
+		/*
+		 * FS-marked frame: TC and flow ID are packed in FLC low word.
+		 * Store them via rte_mbuf_sched_set(), which writes hash.sched.
+		 * Do NOT set RTE_MBUF_F_RX_FDIR: hash.sched overlaps hash.fdir
+		 * and rte_mbuf_sched_set() would corrupt any fdir.hi value.
+		 * hash.sched is a scheduler field; FDIR is not claimed here.
+		 */
+		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) &
+			DPAA2_FS_FLC_TC_MASK;
+		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
+		rte_mbuf_sched_set(m, flow, tc, DPAA2_GET_FD_DROPP(fd));
+		DPAA2_PMD_DP_DEBUG("FS frame received from TC[%d]->flow%d",
+			tc, flow);
+	} else {
+		m->hash.rss = fd->simple.flc_hi;
+		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+		DPAA2_PMD_DP_DEBUG("Hash frame received with RSS(%08x)",
+			m->hash.rss);
+	}
+}
+
+static void __rte_hot
+dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *m, const struct qbman_fd *fd,
+	void *hw_annot_addr, int is_vlan)
+{
+	uint16_t frc = DPAA2_GET_FD_FRC_PARSE_SUM(fd);
+	struct dpaa2_psr_summary *frc_parse = (void *)&frc;
+	struct dpaa2_annot_hdr *annotation = hw_annot_addr;
+	int default_parsed = false, vlan2 = false;
+	uint32_t ext_packet_type = RTE_PTYPE_UNKNOWN;
+
+	RTE_SET_USED(priv);
 
 	m->packet_type = RTE_PTYPE_UNKNOWN;
+	if (unlikely(is_vlan)) {
+		if (frc & DPAA2_PKT_TYPE_VLAN_2)
+			vlan2 = true;
+		frc &= (~DPAA2_PKT_TYPE_VLAN);
+	}
+	if (priv->sp_protocol) {
+		if (frc_parse->fafe2) {
+			frc_parse->fafe2 = 0;
+			ext_packet_type |= RTE_PTYPE_TUNNEL_GENEVE;
+		}
+		if (frc_parse->sum_l.l4.fafe3) {
+			frc_parse->sum_l.l4.fafe3 = 0;
+			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
+		}
+	}
 	switch (frc) {
-	case DPAA2_PKT_TYPE_ETHER:
-		m->packet_type = RTE_PTYPE_L2_ETHER;
-		break;
-	case DPAA2_PKT_TYPE_IPV4:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4;
-		break;
-	case DPAA2_PKT_TYPE_IPV6:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6;
-		break;
-	case DPAA2_PKT_TYPE_IPV4_EXT:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4_EXT;
-		break;
-	case DPAA2_PKT_TYPE_IPV6_EXT:
+	case DPAA2_PKT_TYPE_IPV4_UDP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6_EXT;
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_TCP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
 		break;
-	case DPAA2_PKT_TYPE_IPV6_TCP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP;
-		break;
-	case DPAA2_PKT_TYPE_IPV4_UDP:
+	case DPAA2_PKT_TYPE_IPV4:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP;
+			RTE_PTYPE_L3_IPV4;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_UDP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP;
 		break;
-	case DPAA2_PKT_TYPE_IPV4_SCTP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_SCTP;
-		break;
-	case DPAA2_PKT_TYPE_IPV6_SCTP:
+	case DPAA2_PKT_TYPE_IPV6_TCP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_SCTP;
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP;
 		break;
-	case DPAA2_PKT_TYPE_IPV4_ICMP:
+	case DPAA2_PKT_TYPE_IPV6:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_ICMP;
+			RTE_PTYPE_L3_IPV6;
 		break;
-	case DPAA2_PKT_TYPE_IPV6_ICMP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_ICMP;
+	case DPAA2_PKT_TYPE_ETHER:
+		m->packet_type = RTE_PTYPE_L2_ETHER;
 		break;
 	default:
-		m->packet_type = dpaa2_dev_rx_parse_slow(m, annotation);
+		m->packet_type = dpaa2_dev_rx_parse_frc(fd, m, annotation);
+		default_parsed = true;
 	}
-	flc_lo = fd->simple.flc_lo;
-	if (flc_lo & (1 << DPAA2_FS_FLC_FS_MARK_OFFSET)) {
-		m->ol_flags |= RTE_MBUF_F_RX_FDIR;
-		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) &
-			DPAA2_FS_FLC_TC_MASK;
-		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
-		rte_mbuf_sched_set(m, flow, tc, 0);
-		DPAA2_PMD_DP_DEBUG("FS frame received from TC[%d]->flow%d",
-			tc, flow);
-	} else {
-		m->hash.rss = fd->simple.flc_hi;
-		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
-		DPAA2_PMD_DP_DEBUG("Hash frame received with RSS(%08x)",
-			m->hash.rss);
+
+	m->packet_type |= ext_packet_type;
+
+	if (unlikely(is_vlan && !default_parsed)) {
+		struct dpaa2_psr_result_word5 word5;
+		rte_be16_t *vlan_tci = NULL;
+
+		m->ol_flags |= RTE_MBUF_F_RX_VLAN;
+		*(rte_be64_t *)&word5 = rte_cpu_to_be_64(annotation->word5);
+		if (vlan2) {
+			vlan_tci = rte_pktmbuf_mtod_offset(m, void *,
+				word5.vlan_tci_n_off);
+		} else {
+			vlan_tci = rte_pktmbuf_mtod_offset(m, void *,
+				word5.vlan_tci_1_off);
+		}
+		m->vlan_tci = rte_be_to_cpu_16(*vlan_tci);
 	}
 
 	if (dpaa2_enable_ts[m->port]) {
 		*dpaa2_timestamp_dynfield(m) = annotation->word2;
 		m->ol_flags |= dpaa2_timestamp_rx_dynflag;
 		DPAA2_PMD_DP_DEBUG("pkt timestamp:0x%" PRIx64 "",
-				*dpaa2_timestamp_dynfield(m));
+			*dpaa2_timestamp_dynfield(m));
 	}
 
 	DPAA2_PMD_DP_DEBUG("HW frc = 0x%x\t packet type =0x%x "
@@ -249,13 +306,15 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 }
 
 static inline uint32_t __rte_hot
-dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
+dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *mbuf, void *hw_annot_addr)
 {
-	struct dpaa2_annot_hdr *annotation =
-			(struct dpaa2_annot_hdr *)hw_annot_addr;
+	struct dpaa2_annot_hdr *annotation = hw_annot_addr;
 
 	DPAA2_PMD_DP_DEBUG("(fast parse) Annotation = 0x%" PRIx64 "\t",
-			   annotation->word4);
+		annotation->word4);
+
+	RTE_SET_USED(priv);
 
 	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
@@ -267,9 +326,6 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CV))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
-	if (unlikely(dpaa2_print_parser_result))
-		dpaa2_print_parse_result(annotation);
-
 	if (dpaa2_enable_ts[mbuf->port]) {
 		*dpaa2_timestamp_dynfield(mbuf) = annotation->word2;
 		mbuf->ol_flags |= dpaa2_timestamp_rx_dynflag;
@@ -278,7 +334,7 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	}
 
 	/* Check detailed parsing requirement */
-	if (annotation->word3 & 0x7FFFFC3FFFF)
+	if (unlikely(annotation->word3 & 0x7FFFFC3FFFF))
 		return dpaa2_dev_rx_parse_slow(mbuf, annotation);
 
 	/* Return some common types from parse processing */
@@ -307,8 +363,7 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 }
 
 static inline struct rte_mbuf *__rte_hot
-eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
-		  int port_id)
+dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	struct qbman_sge *sgt, *sge;
 	size_t sg_addr, fd_addr;
@@ -336,12 +391,14 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 	first_seg->pkt_len = DPAA2_GET_FD_LEN(fd);
 	first_seg->nb_segs = 1;
 	first_seg->next = NULL;
-	first_seg->port = port_id;
-	if (dpaa2_svr_family == SVR_LX2160A)
-		dpaa2_dev_rx_parse_new(first_seg, fd, hw_annot_addr);
-	else
-		first_seg->packet_type =
-			dpaa2_dev_rx_parse(first_seg, hw_annot_addr);
+	first_seg->port = priv->eth_dev->data->port_id;
+	if (dpaa2_svr_family == SVR_LX2160A) {
+		dpaa2_dev_rx_parse_new(priv, first_seg, fd, hw_annot_addr, false);
+	} else {
+		first_seg->packet_type = dpaa2_dev_rx_parse(priv, first_seg,
+			hw_annot_addr);
+	}
+	dpaa2_dev_rx_mbuf_sched_set(first_seg, fd);
 
 	rte_mbuf_refcnt_set(first_seg, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
@@ -381,13 +438,22 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 }
 
 static inline struct rte_mbuf *__rte_hot
-eth_fd_to_mbuf(const struct qbman_fd *fd,
-	       int port_id)
+dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	void *v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 	void *hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
 	struct rte_mbuf *mbuf = DPAA2_INLINE_MBUF_FROM_BUF(v_addr,
-		     rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
+		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
+	int is_vlan = false;
+
+	if (unlikely(dpaa2_svr_family == SVR_LX2160A &&
+		(DPAA2_GET_FD_FRC_PARSE_SUM(fd) &
+		DPAA2_PKT_TYPE_VLAN))) {
+		mbuf->data_off = DPAA2_GET_FD_OFFSET(fd);
+		rte_prefetch0(rte_pktmbuf_mtod(mbuf, void *));
+		rte_prefetch0(hw_annot_addr);
+		is_vlan = true;
+	}
 
 	/* need to repopulated some of the fields,
 	 * as they may have changed in last transmission
@@ -397,7 +463,7 @@ eth_fd_to_mbuf(const struct qbman_fd *fd,
 	mbuf->data_off = DPAA2_GET_FD_OFFSET(fd);
 	mbuf->data_len = DPAA2_GET_FD_LEN(fd);
 	mbuf->pkt_len = mbuf->data_len;
-	mbuf->port = port_id;
+	mbuf->port = priv->eth_dev->data->port_id;
 	mbuf->next = NULL;
 	mbuf->hash.sched.color = DPAA2_GET_FD_DROPP(fd);
 	rte_mbuf_refcnt_set(mbuf, 1);
@@ -413,9 +479,10 @@ eth_fd_to_mbuf(const struct qbman_fd *fd,
 	 */
 
 	if (dpaa2_svr_family == SVR_LX2160A)
-		dpaa2_dev_rx_parse_new(mbuf, fd, hw_annot_addr);
+		dpaa2_dev_rx_parse_new(priv, mbuf, fd, hw_annot_addr, is_vlan);
 	else
-		mbuf->packet_type = dpaa2_dev_rx_parse(mbuf, hw_annot_addr);
+		mbuf->packet_type = dpaa2_dev_rx_parse(priv, mbuf, hw_annot_addr);
+	dpaa2_dev_rx_mbuf_sched_set(mbuf, fd);
 
 	DPAA2_PMD_DP_DEBUG("to mbuf - mbuf =%p, mbuf->buf_addr =%p, off = %d,"
 		"fd_off=%d fd =%" PRIx64 ", meta = %d  bpid =%d, len=%d",
@@ -674,6 +741,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	struct dpaa2_fas *fas;
 	struct rte_mbuf *mbuf;
 	char title[32];
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -729,15 +797,16 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 		hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
 		fas = hw_annot_addr;
 
+		if (priv->psr_dynfield_offset >= 0)
+			dpaa2_dev_rx_annot_prefetch(fd);
 		if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg)
-			mbuf = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+			mbuf = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
-			mbuf = eth_fd_to_mbuf(fd, eth_data->port_id);
+			mbuf = dpaa2_eth_fd_to_mbuf(priv, fd);
+		if (priv->psr_dynfield_offset >= 0)
+			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
-		if (!dpaa2_print_parser_result) {
-			/** Don't print parse result twice.*/
-			dpaa2_print_parse_result(hw_annot_addr);
-		}
+		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
 
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
 		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
@@ -792,18 +861,12 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	struct qbman_pull_desc pulldesc;
 	struct queue_storage_info_t *q_storage;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	/* the error-queue drain runs on the regular portal (DPAA2_PER_LCORE_PORTAL);
-	 * the channel/interrupt path owns the ethrx portal, so skip it there
-	 */
-	if (!by_channel) {
-		struct dpaa2_dev_priv *priv = eth_data->dev_private;
-
-		if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
-			dump_err_pkts(priv->rx_err_vq);
-	}
+	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+		dump_err_pkts(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
@@ -909,18 +972,17 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 			dpaa2_dev_prefetch_next_psr(dq_storage);
 
 		fd = qbman_result_DQ_fd(dq_storage);
+
+		if (priv->psr_dynfield_offset >= 0)
+			dpaa2_dev_rx_annot_prefetch(fd);
 		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-			bufs[num_rx] = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+			bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
-			bufs[num_rx] = eth_fd_to_mbuf(fd, eth_data->port_id);
-#if defined(RTE_LIBRTE_IEEE1588)
-		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
-			struct dpaa2_dev_priv *priv = eth_data->dev_private;
+			bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
+		if (priv->psr_dynfield_offset >= 0)
+			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
-			priv->rx_timestamp =
-				*dpaa2_timestamp_dynfield(bufs[num_rx]);
-		}
-#endif
+		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 		dq_storage++;
 		num_rx++;
@@ -989,7 +1051,10 @@ dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -1014,7 +1079,10 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
@@ -1041,7 +1109,10 @@ dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	*dpaa2_seqn(ev->mbuf) = DPAA2_ENQUEUE_FLAG_ORP;
 	*dpaa2_seqn(ev->mbuf) |= qbman_result_DQ_odpid(dq) << DPAA2_EQCR_OPRID_SHIFT;
@@ -1151,12 +1222,15 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 				dpaa2_dev_prefetch_next_psr(dq_storage);
 
 			fd = qbman_result_DQ_fd(dq_storage);
+
+			if (priv->psr_dynfield_offset >= 0)
+				dpaa2_dev_rx_annot_prefetch(fd);
 			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-				bufs[num_rx] = eth_sg_fd_to_mbuf(fd,
-							eth_data->port_id);
+				bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 			else
-				bufs[num_rx] = eth_fd_to_mbuf(fd,
-							eth_data->port_id);
+				bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
+			if (priv->psr_dynfield_offset >= 0)
+				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
 #if defined(RTE_LIBRTE_IEEE1588)
 		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
@@ -1164,6 +1238,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 				*dpaa2_timestamp_dynfield(bufs[num_rx]);
 		}
 #endif
+			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 			dq_storage++;
 			num_rx++;
@@ -1314,7 +1389,7 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 
 	return num_tx_conf;
 }
-
+#ifdef RTE_LIBRTE_IEEE1588
 /* Configure the egress frame annotation for timestamp update */
 static void enable_tx_tstamp(struct qbman_fd *fd)
 {
@@ -1336,7 +1411,7 @@ static void enable_tx_tstamp(struct qbman_fd *fd)
 	fd_faead->ctrl = DPAA2_ANNOT_FAEAD_A2V | DPAA2_ANNOT_FAEAD_UPDV |
 				DPAA2_ANNOT_FAEAD_UPD;
 }
-
+#endif
 /*
  * Callback to handle sending packets through WRIOP based interface
  */
@@ -1617,8 +1692,12 @@ dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci,
 	fd = qbman_result_eqresp_fd(&dpio_dev->eqresp[eqresp_ci]);
 
 	/* Setting port id does not matter as we are to free the mbuf */
-	m = eth_fd_to_mbuf(fd, 0);
-	rte_pktmbuf_free(m);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		m = dpaa2_eth_sg_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
+	else
+		m = dpaa2_eth_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
+	if (m)
+		rte_pktmbuf_free(m);
 }
 
 static void
-- 
2.43.0

