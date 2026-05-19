Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC174CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D6C40665;
	Tue, 19 May 2026 11:31:57 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 517F340612
 for <dev@dpdk.org>; Tue, 19 May 2026 11:31:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvR53Y7zHnH88
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 356EF40570
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:53 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 04/25] bpf/validate: expand comments in evaluate cycle
Date: Tue, 19 May 2026 10:31:07 +0100
Message-ID: <20260519093131.52022-5-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519093131.52022-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
 <20260519093131.52022-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Logic of execution tree traversal is not 100% obvious, and had some bugs
in the past. Add and expand comments to clarify what `next` and `node`
variables are supposed to point to at various points of the cycle.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 lib/bpf/bpf_validate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 1619faf360..362d00c770 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2449,6 +2449,7 @@ evaluate(struct bpf_verifier *bvf)
 		 * each node only once.
 		 */
 		if (next != NULL) {
+			/* just started or stepped down the tree, node == next */
 
 			bvf->evin = node;
 			idx = get_node_idx(bvf, node);
@@ -2481,8 +2482,10 @@ evaluate(struct bpf_verifier *bvf)
 		next = get_next_node(bvf, node);
 
 		if (next != NULL) {
-
-			/* proceed with next child */
+			/*
+			 * proceed with next child
+			 * next points to an unwalked subtree of node
+			 */
 			if (node->cur_edge == node->nb_edge &&
 					node->evst.cur != NULL) {
 				restore_cur_eval_state(bvf, node);
@@ -2514,6 +2517,11 @@ evaluate(struct bpf_verifier *bvf)
 
 			/* first node will not have prev, signalling finish */
 		}
+
+		/*
+		 * next != NULL: stepped down the tree, node == next;
+		 * next == NULL: stepped up after processing or pruning subtree;
+		 */
 	}
 
 	RTE_LOG(DEBUG, BPF, "%s(%p) returns %d, stats:\n"
-- 
2.43.0

