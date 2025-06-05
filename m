Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B328C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 17:33:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0649B40615;
	Thu,  5 Jun 2025 19:33:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 62DE740150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 19:33:29 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5553uHTZ023744;
 Thu, 5 Jun 2025 10:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 8qpr4rJy2OZ8r6gmqk/jecJb91LRoAK8bRpCu+2QEQ=; b=TS5SbAvN0XvAKqK2r
 WjYjkc9sVqQsnnJ12dpOnB4ChD5y5Ub7yCQ4TQ1EQ9JOiMpqIQMSCNytpY+lvI6V
 6xUk/RAKt1NAAKrgYYxjPdIMMKY3MZnKlkTveBDHwJHWexdw4ie/7nsH1VYgwr4w
 CYXbzDEWoK9JnC5AU3ahEdzvm9Vr9ZP7YmONYMc77FqJvLgF9YRrHBGTwlMblhq9
 t2L1lSxlMimF1HyvxoQQSG5ud1Ey1kcwWhPSIqJTrbZH/OJ6WLDQ/VcGiO6AHCcP
 ZezPm7zehATwx1O5T+K3OBlUqDWDqCmS8omUfaeIYbgTVufuHk0h0PKM37M7C4DT
 bRWPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472yurt4jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 10:33:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 10:33:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 10:33:22 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id B4B483F7044;
 Thu,  5 Jun 2025 10:33:19 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v12 1/7] graph: add API to override node process function
Date: Thu, 5 Jun 2025 23:03:06 +0530
Message-ID: <20250605173315.1447003-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605173315.1447003-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YuQPR5YX c=1 sm=1 tr=0 ts=6841d4e3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=NNYphpjPKiaEgiTtL0AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: C_FOoruaBoCHSAfeZ8Li-KQQlW59kIDb
X-Proofpoint-ORIG-GUID: C_FOoruaBoCHSAfeZ8Li-KQQlW59kIDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1NSBTYWx0ZWRfXzfI8Rp99bvVI
 GIip53wJSi78LNa9pIsHqWKF7dIBb9Ycz3/O74mXxxsWLYyYc5r9kwknWHgxGcRjwmKu6+pF53e
 VJTe/CEYPXzT7rmbJ8GitU7sEABw+KhsBBkvzoIvKW3sKNv4ybNm8RY0wKRB6FM1cxSLcWMhpAk
 /5xD9AcETu6u1o0rhuwlYUWJPaZZr++wcwaUpl8gtJl6x1FBN3J42SV7Ae8gKiOJDwcr9VRj8TJ
 JqOPyOE/FTiK8ycI9Z+B3sqou12keERKqwHhHHrpxrYre4xp/mmxTbTXrNJuZMCgzcGv6LEQMKT
 fAa8KFtV0vRw5B/b2eKDDYdtEAtsPwxZ0SxwD5xp3JrqBMKyK6F5FjYLUwbQGhA5Ikc/mRZgxjX
 EkfVHoDPrdT1DvaSbS3eZhexVrVu6H3it6x2BIkTHkuzYlfEu2/9v79o/mOcuU/ngkL9PLVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
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
 lib/graph/node.c          | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 101981ec24..be53c701c7 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -431,3 +431,25 @@ rte_node_max_count(void)
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
+fail:
+	return -1;
+}
--
2.43.0

