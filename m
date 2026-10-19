Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B08FCCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5A2E4067B;
	Mon, 19 Oct 2026 15:08:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0AFA14064F
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:06 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8ON62242493 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 Jq4hgU/qaHFo2pPZq1lJsrFROIXcKiRMjG3GWe+pcQ=; b=Cg5W+A3/ZkNQmb1cN
 VMUOkgqTDTarfSLlTnDPtzs4oEqt514QX8x1Pm1wT1hqCtCuDIDLYjZlMVXaE6V8
 vAalpqoH4N/adJuHzM4yWkUUyytkQjwJNG43bXWLhiXcDFUWIZGyU58PD6X5233t
 kDCOnF7pquudLpChemAZQiGLGIgsnLuebU46FvMStIvPhFSMYkjiSXNBOibB5dTf
 Gl6NN5UQxRJ3XkFRUV1Dez7mckGvYnBw8fIjt0id4NPfb5X1TiKdbswJYm7+hFrP
 yA2ulHwnctK3CuHkoWbmMrclBWLPM/KjfojkPo4Pr673OunoT848IsMFm+bmON2m
 c1lNg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hcw98k3ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:05 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 46D7C3F70B8;
 Mon, 19 Oct 2026 06:08:03 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 01/16] common/cnxk: use context invalidate for cn20k
Date: Mon, 19 Oct 2026 18:37:42 +0530
Message-ID: <20261019130759.2181566-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pwi8AW7TM-5c47mSm3ptbnJ08RfyG5z0
X-Proofpoint-ORIG-GUID: pwi8AW7TM-5c47mSm3ptbnJ08RfyG5z0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXya6+Qs9TOGpD
 bKZhz0HLYBDxk3uOl3DkbgKc9bbjLk9NyE7kPCOAQ00lUANXuCLNXEv+pcXjyJeOYVCG0AlNL2i
 3wU4T37f0SEf0uiALzpscMINHvJjSAo=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ad61635 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=jo8pL_tnLn4ImyyQyp4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX4F7MUer4Pd0J
 ZHL14XJQv4cbv7vC4m4EFK0hPpquJUfd0M24c+jVsxc2urYjKrqkTaalG04t8aELs/eFO/5sfy2
 Zaggorc4t5eX2iA+IP/SYEx8ZeLQyYPPe+QAnjWkwhQpVThXIea+pUsiIQRiTrDxF3hYWVNy0gE
 sRvHQ+vHYyiSfDcEkUwfJAS5dUOCNNp2Fb7GatKO1PsMFzYSpl3ytbXYYiknQyc8GpWME88tCvL
 vnijbdj8za/KCPzBHZ1F5uPQUBmwtuE5mE+yXJCVYkM1Hd7Mfzw+RYBrwR4UBtqttXsvz+KGe/s
 jNxvbCgculDDAp+lz6iN4bV+S/vofHvZj63lbCChIz8k8uf4prIi/Cpozda6FG9GJ+uXsfMFCFW
 eJ39HyXrrR8d9ggxqN5H55GjiUa2k00Yq9xlZZnwYNPwhEN/bVWxbLZPIb2B0Y0Z7wHTDmGIZgY
 fFPZh7xgOkRrTVEpOtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

Using context invalidate for cn20k session APIs.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c     | 75 ++++++++++++++++++++++++++-----
 drivers/common/cnxk/roc_cpt.h     |  3 ++
 drivers/crypto/cnxk/cn20k_ipsec.c | 24 ----------
 drivers/crypto/cnxk/cn20k_tls.c   | 29 ------------
 4 files changed, 68 insertions(+), 63 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 686c9eae7e..9ba591d724 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -850,8 +850,10 @@ roc_cpt_dev_init(struct roc_cpt *roc_cpt)
 int
 roc_cpt_lf_ctx_flush(struct roc_cpt_lf *lf, void *cptr, bool inval)
 {
+	union cpt_lf_ctx_inval ctx_inval;
 	union cpt_lf_ctx_flush reg;
 	union cpt_lf_ctx_err err;
+	uint64_t *sa;
 
 	if (lf == NULL) {
 		plt_err("Could not trigger CTX flush");
@@ -879,6 +881,17 @@ roc_cpt_lf_ctx_flush(struct roc_cpt_lf *lf, void *cptr, bool inval)
 		return -EFAULT;
 	}
 
+	if (inval && roc_model_is_cn20k()) {
+		sa = cptr;
+		/* Clear bit 58 aop_valid */
+		sa[0] &= ~(1ULL << ROC_CN20K_CPT_AOP_VALID_BIT);
+		plt_io_wmb();
+
+		ctx_inval.u = 0;
+		ctx_inval.s.cptr = ((uintptr_t)sa) >> 7;
+		plt_write64(ctx_inval.u, lf->rbase + CPT_LF_CTX_INVAL);
+	}
+
 	return 0;
 }
 
@@ -1265,9 +1278,8 @@ roc_cpt_lmtline_init(struct roc_cpt *roc_cpt, struct roc_cpt_lmtline *lmtline, i
 	return 0;
 }
 
-int
-roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
-		  uint16_t sa_len)
+static int
+cpt_cn10k_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr, uint16_t sa_len)
 {
 	union cpt_res_s res, *hw_res;
 	uint64_t lmt_arg, io_addr;
@@ -1278,13 +1290,8 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 	uint8_t egrp;
 	int i;
 
-	if (!plt_is_aligned(sa_cptr, ROC_CPTR_ALIGN)) {
-		plt_err("Context pointer should be %dB aligned", ROC_CPTR_ALIGN);
-		return -EINVAL;
-	}
-
-	if (lf == NULL) {
-		plt_err("Invalid CPT LF");
+	if (!plt_is_aligned(sa_cptr, 128)) {
+		plt_err("Context pointer should be 128B aligned");
 		return -EINVAL;
 	}
 
@@ -1363,6 +1370,54 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 	return 0;
 }
 
+static int
+cpt_cn20k_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr, uint16_t sa_len)
+{
+	union cpt_lf_ctx_inval inval;
+	uintptr_t rbase;
+	uint64_t *sa;
+
+	if (!plt_is_aligned(sa_cptr, 256)) {
+		plt_err("Context pointer should be 256B aligned");
+		return -EINVAL;
+	}
+
+	sa = sa_dptr;
+
+	/* Clear bit 58 aop_valid */
+	sa[0] &= ~(1ULL << ROC_CN20K_CPT_AOP_VALID_BIT);
+	memcpy(sa_cptr, sa_dptr, sa_len);
+	plt_io_wmb();
+
+	/* Trigger CTX invalidate */
+	rbase = lf->rbase;
+	inval.u = 0;
+	inval.s.cptr = ((uintptr_t)sa_cptr) >> 7;
+	plt_write64(inval.u, rbase + CPT_LF_CTX_INVAL);
+
+	/* Set bit 58 aop_valid */
+	sa = sa_cptr;
+	sa[0] |= (1ULL << ROC_CN20K_CPT_AOP_VALID_BIT);
+	plt_io_wmb();
+
+	return 0;
+}
+
+int
+roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
+		  uint16_t sa_len)
+{
+	if (lf == NULL) {
+		plt_err("Invalid CPT LF");
+		return -EINVAL;
+	}
+
+	if (roc_model_is_cn20k())
+		return cpt_cn20k_ctx_write(lf, sa_dptr, sa_cptr, sa_len);
+
+	return cpt_cn10k_ctx_write(lf, sa_dptr, sa_cptr, sa_len);
+}
+
 void
 roc_cpt_int_misc_cb_register(roc_cpt_int_misc_cb_t cb, void *args)
 {
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 533d194bd4..ea78b73ec5 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -69,6 +69,9 @@
 #define ROC_CN20K_CPT_INST_DW_M1     ROC_CN10K_CPT_INST_DW_M1
 #define ROC_CN20K_TWO_CPT_INST_DW_M1 ROC_CN10K_TWO_CPT_INST_DW_M1
 
+/* aop_valid bit for cn20k */
+#define ROC_CN20K_CPT_AOP_VALID_BIT 58
+
 /* CPT helper macros */
 #define ROC_CPT_AH_HDR_LEN	12
 #define ROC_CPT_AES_GCM_IV_LEN	8
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index 785bee02d4..b2cab4ff5f 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -131,20 +131,12 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	/* Write session using microcode opcode */
 	ret = roc_cpt_ctx_write(lf, sa_dptr, out_sa, sizeof(struct roc_ow_ipsec_outb_sa));
 	if (ret) {
 		plt_err("Could not write outbound session to hardware");
 		goto sa_free;
 	}
 
-	/* Trigger CTX flush so that data is written back to DRAM */
-	ret = roc_cpt_lf_ctx_flush(lf, out_sa, false);
-	if (ret == -EFAULT) {
-		plt_err("Could not flush outbound session");
-		goto sa_free;
-	}
-
 	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
@@ -246,20 +238,12 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	/* Write session using microcode opcode */
 	ret = roc_cpt_ctx_write(lf, sa_dptr, in_sa, sizeof(struct roc_ow_ipsec_inb_sa));
 	if (ret) {
 		plt_err("Could not write inbound session to hardware");
 		goto sa_free;
 	}
 
-	/* Trigger CTX flush so that data is written back to DRAM */
-	ret = roc_cpt_lf_ctx_flush(lf, in_sa, true);
-	if (ret == -EFAULT) {
-		plt_err("Could not flush inbound session");
-		goto sa_free;
-	}
-
 	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
@@ -313,9 +297,6 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 	if (sa->sa_ptr == NULL)
 		return -EINVAL;
 
-	/* Trigger CTX flush to write dirty data back to DRAM */
-	roc_cpt_lf_ctx_flush(lf, sa->in_sa, false);
-
 	ret = -1;
 
 	if (sess->ipsec.is_outbound) {
@@ -339,11 +320,6 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 	plt_free(sa_dptr);
 
 	if (ret) {
-		/* MC write_ctx failed. Attempt reload of CTX */
-
-		/* Wait for 1 ms so that flush is complete */
-		rte_delay_ms(1);
-
 		w2 = (union roc_ow_ipsec_sa_word2 *)&sa->in_sa->w2;
 		w2->s.valid = 0;
 
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index 8556a95ab6..882d193c25 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -446,20 +446,12 @@ cn20k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	/* Write session using microcode opcode */
 	ret = roc_cpt_ctx_write(lf, sa_dptr, read_sa, sizeof(struct roc_ie_ow_tls_read_sa));
 	if (ret) {
 		plt_err("Could not write read session to hardware");
 		goto sa_dptr_free;
 	}
 
-	/* Trigger CTX flush so that data is written back to DRAM */
-	ret = roc_cpt_lf_ctx_flush(lf, read_sa, true);
-	if (ret == -EFAULT) {
-		plt_err("Could not flush TLS read session to hardware");
-		goto sa_dptr_free;
-	}
-
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 sa_dptr_free:
@@ -782,20 +774,12 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	/* Write session using microcode opcode */
 	ret = roc_cpt_ctx_write(lf, sa_dptr, write_sa, sizeof(struct roc_ie_ow_tls_write_sa));
 	if (ret) {
 		plt_err("Could not write tls write session to hardware");
 		goto sa_dptr_free;
 	}
 
-	/* Trigger CTX flush so that data is written back to DRAM */
-	ret = roc_cpt_lf_ctx_flush(lf, write_sa, false);
-	if (ret == -EFAULT) {
-		plt_err("Could not flush TLS write session to hardware");
-		goto sa_dptr_free;
-	}
-
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 sa_dptr_free:
@@ -895,9 +879,6 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 	if (tls->sa_ptr == NULL)
 		return -EINVAL;
 
-	/* Trigger CTX flush to write dirty data back to DRAM */
-	roc_cpt_lf_ctx_flush(lf, tls->read_sa, false);
-
 	if (sess->tls_opt.is_write) {
 		sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
 		if (sa_dptr != NULL) {
@@ -908,11 +889,6 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 			plt_free(sa_dptr);
 		}
 		if (ret) {
-			/* MC write_ctx failed. Attempt reload of CTX */
-
-			/* Wait for 1 ms so that flush is complete */
-			rte_delay_ms(1);
-
 			rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 			/* Trigger CTX reload to fetch new data from DRAM */
@@ -928,11 +904,6 @@ cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *
 			plt_free(sa_dptr);
 		}
 		if (ret) {
-			/* MC write_ctx failed. Attempt reload of CTX */
-
-			/* Wait for 1 ms so that flush is complete */
-			rte_delay_ms(1);
-
 			rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 			/* Trigger CTX reload to fetch new data from DRAM */
-- 
2.43.0

