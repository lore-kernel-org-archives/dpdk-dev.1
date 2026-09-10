Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455AC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1BC342E61;
	Thu, 10 Sep 2026 15:52:41 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0A458427D9
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E35E51A0072;
 Thu, 10 Sep 2026 15:52:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ADFB21A002F;
 Thu, 10 Sep 2026 15:52:30 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A6A7D18000B1;
 Thu, 10 Sep 2026 21:52:29 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 24/47] net/dpaa2: parse tunnel and fragmented packet types
Date: Thu, 10 Sep 2026 19:21:35 +0530
Message-ID: <20260910135158.2181141-25-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

Extend the Rx parser to identify additional packet types decoded from
the hardware parser summary: IPv4/IPv6 fragments, IPsec ESP, and GTP-U /
GTP-C tunnels. The corresponding DPAA2_PKT_TYPE_* values are added and
mapped to the matching RTE_PTYPE_* flags in the slow-path parser.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h | 16 ++++++++++++++++
 drivers/net/dpaa2/dpaa2_rxtx.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ddc1917b23..c298954265 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -162,6 +162,10 @@
 #define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV6_UDP_TCP \
 	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
 
+#define DPAA2_PKT_TYPE_IPV4_FRAG \
+	(DPAA2_PSR_SUMMARY_IP_FRAG | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_FRAG \
+	(DPAA2_PSR_SUMMARY_IP_FRAG | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_TCP \
 	(DPAA2_PSR_SUMMARY_TCP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_TCP \
@@ -178,6 +182,18 @@
 	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_ICMP \
 	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_ESP \
+	(DPAA2_PSR_SUMMARY_IPSEC_ESP | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_ESP \
+	(DPAA2_PSR_SUMMARY_IPSEC_ESP | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_GTPU \
+	(DPAA2_PSR_SUMMARY_GTPU | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_GTPU \
+	(DPAA2_PSR_SUMMARY_GTPU | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_GTPC \
+	(DPAA2_PSR_SUMMARY_GTPC | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_GTPC \
+	(DPAA2_PSR_SUMMARY_GTPC | DPAA2_PKT_TYPE_IPV6)
 
 #define DPAA2_PKT_TYPE_VLAN_1	0x0100
 #define DPAA2_PKT_TYPE_VLAN_2	0x0200
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 47c8cacdc4..26c84e7125 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -153,6 +153,38 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV6;
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
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_GTPU;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_GTPU:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_TUNNEL_GTPU;
+		break;
+	case DPAA2_PKT_TYPE_IPV4_GTPC:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_GTPC;
+		break;
+	case DPAA2_PKT_TYPE_IPV6_GTPC:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_TUNNEL_GTPC;
+		break;
 	case DPAA2_PKT_TYPE_ETHER:
 		m->packet_type = RTE_PTYPE_L2_ETHER;
 		break;
-- 
2.43.0

