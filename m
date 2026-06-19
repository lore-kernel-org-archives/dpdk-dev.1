Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF3CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E564068A;
	Fri, 19 Jun 2026 20:44:35 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 589A940279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A41B20001E;
 Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 02C9A200004;
 Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3B59C1800088;
 Sat, 20 Jun 2026 02:44:29 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 04/10] net/enetc: support ESP packet type in packet parsing
Date: Sat, 20 Jun 2026 00:14:21 +0530
Message-Id: <20260619184427.522518-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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
 drivers/net/enetc/base/enetc_hw.h |  4 ++++
 drivers/net/enetc/enetc_ethdev.c  |  4 +++-
 drivers/net/enetc/enetc_rxtx.c    | 10 ++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index f41f3c1..407179f 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <stdbool.h>
@@ -95,6 +95,8 @@ enetc_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 		RTE_PTYPE_L4_UDP,
 		RTE_PTYPE_L4_SCTP,
 		RTE_PTYPE_L4_ICMP,
+		RTE_PTYPE_TUNNEL_ESP,
+		RTE_PTYPE_UNKNOWN,
 	};
 
 	*no_of_elements = RTE_DIM(ptypes);
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index b44e6f3..c87349f 100644
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

