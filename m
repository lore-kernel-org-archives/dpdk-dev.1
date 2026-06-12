Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E24CD4F2C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 09:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F4054349C;
	Fri, 12 Jun 2026 11:12:24 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 4774C40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 11:12:21 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Dpg0x7mWnvK1IKS7VdwaZ2P7SI+FjEGrUQbQz8WdnLI=;
 b=KzUkWFsTkBnJ0wDmMRd8q6QbtcIX80OVjLxaa3TpGKmlykfkzWNlk6MfiFd1eCBwNFxf1yxiq
 kJkgbVF2zrJJSSdZIVUowurMrkGdm4MrtESJcKtBwSqsPY/OvREwPCNoS/FlTPg5fT1G3dLxU+d
 ptQa/r/5unmJW5TvTxdDIUA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gcD933KCSzLlTG;
 Fri, 12 Jun 2026 17:04:23 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 82C3C40563;
 Fri, 12 Jun 2026 17:12:18 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 12 Jun 2026 17:12:17 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2] app/testpmd: add padding mode to txonly engine
Date: Fri, 12 Jun 2026 17:12:17 +0800
Message-ID: <20260612091217.2899755-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

Add a new padding mode to the txonly forwarding engine, which allows
sending packets with configurable small sizes without standard L2/L3
headers. This is useful for testing NIC padding logic.

When padding mode is enabled via --tx-pkt-pad-mode flag:
- l2_len and l3_len are set to 0 instead of standard header lengths
- Packet data is filled with a static pattern instead of
  Ethernet/IP/UDP headers
- Minimum packet length validation is bypassed to allow small
  packet sizes (e.g., set txpkts 14)

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
v2: Fix compilation exception of unterminated-string-initialization
---
 app/test-pmd/config.c     |  2 +-
 app/test-pmd/parameters.c |  7 +++++++
 app/test-pmd/testpmd.c    |  3 +++
 app/test-pmd/testpmd.h    |  1 +
 app/test-pmd/txonly.c     | 18 ++++++++++++++++--
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d457ca88e..36b9b023e2 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6341,7 +6341,7 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsigned int nb_segs)
 		}
 		tx_pkt_len = (uint16_t)(tx_pkt_len + seg_lengths[i]);
 	}
-	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8)) {
+	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8) && !tx_pkt_pad_mode) {
 		fprintf(stderr, "total packet length=%u < %d - give up\n",
 				(unsigned) tx_pkt_len,
 				(int)(sizeof(struct rte_ether_hdr) + 20 + 8));
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 337d8fc8ac..8c3b1244e7 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -195,6 +195,8 @@ enum {
 	TESTPMD_OPT_TXONLY_MULTI_FLOW_NUM,
 #define TESTPMD_OPT_TXONLY_FLOWS "txonly-flows"
 	TESTPMD_OPT_TXONLY_FLOWS_NUM,
+#define TESTPMD_OPT_TX_PKT_PAD_MODE "tx-pkt-pad-mode"
+	TESTPMD_OPT_TX_PKT_PAD_MODE_NUM,
 #define TESTPMD_OPT_RXQ_SHARE "rxq-share"
 	TESTPMD_OPT_RXQ_SHARE_NUM,
 #define TESTPMD_OPT_ETH_LINK_SPEED "eth-link-speed"
@@ -351,6 +353,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_MULTI_RX_MEMPOOL),
 	NO_ARG(TESTPMD_OPT_TXONLY_MULTI_FLOW),
 	REQUIRED_ARG(TESTPMD_OPT_TXONLY_FLOWS),
+	NO_ARG(TESTPMD_OPT_TX_PKT_PAD_MODE),
 	NO_ARG(TESTPMD_OPT_RXQ_SHARE),
 	REQUIRED_ARG(TESTPMD_OPT_ETH_LINK_SPEED),
 	NO_ARG(TESTPMD_OPT_DISABLE_LINK_CHECK),
@@ -504,6 +507,7 @@ usage(char* progname)
 	printf("  --txonly-multi-flow: generate multiple flows in txonly mode\n");
 	printf("  --txonly-nb-flows=N: number of flows per lcore in txonly"
 	       " multi-flow mode (1-64, default 64)\n");
+	printf("  --tx-pkt-pad-mode: enable padding mode in txonly mode\n");
 	printf("  --tx-ip=src,dst: IP addresses in Tx-only mode\n");
 	printf("  --tx-udp=src[,dst]: UDP ports in Tx-only mode\n");
 	printf("  --eth-link-speed: force link speed.\n");
@@ -1577,6 +1581,9 @@ launch_args_parse(int argc, char** argv)
 			else
 				rte_exit(EXIT_FAILURE, "txonly-flows must be >= 1 and <= 64\n");
 			break;
+		case TESTPMD_OPT_TX_PKT_PAD_MODE_NUM:
+			tx_pkt_pad_mode = 1;
+			break;
 		case TESTPMD_OPT_RXQ_SHARE_NUM:
 			rxq_share = 1;
 			break;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fcd8a90967..457bb6d3fe 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -296,6 +296,9 @@ uint32_t tx_pkt_times_inter;
 uint32_t tx_pkt_times_intra;
 /**< Timings for send scheduling in TXONLY mode, time between packets. */
 
+uint8_t tx_pkt_pad_mode;
+/**< Whether packet padding mode is enabled. */
+
 uint16_t nb_pkt_per_burst = DEF_PKT_BURST; /**< Number of packets per burst. */
 uint16_t nb_pkt_flowgen_clones; /**< Number of Tx packet clones to send in flowgen mode. */
 int nb_flows_flowgen = 1024; /**< Number of flows in flowgen mode. */
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 3d4b36d668..04fdc2db42 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -663,6 +663,7 @@ extern uint16_t tx_pkt_seg_lengths[RTE_MAX_SEGS_PER_PKT]; /**< Seg. lengths */
 extern uint8_t  tx_pkt_nb_segs; /**< Number of segments in TX packets */
 extern uint32_t tx_pkt_times_intra;
 extern uint32_t tx_pkt_times_inter;
+extern uint8_t  tx_pkt_pad_mode;
 
 enum tx_pkt_split {
 	TX_PKT_SPLIT_OFF,
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index 64893fa205..2ddc100f21 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -192,8 +192,8 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 	pkt->ol_flags |= ol_flags;
 	pkt->vlan_tci = vlan_tci;
 	pkt->vlan_tci_outer = vlan_tci_outer;
-	pkt->l2_len = sizeof(struct rte_ether_hdr);
-	pkt->l3_len = sizeof(struct rte_ipv4_hdr);
+	pkt->l2_len = tx_pkt_pad_mode ? 0 : sizeof(struct rte_ether_hdr);
+	pkt->l3_len = tx_pkt_pad_mode ? 0 : sizeof(struct rte_ipv4_hdr);
 
 	pkt_len = pkt->data_len;
 	pkt_seg = pkt;
@@ -204,6 +204,19 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 		pkt_len += pkt_seg->data_len;
 	}
 	pkt_seg->next = NULL; /* Last segment of packet. */
+
+	if (tx_pkt_pad_mode) {
+		static const char pad_pattern[] = "0123456789abcdef";
+		uint32_t j;
+		char *pad;
+
+		pad = rte_pktmbuf_mtod(pkt, char *);
+		for (j = 0; j < pkt->data_len; j++)
+			pad[j] = pad_pattern[j % 16];
+
+		goto out;
+	}
+
 	/*
 	 * Copy headers in first packet segment(s).
 	 */
@@ -295,6 +308,7 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 			sizeof(struct rte_ipv4_hdr) +
 			sizeof(pkt_udp_hdr));
 	}
+out:
 	/*
 	 * Complete first mbuf of packet and append it to the
 	 * burst of packets to be transmitted.
-- 
2.43.0

