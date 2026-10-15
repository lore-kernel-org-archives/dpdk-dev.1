Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB976CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:26:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D07014064E;
	Thu, 15 Oct 2026 11:25:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 925F440687
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:25:28 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7227C200006;
 Thu, 15 Oct 2026 11:25:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CCF0200003;
 Thu, 15 Oct 2026 11:25:28 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7ADA1800068;
 Thu, 15 Oct 2026 17:25:26 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v11-S2 09/11] net/dpaa2: parse tunnel and fragmented packet
 types
Date: Thu, 15 Oct 2026 14:55:11 +0530
Message-ID: <20261015092513.2427856-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
References: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
 <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
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

Extend dpaa2_dev_rx_parse_new() (LX2160A FRC fast path) to
identify IPv4/IPv6 fragmented packets, IPsec ESP, and
GTP-U/GTP-C packets.

Map the corresponding parser summary values to DPDK packet
types. GTP-U and GTP-C packets are additionally marked with
RTE_PTYPE_L4_UDP to reflect the UDP transport used by the
outer tunnel header.

Advertise the newly supported packet types through
dpaa2_supported_ptypes_get().

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |  4 ++++
 drivers/net/dpaa2/dpaa2_ethdev.h | 12 ++++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c   | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 37c671bebf..0c1f176291 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1371,6 +1371,10 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		RTE_PTYPE_L4_UDP,
 		RTE_PTYPE_L4_SCTP,
 		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_L4_FRAG,
+		RTE_PTYPE_TUNNEL_ESP,
+		RTE_PTYPE_TUNNEL_GTPU,
+		RTE_PTYPE_TUNNEL_GTPC,
 	};
 
 	if (dev->rx_pkt_burst == dpaa2_dev_prefetch_rx ||
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 160178d70e..c68e24cbb8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -147,6 +147,18 @@
 			(0x0003 | DPAA2_PKT_TYPE_IPV4_EXT)
 #define DPAA2_PKT_TYPE_IPV6_ICMP \
 			(0x0003 | DPAA2_PKT_TYPE_IPV6_EXT)
+#define DPAA2_PKT_TYPE_IPV4_ESP \
+			(0x0005 | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_ESP \
+			(0x0005 | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_GTPU \
+			(0x0014 | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_GTPU \
+			(0x0014 | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_GTPC \
+			(0x0015 | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_GTPC \
+			(0x0015 | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_VLAN_1		0x0160
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 62565486a7..052133eb55 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -78,11 +78,11 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 		break;
 	case DPAA2_PKT_TYPE_IPV4_EXT:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4_EXT;
+			RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_FRAG;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_EXT:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6_EXT;
+			RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_FRAG;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_TCP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
@@ -116,6 +116,34 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_ICMP;
 		break;
+	case DPAA2_PKT_TYPE_IPV4_ESP:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_ESP;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_ESP:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_TUNNEL_ESP;
+		break;
+	case DPAA2_PKT_TYPE_IPV4_GTPU:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP |
+			RTE_PTYPE_TUNNEL_GTPU;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_GTPU:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP |
+			RTE_PTYPE_TUNNEL_GTPU;
+		break;
+	case DPAA2_PKT_TYPE_IPV4_GTPC:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP |
+			RTE_PTYPE_TUNNEL_GTPC;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_GTPC:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP |
+			RTE_PTYPE_TUNNEL_GTPC;
+		break;
 	default:
 		m->packet_type = dpaa2_dev_rx_parse_slow(m, annotation);
 	}
-- 
2.43.0

