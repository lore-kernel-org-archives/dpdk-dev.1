Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F284C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C0140A75;
	Tue,  3 Jun 2025 13:50:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6D6C640B90
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:49 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AIXno018117
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 3cWalysGJXc1vVfGlj7qR7/kJX/LBZYkjYzA18yDGc=; b=MLRYdFFg4yc0Tj4Z5
 hfu1WypHMJYK+4JYT0p/uvBb4RPsfBIwzRF1GWuIfBsqBVBMsjw6XqfOR0KVrSh8
 7pyjXPY323qaaAfpYvAing5ebM9QIc+u/3Cd4gB2VGRI5s1WWaQZjBn53rFNCifb
 zOBxDZuJSaLreGHMx7FtaySflTe5azHlTCr6gsOVITqIfVAnOsyRTYb+Ka+3idK3
 hdwr9kSe6JsD9xFfwmc04BUynsqqZJ6tzefd4zPWqvrh6niClFeA/XNih7t2GoUW
 SU/lEdoz3O9z5e+yXxCw8YOssnI2Ko+mM7yWb5mPkYa/+QeeUT3iQTdzc/sDShL4
 rqtSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471y6304dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:47 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id BB1B73F704B;
 Tue,  3 Jun 2025 04:50:45 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 08/25] crypto/cnxk: move debug dumps to common
Date: Tue, 3 Jun 2025 17:20:09 +0530
Message-ID: <20250603115026.2664706-9-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX1QuDNcD4BOLE
 hHBiuoymFM3g4yRHMPd4gsNIdLvmDVWwI3Kqo2SfU7AZZOGJgRpMo6HrWm+OOji0jn8WMfc7HzO
 cjIicwvQ53YhOl9RW3OW54WFZd2/FCjBmHxKY1lP6rH1L8bfbnxIF8mrIpIMwepeA/1xPNnGYGA
 PY0wGyTH4k+XASpfB6k8rQbhL4os9KILPy2ofLmBwoe0N3c4uilujoR1VVrasf48y3F2CJkgXPR
 j7CJohPl8qLnAoYrEVns51D4Gr4/ytnWkBTxEiVQ89yOaeAcObpV00pMpIJfRFmvBV4hD2EY83H
 +LbTHKZTP1TCEZRfZyePbXEmDSuyMDQgTbwG/wUU3IVGgNI7pU++y+0EJ0A/Fx0jm5wRU9FxIEC
 XPSOxZ36zF03EfSZ6R7xGavGjOioHFcAFcffSFnbCtiYv0sP+/jgb3HIi1FwvqEC5HuB8lpa
X-Proofpoint-GUID: my3fbfr3xKQvwdTPu7zGJL0hi6kOzXqb
X-Authority-Analysis: v=2.4 cv=QaJmvtbv c=1 sm=1 tr=0 ts=683ee198 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=8BhNfBrQ-ihCWAvsCRwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: my3fbfr3xKQvwdTPu7zGJL0hi6kOzXqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Move the crypto instruction dumps to common

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 125 +++-------------------
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |   7 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 101 +++++++++++++++++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |   6 ++
 4 files changed, 126 insertions(+), 113 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 947f50b4c8..9ad0629519 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -98,104 +98,6 @@ cpt_sec_ipsec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 	return ret;
 }
 
-#ifdef CPT_INST_DEBUG_ENABLE
-static inline void
-cpt_request_data_sgv2_mode_dump(uint8_t *in_buffer, bool glist, uint16_t components)
-{
-	struct roc_se_buf_ptr list_ptr[ROC_MAX_SG_CNT];
-	const char *list = glist ? "glist" : "slist";
-	struct roc_sg2list_comp *sg_ptr = NULL;
-	uint16_t list_cnt = 0;
-	char suffix[64];
-	int i, j;
-
-	sg_ptr = (void *)in_buffer;
-	for (i = 0; i < components; i++) {
-		for (j = 0; j < sg_ptr->u.s.valid_segs; j++) {
-			list_ptr[i * 3 + j].size = sg_ptr->u.s.len[j];
-			list_ptr[i * 3 + j].vaddr = (void *)sg_ptr->ptr[j];
-			list_ptr[i * 3 + j].vaddr = list_ptr[i * 3 + j].vaddr;
-			list_cnt++;
-		}
-		sg_ptr++;
-	}
-
-	printf("Current %s: %u\n", list, list_cnt);
-
-	for (i = 0; i < list_cnt; i++) {
-		snprintf(suffix, sizeof(suffix), "%s[%d]: vaddr 0x%" PRIx64 ", vaddr %p len %u",
-			 list, i, (uint64_t)list_ptr[i].vaddr, list_ptr[i].vaddr, list_ptr[i].size);
-		rte_hexdump(stdout, suffix, list_ptr[i].vaddr, list_ptr[i].size);
-	}
-}
-
-static inline void
-cpt_request_data_sg_mode_dump(uint8_t *in_buffer, bool glist)
-{
-	struct roc_se_buf_ptr list_ptr[ROC_MAX_SG_CNT];
-	const char *list = glist ? "glist" : "slist";
-	struct roc_sglist_comp *sg_ptr = NULL;
-	uint16_t list_cnt, components;
-	char suffix[64];
-	int i;
-
-	sg_ptr = (void *)(in_buffer + 8);
-	list_cnt = rte_be_to_cpu_16((((uint16_t *)in_buffer)[2]));
-	if (!glist) {
-		components = list_cnt / 4;
-		if (list_cnt % 4)
-			components++;
-		sg_ptr += components;
-		list_cnt = rte_be_to_cpu_16((((uint16_t *)in_buffer)[3]));
-	}
-
-	printf("Current %s: %u\n", list, list_cnt);
-	components = list_cnt / 4;
-	for (i = 0; i < components; i++) {
-		list_ptr[i * 4 + 0].size = rte_be_to_cpu_16(sg_ptr->u.s.len[0]);
-		list_ptr[i * 4 + 1].size = rte_be_to_cpu_16(sg_ptr->u.s.len[1]);
-		list_ptr[i * 4 + 2].size = rte_be_to_cpu_16(sg_ptr->u.s.len[2]);
-		list_ptr[i * 4 + 3].size = rte_be_to_cpu_16(sg_ptr->u.s.len[3]);
-		list_ptr[i * 4 + 0].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[0]);
-		list_ptr[i * 4 + 1].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[1]);
-		list_ptr[i * 4 + 2].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[2]);
-		list_ptr[i * 4 + 3].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[3]);
-		list_ptr[i * 4 + 0].vaddr = list_ptr[i * 4 + 0].vaddr;
-		list_ptr[i * 4 + 1].vaddr = list_ptr[i * 4 + 1].vaddr;
-		list_ptr[i * 4 + 2].vaddr = list_ptr[i * 4 + 2].vaddr;
-		list_ptr[i * 4 + 3].vaddr = list_ptr[i * 4 + 3].vaddr;
-		sg_ptr++;
-	}
-
-	components = list_cnt % 4;
-	switch (components) {
-	case 3:
-		list_ptr[i * 4 + 2].size = rte_be_to_cpu_16(sg_ptr->u.s.len[2]);
-		list_ptr[i * 4 + 2].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[2]);
-		list_ptr[i * 4 + 2].vaddr = list_ptr[i * 4 + 2].vaddr;
-		/* FALLTHROUGH */
-	case 2:
-		list_ptr[i * 4 + 1].size = rte_be_to_cpu_16(sg_ptr->u.s.len[1]);
-		list_ptr[i * 4 + 1].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[1]);
-		list_ptr[i * 4 + 1].vaddr = list_ptr[i * 4 + 1].vaddr;
-		/* FALLTHROUGH */
-	case 1:
-		list_ptr[i * 4 + 0].size = rte_be_to_cpu_16(sg_ptr->u.s.len[0]);
-		list_ptr[i * 4 + 0].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[0]);
-		list_ptr[i * 4 + 0].vaddr = list_ptr[i * 4 + 0].vaddr;
-		break;
-	default:
-		break;
-	}
-
-	for (i = 0; i < list_cnt; i++) {
-		snprintf(suffix, sizeof(suffix), "%s[%d]: vaddr 0x%" PRIx64 ", vaddr %p len %u",
-			 list, i, (uint64_t)list_ptr[i].vaddr, list_ptr[i].vaddr, list_ptr[i].size);
-		rte_hexdump(stdout, suffix, list_ptr[i].vaddr, list_ptr[i].size);
-	}
-}
-#endif
-
 static __rte_always_inline int __rte_hot
 cpt_sec_tls_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 		      struct cn10k_sec_session *sess, struct cpt_inst_s *inst,
@@ -305,20 +207,22 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	infl_req->scatter_sz = inst[0].w6.s.scatter_sz;
 	infl_req->opcode_major = inst[0].w4.s.opcode_major;
 
-	rte_hexdump(stdout, "cptr", (void *)(uint64_t)inst[0].w7.s.cptr, 128);
-	printf("major opcode:%d\n", inst[0].w4.s.opcode_major);
-	printf("minor opcode:%d\n", inst[0].w4.s.opcode_minor);
-	printf("param1:%d\n", inst[0].w4.s.param1);
-	printf("param2:%d\n", inst[0].w4.s.param2);
-	printf("dlen:%d\n", inst[0].w4.s.dlen);
+	rte_hexdump(rte_log_get_stream(), "cptr", (void *)(uint64_t)inst[0].w7.s.cptr, 128);
+	plt_err("major opcode:%d", inst[0].w4.s.opcode_major);
+	plt_err("minor opcode:%d", inst[0].w4.s.opcode_minor);
+	plt_err("param1:%d", inst[0].w4.s.param1);
+	plt_err("param2:%d", inst[0].w4.s.param2);
+	plt_err("dlen:%d", inst[0].w4.s.dlen);
 
 	if (is_sg_ver2) {
-		cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1, inst[0].w5.s.gather_sz);
-		cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0, inst[0].w6.s.scatter_sz);
+		cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1,
+						     inst[0].w5.s.gather_sz);
+		cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0,
+						     inst[0].w6.s.scatter_sz);
 	} else {
 		if (infl_req->opcode_major >> 7) {
-			cpt_request_data_sg_mode_dump((void *)inst[0].dptr, 1);
-			cpt_request_data_sg_mode_dump((void *)inst[0].dptr, 0);
+			cnxk_cpt_request_data_sg_mode_dump((void *)inst[0].dptr, 1);
+			cnxk_cpt_request_data_sg_mode_dump((void *)inst[0].dptr, 0);
 		}
 	}
 #endif
@@ -1163,10 +1067,11 @@ cn10k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 	if (likely(compcode == CPT_COMP_GOOD)) {
 #ifdef CPT_INST_DEBUG_ENABLE
 		if (infl_req->is_sg_ver2)
-			cpt_request_data_sgv2_mode_dump(infl_req->rptr, 0, infl_req->scatter_sz);
+			cnxk_cpt_request_data_sgv2_mode_dump(infl_req->rptr, 0,
+							     infl_req->scatter_sz);
 		else {
 			if (infl_req->opcode_major >> 7)
-				cpt_request_data_sg_mode_dump(infl_req->dptr, 0);
+				cnxk_cpt_request_data_sg_mode_dump(infl_req->dptr, 0);
 		}
 #endif
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index c54bdd1f34..b44f747b02 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -4,6 +4,7 @@
 
 #include <cryptodev_pmd.h>
 #include <rte_cryptodev.h>
+#include <rte_hexdump.h>
 
 #include "roc_cpt.h"
 #include "roc_idev.h"
@@ -142,8 +143,8 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	plt_err("param2:%d", inst[0].w4.s.param2);
 	plt_err("dlen:%d", inst[0].w4.s.dlen);
 
-	cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1, inst[0].w5.s.gather_sz);
-	cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0, inst[0].w6.s.scatter_sz);
+	cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1, inst[0].w5.s.gather_sz);
+	cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0, inst[0].w6.s.scatter_sz);
 #endif
 
 	return 1;
@@ -254,7 +255,7 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 
 	if (likely(compcode == CPT_COMP_GOOD)) {
 #ifdef CPT_INST_DEBUG_ENABLE
-		cpt_request_data_sgv2_mode_dump(infl_req->rptr, 0, infl_req->scatter_sz);
+		cnxk_cpt_request_data_sgv2_mode_dump(infl_req->rptr, 0, infl_req->scatter_sz);
 #endif
 
 		if (unlikely(uc_compcode)) {
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 61f3e135aa..b4020f96c1 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -7,6 +7,9 @@
 #include <rte_cryptodev.h>
 #include <cryptodev_pmd.h>
 #include <rte_errno.h>
+#ifdef CPT_INST_DEBUG_ENABLE
+#include <rte_hexdump.h>
+#endif
 #include <rte_security_driver.h>
 
 #include "roc_ae_fpm_tables.h"
@@ -1223,3 +1226,101 @@ rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 
 	return 0;
 }
+
+#ifdef CPT_INST_DEBUG_ENABLE
+void
+cnxk_cpt_request_data_sgv2_mode_dump(uint8_t *in_buffer, bool glist, uint16_t components)
+{
+	struct roc_se_buf_ptr list_ptr[ROC_MAX_SG_CNT];
+	const char *list = glist ? "glist" : "slist";
+	struct roc_sg2list_comp *sg_ptr = NULL;
+	uint16_t list_cnt = 0;
+	char suffix[64];
+	int i, j;
+
+	sg_ptr = (void *)in_buffer;
+	for (i = 0; i < components; i++) {
+		for (j = 0; j < sg_ptr->u.s.valid_segs; j++) {
+			list_ptr[i * 3 + j].size = sg_ptr->u.s.len[j];
+			list_ptr[i * 3 + j].vaddr = (void *)sg_ptr->ptr[j];
+			list_ptr[i * 3 + j].vaddr = list_ptr[i * 3 + j].vaddr;
+			list_cnt++;
+		}
+		sg_ptr++;
+	}
+
+	plt_err("Current %s: %u", list, list_cnt);
+
+	for (i = 0; i < list_cnt; i++) {
+		snprintf(suffix, sizeof(suffix), "%s[%d]: vaddr 0x%" PRIx64 ", vaddr %p len %u",
+			 list, i, (uint64_t)list_ptr[i].vaddr, list_ptr[i].vaddr, list_ptr[i].size);
+		rte_hexdump(rte_log_get_stream(), suffix, list_ptr[i].vaddr, list_ptr[i].size);
+	}
+}
+
+void
+cnxk_cpt_request_data_sg_mode_dump(uint8_t *in_buffer, bool glist)
+{
+	struct roc_se_buf_ptr list_ptr[ROC_MAX_SG_CNT];
+	const char *list = glist ? "glist" : "slist";
+	struct roc_sglist_comp *sg_ptr = NULL;
+	uint16_t list_cnt, components;
+	char suffix[64];
+	int i;
+
+	sg_ptr = (void *)(in_buffer + 8);
+	list_cnt = rte_be_to_cpu_16((((uint16_t *)in_buffer)[2]));
+	if (!glist) {
+		components = list_cnt / 4;
+		if (list_cnt % 4)
+			components++;
+		sg_ptr += components;
+		list_cnt = rte_be_to_cpu_16((((uint16_t *)in_buffer)[3]));
+	}
+
+	plt_err("Current %s: %u", list, list_cnt);
+	components = list_cnt / 4;
+	for (i = 0; i < components; i++) {
+		list_ptr[i * 4 + 0].size = rte_be_to_cpu_16(sg_ptr->u.s.len[0]);
+		list_ptr[i * 4 + 1].size = rte_be_to_cpu_16(sg_ptr->u.s.len[1]);
+		list_ptr[i * 4 + 2].size = rte_be_to_cpu_16(sg_ptr->u.s.len[2]);
+		list_ptr[i * 4 + 3].size = rte_be_to_cpu_16(sg_ptr->u.s.len[3]);
+		list_ptr[i * 4 + 0].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[0]);
+		list_ptr[i * 4 + 1].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[1]);
+		list_ptr[i * 4 + 2].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[2]);
+		list_ptr[i * 4 + 3].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[3]);
+		list_ptr[i * 4 + 0].vaddr = list_ptr[i * 4 + 0].vaddr;
+		list_ptr[i * 4 + 1].vaddr = list_ptr[i * 4 + 1].vaddr;
+		list_ptr[i * 4 + 2].vaddr = list_ptr[i * 4 + 2].vaddr;
+		list_ptr[i * 4 + 3].vaddr = list_ptr[i * 4 + 3].vaddr;
+		sg_ptr++;
+	}
+
+	components = list_cnt % 4;
+	switch (components) {
+	case 3:
+		list_ptr[i * 4 + 2].size = rte_be_to_cpu_16(sg_ptr->u.s.len[2]);
+		list_ptr[i * 4 + 2].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[2]);
+		list_ptr[i * 4 + 2].vaddr = list_ptr[i * 4 + 2].vaddr;
+		[[fallthrough]];
+	case 2:
+		list_ptr[i * 4 + 1].size = rte_be_to_cpu_16(sg_ptr->u.s.len[1]);
+		list_ptr[i * 4 + 1].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[1]);
+		list_ptr[i * 4 + 1].vaddr = list_ptr[i * 4 + 1].vaddr;
+		[[fallthrough]];
+	case 1:
+		list_ptr[i * 4 + 0].size = rte_be_to_cpu_16(sg_ptr->u.s.len[0]);
+		list_ptr[i * 4 + 0].vaddr = (void *)rte_be_to_cpu_64(sg_ptr->ptr[0]);
+		list_ptr[i * 4 + 0].vaddr = list_ptr[i * 4 + 0].vaddr;
+		break;
+	default:
+		break;
+	}
+
+	for (i = 0; i < list_cnt; i++) {
+		snprintf(suffix, sizeof(suffix), "%s[%d]: vaddr 0x%" PRIx64 ", vaddr %p len %u",
+			 list, i, (uint64_t)list_ptr[i].vaddr, list_ptr[i].vaddr, list_ptr[i].size);
+		rte_hexdump(rte_log_get_stream(), suffix, list_ptr[i].vaddr, list_ptr[i].size);
+	}
+}
+#endif
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 6ad52ec13e..417b869828 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -157,6 +157,12 @@ int cnxk_cpt_queue_pair_event_error_query(struct rte_cryptodev *dev, uint16_t qp
 
 uint32_t cnxk_cpt_qp_depth_used(void *qptr);
 
+#ifdef CPT_INST_DEBUG_ENABLE
+void cnxk_cpt_request_data_sg_mode_dump(uint8_t *in_buffer, bool glist);
+
+void cnxk_cpt_request_data_sgv2_mode_dump(uint8_t *in_buffer, bool glist, uint16_t components);
+#endif
+
 static __rte_always_inline void
 pending_queue_advance(uint64_t *index, const uint64_t mask)
 {
-- 
2.25.1

