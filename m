Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41050C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7935542709;
	Fri, 31 Jan 2025 09:05:56 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0FB7A42759
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:05:53 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7pHbC014754
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 ZxiC/i1DAWftQknRLLO/Ogno0TcmWxx9EKZQJUT1no=; b=dr2C75ga1fvvl/oUu
 9Y1DDvj504/j5INJ98wVwSj6Ft/oAVVAgrY81HkwbCwOdKt3Qmap40CYxq+qPnZN
 47UQEhlv+wz7/SSTpmvLjkeK7MDtiVZ3ZGdfUz9UNUFugyic3OQCWQw/KPZ4684B
 M9yIgCiJDn5GmYhyEzq1/TzGtLELsQCkSudsi5UaaFk6NrHETOX+Rst/c0nMhgMR
 4HqS0QhE4lKC8lXMUCioFPTwytuNK5sV1ndb4U2HuJGX7v6al8aiG8Ck23DGerCp
 VnWGd0dKrVSIsKQrELwWbE/009283Ny/zCi6s3fsUFtKuuRV1uVDQUlvWMWB4rgL
 L4tMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gsr3g2yy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:53 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:05:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:05:51 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 606CA3F705C;
 Fri, 31 Jan 2025 00:05:49 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 06/34] common/cnxk: enable IE with cn9k and cn10k only
Date: Fri, 31 Jan 2025 13:35:01 +0530
Message-ID: <20250131080530.3224977-6-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 58kzJQFyyaLcfAkvAzjY3CnJO1Lx2uxd
X-Proofpoint-GUID: 58kzJQFyyaLcfAkvAzjY3CnJO1Lx2uxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Anoob Joseph <anoobj@marvell.com>

IE engines are present only with cn9k and cn10k.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c | 43 +++++++++++++++++++++++++++++++----
 drivers/common/cnxk/roc_cpt.h |  3 +++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 90433e2390..88f6044e60 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -624,9 +624,13 @@ roc_cpt_dev_configure(struct roc_cpt *roc_cpt, int nb_lf, bool rxc_ena, uint16_t
 	for (i = 0; i < nb_lf; i++)
 		cpt->lf_blkaddr[i] = blkaddr[blknum];
 
-	eng_grpmsk = (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_AE]) |
-		     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_SE]) |
-		     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_IE]);
+	if (roc_cpt_has_ie_engines())
+		eng_grpmsk = (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_AE]) |
+			     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_SE]) |
+			     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_IE]);
+	else
+		eng_grpmsk = (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_AE]) |
+			     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_SE]);
 
 	if (roc_errata_cpt_has_ctx_fetch_issue()) {
 		ctx_ilen_valid = true;
@@ -1180,12 +1184,13 @@ int
 roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 		  uint16_t sa_len)
 {
-	uintptr_t lmt_base = lf->lmt_base;
 	union cpt_res_s res, *hw_res;
 	uint64_t lmt_arg, io_addr;
 	struct cpt_inst_s *inst;
+	uintptr_t lmt_base;
 	uint16_t lmt_id;
 	uint64_t *dptr;
+	uint8_t egrp;
 	int i;
 
 	if (!plt_is_aligned(sa_cptr, 128)) {
@@ -1193,6 +1198,25 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 		return -EINVAL;
 	}
 
+	if (lf == NULL) {
+		plt_err("Invalid CPT LF");
+		return -EINVAL;
+	}
+
+	if (lf->roc_cpt == NULL) {
+		if (roc_cpt_has_ie_engines())
+			egrp = ROC_CPT_DFLT_ENG_GRP_SE_IE;
+		else
+			egrp = ROC_CPT_DFLT_ENG_GRP_SE;
+	} else {
+		if (roc_cpt_has_ie_engines())
+			egrp = lf->roc_cpt->eng_grp[CPT_ENG_TYPE_IE];
+		else
+			egrp = lf->roc_cpt->eng_grp[CPT_ENG_TYPE_SE];
+	}
+
+	lmt_base = lf->lmt_base;
+
 	/* Use this lcore's LMT line as no one else is using it */
 	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
 	inst = (struct cpt_inst_s *)lmt_base;
@@ -1225,7 +1249,7 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 	inst->w4.s.opcode_minor = ROC_IE_OT_MINOR_OP_WRITE_SA;
 	inst->w7.s.cptr = (uint64_t)sa_cptr;
 	inst->w7.s.ctx_val = 1;
-	inst->w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE_IE;
+	inst->w7.s.egrp = egrp;
 
 	lmt_arg = ROC_CN10K_CPT_LMT_ARG | (uint64_t)lmt_id;
 	io_addr = lf->io_addr | ROC_CN10K_CPT_INST_DW_M1 << 4;
@@ -1276,3 +1300,12 @@ roc_cpt_int_misc_cb_unregister(roc_cpt_int_misc_cb_t cb, void *args)
 	int_cb.cb_args = NULL;
 	return 0;
 }
+
+bool
+roc_cpt_has_ie_engines(void)
+{
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		return true;
+
+	return false;
+}
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 70129531eb..c8cf9354da 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -226,4 +226,7 @@ int __roc_api roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_c
 
 void __roc_api roc_cpt_int_misc_cb_register(roc_cpt_int_misc_cb_t cb, void *args);
 int __roc_api roc_cpt_int_misc_cb_unregister(roc_cpt_int_misc_cb_t cb, void *args);
+
+bool roc_cpt_has_ie_engines(void);
+
 #endif /* _ROC_CPT_H_ */
-- 
2.34.1

