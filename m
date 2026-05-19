Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13406CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:32:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF2054065F;
	Tue, 19 May 2026 11:31:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id EEE3E40612
 for <dev@dpdk.org>; Tue, 19 May 2026 11:31:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvR2NWjzHnHBL
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id CE42340570
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:52 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 03/25] bpf/validate: break on error in evaluate
Date: Tue, 19 May 2026 10:31:06 +0100
Message-ID: <20260519093131.52022-4-marat.khalili@huawei.com>
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

Evaluation loop previously continued until the cycle end in case of an
evaluation error. It made reasoning about the code difficult since it
might be executing when the evaluation is already in an invalid state.

Change loop logic to break out of the loop immediately after an error.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 lib/bpf/bpf_validate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index bf8a4abb5a..1619faf360 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2401,11 +2401,11 @@ prune_eval_state(struct bpf_verifier *bvf, const struct inst_node *node,
 static int
 evaluate(struct bpf_verifier *bvf)
 {
-	int32_t rc;
 	uint32_t idx, op;
 	const char *err;
 	const struct ebpf_insn *ins;
 	struct inst_node *next, *node;
+	int rc = 0;
 
 	struct {
 		uint32_t nb_eval;
@@ -2439,11 +2439,10 @@ evaluate(struct bpf_verifier *bvf)
 	ins = bvf->prm->raw.ins;
 	node = bvf->in;
 	next = node;
-	rc = 0;
 
 	memset(&stats, 0, sizeof(stats));
 
-	while (node != NULL && rc == 0) {
+	while (node != NULL) {
 
 		/*
 		 * current node evaluation, make sure we evaluate
@@ -2457,17 +2456,20 @@ evaluate(struct bpf_verifier *bvf)
 
 			/* for jcc node make a copy of evaluation state */
 			if (node->nb_edge > 1) {
-				rc |= save_cur_eval_state(bvf, node);
+				rc = save_cur_eval_state(bvf, node);
+				if (rc < 0)
+					break;
 				stats.nb_save++;
 			}
 
-			if (ins_chk[op].eval != NULL && rc == 0) {
+			if (ins_chk[op].eval != NULL) {
 				err = ins_chk[op].eval(bvf, ins + idx);
 				stats.nb_eval++;
 				if (err != NULL) {
 					RTE_BPF_LOG_FUNC_LINE(ERR,
 						"%s at pc: %u", err, idx);
 					rc = -EINVAL;
+					break;
 				}
 			}
 
-- 
2.43.0

