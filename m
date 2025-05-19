Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA39C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 12:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E100402AC;
	Mon, 19 May 2025 14:54:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3A63540276
 for <dev@dpdk.org>; Mon, 19 May 2025 14:54:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INSLVs008034
 for <dev@dpdk.org>; Mon, 19 May 2025 05:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=snFYCTKaOeJunW196DEunbG
 uclwNCD9AzjCYbbC2vcM=; b=DwAumtJNEQnLzXW7DX7YQJFvM6nvds0qaeKlCr1
 SbviO6MzPl5Lt2hIln7fP+7HM3+FWFaBe47uDGw/WXjrg3vE4o+OmdFkQj3R9HvI
 E2/3g0YNVMsZa2yjIczRYp7s4447iIA8CJQ0U6dDd6EoIgO9SkA4/JSAi/AIMOwH
 m5sIh9cn3sE1Ci4RSwCKELSq965CRPA27Av0SyrkzAs379DVHTaAKfr5+kDCdUEb
 QCR1OSE6iEJjIfQWNo6bz/iIUtK/WrZA0D68jUJ8v64UfFwmwpuk5FpydZ9aPiCo
 gGo57I3KpObqu8X0mYnxoZZBzd3QEqcJu8PKKW2BMfGXoIA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46qb79a06h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 May 2025 05:54:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 05:54:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 05:54:35 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 17F8C3F709C;
 Mon, 19 May 2025 05:54:32 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Monendra Singh Kushwaha <kmonendra@marvell.com>
Subject: [PATCH 1/6] common/cnxk: config of CPT result address offset
Date: Mon, 19 May 2025 18:24:19 +0530
Message-ID: <20250519125424.1435140-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YjwxzdZViBT_EEb_bYM6FGWCtIeiltQN
X-Proofpoint-ORIG-GUID: YjwxzdZViBT_EEb_bYM6FGWCtIeiltQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyMCBTYWx0ZWRfX42f9wtzM+l5K
 KPQwXCG5QNzTgRJCBUsXeSTHTczeCeSYeJJKSAFHY5ejtVgId+Zrha7tb4UoI76ydO7zEVHrGyG
 3R0QfgbnTVt2LT7hmKJdc2RtR6vqYTnGodE3gCn69Dly8Wx+xFaVkje3XBxf2wqd6+K8D0MaQJN
 XYgTKjHQS3D4kkuT8D4NCQ2NTG9wvN64oMVhLU6Gc3rQ8SCdtGfmrVfS6bdx+dSLeCzdYIiVPT6
 i4X09EqLuHIuU8K6aOWgMf/Bv4JaEMjuD1+ijs/Eq/acVStxGF3mCgb44JogAENGdMRbdle0KQi
 KYt3atYBhWyTdxmy21Gk/Z9Z/NoVSUhD9GHGU1VSfOQFtHfZzV9dJWY13Dc5QMLNFV0Cz6DnxxR
 3MVN1ViX2rPRlGuqVxLG8x1BjwebX2/S2/tMr8AyMgvgs9gSMTffQwkZxQspQ4cQh2UovKqY
X-Authority-Analysis: v=2.4 cv=YvQPR5YX c=1 sm=1 tr=0 ts=682b2a0d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=1pmt-tPcaZLepNR4IZcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch enables setting CPT result address offset relative
to wqe address.

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
Depends-on: series-34970 ("[v2,1/3] common/cnxk: update steer rule mbox for cn20k")

 drivers/common/cnxk/roc_mbox.h         | 4 ++++
 drivers/common/cnxk/roc_nix.c          | 5 +++++
 drivers/common/cnxk/roc_nix.h          | 2 ++
 drivers/common/cnxk/roc_nix_inl.c      | 7 +++++++
 drivers/common/cnxk/roc_nix_inl.h      | 2 ++
 drivers/common/cnxk/roc_nix_inl_dev.c  | 7 +++++++
 drivers/common/cnxk/roc_nix_inl_priv.h | 1 +
 7 files changed, 28 insertions(+)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..255e0f0fe0 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2095,6 +2095,10 @@ struct nix_inline_ipsec_lf_cfg {
 		uint8_t __io sa_idx_w;
 	} ipsec_cfg1;
 	uint8_t __io enable;
+	struct {
+		uint8_t __io res_addr_offset;
+		uint8_t __io res_addr_offset_valid;
+	} ipsec_cfg0_ext;
 };

 struct nix_hw_info {
diff --git a/drivers/common/cnxk/roc_nix.c b/drivers/common/cnxk/roc_nix.c
index e4d7e11121..477c7d5ca0 100644
--- a/drivers/common/cnxk/roc_nix.c
+++ b/drivers/common/cnxk/roc_nix.c
@@ -120,6 +120,11 @@ roc_nix_lf_inl_ipsec_cfg(struct roc_nix *roc_nix, struct roc_nix_ipsec_cfg *cfg,
 		lf_cfg->ipsec_cfg0.sa_pow2_size = plt_log2_u32(cfg->sa_size);
 		lf_cfg->ipsec_cfg0.tag_const = cfg->tag_const;
 		lf_cfg->ipsec_cfg0.tt = cfg->tt;
+		if (cfg->res_addr_offset) {
+			lf_cfg->ipsec_cfg0_ext.res_addr_offset_valid = 1;
+			lf_cfg->ipsec_cfg0_ext.res_addr_offset =
+				(cfg->res_addr_offset & 0x80) | abs(cfg->res_addr_offset);
+		}
 	} else {
 		lf_cfg->enable = 0;
 	}
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a1bd14ffc4..80392e7e1b 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -431,6 +431,7 @@ struct roc_nix_ipsec_cfg {
 	plt_iova_t iova;
 	uint16_t max_sa;
 	uint8_t tt;
+	int8_t res_addr_offset;
 };

 /* Link status update callback */
@@ -469,6 +470,7 @@ struct roc_nix {
 	uint32_t dwrr_mtu;
 	bool ipsec_out_sso_pffunc;
 	bool custom_sa_action;
+	int8_t res_addr_offset;
 	bool local_meta_aura_ena;
 	uint32_t meta_buf_sz;
 	bool force_rx_aura_bp;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 8ade58e1a2..6afdfb6b85 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -471,6 +471,11 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		lf_cfg->ipsec_cfg0.sa_pow2_size = sa_pow2_sz;
 		lf_cfg->ipsec_cfg0.tag_const = 0;
 		lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+		if (roc_nix->res_addr_offset) {
+			lf_cfg->ipsec_cfg0_ext.res_addr_offset_valid = 1;
+			lf_cfg->ipsec_cfg0_ext.res_addr_offset =
+				(roc_nix->res_addr_offset & 0x80) | abs(roc_nix->res_addr_offset);
+		}
 	} else {
 		struct nix_rx_inl_lf_cfg_req *lf_cfg;
 		uint64_t def_cptq = 0;
@@ -2155,6 +2160,8 @@ roc_nix_inl_inb_tag_update(struct roc_nix *roc_nix, uint32_t tag_const,
 	cfg.max_sa = nix->inb_spi_mask + 1;
 	cfg.tt = tt;
 	cfg.tag_const = tag_const;
+	if (roc_nix->res_addr_offset)
+		cfg.res_addr_offset = roc_nix->res_addr_offset;

 	return roc_nix_lf_inl_ipsec_cfg(roc_nix, &cfg, true);
 }
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index dab4918535..4ef1908696 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -99,6 +99,8 @@ struct roc_nix_inl_dev {
 	uint8_t rx_inj_ena; /* Rx Inject Enable */
 	uint8_t custom_inb_sa;
 	uint8_t nb_inb_cptlfs;
+	int8_t res_addr_offset; /* CPT result address offset */
+
 	/* End of input parameters */

 #define ROC_NIX_INL_MEM_SZ (6144)
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 376582f5db..1db05741ad 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -365,6 +365,12 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)

 			lf_cfg->ipsec_cfg0.tag_const = 0;
 			lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+			if (inl_dev->res_addr_offset) {
+				lf_cfg->ipsec_cfg0_ext.res_addr_offset_valid = 1;
+				lf_cfg->ipsec_cfg0_ext.res_addr_offset =
+					(inl_dev->res_addr_offset & 0x80) |
+					abs(inl_dev->res_addr_offset);
+			}
 		} else {
 			lf_cfg->enable = 0;
 		}
@@ -1370,6 +1376,7 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	inl_dev->nix_inb_q_bpid = -1;
 	inl_dev->nb_cptlf = 1;
 	inl_dev->ipsec_prof_id = 0;
+	inl_dev->res_addr_offset = roc_inl_dev->res_addr_offset;

 	if (roc_model_is_cn9k() || roc_model_is_cn10k())
 		inl_dev->eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index 8b3bd43547..33073b2f34 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -67,6 +67,7 @@ struct nix_inl_dev {
 	uint16_t inb_sa_sz[NIX_INL_PROFILE_CNT];
 	uint32_t inb_sa_max[NIX_INL_PROFILE_CNT];
 	uint8_t nb_cptlf;
+	int8_t res_addr_offset;

 	/* CPT data */
 	struct roc_cpt_lf cpt_lf[MAX_NIX_INL_DEV_CPT_LF];
--
2.25.1

