Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD517C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9763940E1B;
	Fri, 23 May 2025 15:52:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C05A640DF8
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8SJ006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 tIMRyA5sxZ4p4wtB8Y6MZUCygiqccDZCFEiUtOGt4c=; b=i5L8mE9l6Nq+TKOqe
 9rCrTCh+jrTj9xbHf031LEkRHkGvsLDr4FWKd7aKArcZMZDby3DtfCjo4pLPZVwH
 dspISEpWzS8Qz5YzJ3J6oPBiOPiPi8xVjwiokoXbqTV7tWA4a7WUdCXHxIJy7nS8
 OSPFBR91ztGQ4ozLLdix0ZkYYpTK9OBtQcJzGr2dSa10MYwXehTkUpvulBuJLpgS
 gpJNyGCDdMJlVuKeBhND3wJXq9ysXRbKaXPp6uBml4tEFabEnMZY68D7sf1Txhj/
 iA/O8OfwaVd8zXowCOk3z7pS/DsFVbKcDAzIw6/vaX6uXAAPHmPhqp47TfTE5E+2
 /bInQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:50 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id F3EDB3F707B;
 Fri, 23 May 2025 06:51:47 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 11/40] crypto/cnxk: add lmtst routines for cn20k
Date: Fri, 23 May 2025 19:20:42 +0530
Message-ID: <20250523135111.2178408-12-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXx+b+YfJuJtUk
 GVabEoTVZzMA4KHwPm6CXtYJFFECvvhweZGvnT0/whfbuQyDtshA9nxcJFZp379liXG6Ibja75n
 OXAIXBwrKLOruieFERe7FtuWJC00+KRwD1VoWpbHE4+Yg8bbWpI2nc9CTrhQJfC37cxqFFKQLEI
 Vd4fk4o99xs7E2AbpnMtwCp34/gvLH4DvSUWVlN1Fu3kDwgow19ov8gNmNpXeiKgjD6/6NhXne3
 GtadE6e/RKQko5lrYoeaZ45rNFNfELSUGGnz8ebE6Z9xSd7Yos07tPR3u3VCPKxSymHFylTXtSZ
 BoZ/Q00kLiTQSqkVJ06xKaBgAYamxjZLN32zOi3BnqY4WnO7ryrlAo1xGqoKdmHO+2UaJB0t5ro
 3nwAUOKX5J5pAcQeaYXL0wRWdx8FCDUpVb81exqVayumq+BMaHn7191FODimreh8iMsk0ka4
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d9c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=mEAfqhfBv2LVoDoXFKoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0aplw6L-fCXZaJqn3z2ndstEtN1xhh5T
X-Proofpoint-ORIG-GUID: 0aplw6L-fCXZaJqn3z2ndstEtN1xhh5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

