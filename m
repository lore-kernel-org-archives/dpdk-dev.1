Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC2C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F42442D6A;
	Thu, 17 Sep 2026 09:15:04 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0355A42D6A
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:15:01 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Hq52203099 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:15:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 jAKBAWoy0dO/OuayGB4dWaMcdhfNPNbHM9/ou7EcYo=; b=TUGbC0ne/YQ+67CM7
 u5dSA++CfJifSpN/NlbGO08oWCWIKnCScowF6ToFxPgZ0UAjrjrTYfQbeW8C6nP6
 XwCo3B7P7LcWAkl1C+34KZn5b2Jjclnr9PaMGUm+ZpVtsUC3u4+dDFfhpRoL/upH
 rbRrJofXt/THzUhv8419K4SpP2b9K1HsvoneAa5eBuQ0QAbU62Ohd/RN3t4eEWN2
 m6k6k+bZqrMquKAPWfGK8A59yCtu3VlC+gFUq4cG1XiwO4EQtJLPwrh436jSCekC
 R50+g3oG2rHFqbrE+qb2PHHBlUmnmTU523lLrMvnNVep3O0mgPU3jR5pPX57COpw
 WWE9w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5yge5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:15:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:15:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:15:00 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 079635C68E1;
 Thu, 17 Sep 2026 00:14:56 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 13/14] common/cnxk: support for cn20k legacy msns mode
Date: Thu, 17 Sep 2026 12:40:15 +0530
Message-ID: <20260917071016.2366467-13-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX9w/yUWEsMmvJ
 VTBNYmCzQy+XzJZ3LEyw6ZzV3P14iol28e4Z/xvUFxDjC/me+ERdEwz8IE0snDXEyCMynr4ylMT
 7kK+186O+SkpAgfmSg6Z+HoXAPEIKzU=
X-Proofpoint-GUID: 8hv1xSCIXUQx_wL9eTun66eSnM_v3n1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX3emkTZ5jL7pw
 OmAOiZlwZ0ULUep5o2mBGKkmLzgSLIius7kPqPSDmiEvHtVrsfdGRX00E6SQJB1Gxm6egkt9Ntk
 Wj7nY/fZkHc3/oz0sU3TdaoJH5aNOcQRdyu+tO9OC4SYY1eJG88w2F+UpCd16FdzOFZNS2V4Ixt
 VqmorHzkMAUERjJCxzwSfGKGFCfEL1d2ocsoSooJJuA8lCcL4GuGgrENfaFV+wSg3viUJe1SCHr
 SSf7j97UQ1jbOB99jRMMtKSX9TR5d8erhBr1gS+2eBhTTZUEJ42Lymq4dZ1ojpKdTZEmXMs61JJ
 7oMkNydHTJGads2ScpkDYuDoZ4E4jssmiPpj1iUjI0YOWr9qIjVKgRyaRqezFsoZAzEwFTcg5jc
 vXhGoo7A+NancvOzV1n8q2MQJs9UeUNqOTTow/sNOW3dwczNJWeLYzYBn+SByf2Xc12DM3MWhty
 IGuNVAX/RnIv8PHrnlQ==
X-Proofpoint-ORIG-GUID: 8hv1xSCIXUQx_wL9eTun66eSnM_v3n1g
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9375 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=LQBhH_HGYlT3MjfW-3cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Update nix_rx_action2_s for legacy msns mode support for cn20k

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h                 |  2 +
 drivers/common/cnxk/roc_cpt_debug.c           | 22 ++++++++
 drivers/common/cnxk/roc_nix_debug.c           |  2 +-
 drivers/common/cnxk/roc_nix_inl.c             |  4 +-
 drivers/common/cnxk/roc_npc.c                 | 54 ++++++++++---------
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 6 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 533d194bd4..1673cdb5db 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -260,4 +260,6 @@ int __roc_api roc_cpt_int_misc_cb_unregister(roc_cpt_int_misc_cb_t cb, void *arg
 
 bool roc_cpt_has_ie_engines(void);
 
+void __roc_api roc_cpt_cq_dump(FILE *file, const struct cpt_cq_s *cq);
+
 #endif /* _ROC_CPT_H_ */
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 3c1c052e50..91e8cbc30d 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -191,6 +191,28 @@ roc_cpt_parse_hdr_dump(FILE *file, const union cpt_parse_hdr_u *cpth)
 		cpt_cnxk_parse_hdr_dump(file, &cpth->s);
 }
 
+void
+roc_cpt_cq_dump(FILE *file, const struct cpt_cq_s *cq)
+{
+	cpt_dump(file, "CPT_CQ \t%p:", cq);
+
+	/* W0 */
+	cpt_dump(file, "W0: compcode \t0x%x\t\tdoneint \t%u\t", cq->w0.s.compcode,
+		 cq->w0.s.doneint);
+	cpt_dump(file, "W0: uc_compcode \t0x%x\t\tuc_info \t0%" PRIu64, cq->w0.s.uc_compcode,
+		 (uint64_t)cq->w0.s.uc_info);
+
+	/* W1 */
+	cpt_dump(file, "W1: esn \t%" PRIx64 "\t\n", cq->w1.esn);
+
+	/* W2 */
+	cpt_dump(file, "W2: fmt \t0x%x\t\tuc_info2 \t%" PRIu64, cq->w2.s.fmt,
+		 (uint64_t)cq->w2.s.uc_info2);
+
+	/* W3 */
+	cpt_dump(file, "W3: comp_ptr \t0x%" PRIx64 "\t\n", cq->w3.comp_ptr);
+}
+
 static int
 cpt_af_reg_read(struct roc_cpt *roc_cpt, uint64_t reg, uint64_t *val)
 {
diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index 9c3bc8abe3..4f4e9b0c6c 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -1087,7 +1087,7 @@ roc_nix_cqe_dump(FILE *file, const struct nix_cqe_hdr_s *cq)
 	nix_dump(file, "W5: vtag0_ptr \t%d\t\tvtag1_ptr \t%d\t\tflow_key_alg \t%d",
 		 rx->vtag0_ptr, rx->vtag1_ptr, rx->flow_key_alg);
 
-	for (i = 0; i < (rx->desc_sizem1 + 1) << 1; i++)
+	for (i = 0; i < ((rx->desc_sizem1 + 1) << 1) + 2; i++)
 		nix_dump(file, "sg[%u] = %p", i, (void *)sgs[i]);
 }
 
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 935dd37778..4c0ddb66ed 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2620,11 +2620,9 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 		return -EINVAL;
 
 	if (roc_nix) {
-		if (inb && roc_nix->custom_inb_sa && sa_len > ROC_NIX_INL_INB_CUSTOM_SA_SZ) {
+		if (inb && roc_nix->custom_inb_sa && sa_len > ROC_NIX_INL_INB_CUSTOM_SA_SZ)
 			plt_nix_dbg("SA length: %u is more than allocated length: %u", sa_len,
 				    ROC_NIX_INL_INB_CUSTOM_SA_SZ);
-			return -EINVAL;
-		}
 		nix = roc_nix_to_nix_priv(roc_nix);
 		outb_lf = nix->cpt_lf_base;
 
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index a8a31c7f6c..f709c71e36 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -544,49 +544,37 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 	struct nix_spi_to_sa_add_rsp *rsp;
 	struct nix_inl_dev *inl_dev;
 	struct idev_cfg *idev;
+	uint64_t npc_action2 = 0;
 	union {
 		uint64_t reg;
 		union nix_rx_vtag_action_u act;
-	} vtag_act;
+	} vtag_act = {0};
 	struct mbox *mbox;
+	uint8_t alg = 0;
 	int rc;
 
 	if (roc_npc->roc_nix->custom_sa_action == 0 || roc_model_is_cn9k() == 1 ||
 	    act->conf == NULL || flow->is_validate)
 		return 0;
 
-	*has_spi_to_sa_action = true;
-	sec_action = act->conf;
-
-	vtag_act.reg = 0;
-	vtag_act.act.sa_xor = sec_action->sa_xor;
-	vtag_act.act.sa_hi = sec_action->sa_hi;
-	vtag_act.act.sa_lo = sec_action->sa_lo;
-
 	idev = idev_get_cfg();
 	if (!idev)
 		return -1;
 
 	inl_dev = idev->nix_inl_dev;
 
+	*has_spi_to_sa_action = true;
+	sec_action = act->conf;
+
 	switch (sec_action->alg) {
 	case ROC_NPC_SEC_ACTION_ALG0:
-		break;
 	case ROC_NPC_SEC_ACTION_ALG1:
-		vtag_act.act.vtag1_valid = false;
-		vtag_act.act.vtag1_lid = ROC_NPC_SEC_ACTION_ALG1;
-		break;
 	case ROC_NPC_SEC_ACTION_ALG2:
-		vtag_act.act.vtag1_valid = false;
-		vtag_act.act.vtag1_lid = ROC_NPC_SEC_ACTION_ALG2;
-		break;
 	case ROC_NPC_SEC_ACTION_ALG3:
-		vtag_act.act.vtag1_valid = false;
-		vtag_act.act.vtag1_lid = ROC_NPC_SEC_ACTION_ALG3;
+		alg = sec_action->alg;
 		break;
 	case ROC_NPC_SEC_ACTION_ALG4:
-		vtag_act.act.vtag1_valid = false;
-		vtag_act.act.vtag1_lid = 0;
+		alg = 0;
 		mbox = inl_dev->dev.mbox;
 		req = mbox_alloc_msg_nix_spi_to_sa_add(mbox);
 		if (req == NULL)
@@ -595,7 +583,7 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 		req->spi_index = plt_be_to_cpu_32(flow->spi_to_sa_info.spi);
 		req->match_id = flow->match_id;
 		req->valid = true;
-		if (roc_model_is_cn20k()) {
+		if (roc_feature_nix_has_inl_profile()) {
 			if (sec_action->use_custom_profile)
 				req->inline_profile_id = sec_action->profile_id;
 			else
@@ -614,7 +602,21 @@ npc_parse_spi_to_sa_action(struct roc_npc *roc_npc, const struct roc_npc_action
 		return -1;
 	}
 
+	if (!roc_feature_nix_has_inl_profile()) {
+		vtag_act.act.sa_xor = sec_action->sa_xor;
+		vtag_act.act.sa_hi = sec_action->sa_hi;
+		vtag_act.act.sa_lo = sec_action->sa_lo;
+		vtag_act.act.vtag1_valid = false;
+		vtag_act.act.vtag1_lid = alg;
+
+	} else {
+		npc_action2 = ((uint64_t)sec_action->sa_xor << 7);
+		npc_action2 |= ((uint64_t)sec_action->sa_hi << 48);
+		npc_action2 |= ((uint64_t)sec_action->sa_lo << 32);
+		npc_action2 |= ((uint64_t)alg << 17);
+	}
 	flow->vtag_action = vtag_act.reg;
+	flow->npc_action2 |= npc_action2;
 
 	return 0;
 }
@@ -679,6 +681,7 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	/* Initialize actions */
 	flow->ctr_id = NPC_COUNTER_NONE;
 	flow->mtr_id = ROC_NIX_MTR_ID_INVALID;
+	flow->npc_action2 = 0;
 	pf_func = npc->pf_func;
 	if (flow->has_rep)
 		pf_func = flow->rep_pf_func;
@@ -988,19 +991,20 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	} else if (req_act & ROC_NPC_ACTION_TYPE_RSS) {
 		flow->npc_action = NIX_RX_ACTIONOP_UCAST;
 	} else if (req_act & ROC_NPC_ACTION_TYPE_SEC) {
-		if (roc_model_is_cn20k()) {
+		if (roc_feature_nix_has_inl_profile()) {
 			const struct roc_npc_sec_action *sa_action = NULL;
 			uint16_t profile_id;
 
-			flow->npc_action = NIX_RX_ACTIONOP_UCAST_CPT;
-			flow->npc_action |= (uint64_t)rq << 20;
 			profile_id = roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true);
 			if (sec_action && sec_action->conf) {
 				sa_action = (const struct roc_npc_sec_action *)sec_action->conf;
 				if (sa_action->use_custom_profile)
 					profile_id = sa_action->profile_id;
 			}
-			flow->npc_action2 = (is_non_inp ? (1ULL << 15) : 0) | (profile_id << 8);
+			flow->npc_action2 |= (is_non_inp ? (1ULL << 15) : 0) | (profile_id << 8);
+
+			flow->npc_action = NIX_RX_ACTIONOP_UCAST_CPT;
+			flow->npc_action |= (uint64_t)rq << 20;
 		} else {
 			flow->npc_action = NIX_RX_ACTIONOP_UCAST_IPSEC;
 			flow->npc_action |= (uint64_t)rq << 20;
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index de8de910f6..440ff13118 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -63,6 +63,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_unregister)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_parse_hdr_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_afs_print)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lfs_print)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_cq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_wait_queue_idle)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_disable)
-- 
2.34.1

