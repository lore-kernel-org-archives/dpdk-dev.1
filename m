Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5528C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A116D4060A;
	Fri,  9 May 2025 08:45:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 392464060B
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:17 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5496XpX2031222;
 Thu, 8 May 2025 23:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 zN7ydV2H6iCMt2rBh8hjF76qjt2fAhPPLxX8AlwEtE=; b=Kltip1bX24PhWKgGC
 3r5MSAhi7p0cQCpenQt2MwbPVjbTcsR0zMc4bGvriQPt5U157t8Mdots5K5oX5vy
 i1sCSjDsusp+cqvobkDR0I4BTuH0V42th39EHJ4trVXXOJGF9++IyT/lI5075CQJ
 Xo7E8ylVSgrYshBIbb3GmJADs5c2NmVPdsOV3MJkReN0q7+DDPF+wz/G3F13vKrO
 ZMexv1fplwi53ZvV6Oiyb+Dp2935bia5PTayiFSbyfpsokHB/qEppQQMg5hYzvqH
 e4vKCnZFeUa+0lo0vyAxfxGE0vF87dkycybLd9UsonWezd44phu7j8lnbrl9MT3j
 k01xA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46hcg080s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:14 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id A308A3F7063;
 Thu,  8 May 2025 23:45:11 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 03/13] node: add IP4 FIB route add
Date: Fri, 9 May 2025 12:14:38 +0530
Message-ID: <20250509064448.724019-4-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pNuucOrohzppOweoaN8x3_w1-c_MUfLG
X-Proofpoint-ORIG-GUID: pNuucOrohzppOweoaN8x3_w1-c_MUfLG
X-Authority-Analysis: v=2.4 cv=BaPY0qt2 c=1 sm=1 tr=0 ts=681da47c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX1OHGDYRMt7lK
 yQORr1xSKf7FPcjo3oVtwnmSMKYWsi9blEnLBoOsJsQk2dEcm6eIQh2y4JA1+CcIloUotThZcn1
 gT1b9v7otjngBwg1jKgIhbL0z7HUQ7RKGLgFGbv11hZohowtw9B1YQNhto7GrYuB6jzTLfWOWlX
 1yfgPASf0JBiqEbh5Vyb+yvTgkatwNXLs7Q2Ayysmn6JEDBZ9/87JElKDClOA10Wkk8mVFVjmb7
 zSjqlmg8ws3aBZU0IfJzEBu/PNq6gj1hDeWYqlqFyjbsp4Q7YMRoki7KwadayOBXCGQg8XMPt4j
 aAEOr/qSWHjgNUyHmaZVY/Oi3DbgjwL8zIqoU9koxLtbWomxYeW+UNYzmR1R+lODh4RExjM3H8J
 avOgJADdoUn37LUxfn+ZeTlzqmBlW5IJW5X2A+5n+62M5usMedir3wlE4fsk0UMQgjGZmhKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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
 lib/node/ip4_lookup_fib.c   | 37 +++++++++++++++++++++++++++++++++++++
 lib/node/rte_node_ip4_api.h | 19 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 977d97b713..f300266c00 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -2,6 +2,8 @@
  * Copyright(C) 2025 Marvell.
  */
 
+#include <arpa/inet.h>
+
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_ether.h>
@@ -58,6 +60,41 @@ rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
+int
+rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
+			   enum rte_node_ip4_lookup_next next_node)
+{
+	char abuf[INET6_ADDRSTRLEN];
+	unsigned int nb_sockets;
+	struct in_addr in;
+	uint8_t socket;
+	uint32_t val;
+	int ret;
+
+	nb_sockets = rte_socket_count();
+	in.s_addr = htonl(ip);
+	inet_ntop(AF_INET, &in, abuf, sizeof(abuf));
+	/* Embedded next node id into 24 bit next hop */
+	val = ((next_node << 16) | next_hop) & ((1ull << 24) - 1);
+	node_dbg("ip4_lookup_fib", "FIB: Adding route %s / %d nh (0x%x)", abuf, depth, val);
+
+	for (socket = 0; socket < nb_sockets; socket++) {
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
 setup_fib(int socket)
 {
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index 1dac7a4936..4d75c5f874 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -132,6 +132,25 @@ int rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, u
 __rte_experimental
 int rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf);
 
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

