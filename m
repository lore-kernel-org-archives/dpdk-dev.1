Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C78C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E0584042C;
	Mon,  2 Jun 2025 08:37:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 67A794026B
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:55 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jKMR014482;
 Sun, 1 Jun 2025 23:37:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 vCEz1DgB2/SfzLOr4mk51Or0qbIv/1O63+2uWKuYmA=; b=GCPcdDM5QUCHCgMty
 M0D9HVyPsa11DeyVyJNeo3NWs7D0lby6DgHTfauEp3xWYhlvu6Sq39QUO0BWo1xf
 G0BWSTpomM3aW3y+UbuaRQ8Xy05wY7g1VU9aEtGVdKyeCw4XFwwyKQxRj1kXRbuO
 ypPBlqEnt2VoDxFKTzOdWeIMIRuWswkmCu/P42kknOvwC0csetVYW2+7MlrBwbSY
 WK80tRSt1IC3K7q2qaRmAwRAkvzXTmCOIW4I7gsphIyH3SlfRCToACnkPqoab4pM
 Ufc0s2ZYesPyjn05Utxa+q1v5RP7y6ygaLe0tlgRQ5Ref2zQ4/Q57rCALXKwp+Gy
 pRpXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa1ta6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:51 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 7EAE93F704B;
 Sun,  1 Jun 2025 23:37:48 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 10/14] node: add IP6 FIB route add
Date: Mon, 2 Jun 2025 12:06:35 +0530
Message-ID: <20250602063639.198550-11-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d46c2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9595PLp9pgbW6rTsj0_b9JVNOuVugIOV
X-Proofpoint-GUID: 9595PLp9pgbW6rTsj0_b9JVNOuVugIOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX2Gw1EOD+k5jf
 Z4T4qYgwm/MoaAUhjREeYQ4c013oH6D4MPr4xXuhYAxVlUJ5RBHROcgk5GqYdoQF3YYEkUjzOs7
 lzCyTP3rd8B1oSdfES89PqBRxN6KyaqprjhyPPubfoCoGIpXoYZp3aBR9gUY7mVFuo9r7pVHYs+
 P4ssH6hsWY3vbBQ2poz2R7glq++E2y6jiz29kCRKIe8wejAnA3jNIrxIX+P5FMXniT0c7rxo6d5
 5lO2zmTgIGmlPKPPTNfiuH0R493PBrD87jvAEVzezH5wlyMunoBVS8UqXINjBjGbJ4w07GaisDC
 wVID8r6sENnOIwQnCvridkOwkHm3L5g81Rg2OUhq3aRy0/ngAQ5Qia+et0U/d+UE3CJJc0647PW
 RHGDRgaxi0CJKqOgzeHeE113g8IyVKiYlH9YPmkHEpeCVW5iY2cagoPUhaCRDnAnySXvqyOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

