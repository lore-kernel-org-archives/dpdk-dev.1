Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8BE83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD4140673;
	Tue, 17 Feb 2026 06:44:22 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 41E4240656
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:21 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GLTgX81052241 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 VwFKfUbPccmljM6cHKvJ2RNC8J7cDD9PnALmUI2koQ=; b=YXMFa7fsI9t5YL77r
 LEI/RLvGUh9uNkNP5wO5xAXaTGt0XP6ll9Ojl7M9LwZvP2PKnz9t8Ixyf4EwFnrw
 CeOBN0gWHN+d6nqYBqVHY6N0Kuj10BLt1yMzu6METcO5hfJ2YSTp7FrLmeG9tJ4e
 Ebvlk6l5gonEpV81Vvt8gZ9gd9tgvlP4oLy2v3vwBk5Lf5FxHIoiHsrJCY9vkTl9
 PGFhUoEKz2uhofS3E1g+IXGDLAkOOu/kWHlqCOHip6U3CMftxG2rSuLklt65oKNj
 lvvrUOf5t0rcos4m2NDquAnHfpWwSG64tzmgRJynMP7PoqY9CR5apIxyNKR/F68C
 0ajmQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1k1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:32 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2E3235B696D;
 Mon, 16 Feb 2026 21:44:12 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 06/18] common/cnxk: update inline RQ mask configuration
Date: Tue, 17 Feb 2026 11:13:33 +0530
Message-ID: <20260217054345.2759687-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=69940034 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=xRAhIN1rP7Vl5Z9gi64A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: n2anuAMBeC-QfB2J6dR1RLk-icelzh2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfXwLI65iD6AZyM
 s+y0/i2nq+Vr05DX66SCWwJu/hpsSgPShnbvrYNkfs7Euogq4sGKSUJIlitCR6pCOyJ9IvDVmRx
 LjxJIhEmh4Wo/er5nIq0FrONxPf+Azgo7ce3ijII4XVVX8Pcfra/hTEPYmqldz8JUa/cUvpTpOt
 WWLUizy+mxXKmJwVNE3KMPdlUJ+UHTTMml9RuK5Thr0O9tvMzw8uSH0DHHwStrqe2T1tIel0tYt
 Lr5mNBgzEeqMmuSB6JGNXAxsGGwJhrvrqDxLQkIbZLWrM0/YF/XAnBJsfqI5FvzI8pNztyXU60d
 3RNnkjzTWshzDeUch3i34LHSh3UoFervjqn6+7kxt8mzM+6g33lhY8ObA91ZArKny2s7f58zjqY
 iNpN3+aMdFeEjyAYdWFsn5DwCsaEsE5JY9EwESWtfhRaU8kJwwbJrTays7KeH6okXa0QyYWwQzG
 P50d0wgMO/K435sAvrg==
X-Proofpoint-GUID: n2anuAMBeC-QfB2J6dR1RLk-icelzh2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Inline IPsec RQ mask configuration is modified as per
updates in nix_lf_inline_rq_cfg mbox.
Also, adds the support of default RQ first skip bytes
configuration for local meta aura option.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

 drivers/common/cnxk/roc_mbox.h    |  4 +-
 drivers/common/cnxk/roc_nix.h     |  1 +
 drivers/common/cnxk/roc_nix_inl.c | 82 +++++++++++++------------------
 3 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 7871613d9c..3da85b4d12 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1844,12 +1844,12 @@ struct nix_rq_cpt_field_mask_cfg_req {
 		uint64_t __io rq_ctx_word_mask[RQ_CTX_MASK_MAX];
 		__io struct nix_cn10k_rq_ctx_s rq_mask;
 	};
-	struct nix_lf_rx_ipec_cfg1_req {
+	struct nix_lf_rx_ipsec_cfg1_inline_replay_req {
 		uint32_t __io spb_cpt_aura;
 		uint8_t __io rq_mask_enable;
 		uint8_t __io spb_cpt_sizem1;
 		uint8_t __io spb_cpt_enable;
-	} ipsec_cfg1;
+	} ipsec_cfg1_inline_replay;
 };

 struct nix_lso_format_cfg {
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 326decde2b..58f71c10e8 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -590,6 +590,7 @@ struct roc_nix {
 	bool force_tail_drop;
 	bool dis_xqe_drop;
 	bool sq_resize_ena;
+	uint8_t def_first_skip;
 	/* End of input parameters */
 	/* LMT line base for "Per Core Tx LMT line" mode*/
 	uintptr_t lmt_base;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 86bafd5c33..917c2c669a 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -101,10 +101,12 @@ nix_inl_meta_aura_create(struct idev_cfg *idev, struct roc_nix *roc_nix, uint16_
 			nb_bufs += roc_npa_aura_op_limit_get(inl_rq->spb_aura_handle);

 		/* Override meta buf size from NIX devargs if present */
-		if (roc_nix->meta_buf_sz)
+		if (roc_nix->meta_buf_sz) {
 			buf_sz = roc_nix->meta_buf_sz;
-		else
-			buf_sz = first_skip + NIX_INL_META_SIZE;
+		} else {
+			buf_sz = NIX_INL_META_SIZE;
+			buf_sz += roc_nix->def_first_skip ? roc_nix->def_first_skip : first_skip;
+		}

 		/* Create Metapool name */
 		snprintf(mempool_name, sizeof(mempool_name), "NIX_INL_META_POOL_%d",
@@ -304,10 +306,14 @@ nix_inl_global_meta_buffer_validate(struct idev_cfg *idev, struct roc_nix_rq *rq
 static int
 nix_inl_local_meta_buffer_validate(struct roc_nix *roc_nix, struct roc_nix_rq *rq)
 {
+	uint32_t buf_sz = NIX_INL_META_SIZE;
+
+	buf_sz += roc_nix->def_first_skip ? roc_nix->def_first_skip : rq->first_skip;
+
 	/* Validate if we have enough space for meta buffer */
-	if (roc_nix->buf_sz && (rq->first_skip + NIX_INL_META_SIZE > roc_nix->buf_sz)) {
-		plt_err("Meta buffer size %u not sufficient to meet RQ first skip %u",
-			roc_nix->buf_sz, rq->first_skip);
+	if (roc_nix->buf_sz && (buf_sz > roc_nix->buf_sz)) {
+		plt_err("Meta buffer size %u is not sufficient to meet minimum required %u",
+			roc_nix->buf_sz, buf_sz);
 		return -EIO;
 	}

@@ -1018,7 +1024,7 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 }

 static void
-nix_inl_rq_mask_init(struct nix_rq_cpt_field_mask_cfg_req *msk_req)
+nix_inl_rq_mask_init(struct nix_rq_cpt_field_mask_cfg_req *msk_req, uint8_t first_skip)
 {
 	int i;

@@ -1041,6 +1047,8 @@ nix_inl_rq_mask_init(struct nix_rq_cpt_field_mask_cfg_req *msk_req)
 	msk_req->rq_set.spb_drop_ena = 0;
 	msk_req->rq_set.xqe_drop_ena = 0;
 	msk_req->rq_set.spb_ena = 1;
+	if (first_skip)
+		msk_req->rq_set.first_skip = first_skip;

 	if (!roc_feature_nix_has_second_pass_drop()) {
 		msk_req->rq_set.ena = 1;
@@ -1065,6 +1073,8 @@ nix_inl_rq_mask_init(struct nix_rq_cpt_field_mask_cfg_req *msk_req)
 	msk_req->rq_mask.spb_drop_ena = 0;
 	msk_req->rq_mask.xqe_drop_ena = 0;
 	msk_req->rq_mask.spb_ena = 0;
+	if (first_skip)
+		msk_req->rq_mask.first_skip = 0;
 }

 static int
@@ -1087,7 +1097,7 @@ nix_inl_legacy_rq_mask_setup(struct roc_nix *roc_nix, bool enable)
 	if (msk_req == NULL)
 		goto exit;

-	nix_inl_rq_mask_init(msk_req);
+	nix_inl_rq_mask_init(msk_req, 0);
 	if (roc_nix->local_meta_aura_ena) {
 		aura_handle = roc_nix->meta_aura_handle;
 		buf_sz = roc_nix->buf_sz;
@@ -1100,10 +1110,10 @@ nix_inl_legacy_rq_mask_setup(struct roc_nix *roc_nix, bool enable)
 		buf_sz = inl_cfg->buf_sz;
 	}

-	msk_req->ipsec_cfg1.spb_cpt_aura = roc_npa_aura_handle_to_aura(aura_handle);
-	msk_req->ipsec_cfg1.rq_mask_enable = enable;
-	msk_req->ipsec_cfg1.spb_cpt_sizem1 = (buf_sz >> 7) - 1;
-	msk_req->ipsec_cfg1.spb_cpt_enable = enable;
+	msk_req->ipsec_cfg1_inline_replay.spb_cpt_aura = roc_npa_aura_handle_to_aura(aura_handle);
+	msk_req->ipsec_cfg1_inline_replay.rq_mask_enable = enable;
+	msk_req->ipsec_cfg1_inline_replay.spb_cpt_sizem1 = (buf_sz >> 7) - 1;
+	msk_req->ipsec_cfg1_inline_replay.spb_cpt_enable = enable;

 	rc = mbox_process(mbox);
 exit:
@@ -1116,10 +1126,8 @@ nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct nix_rq_cpt_field_mask_cfg_req *msk_req;
-	struct idev_cfg *idev = idev_get_cfg();
-	struct nix_rx_inl_lf_cfg_req *lf_cfg;
-	struct idev_nix_inl_cfg *inl_cfg;
 	uint64_t aura_handle;
+	uint8_t first_skip;
 	struct mbox *mbox;
 	int rc = -ENOSPC;
 	uint64_t buf_sz;
@@ -1133,21 +1141,8 @@ nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
 	if (msk_req == NULL)
 		goto exit;

-	nix_inl_rq_mask_init(msk_req);
-	rc = mbox_process(mbox);
-	if (rc) {
-		plt_err("Failed to setup NIX Inline RQ mask, rc=%d", rc);
-		goto exit;
-	}
-
-	/* SPB setup */
-	if (!roc_nix->local_meta_aura_ena && !roc_nix->custom_meta_aura_ena)
-		goto exit;
-
-	if (!idev)
-		return -ENOENT;
-
-	inl_cfg = &idev->inl_cfg;
+	first_skip = roc_nix->def_first_skip ? (roc_nix->def_first_skip / 8) : 0;
+	nix_inl_rq_mask_init(msk_req, first_skip);

 	if (roc_nix->local_meta_aura_ena) {
 		aura_handle = roc_nix->meta_aura_handle;
@@ -1157,28 +1152,19 @@ nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
 			rc = -EINVAL;
 			goto exit;
 		}
-	} else {
-		aura_handle = roc_npa_zero_aura_handle();
-		buf_sz = inl_cfg->buf_sz;
-	}

-	/* SPB setup */
-	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
-	if (lf_cfg == NULL) {
-		rc = -ENOSPC;
-		goto exit;
+		/* SPB setup */
+		msk_req->ipsec_cfg1_inline_replay.spb_cpt_aura =
+			roc_npa_aura_handle_to_aura(aura_handle);
+		msk_req->ipsec_cfg1_inline_replay.rq_mask_enable = enable;
+		msk_req->ipsec_cfg1_inline_replay.spb_cpt_sizem1 = (buf_sz >> 7) - 1;
+		msk_req->ipsec_cfg1_inline_replay.spb_cpt_enable = enable;
 	}

-	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base;
-	lf_cfg->rx_inline_cfg0 = nix->rx_inline_cfg0;
-	lf_cfg->profile_id = nix->ipsec_prof_id;
-	if (enable)
-		lf_cfg->rx_inline_cfg1 =
-			(nix->rx_inline_cfg1 | BIT_ULL(37) | ((buf_sz >> 7) - 1) << 38 |
-			 roc_npa_aura_handle_to_aura(aura_handle) << 44);
-	else
-		lf_cfg->rx_inline_cfg1 = nix->rx_inline_cfg1;
 	rc = mbox_process(mbox);
+	if (rc)
+		plt_err("Failed to setup NIX Inline RQ mask, rc=%d", rc);
+
 exit:
 	mbox_put(mbox);
 	return rc;
--
2.34.1

