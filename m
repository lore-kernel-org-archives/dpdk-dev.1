Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06261CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E136D4065B;
	Thu,  9 Oct 2025 13:16:44 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 057B640611
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:38 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEAB4201F2F;
 Thu,  9 Oct 2025 13:16:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9418201F22;
 Thu,  9 Oct 2025 13:16:37 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 23C2F180008F;
 Thu,  9 Oct 2025 19:16:37 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v1 06/12] net/enetc: Add packet type parsing support
Date: Thu,  9 Oct 2025 16:46:27 +0530
Message-Id: <20251009111633.3585957-7-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Introduces packet type parsing for ENETC4 PMD, supporting:

- RTE_PTYPE_L2_ETHER (Ethernet II)
- RTE_PTYPE_L3_IPV4 (IPv4)
- RTE_PTYPE_L3_IPV6 (IPv6)
- RTE_PTYPE_L4_TCP (TCP)
- RTE_PTYPE_L4_UDP (UDP)
- RTE_PTYPE_L4_SCTP (SCTP)
- RTE_PTYPE_L4_ICMP (ICMP)
- RTE_PTYPE_L4_FRAG (IPv4/IPv6 fragmentation)
- RTE_PTYPE_TUNNEL_ESP (ESP tunneling)

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |  1 +
 drivers/net/enetc/base/enetc_hw.h   |  5 +++++
 drivers/net/enetc/enetc.h           |  2 ++
 drivers/net/enetc/enetc4_ethdev.c   | 23 +++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c       |  1 +
 drivers/net/enetc/enetc_rxtx.c      | 10 ++++++++++
 6 files changed, 42 insertions(+)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index e814852d2d..3356475317 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Packet type parsing  = Y
 Basic stats          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 3208d91bc5..10bd3c050c 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -196,6 +196,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PKT_TYPE_ETHER            0x0060
 #define ENETC_PKT_TYPE_IPV4             0x0000
 #define ENETC_PKT_TYPE_IPV6             0x0020
+#define ENETC_PKT_TYPE_IPV6_EXT         0x0080
 #define ENETC_PKT_TYPE_IPV4_TCP \
 			(0x0010 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_TCP \
@@ -208,6 +209,10 @@ enum enetc_bdr_type {TX, RX};
 			(0x0013 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_SCTP \
 			(0x0013 | ENETC_PKT_TYPE_IPV6)
+#define ENETC_PKT_TYPE_IPV4_FRAG \
+			(0x0001 | ENETC_PKT_TYPE_IPV4)
+#define ENETC_PKT_TYPE_IPV6_FRAG \
+			(0x0001 | ENETC_PKT_TYPE_IPV6_EXT | ENETC_PKT_TYPE_IPV6)
 #define ENETC_PKT_TYPE_IPV4_ICMP \
 			(0x0003 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_ICMP \
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index ab9e6cbd6b..8a63f55aa1 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -116,6 +116,8 @@ int enetc4_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 int enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
 int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
 void enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+const uint32_t *enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+			size_t *no_of_elements);
 
 /*
  * enetc4_vf function prototype
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 0f711a4bfb..b4bf7e4e63 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -648,6 +648,28 @@ enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
 	return 0;
 }
 
+const uint32_t *
+enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+			    size_t *no_of_elements)
+{
+	PMD_INIT_FUNC_TRACE();
+	static const uint32_t ptypes[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L3_IPV4,
+		RTE_PTYPE_L3_IPV6,
+		RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_L4_FRAG,
+		RTE_PTYPE_TUNNEL_ESP,
+		RTE_PTYPE_UNKNOWN
+	};
+
+	*no_of_elements = RTE_DIM(ptypes);
+	return ptypes;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -673,6 +695,7 @@ static const struct eth_dev_ops enetc4_ops = {
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 0d35fc2e1c..360bb0c710 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -73,6 +73,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
 static int
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index 6680b46103..a2b8153085 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -389,6 +389,16 @@ enetc_dev_rx_parse(struct rte_mbuf *m, uint16_t parse_results)
 				 RTE_PTYPE_L3_IPV6 |
 				 RTE_PTYPE_L4_ICMP;
 		return;
+	case ENETC_PKT_TYPE_IPV4_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV4 |
+				 RTE_PTYPE_L4_FRAG;
+		return;
+	case ENETC_PKT_TYPE_IPV6_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV6 |
+				 RTE_PTYPE_L4_FRAG;
+		return;
 	/* More switch cases can be added */
 	default:
 		enetc_slow_parsing(m, parse_results);
-- 
2.25.1

