Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED589CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 05:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0752440A72;
	Wed, 14 Oct 2026 07:44:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 853B240279
 for <dev@dpdk.org>; Wed, 14 Oct 2026 07:44:15 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 675F520013A;
 Wed, 14 Oct 2026 07:44:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3327B20012F;
 Wed, 14 Oct 2026 07:44:15 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D439618000BF;
 Wed, 14 Oct 2026 13:44:13 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v10-S2 09/11] net/dpaa2: parse tunnel and fragmented packet
 types
Date: Wed, 14 Oct 2026 11:13:58 +0530
Message-ID: <20261014054400.980123-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
References: <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261014054400.980123-1-prashant.gupta_3@nxp.com>
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
 drivers/net/dpaa2/dpaa2_ethdev.h | 16 ++++++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c   | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 160178d70e..8e1852741c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -131,6 +131,10 @@
 			(0x0001 | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_EXT \
 			(0x0001 | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_FRAG \
+			(0x0002 | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_FRAG \
+			(0x0002 | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_TCP \
 			(0x000e | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_TCP \
@@ -147,6 +151,18 @@
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
index 62565486a7..7da75649e2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -116,6 +116,42 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_ICMP;
 		break;
+	case DPAA2_PKT_TYPE_IPV4_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_FRAG;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_FRAG:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_FRAG;
+		break;
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

