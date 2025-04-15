Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39972C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 813174066C;
	Tue, 15 Apr 2025 14:11:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2AD6B40672
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:34 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9lPqm016220;
 Tue, 15 Apr 2025 05:11:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 WAwOXKCCXZjA8+vqpHfFDzF7Vzv0XkN2773Ph6eWSM=; b=ZDZq2U3NSP3lf4Ioo
 vwT7pKYStkiQzyWbDd6IiBoH46RIhvXuG313Rxk6fZb0SQAqPBw4IgYVfhFjQxuB
 qJIhTQzrKuI+pZ6A6EfXsN/a8umBExxnDZVmq2NiLmeOjqFWkZHggyEqQTp6tYlO
 13/VDdxTx7otRJtivCCww7HxVu0m1z/L6j0XJAJRG9pp9XV5uh/sV4dgjb5Cdqga
 7zT9TaaMvgII/wE/BdTxU3StkpmXUaSUVolaOcnULROP4l1cyG62U2kKbe3A0c9B
 E523Zq36eRNeG+vPiUs5NxRoTN62oow6KwyQlxpQnZHPNpIFlGX4d8D2Uvu1l/qH
 iDh7Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjee8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id B5E2C67398;
 Tue, 15 Apr 2025 05:11:29 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 03/12] node: add IP4 FIB route add
Date: Tue, 15 Apr 2025 17:40:43 +0530
Message-ID: <20250415121052.1497155-4-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uiKMFxE6BVc-79FVtvTVOIK4D-yWZgDL
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67fe4cf5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uiKMFxE6BVc-79FVtvTVOIK4D-yWZgDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
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

Adds a public function to add IP4 route to FIB. The applications should
call this function to add IP4 routes to FIB.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip4_lookup_fib.c   | 36 ++++++++++++++++++++++++++++++++++++
 lib/node/rte_node_ip4_api.h | 19 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 9c71610718..e87864e672 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -2,6 +2,9 @@
  * Copyright(C) 2025 Marvell.
  */
 
+#include <arpa/inet.h>
+
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_ether.h>
 #include <rte_fib.h>
@@ -37,6 +40,39 @@ static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
 #define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
 	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
+int
+rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
+			   enum rte_node_ip4_lookup_next next_node)
+{
+	char abuf[INET6_ADDRSTRLEN];
+	struct in_addr in;
+	uint8_t socket;
+	uint32_t val;
+	int ret;
+
+	in.s_addr = htonl(ip);
+	inet_ntop(AF_INET, &in, abuf, sizeof(abuf));
+	/* Embedded next node id into 24 bit next hop */
+	val = ((next_node << 16) | next_hop) & ((1ull << 24) - 1);
+	node_dbg("ip4_lookup_fib", "FIB: Adding route %s / %d nh (0x%x)", abuf, depth, val);
+
+	for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++) {
+		if (!ip4_lookup_fib_nm.fib[socket])
+			continue;
+
+		ret = rte_fib_add(ip4_lookup_fib_nm.fib[socket], ip, depth, val);
+		if (ret < 0) {
+			node_err("ip4_lookup_fib",
+				 "Unable to add entry %s / %d nh (%x) to FIB on sock %d, rc=%d",
+				 abuf, depth, val, socket, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int
 setup_fib(unsigned int socket)
 {
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index 950751a525..93047a0634 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -117,6 +117,25 @@ int rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 __rte_experimental
 int rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt);
 
+/**
+ * Add ipv4 route to FIB.
+ *
+ * @param ip
+ *   IP address of route to be added.
+ * @param depth
+ *   Depth of the rule to be added.
+ * @param next_hop
+ *   Next hop id of the rule result to be added.
+ * @param next_node
+ *   Next node to redirect traffic to.
+ *
+ * @return
+ *   0 on success, negative otherwise.
+ */
+__rte_experimental
+int rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
+			       enum rte_node_ip4_lookup_next next_node);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

