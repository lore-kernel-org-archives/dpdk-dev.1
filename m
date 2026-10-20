Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E6606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC9440A89;
	Tue, 20 Oct 2026 16:49:08 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4AA7D40695
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:56 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 206FD1A00B4;
 Tue, 20 Oct 2026 16:48:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF2E21A008D;
 Tue, 20 Oct 2026 16:48:55 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 877761800068;
 Tue, 20 Oct 2026 22:48:54 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v14-S2 09/10] net/dpaa2: parse tunnel and fragmented packet
 types
Date: Tue, 20 Oct 2026 20:18:40 +0530
Message-ID: <20261020144841.506038-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Extend dpaa2_dev_rx_parse_new() (LX2160A FRC fast path) to
identify IPv4/IPv6 fragmented packets, IPsec ESP, and
GTP-U/GTP-C packets.

Map the corresponding parser summary values to DPDK packet
types. Fragmented IPv4/IPv6 packets are reported with
RTE_PTYPE_L4_FRAG. GTP-U and GTP-C packets are additionally
marked with RTE_PTYPE_L4_UDP to reflect the UDP transport
used by the outer tunnel header.

Advertise the newly supported packet types through
dpaa2_supported_ptypes_get().

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |  4 +++
 drivers/net/dpaa2/dpaa2_ethdev.h | 20 ++++++++++++---
 drivers/net/dpaa2/dpaa2_rxtx.c   | 44 ++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f88ecb88aa..72b37a988d 100644
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
index 2569b2bd83..dc72939103 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -127,9 +127,9 @@
 #define DPAA2_PKT_TYPE_ETHER		0x0060
 #define DPAA2_PKT_TYPE_IPV4		0x0000
 #define DPAA2_PKT_TYPE_IPV6		0x0020
-#define DPAA2_PKT_TYPE_IPV4_EXT \
+#define DPAA2_PKT_TYPE_IPV4_FRAG \
 			(0x0001 | DPAA2_PKT_TYPE_IPV4)
-#define DPAA2_PKT_TYPE_IPV6_EXT \
+#define DPAA2_PKT_TYPE_IPV6_FRAG \
 			(0x0001 | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_TCP \
 			(0x000e | DPAA2_PKT_TYPE_IPV4)
@@ -144,9 +144,21 @@
 #define DPAA2_PKT_TYPE_IPV6_SCTP	\
 			(0x000f | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV4_EXT)
+			(0x0003 | DPAA2_PKT_TYPE_IPV4_FRAG)
 #define DPAA2_PKT_TYPE_IPV6_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV6_EXT)
+			(0x0003 | DPAA2_PKT_TYPE_IPV6_FRAG)
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
index 71e292fea6..c2c581f69b 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -76,14 +76,6 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV6;
 		break;
-	case DPAA2_PKT_TYPE_IPV4_EXT:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4_EXT;
-		break;
-	case DPAA2_PKT_TYPE_IPV6_EXT:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6_EXT;
-		break;
 	case DPAA2_PKT_TYPE_IPV4_TCP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
@@ -116,6 +108,42 @@ dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
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

