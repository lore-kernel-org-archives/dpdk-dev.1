Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90410C54ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 270674064F;
	Fri, 23 May 2025 17:54:27 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E91AD402B4
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:24 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBAf6c031533
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 v+NmVyQ2sc6fGuG8+kRWJpBuW+Q7WCRGjWohKc2xtw=; b=HYpXFih3EZhKR3GsD
 VIerQhaLzJWw9R0u8XFqrOITYjwEQBSRSyhuixz+4JkSxc5hfTZRbqyPzdlB4av9
 v6zE7nnOuoNye7ov9HDJGP+1k6tvOVhkQbdtIEHlHSrv9pnwLkAgsXWqSobDi+2n
 J0NbX+F0CUjrYPBf8odDEZXm7rncLylT2L2kWDXYlPbHHUHoIeMrrHV711jROk69
 6JCLLZJefVrXsteaPw3528UAyQ2DoRwL5NWrQlU2M8DucWCSadAtmeZhTH/Eg+Ux
 CM05bLyMaC8CwSpbw/hXCmRV76YKLKgBMsi2esmWCdCLy+Ue3RQe1x01uxG+Gm5E
 PuhHw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw58hkd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:21 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id B5BD63F7078;
 Fri, 23 May 2025 08:54:18 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Monendra Singh Kushwaha <kmonendra@marvell.com>
Subject: [PATCH v2 1/6] common/cnxk: config of CPT result address offset
Date: Fri, 23 May 2025 21:23:42 +0530
Message-ID: <20250523155347.1156891-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519125424.1435140-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68309a2f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=1pmt-tPcaZLepNR4IZcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0MyBTYWx0ZWRfX6fxsojiHie8V
 C+TyJwzb8p2DBptG1liWal9j97Jmww2qIq/AbLGePovyfABDrruS8h/zVr8ALNcF43kMa4BFGrD
 OaOH3cyQvJZ0NPLwkkzyAMxhhZ9Kh8stBzNoTzIVQcXA9v16cu+LqqRwXbIQ0QHRqJVtsX5mKwY
 RRy82HKkdNz/iboK4dFEgdknWrUmFfHHWG6pBTsIBINGgFgxsYtRyFBc/kRYYNA7EpM4y/xytBB
 uidxuR+wX3pI3roWrd+VfM4rYVrNPQUsFdHeOsSa4dKcc3RSa38EawsSvVE/1v13TUhHqACF1dm
 /AjSZqovsqaym/QKn+nG006Jljo8OchlO4fH7/Ue/vvc33riI0ZWqAty2CHMsJVmpk1EZV1YJwJ
 pp6TXj+E5RdmeYzmlVxGdn5ZkLkaoVmA5pXesuwUwrMHPF7JSmX6ox6Vd3Me0oQJEH7b1QQB
X-Proofpoint-GUID: SlOD8KPhr7t-5sJdrRjHyvGtL5drY73B
X-Proofpoint-ORIG-GUID: SlOD8KPhr7t-5sJdrRjHyvGtL5drY73B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
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
Changes in v2: No change.

 drivers/common/cnxk/roc_mbox.h         | 4 ++++
 drivers/common/cnxk/roc_nix.c          | 5 +++++
 drivers/common/cnxk/roc_nix.h          | 2 ++
 drivers/common/cnxk/roc_nix_inl.c      | 7 +++++++
 drivers/common/cnxk/roc_nix_inl.h      | 2 ++
 drivers/common/cnxk/roc_nix_inl_dev.c  | 7 +++++++
 drivers/common/cnxk/roc_nix_inl_priv.h | 1 +
 7 files changed, 28 insertions(+)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 471b66ec78..d2192cb6f9 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2096,6 +2096,10 @@ struct nix_inline_ipsec_lf_cfg {
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

