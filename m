Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F5C369BD
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 07:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46DB6402F1;
	Sat, 19 Apr 2025 09:11:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9A4AA400D7
 for <dev@dpdk.org>; Sat, 19 Apr 2025 09:11:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J6i7Jf007810;
 Sat, 19 Apr 2025 00:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 vgyv9E9qbjWVJCl5JRmec70VG5ffsr8DrKSLL8vZtc=; b=Z+PQOfi1Mc86GtjQ3
 M/awxE2rLdyWwuGHIls9FcNb5KSfTUN0aw2+HhcvDtXEqS+/vuySHiw9p9iI0qM8
 MyGRYyp8cD0TJ2JpdGq47hnjvRXBpnfAbvVkGSX+DpAQHNNSvnO+xqPgoDIOH9bD
 kNL0N7q0MD0LkJQQB6eAfD9xm358TsWy3C9c9iupfoosUEzLhZlRryHjwsSnKkNV
 +GT4ZqnAIo8QG3QiE85Qo89PbrbBNedI2BFcSKNKvGU6hTNbql2DlpKsKBIWSzce
 Og0LhhyRaDtLihMNLaGuNZ3UpGgsnjhLYoYb/hKC97V3TRom5pCsEpll3xo7v5lq
 B42/g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4620fdr0rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Apr 2025 00:10:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 00:10:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 00:10:57 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id A2DEB3F71C0;
 Sat, 19 Apr 2025 00:10:53 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v7 1/5] graph: add API to override node process function
Date: Sat, 19 Apr 2025 12:40:41 +0530
Message-ID: <20250419071047.1334983-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419071047.1334983-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250419071047.1334983-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: trClx_ZiUVFvrZl-G1cVL7TgbQvxMwUi
X-Proofpoint-ORIG-GUID: trClx_ZiUVFvrZl-G1cVL7TgbQvxMwUi
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=68034c83 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=NNYphpjPKiaEgiTtL0AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_02,2025-04-17_01,2024-11-22_01
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

