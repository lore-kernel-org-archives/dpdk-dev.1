Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E89C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AACE34028D;
	Wed, 28 May 2025 13:51:35 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 36EED40279
 for <dev@dpdk.org>; Wed, 28 May 2025 13:51:34 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qitJ021221
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=aKQPJC+vdn2H6e5cyCyqlG2
 354o7wE9KBFpWgiFirL8=; b=SQRW/MTwjNrbry/JakQyWvHzr+N6viFjx0W8w9B
 +smsao27TxZt0e+oMunwEmCbfBGihTBA6zVxaPXHrMkrGOoWKpNzPwdTWUeUH/Vb
 I0RrvwI9S/Vdridc9Bh2paHJg7p3QnBPAT6NtXElBbaodoSEwumIss95ZuAXID1f
 R8M2lMSXwn87YU0edzNBONX53+a8it7WOCc+o1ezB4prLkEhvuMq8dhTi2WtfCY5
 KbF/KJlCFk7rbTO17OpwphojUPNtLlM2D1POYhqKwI8N4u/za/D7Oc9VQoWvejwF
 9VlHKJpULppkITT/rTxPTtP+/HpgwZd1GnnfAyrqqCT5swg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq8217ac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:51:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:51:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 0AB3F3F7060;
 Wed, 28 May 2025 04:51:28 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: [PATCH 1/7] common/cnxk: fix CQ tail drop feature
Date: Wed, 28 May 2025 17:21:16 +0530
Message-ID: <20250528115122.24052-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ezcjZAnr1lzUpz7pF7_tidP-RxbHU76r
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6836f8c4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=jIIgz-6HreFS4v86cGkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX4eKFBaeY8vy/
 qRiaNnIij/EGZjk0DsNIfsJOvYZqYDJjM0oWyituDOU34Ifx31Wtgy7j52Ayd8xIHuzb7E3RYwc
 AFCH/gbU2KR99IpM2mwHJhRk4jbmWSnpzGld5Pqf0j6j6Qsko17QVQYVEohfFmwO0Uzqq0p+ubE
 qM/emDBK/dA604PD/I778Hy032G/hwovU2ez0ZwJW4Fl6sty/LuGrEdGqgXp8OA3sIorGt4zm0E
 UU6Q4J4/L8JwpR0MMZrgZfu8/AmRMuleFG3ZpDH5cyG27IUNNToblO1a8b3Qb+tfxPfDZtb8kHB
 fuIK1b8msCCNwcUe8q87ZvtNxPSJhDGdEWOUt4Y72k1D45c+ZotFOmcM2jbnek9YxJaqoLe1KuQ
 0zjJuVK++Bq0zVJq+ASisSvjSQOJsPTx+2sJplUmy4kJ429E5fEGXdRj3vEEYRenK0bC/E1d
X-Proofpoint-GUID: ezcjZAnr1lzUpz7pF7_tidP-RxbHU76r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

CQ tail drop feature is currently supposed to be enabled
when inline IPsec is disabled. But since XQE drop is not
enabled, CQ tail drop is implicitly disabled. Fix the same.

Fixes: c8c967e11717 ("common/cnxk: support enabling AURA tail drop for RQ")

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix.h       |  2 ++
 drivers/common/cnxk/roc_nix_queue.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 80392e7e1b..1e543d8f11 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -355,6 +355,8 @@ struct roc_nix_rq {
 	bool lpb_drop_ena;
 	/* SPB aura drop enable */
 	bool spb_drop_ena;
+	/* XQE drop enable */
+	bool xqe_drop_ena;
 	/* End of Input parameters */
 	struct roc_nix *roc_nix;
 	uint64_t meta_aura_handle;
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index e852211ba4..39bd051c94 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -530,7 +530,7 @@ nix_rq_cn9k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints,
 	aq->rq.rq_int_ena = 0;
 	/* Many to one reduction */
 	aq->rq.qint_idx = rq->qid % qints;
-	aq->rq.xqe_drop_ena = 1;
+	aq->rq.xqe_drop_ena = rq->xqe_drop_ena;
 
 	/* If RED enabled, then fill enable for all cases */
 	if (rq->red_pass && (rq->red_pass >= rq->red_drop)) {
@@ -613,6 +613,7 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 		aq->rq.wqe_skip = rq->wqe_skip;
 		aq->rq.wqe_caching = 1;
 
+		aq->rq.xqe_drop_ena = 0;
 		aq->rq.good_utag = rq->tag_mask >> 24;
 		aq->rq.bad_utag = rq->tag_mask >> 24;
 		aq->rq.ltag = rq->tag_mask & BITMASK_ULL(24, 0);
@@ -632,6 +633,8 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 		aq->rq.bad_utag = rq->tag_mask >> 24;
 		aq->rq.ltag = rq->tag_mask & BITMASK_ULL(24, 0);
 		aq->rq.cq = rq->cqid;
+		if (rq->xqe_drop_ena)
+			aq->rq.xqe_drop_ena = 1;
 	}
 
 	if (rq->ipsech_ena) {
@@ -680,7 +683,6 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 	aq->rq.rq_int_ena = 0;
 	/* Many to one reduction */
 	aq->rq.qint_idx = rq->qid % qints;
-	aq->rq.xqe_drop_ena = 0;
 	aq->rq.lpb_drop_ena = rq->lpb_drop_ena;
 	aq->rq.spb_drop_ena = rq->spb_drop_ena;
 
@@ -725,6 +727,7 @@ nix_rq_cn10k_cfg(struct dev *dev, struct roc_nix_rq *rq, uint16_t qints, bool cf
 			aq->rq_mask.bad_utag = ~aq->rq_mask.bad_utag;
 			aq->rq_mask.ltag = ~aq->rq_mask.ltag;
 			aq->rq_mask.cq = ~aq->rq_mask.cq;
+			aq->rq_mask.xqe_drop_ena = ~aq->rq_mask.xqe_drop_ena;
 		}
 
 		if (rq->ipsech_ena)
@@ -950,6 +953,10 @@ roc_nix_rq_init(struct roc_nix *roc_nix, struct roc_nix_rq *rq, bool ena)
 	rq->roc_nix = roc_nix;
 	rq->tc = ROC_NIX_PFC_CLASS_INVALID;
 
+	/* Enable XQE/CQ drop on cn10k to count pkt drops only when inline is disabled */
+	if (roc_model_is_cn10k() && !roc_nix_inl_inb_is_enabled(roc_nix))
+		rq->xqe_drop_ena = true;
+
 	if (is_cn9k)
 		rc = nix_rq_cn9k_cfg(dev, rq, nix->qints, false, ena);
 	else if (roc_model_is_cn10k())
-- 
2.25.1

