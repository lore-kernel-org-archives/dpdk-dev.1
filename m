Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC50C83F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 10:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44D094025A;
	Fri, 25 Jul 2025 12:22:02 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by mails.dpdk.org (Postfix) with ESMTP id 8E5E9400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 12:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=N8
 OHUVmBPXxuGnaWyw+w/5TxI8wYIDSJVfdnUE7skAI=; b=qHb6WQb3Ue8ym6YuHr
 Nl8MK5aKV+NnID8ecxFKKkKFVHQB+GHndGvhN8sez+iaf8k6XsbM6OKwgYRzqm89
 SmMXwcZIF9KcoGoFkeWisIe30hjPAJCZT39g2tmLr3GVFnh5hDiI/N5Xq4WAmV08
 Z+p4z2aLDJ9KJr33Ftqm08aMo=
Received: from localhost.localdomain.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCnEe7CWoNoywFhHQ--.65101S2; 
 Fri, 25 Jul 2025 18:21:55 +0800 (CST)
From: Huichao Cai <chcchc88@163.com>
To: konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org
Subject: [PATCH] acl: fix the value of the trans table
Date: Fri, 25 Jul 2025 18:21:51 +0800
Message-Id: <20250725102151.6677-1-chcchc88@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnEe7CWoNoywFhHQ--.65101S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrZw1DAr43CFykZr4fKrg_yoWDAwb_CF
 18Kr1SgFWUJF1Iqws5ua48K34xX3yFvF4fAry3GFsI93y7J3yrW392kwn8Xr9rGrW5C398
 try7Wrs3K34qvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbsjjPUUUUU==
X-Originating-IP: [124.127.58.137]
X-CM-SenderInfo: pfkfuxrfyyqiywtou0bp/1tbiUhSUF2iCVW9uwwABs5
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

The node_array[RTE_ACL_DFA_SIZE] is assigned to
RTE_ACL_IDLE_NODE and is used as a node of
RTE_ACL_NODE_SINGLE type, but it is currently based
on the implementation of idle arrays with a value of all
0 to point to itself, which is unsafe, if the value of the
idle array is not 0, it will produce undefined behavior,
so it needs to be given node_array[RTE_ACL_DFA_ SIZE]
plus RTE_ACL_QUAD_SINGLE.

Signed-off-by: Huichao Cai <chcchc88@163.com>
---
 lib/acl/acl_gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
index 3c53d24056..95c7888162 100644
--- a/lib/acl/acl_gen.c
+++ b/lib/acl/acl_gen.c
@@ -497,7 +497,7 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 	 * highest index, that points to itself)
 	 */
 
-	node_array[RTE_ACL_DFA_SIZE] = RTE_ACL_IDLE_NODE;
+	node_array[RTE_ACL_DFA_SIZE] = RTE_ACL_QUAD_SINGLE | RTE_ACL_IDLE_NODE;
 
 	for (n = 0; n < RTE_ACL_DFA_SIZE; n++)
 		node_array[n] = no_match;
-- 
2.27.0

