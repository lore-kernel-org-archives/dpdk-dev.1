Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09266C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F88340665;
	Fri,  9 May 2025 08:46:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6372F40659
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:59 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIha4003978;
 Thu, 8 May 2025 23:45:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 vCEz1DgB2/SfzLOr4mk51Or0qbIv/1O63+2uWKuYmA=; b=CEvZvz/o/oJtkMFIU
 9VMZ4GAviaj3J+JDiLq5csbmH28m3B7sKAvFaY3rwOCbPAdOwH9A8JSVtRkv28v5
 ecM5ugrQaJAmjdOOcZKAJne5ZVXtfFBJV93g9wPkn7xrDPrrX77E4Hpolf6Ix6VJ
 TReJ9CzVSe6dP8cAObcBrz1b/7toiaO8WFlrhidfEjjKd9SJNOwaM0a6wiNEwXHb
 mZCwCves3H66pg9DNJhJTAgdXNqB44rhDa2w1oaLcsa4G6BEgDpIWKFvqQkCNm9Y
 aQOKyaB9w+yG5wHIKC71UiIyMkeD0pkP08gBJzN8gBdBYhaV5rmIXFQv39UGX6tb
 Uo4+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0pat-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id CD68C3F704F;
 Thu,  8 May 2025 23:45:54 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 10/13] node: add IP6 FIB route add
Date: Fri, 9 May 2025 12:14:45 +0530
Message-ID: <20250509064448.724019-11-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681da4a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfXySto042AY+85
 CNIUOAWgPiNeyZ/G/xs4wlD2fLhiCdePCwD3DNjQu5Tfxhk7YVp1Nzup9tF5k03vtxziiz/8N9z
 ipmWKnu2s7H8Tb5u8MsdmoWpOWYK3Qim9UT7AZNVnydGGuCj1n+QKqLtv6iChTGfA7+OHHXvetd
 PVGrO+QytJEUBxzhnlDTOT7vt9KdGispAcPgY/a8cXCCP95Q6whtL8Ad+wSVtsn1KcGGFhPOzZm
 /N5xprqH6A3d1nNI2Rv2lpVrmpHNsBJsxE09fVSnSNERkWMOwUJqpTu69y4q7wnz6uQEYpwXUNF
 7Nv1I5E39kvMFyfcYgHvsm2h/p98PSnKWCevdOqmXJ/5FZaIBAmPDtgecZbTiP9/K1dminSKzOO
 OHJGrYRwrs5GjrygMiLWfVBMKPz1niyJY7VZtwo9+ABMEg7qO+nTZIHG15D4Uuk2ZMZcdTJ3
X-Proofpoint-GUID: fyX11oVGSojxeRkzhBWk377Pf3EdVM-J
X-Proofpoint-ORIG-GUID: fyX11oVGSojxeRkzhBWk377Pf3EdVM-J
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

Adds a public function to add IP6 route to FIB. The applications should
call this function to add IP6 routes to FIB.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip6_lookup_fib.c   | 35 +++++++++++++++++++++++++++++++++++
 lib/node/rte_node_ip6_api.h | 19 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index a4f9f53644..b510452ad8 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -2,6 +2,8 @@
  * Copyright(C) 2025 Marvell.
  */
 
+#include <arpa/inet.h>
+
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_ether.h>
@@ -58,6 +60,39 @@ rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_route_add, 25.07)
+int
+rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
+			   enum rte_node_ip6_lookup_next next_node)
+{
+	char abuf[INET6_ADDRSTRLEN];
+	unsigned int nb_sockets;
+	uint8_t socket;
+	uint32_t val;
+	int ret;
+
+	nb_sockets = rte_socket_count();
+	inet_ntop(AF_INET6, ip, abuf, sizeof(abuf));
+	/* Embedded next node id into 24 bit next hop */
+	val = ((next_node << 16) | next_hop) & ((1ull << 24) - 1);
+	node_dbg("ip6_lookup_fib", "FIB6: Adding route %s / %d nh (0x%x)", abuf, depth, val);
+
+	for (socket = 0; socket < nb_sockets; socket++) {
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
 setup_fib6(int socket)
 {
diff --git a/lib/node/rte_node_ip6_api.h b/lib/node/rte_node_ip6_api.h
index 1d2b190724..31089b35fc 100644
--- a/lib/node/rte_node_ip6_api.h
+++ b/lib/node/rte_node_ip6_api.h
@@ -86,6 +86,25 @@ int rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 __rte_experimental
 int rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf);
 
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

