Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55508C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B37840A79;
	Tue,  3 Jun 2025 13:50:45 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2A37640A71
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:43 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AJZbm021003
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 s+MWkzDkMmxB7aKRoMqvqdaGH2XYvgz1RmRtD3fclU=; b=KQwRYSINWv2DVi4L4
 aNeXHPfBef5WP3XNMpIZdn0YBWb67XmBhwUHjb6cV0mGxIEy/3B8F6J35V2WOj0i
 45mIlcIZwLbt46xt06QtaS6/e6sZLyoB5H3e59HgZ81LMtIQu8YQqUBZmH3BzkqB
 4RtBm7LHuyDvq88Teo2gjY3D/cv75bND9JrB03wKDXtP3bhPpspb9pZ4f8Hl75Yv
 m3kj/Q3M6pCkXNpO4RRVleiLCSq85BHPqRJty6SaZfAxoxDH2BrG+0Qnj/cuKCxw
 kSUJ0EXa9mqyf6LAFnmJ0blaolgtM3meNbKS1IV8qbMir72a2BOFIcVAFM6C94ZJ
 eyXfw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471y6rg4je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:40 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id D80085B6922;
 Tue,  3 Jun 2025 04:50:38 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 05/25] crypto/cnxk: add cn20k lmtst routines
Date: Tue, 3 Jun 2025 17:20:06 +0530
Message-ID: <20250603115026.2664706-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Xpf6OUF9 c=1 sm=1 tr=0 ts=683ee192 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=mEAfqhfBv2LVoDoXFKoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CJPQ3lcvfZSBiUtxah_coLZfxcerxNVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX4YOtLbeGZx87
 qg2ELy80Vi85sttB1Xv9q+rlyzr+hEdE7KRRpicwHC525UWRSHGWMoA/nP5K+eHbvl8UcA9k3Ca
 fV/2vx3TPC/eXF9zaNWO6dKRJkDQkP9YoCrzRie3cfy3oz3wd3rMePVokBa0oP6cHLbGkpS/eKo
 ypuIe+QQIKxw37Wxt2YcN3bsLF6a2O9nhkoT5b/N0aWITRVnWqtjkX0YFGp1pxwZWnlGPRxvrow
 eusT0tpsdmK+oRjp8Eocc11/aYZRfzTYp0b4UeUn2ulExyhClFlwO8YJz62/2MVCCAmi1NBMNPA
 ePs1eB45lGERyGxYWhXfwxncZR8hKY5X8cgmfWuqywvabXTJiEzJ1QP9S1kn5NqHDKsrrTDh3AY
 FmsSUSv+hgiMH9GsAJVkRGDitO7kFYT4JTJCX4VqicRMIBm2cCOBSehKt0eH6lwXEC0Snp+7
X-Proofpoint-ORIG-GUID: CJPQ3lcvfZSBiUtxah_coLZfxcerxNVr
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add lmtst routines for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h             |  7 +--
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h | 53 +++++++++++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 37634793d4..02f49c06b7 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -64,9 +64,10 @@
 	 ROC_CN10K_TWO_CPT_INST_DW_M1 << (19 + 3 * 13) |                                           \
 	 ROC_CN10K_TWO_CPT_INST_DW_M1 << (19 + 3 * 14))
 
-#define ROC_CN20K_CPT_LMT_ARG	   ROC_CN10K_CPT_LMT_ARG
-#define ROC_CN20K_DUAL_CPT_LMT_ARG ROC_CN10K_DUAL_CPT_LMT_ARG
-#define ROC_CN20K_CPT_INST_DW_M1   ROC_CN10K_CPT_INST_DW_M1
+#define ROC_CN20K_CPT_LMT_ARG	     ROC_CN10K_CPT_LMT_ARG
+#define ROC_CN20K_DUAL_CPT_LMT_ARG   ROC_CN10K_DUAL_CPT_LMT_ARG
+#define ROC_CN20K_CPT_INST_DW_M1     ROC_CN10K_CPT_INST_DW_M1
+#define ROC_CN20K_TWO_CPT_INST_DW_M1 ROC_CN10K_TWO_CPT_INST_DW_M1
 
 /* CPT helper macros */
 #define ROC_CPT_AH_HDR_LEN	12
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index d9594513d1..bdd6f71022 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -18,7 +18,60 @@
 
 #include "cnxk_cryptodev.h"
 
+#define CN20K_PKTS_PER_STEORL	  32
+#define CN20K_LMTLINES_PER_STEORL 16
+
 extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
 void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev);
+
+static __rte_always_inline void __rte_hot
+cn20k_cpt_lmtst_dual_submit(uint64_t *io_addr, const uint16_t lmt_id, int *i)
+{
+	uint64_t lmt_arg;
+
+	/* Check if the total number of instructions is odd or even. */
+	const int flag_odd = *i & 0x1;
+
+	/* Reduce i by 1 when odd number of instructions.*/
+	*i -= flag_odd;
+
+	if (*i > CN20K_PKTS_PER_STEORL) {
+		lmt_arg = ROC_CN20K_DUAL_CPT_LMT_ARG | (CN20K_LMTLINES_PER_STEORL - 1) << 12 |
+			  (uint64_t)lmt_id;
+		roc_lmt_submit_steorl(lmt_arg, *io_addr);
+		lmt_arg = ROC_CN20K_DUAL_CPT_LMT_ARG |
+			  (*i / 2 - CN20K_LMTLINES_PER_STEORL - 1) << 12 |
+			  (uint64_t)(lmt_id + CN20K_LMTLINES_PER_STEORL);
+		roc_lmt_submit_steorl(lmt_arg, *io_addr);
+		if (flag_odd) {
+			*io_addr = (*io_addr & ~(uint64_t)(0x7 << 4)) |
+				   (ROC_CN20K_CPT_INST_DW_M1 << 4);
+			lmt_arg = (uint64_t)(lmt_id + *i / 2);
+			roc_lmt_submit_steorl(lmt_arg, *io_addr);
+			*io_addr = (*io_addr & ~(uint64_t)(0x7 << 4)) |
+				   (ROC_CN20K_TWO_CPT_INST_DW_M1 << 4);
+			*i += 1;
+		}
+	} else {
+		if (*i != 0) {
+			lmt_arg =
+				ROC_CN20K_DUAL_CPT_LMT_ARG | (*i / 2 - 1) << 12 | (uint64_t)lmt_id;
+			roc_lmt_submit_steorl(lmt_arg, *io_addr);
+		}
+
+		if (flag_odd) {
+			*io_addr = (*io_addr & ~(uint64_t)(0x7 << 4)) |
+				   (ROC_CN20K_CPT_INST_DW_M1 << 4);
+			lmt_arg = (uint64_t)(lmt_id + *i / 2);
+			roc_lmt_submit_steorl(lmt_arg, *io_addr);
+			*io_addr = (*io_addr & ~(uint64_t)(0x7 << 4)) |
+				   (ROC_CN20K_TWO_CPT_INST_DW_M1 << 4);
+			*i += 1;
+		}
+	}
+
+	rte_io_wmb();
+}
+
 #endif /* _CN20K_CRYPTODEV_OPS_H_ */
-- 
2.25.1

