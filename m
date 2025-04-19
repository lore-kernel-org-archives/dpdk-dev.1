Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F4C369BD
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 10:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B4A402F1;
	Sat, 19 Apr 2025 12:11:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BF3D940156
 for <dev@dpdk.org>; Sat, 19 Apr 2025 12:11:41 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J9oolG010043;
 Sat, 19 Apr 2025 03:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 vgyv9E9qbjWVJCl5JRmec70VG5ffsr8DrKSLL8vZtc=; b=ZIBZVvXpE31ESttL4
 6GtSy2wzt6853NXksd/ZNcJhdg+PGCQvt9HX8kVwQinFph4Rvpn8z5npeKCD8bbr
 VpNDTWN6i5E3ReuR/lGg7PzspENjEfJkutEq1gM/+XpRUGe+dSs1zpJQpVHMcOdd
 foYH5l1dKVrJGC/169k/C/bXjVF2yU6qScjOoY2od2tA0eEaEOhRMyzfLvyhxB1O
 AP6wNxFL5ywi5e1vgsNKRcjo50plxhFFeh0V4EcKYuab5Lh5qoOonZ/6gUbqLcyf
 GWUSF7j6NGa92xb2y7lKVFfrb1ppJIi5d/A62+RdWQYjsH7hkUxSE+YA2Bj0z7fs
 UwAqg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 463gjna3wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Apr 2025 03:11:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 03:11:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 03:11:36 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id A77BF5E6891;
 Sat, 19 Apr 2025 03:11:33 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v8 1/5] graph: add API to override node process function
Date: Sat, 19 Apr 2025 15:41:18 +0530
Message-ID: <20250419101124.1410233-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419101124.1410233-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250419101124.1410233-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bKQWIO+Z c=1 sm=1 tr=0 ts=680376d9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=NNYphpjPKiaEgiTtL0AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aQ_oA8qMmkqgOrUyqXZp2ZdozBsNorQe
X-Proofpoint-ORIG-GUID: aQ_oA8qMmkqgOrUyqXZp2ZdozBsNorQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
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

New API used by feature arc library to override node's original
process() func.

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 lib/graph/graph_private.h | 11 +++++++++++
 lib/graph/node.c          | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 813dd78b9d..579546e658 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -198,6 +198,17 @@ struct node_head *node_list_head_get(void);
  */
 struct node *node_from_name(const char *name);

+/**
+ * @internal
+ *
+ * Override process func of a node.
+ *
+ * @return
+ *   - 0: Success.
+ *   - <0: Error
+ */
+int node_override_process_func(rte_node_t id, rte_node_process_t process);
+
 /* Graph list functions */
 STAILQ_HEAD(graph_head, graph);

diff --git a/lib/graph/node.c b/lib/graph/node.c
index 101981ec24..c8a1cd5586 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -431,3 +431,26 @@ rte_node_max_count(void)
 {
 	return node_id;
 }
+
+int
+node_override_process_func(rte_node_t id, rte_node_process_t process)
+{
+	struct node *node;
+
+	NODE_ID_CHECK(id);
+	graph_spinlock_lock();
+
+	STAILQ_FOREACH(node, &node_list, next) {
+		if (node->id == id) {
+			node->process = process;
+			graph_spinlock_unlock();
+			return 0;
+		}
+	}
+
+	graph_spinlock_unlock();
+
+	return 0;
+fail:
+	return -1;
+}
--
2.43.0

