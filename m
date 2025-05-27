Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FBC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85567406B6;
	Tue, 27 May 2025 13:02:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DEE1440672
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:32 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsaa001051
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 tIMRyA5sxZ4p4wtB8Y6MZUCygiqccDZCFEiUtOGt4c=; b=KxMHafzdo3bFBsIGx
 EDQ5Y8/1GY5tixeIdnH7bYQXUO48Ed316rNFtWLAipkdWELN/TmiT+JW468fAFZs
 W8v1WIAZsNMw18tIRF4mLbl56r80OvzBaVxeAMCDY9t/HzTiuUffnaqwIVNx2veO
 D3yNVC2s2rhWmtSR4EbtLGGidxjJSgIi5ncTW9DTtOa5CHYsEvvPEkgpcWL8xFOi
 0YtjEXciKucuXj3n12+muBUydfV+9+WAtLMqLMpKQDcZu1mW9pGatu0Lyv5sGSca
 0w4BIo4+QghnlEcu68gLNuzAh3GW10I5yiPmaRDJpKq33P8+8J4KRujvD7bjQKBF
 8Ke8w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21293nw-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:20 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 5ADC43F707A;
 Tue, 27 May 2025 04:02:18 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 05/25] crypto/cnxk: add lmtst routines for cn20k
Date: Tue, 27 May 2025 16:31:45 +0530
Message-ID: <20250527110205.2300800-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68359bc8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=mEAfqhfBv2LVoDoXFKoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wi-5xTey9Ca50DZLLQIdGSDxzv434b9g
X-Proofpoint-ORIG-GUID: wi-5xTey9Ca50DZLLQIdGSDxzv434b9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX1ea4DZCwjUaS
 ooJHsCXCvHeRs3wikF1mt21P8SpFWc2jnBFi5uC2ASqFDAxUtcNou1otIiqC2tvX7l8RdA4dh4P
 mukmgUsBa4uuQVybDQlFIozk/Lq/f0Fhdg5iaf61z09uPdF8AsQG3jXWONB5qSo1y6pji/GWdPQ
 DPaQueeYlKnrs7rusJAVYKITxxdOlr25hNq6DQUchCTZF5CDqllaInEw/QPRpLT/lgTkUtzMbXn
 x/aG56+2w3YtkByjkYRjbQYIkZp99yxq9EuOkIMcqKYmh+n9VSwtaGxXyrTyICSrbfn297AZXO/
 0L54c8ydXoLjDki1PqoCBnnrk2SWkxS3RUDEW5/rSq3phjWdzLKexWZJ827w536zvstldiAT1+A
 0nhzfZ06awsR8yCcOEZFcN4BDlnaAZmjLVtVwZZc8Ae30ulb9plBoMPxiSBBzxH1PSi+QUub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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
index d6f1592a56..3e2ad1e2df 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -18,7 +18,60 @@
 
 #include "cnxk_cryptodev.h"
 
+#define CN20K_PKTS_PER_STEORL	  32
+#define CN20K_LMTLINES_PER_STEORL 16
+
 extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
 void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt_vf *vf);
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

