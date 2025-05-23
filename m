Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3228AC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C1BE40697;
	Fri, 23 May 2025 17:54:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DA5C940DC9
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDjErQ009967
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 JpBzzSseL9ZYbMUHAydw2fVdgdtUyyuTuYVs7JTegw=; b=NJg79jIByU4bZ2Kqu
 lhbKt6dkcSlkHcOS7vC1FV0YoV9IzImUx3SXyKQHDLo6iiKfhbGO5bd/XFK1BotZ
 zSGJBbrmXhl3bKNi91lYM/ubrUurYG7c6M9B05QNzo28Kz6Q/rE3Q6bXcp3yJtvC
 ih7/Jvq8dP2X7eS7eSPlicE2hPDjprzsbAtP+P/7m28rwhgVOfIGs6DaCjYysWbj
 pYC6JIGcr07iKQgKWEA1YjXRRVLcBnT1z5aINxQ432WHGoERCctXDVrEY70ELsGO
 ecINvX+YqqODGhX05C1M7As2T9kzieJy0RsvgtAggeK1SOwioiYP4dYVHisPadPA
 +KzDA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tt5w08as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 2B59D3F7078;
 Fri, 23 May 2025 08:54:23 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 2/6] common/cnxk: config CPT result address for cn20k
Date: Fri, 23 May 2025 21:23:43 +0530
Message-ID: <20250523155347.1156891-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523155347.1156891-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bYBrUPPB c=1 sm=1 tr=0 ts=68309a33 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=GNgiR153GRbNzZcAi6YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xS7SRGfKCWre8PdGQKLcL7ydyCsLJfA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0MyBTYWx0ZWRfX0PyXu3I/vkSJ
 hL8xm4veRbcSjRLqFizBHckUsqjwApGIU+UYjQP2FpcIP9sWlBgkwTWnEv6+eSTKNQlmkso7pWu
 JCfww4m/Lsl5m9yN+eqBYW0vD6dxsw4gmnfinbEbmUJlalwCBxU+7C3dH0z/+0ZYxHiizyEwLW9
 zrD9INoYdkaMyAvwCWal3Ud/glzsseZAJB0UL7aRfqHJ+XNYCYEvASJUX8bef8rduTLz8HO30mg
 0N3iUhoq2DN3wv9TXuKmdd47ZSO4W9ghnZa6W4q6h6HGfbBisyBXU6837r+0seLQndwr+R/TnSk
 XO0zOdfEZJVfKEP023q1FGl23cfZwwZK/mRKS2xWwA2kK9bqzIFa8/36ePh/DCGoVnPTxYBEOEY
 MbMhweWCGeffiP7OybU8OTVyH/R3vhvOfaCuRtLWmfI3UXfjBT/8btQHHSIGYxNU7hMefSS2
X-Proofpoint-GUID: xS7SRGfKCWre8PdGQKLcL7ydyCsLJfA0
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

This configures the CPT result address offset from WQE pointer
in RX_INLINE_CFG0. CPT result address offset is a signed
number in multiple of 16 bytes and configured to the
corresponding reserved space in packet meta area itself.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_inl.c     | 27 ++++++++++++++++++++++++---
 drivers/common/cnxk/roc_nix_inl_dev.c | 19 +++++++++++++++----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 6afdfb6b85..7e47151eee 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -399,6 +399,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa, i, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
+	uint64_t res_addr_offset;
 	uint8_t profile_id = 0;
 	struct mbox *mbox;
 	size_t inb_sa_sz;
@@ -497,11 +498,16 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 				def_cptq = inl_dev->nix_inb_qids[0];
 		}

+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
+
 		lf_cfg->enable = 1;
 		lf_cfg->profile_id = profile_id; /* IPsec profile is 0th one */
 		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
-		lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
-					  (sa_pow2_sz << 16) | lenm1_max);
+		lf_cfg->rx_inline_cfg0 =
+			((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
+			 (sa_pow2_sz << 16) | lenm1_max);
 		lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_idx_w << 32);
 	}

@@ -570,9 +576,13 @@ static int
 nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct idev_cfg *idev = idev_get_cfg();
 	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa = 1, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
+	uint64_t res_addr_offset;
+	uint64_t def_cptq = 0;
 	size_t inb_sa_sz = 1;
 	uint8_t profile_id;
 	struct mbox *mbox;
@@ -612,11 +622,22 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	sa_idx_w = plt_log2_u32(max_sa);
 	lenm1_max = roc_nix_max_pkt_len(roc_nix) - 1;

+	if (idev && idev->nix_inl_dev) {
+		inl_dev = idev->nix_inl_dev;
+		if (inl_dev->nb_inb_cptlfs)
+			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+	}
+
+	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+	if (res_addr_offset)
+		res_addr_offset |= (1UL << 56);
+
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
 	lf_cfg->rx_inline_cfg0 =
-		(((uint64_t)SSO_TT_ORDERED << 44) | (sa_pow2_sz << 16) | lenm1_max);
+		((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
+		 (sa_pow2_sz << 16) | lenm1_max);
 	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_idx_w << 32);

 	rc = mbox_process(mbox);
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 1db05741ad..1f071df8ea 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -376,6 +376,7 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 		}
 	} else {
 		struct nix_rx_inl_lf_cfg_req *lf_cfg;
+		uint64_t res_addr_offset;
 		uint64_t def_cptq;

 		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
@@ -390,13 +391,17 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 		else
 			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];

+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
+
 		lf_cfg->profile_id = inl_dev->ipsec_prof_id;
 		if (ena) {
 			lf_cfg->enable = 1;
 			lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
 			lf_cfg->rx_inline_cfg0 =
-				((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
-				 (sa_pow2_sz << 16) | lenm1_max);
+				((def_cptq << 57) | res_addr_offset |
+				 ((uint64_t)SSO_TT_ORDERED << 44) | (sa_pow2_sz << 16) | lenm1_max);
 			lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);
 		} else {
 			lf_cfg->enable = 0;
@@ -611,6 +616,7 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
 	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
 	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	uint64_t res_addr_offset;
 	uint64_t def_cptq;
 	size_t inb_sa_sz;
 	void *sa;
@@ -646,11 +652,16 @@ nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
 	else
 		def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id + 1];

+	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+	if (res_addr_offset)
+		res_addr_offset |= (1UL << 56);
+
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
-	lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
-				  (sa_pow2_sz << 16) | lenm1_max);
+	lf_cfg->rx_inline_cfg0 =
+		((def_cptq << 57) | res_addr_offset | ((uint64_t)SSO_TT_ORDERED << 44) |
+		 (sa_pow2_sz << 16) | lenm1_max);
 	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);

 	rc = mbox_process(mbox);
--
2.25.1

