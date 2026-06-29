Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6618EC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB8FB4065B;
	Mon, 29 Jun 2026 07:21:36 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 808A6402D5
 for <dev@dpdk.org>; Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 582AF1A0AFB;
 Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F17DB1A0B51;
 Mon, 29 Jun 2026 07:05:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7DFA81800086;
 Mon, 29 Jun 2026 13:05:31 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 3/9] net/enetc: support ESP packet type in packet parsing
Date: Mon, 29 Jun 2026 10:35:21 +0530
Message-Id: <20260629050527.981200-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260629050527.981200-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
 <20260629050527.981200-1-g.singh@nxp.com>
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

Add ESP (Encapsulating Security Payload) packet type definitions and
handling to the RX packet parsing path. Also update the supported
ptypes array to advertise ESP tunnel type support.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/enetc/base/enetc_hw.h      |  4 ++++
 drivers/net/enetc/enetc_ethdev.c       |  3 ++-
 drivers/net/enetc/enetc_rxtx.c         | 10 ++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index fc6e144..35476c2 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -187,6 +187,9 @@ New Features
   ``RTE_ETH_EVENT_RECOVERY_FAILED``) to notify upper layers of the
   reset lifecycle.
 
+* **Updated NXP ENETC ethernet driver.**
+
+  * Added support for ESP packet type in packet parsing
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 19efadd..f79c950 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -226,6 +226,10 @@ enum enetc_bdr_type {TX, RX};
 			(0x0003 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_ICMP \
 			(0x0003 | ENETC_PKT_TYPE_IPV6)
+#define ENETC_PKT_TYPE_IPV4_ESP \
+			(0x0005 | ENETC_PKT_TYPE_IPV4)
+#define ENETC_PKT_TYPE_IPV6_ESP \
+			(0x0005 | ENETC_PKT_TYPE_IPV6)
 
 /* PCI device info */
 struct enetc_hw {
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index f41f3c1..8196377 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <stdbool.h>
@@ -95,6 +95,7 @@ enetc_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 		RTE_PTYPE_L4_UDP,
 		RTE_PTYPE_L4_SCTP,
 		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_TUNNEL_ESP
 	};
 
 	*no_of_elements = RTE_DIM(ptypes);
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index d3b98b3..94177bb 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -370,6 +370,16 @@ enetc_dev_rx_parse(struct rte_mbuf *m, uint16_t parse_results)
 				 RTE_PTYPE_L3_IPV6 |
 				 RTE_PTYPE_L4_UDP;
 		return;
+	case ENETC_PKT_TYPE_IPV4_ESP:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV4 |
+				 RTE_PTYPE_TUNNEL_ESP;
+		return;
+	case ENETC_PKT_TYPE_IPV6_ESP:
+		m->packet_type = RTE_PTYPE_L2_ETHER |
+				 RTE_PTYPE_L3_IPV6 |
+				 RTE_PTYPE_TUNNEL_ESP;
+		return;
 	case ENETC_PKT_TYPE_IPV4_SCTP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
 				 RTE_PTYPE_L3_IPV4 |
-- 
2.25.1

