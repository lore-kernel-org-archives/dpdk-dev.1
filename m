Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16EC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF114042C;
	Mon,  2 Jun 2025 08:37:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6FBB6402E1
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:12 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551MEgOf028737;
 Sun, 1 Jun 2025 23:37:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 zN7ydV2H6iCMt2rBh8hjF76qjt2fAhPPLxX8AlwEtE=; b=e0BbVtVdJUR62LlHs
 VFa7LVMJlE8G7Q84kScXfs3M2OQ4/e+cTgXMuy7KaB4An/yIMkTvLHn5pixSiNEu
 u3qzvV5PYvu9ZsCG01osjAVJ64ChYK40eiymDKyjmhhK8uxGBYlS6MVqejlVdYHQ
 7XcLpAduq6PWl5/QfeVnVdV/9WQz5T7IppZ8FHq8wjKxQ8aka9DoIKDdAXdJlBdO
 5w+Tu1ySjQRLA/DcFoGfo/SxLrjwrYsdjgG/+gVi/2ZN+HOkoVbKRX51KQkMaGT6
 rgaMQOWQ3usrvwxqTZnT+ldkHpSMPwYT6Em1rarR9Hm/ZhdrmtpQk4z9ptE3WzET
 ZfzjA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye00n26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:10 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 4A44B3F706C;
 Sun,  1 Jun 2025 23:37:07 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 03/14] node: add IP4 FIB route add
Date: Mon, 2 Jun 2025 12:06:28 +0530
Message-ID: <20250602063639.198550-4-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX7PPySI9u1/Bx
 w2IwYCWsWIEvy/1YqK1v0lCUWjJ792xwyZ6FK2O94Vkj5xAIJwc6gF2hCp873k0wpp2jPLZoXuT
 ZezJkQeork/s2ZAVpPFE2FFmsGg+0BmgWj1U78Zm/7CaaxnCFfmZ3mhCDiDUhtO6+yZ+mMZTtJt
 j8rBrZVegZnYkreiPeuawBXB+LUhV2xVcEQDG/+xZC8wNMoPUfa2/ocZSV8pDMnTWoUPEUjyj6n
 kXo661QqJhwdtYm/QuigCOThWnuQJQzHDN5nb1s39BuUR7jPrMO/4JEIzAkP6UGXupdq+w3ElKr
 xYf4VSA+5DxjStu9q4p25JasSlxe/GDT4tyOo1HxwX/OLrgafDsYN00LsAxk0cLp07t2kdHQV9Y
 czTdh+h3PQ/qXNFdXd7fNfCW763BeYyzk/uO1B4nmHK/VKq1/LGZH/5l5Ncqww624mC+9ded
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d4697 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=KWxuKWQm0HYJUTJt3pUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: NEEZ3gHyaBa-mh2RWYQ3csl_a72PWxML
X-Proofpoint-GUID: NEEZ3gHyaBa-mh2RWYQ3csl_a72PWxML
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

