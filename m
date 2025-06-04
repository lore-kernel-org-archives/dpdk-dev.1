Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0709C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87B87427CD;
	Wed,  4 Jun 2025 12:13:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 613254042E
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:13:12 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553NTetJ005496;
 Wed, 4 Jun 2025 03:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 n2deiwZY1sVSEx4mOJZOIeQJ216XEHK4ZwZTyjvKDY=; b=Nj8YkTo9FvkRmhT/f
 UNNYFo0rAh6Mf9OyZ6kCOCXYMm0MwFJr8KJrDp/OW5KrzRiozjfYRjz1P0vLFuA7
 yeeW9mirmaJmMJMP86A3Ey6jmcNU+7PheSnFPHkkbvQSQVi5QduhtYcm3LECyQ0K
 nDDjBAwQS40OP4TVCO4IT95ehfQh/mGOnOnQmMoqJBOYs+Fs4d1UH5RYcLxrNcDN
 7/Kq7Br1Qie9q21Mdrfg7cXW0j+Kxb4bvCDzEHb+Oykf9tdIpb8wknFveZcWmFR9
 jz3kWRAixfqh1/ZUwEuQcwSDQAKpCTQTO7l6gjksnRkht7ihreaKfVjpApZvse7L
 Tkx7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 472as414nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 03:13:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 03:13:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Jun 2025 03:13:06 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id CAEA33F7080;
 Wed,  4 Jun 2025 03:13:03 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v10 1/7] graph: add API to override node process function
Date: Wed, 4 Jun 2025 15:42:28 +0530
Message-ID: <20250604101259.4181992-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604101259.4181992-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3NiBTYWx0ZWRfX+bsUbuaXu28K
 KqiEarX4+WwCSlSjF+DdI739GegYJlHFEzW6BdET3qNvUAg0o2qHQC3W6WUo3jDY+psj//IeCL1
 TT2TJne22jjO57lhiH5wSxxZbQbuWfA7bQTpgCs5bLJfncrtGhtvl/6bIoeIqzgdyF5UPo5Snmm
 Gsif55iKqp/ouvpFfLA2zmhZ1rFdK/5p/D0BmmlTbpFvMzWCzkLyURo6Glp9aufOLDdxFpjBi0C
 WvRWMy3O23x9JzCso5+bCacOuJncufZhqfDIJhyTyp0i3MpXYhw0ysYgaDSaCmQsxc6v1CB0nma
 SNPgPuI8J7CXYnpS/1cov4i88ITrqdUcWgEJo8VbWoOyXLkGgGp6vkUz8ohqKlKFMJzl/lZffLh
 ysY0d968wJKFMeFHciH7ZUtuRMF0B545YBW4KvpmJlfShPn5H8J6atRmvIGW58ms21VoXvT2
X-Proofpoint-GUID: wKSLiTChcl4R1Wy-cpoAgSc1bT_v2Mvk
X-Proofpoint-ORIG-GUID: wKSLiTChcl4R1Wy-cpoAgSc1bT_v2Mvk
X-Authority-Analysis: v=2.4 cv=It4ecK/g c=1 sm=1 tr=0 ts=68401c33 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=NNYphpjPKiaEgiTtL0AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
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

New internal API used by feature arc library to override node's original
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

