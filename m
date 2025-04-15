Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767ABC369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E69A406B8;
	Tue, 15 Apr 2025 14:12:17 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C3F0C40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:12:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F7WaZq031395;
 Tue, 15 Apr 2025 05:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 zEEWd0TJA6k4xAXST53DeRCYKPqoq5+ernZxv/CRoI=; b=JsqEU5e7txrzxBA6z
 MgD4TF+HR8X8ng9ZIQQDMpoZGSc2+K8J4beSwbAkFOXoIzdJNwMqUVLLjHx1e6vv
 JaJNqAaSHQf/FWGLCfUaGrBiebYXCzukJ/QewMiF2gaHApIZ8zZBCzhpeuiPcqju
 7bvnMFlRhzrif8WmmWtVZIfhPdJqSQHmK8aLaFTzbhBwRIBemzL9s05a4obBUX2B
 cHvdwk7ZyWSPqBBcZXH11vww1MiEP05li53yw5zjxF7EGps173HLqqTYgscZClfO
 ovqbRll1uO7SsSobwspxtBI2XJtpHxvOueW3F8c/BrzqxGSBcJUIsHpLH8rueoV0
 e9ZoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 460cebn0fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:12:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:12:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:12:13 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id B16A167398;
 Tue, 15 Apr 2025 05:12:10 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 09/12] node: add IP6 FIB route add
Date: Tue, 15 Apr 2025 17:40:49 +0530
Message-ID: <20250415121052.1497155-10-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZD5wtgL2-FtxF9vCKBnRhOfM-nA425IR
X-Authority-Analysis: v=2.4 cv=UJfdHDfy c=1 sm=1 tr=0 ts=67fe4d1e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZD5wtgL2-FtxF9vCKBnRhOfM-nA425IR
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

Adds a public function to add IP6 route to FIB. The applications should
call this function to add IP6 routes to FIB.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip6_lookup_fib.c   | 34 ++++++++++++++++++++++++++++++++++
 lib/node/rte_node_ip6_api.h | 19 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 317cb53d7b..caf3e9d1fa 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -2,6 +2,9 @@
  * Copyright(C) 2025 Marvell.
  */
 
+#include <arpa/inet.h>
+
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_ether.h>
 #include <rte_fib6.h>
@@ -37,6 +40,37 @@ static struct ip6_lookup_fib_node_main ip6_lookup_fib_nm;
 #define IP6_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
 	(((struct ip6_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_route_add, 25.07)
+int
+rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
+			   enum rte_node_ip6_lookup_next next_node)
+{
+	char abuf[INET6_ADDRSTRLEN];
+	uint8_t socket;
+	uint32_t val;
+	int ret;
+
+	inet_ntop(AF_INET6, ip, abuf, sizeof(abuf));
+	/* Embedded next node id into 24 bit next hop */
+	val = ((next_node << 16) | next_hop) & ((1ull << 24) - 1);
+	node_dbg("ip6_lookup_fib", "FIB6: Adding route %s / %d nh (0x%x)", abuf, depth, val);
+
+	for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++) {
+		if (!ip6_lookup_fib_nm.fib6[socket])
+			continue;
+
+		ret = rte_fib6_add(ip6_lookup_fib_nm.fib6[socket], ip, depth, val);
+		if (ret < 0) {
+			node_err("ip6_lookup_fib",
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
 setup_fib6(unsigned int socket)
 {
diff --git a/lib/node/rte_node_ip6_api.h b/lib/node/rte_node_ip6_api.h
index 2875bc981a..e6f997a9c5 100644
--- a/lib/node/rte_node_ip6_api.h
+++ b/lib/node/rte_node_ip6_api.h
@@ -71,6 +71,25 @@ __rte_experimental
 int rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			     uint8_t rewrite_len, uint16_t dst_port);
 
+/**
+ * Add IPv6 route to FIB.
+ *
+ * @param ip
+ *   IPv6 address of route to be added.
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
+int rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
+			       enum rte_node_ip6_lookup_next next_node);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

