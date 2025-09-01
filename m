Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07ECA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C93BD406BC;
	Mon,  1 Sep 2025 09:32:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 95282406BC
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5810Uhqh012211;
 Mon, 1 Sep 2025 00:32:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 VRD8g5klX5H4pEoQAXkRJKx2mcdwnqAH3bnUNDC68Q=; b=GzpQGkdyxwcgcYlJG
 3n7K6K+HQiHDb2VXsZgGrMCjNvUKui7xWgL1bSDk4cvFV+LZ7wlt8Nbba3CpnUcW
 0tNNYRR+ocIFnqaKMVxon7wqSjPr6xMYLNIS0UhGe03AkSpbVL9CdWErP7mXpFj9
 KKkZLMSqkLkXXb7mfE3BcN057x0S0I/ONzjzm1ZJwUgX8VT6UrMkU+9jv00PmD7L
 PiuEtr9v88jSL01TDXjAJ99H3m2MOUuqeHvPYQ3KuGNTBDqxbmKQSmPSMZuSvbvG
 Kalf+ng1Bou/Y8pwXXjOA4rF1CqhQ1TqVlqhhxyHedJNCPW3zV6g3WdNMwO908e8
 n+t8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48uxnktgwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 00:32:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:32:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:32:24 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0370C3F70AC;
 Mon,  1 Sep 2025 00:32:20 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH 19/19] drivers: fix Klocwork issues
Date: Mon, 1 Sep 2025 13:00:35 +0530
Message-ID: <20250901073036.1381560-19-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hgCTAZl99xCY1nlv1C1LPBWYhwlDgIQv
X-Authority-Analysis: v=2.4 cv=EqTSrTcA c=1 sm=1 tr=0 ts=68b54c09 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=02K0Y2VpAAAA:8 a=yBKhqCqsAAAA:8
 a=20KFwNOVAAAA:8 a=lOrjXhgRObHz-F5jIjYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=SVpKTQGeYiyENV88YW8K:22 a=u5H4eTi2zCHWd_3L5ZMT:22
X-Proofpoint-GUID: hgCTAZl99xCY1nlv1C1LPBWYhwlDgIQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA5MyBTYWx0ZWRfX8Ec52SUIuLDy
 mBK3E726Guu2+ClCWRVEkkdkcjAlfbBHGLHIFk3qPOxSVht4XKODgxW717BGqGHjV15s/m2QZOz
 egLIMVOnW5lpQhkK4Sr1HU3SX2avTtALmcAQaC1/Feps2kQiwXB0qYFX/fqg2rVfpa31EKMkzul
 GdIfT2H/faKpCwRQkjZ0ZMVllKLcAgfBLUQpIEVNMLMft5qjiQxSV1FNPbpcXvuzdc5W+DVtzCd
 /MQhiuzq+uSpnSEtFbz5X1YtAHUFnvC37n1q4DEx5/cmqkuDzZAMF0CxbtormLSRM2Qf/OxvCc/
 IivxbwIPeNMmmi6I7upJDLxNTl2WE8qhkJ1dqDFCJmMfFZ4hi/b++lwJVDwT2tq8TZrp2h4QW2k
 yjrZFGXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

From: Aarnav JP <ajp@marvell.com>

fixed klocwork suggested issues in
cnxk component of drivers module

Fixes: db5744d3cd23 ("common/cnxk: support NIX debug for CN20K")
Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K")
Fixes: 4b8eb5bd6627 ("common/cnxk: reserve CPT LF for Rx inject")
Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 .mailmap                            |  1 +
 drivers/common/cnxk/roc_nix_debug.c |  4 ++--
 drivers/common/cnxk/roc_nix_inl.c   | 13 ++++++-------
 drivers/net/cnxk/cn10k_ethdev_sec.c |  2 ++
 drivers/net/cnxk/cnxk_ethdev_mtr.c  |  8 +++++++-
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..309551d007 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,5 @@
 Aakash Sasidharan <asasidharan@marvell.com>
+Aarnav JP <ajp@marvell.com>
 Aaro Koskinen <aaro.koskinen@nsn.com>
 Aaron Campbell <aaron@arbor.net>
 Aaron Conole <aconole@redhat.com>
diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index f9294e693b..11994bf131 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -769,8 +769,8 @@ nix_lf_rq_dump(__io struct nix_cn20k_rq_ctx_s *ctx, FILE *file)
 
 	nix_dump(file, "W2: xqe_hdr_split \t\t%d\nW2: xqe_imm_copy \t\t%d",
 		 ctx->xqe_hdr_split, ctx->xqe_imm_copy);
-	nix_dump(file, "W2: band_prof_id\t\t%d\n",
-		 ((ctx->band_prof_id_h << 10) | ctx->band_prof_id_l));
+	nix_dump(file, "W2: band_prof_id\t\t0x%" PRIx64 "\n",
+		 (uint64_t)((ctx->band_prof_id_h << 10) | ctx->band_prof_id_l));
 	nix_dump(file, "W2: xqe_imm_size \t\t%d\nW2: later_skip \t\t\t%d",
 		 ctx->xqe_imm_size, ctx->later_skip);
 	nix_dump(file, "W2: sso_bp_ena\t\t%d\n", ctx->sso_bp_ena);
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index a5fc33b5c9..9135c1c172 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -581,7 +581,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa = 1, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
-	uint64_t res_addr_offset;
+	uint64_t res_addr_offset = 0;
 	uint64_t def_cptq = 0;
 	size_t inb_sa_sz = 1;
 	uint8_t profile_id;
@@ -626,12 +626,11 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		inl_dev = idev->nix_inl_dev;
 		if (inl_dev->nb_inb_cptlfs)
 			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+		res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
+		if (res_addr_offset)
+			res_addr_offset |= (1UL << 56);
 	}
 
-	res_addr_offset = (uint64_t)(inl_dev->res_addr_offset & 0xFF) << 48;
-	if (res_addr_offset)
-		res_addr_offset |= (1UL << 56);
-
 	lf_cfg->enable = 1;
 	lf_cfg->profile_id = profile_id;
 	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
@@ -850,12 +849,12 @@ roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inb_inl_dev)
 
 	if (inb_inl_dev) {
 		inl_dev = idev->nix_inl_dev;
-		if (inl_dev && inl_dev->attach_cptlf && inl_dev->rx_inj_ena &&
+		if (inl_dev && inl_dev->attach_cptlf && inl_dev->rx_inj_ena && roc_nix &&
 		    roc_nix->rx_inj_ena)
 			return true;
 	}
 
-	return roc_nix->rx_inj_ena;
+	return roc_nix ? roc_nix->rx_inj_ena : 0;
 }
 
 uint32_t
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 110630596e..5ecdc2b463 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -1336,6 +1336,8 @@ cn10k_eth_sec_rx_inject_config(void *device, uint16_t port_id, bool enable)
 	roc_idev_nix_rx_inject_set(port_id, enable);
 
 	inl_lf = roc_nix_inl_inb_inj_lf_get(nix);
+	if (!inl_lf)
+		return -ENOTSUP;
 	sa_base = roc_nix_inl_inb_sa_base_get(nix, dev->inb.inl_dev);
 
 	inj_cfg = &dev->inj_cfg;
diff --git a/drivers/net/cnxk/cnxk_ethdev_mtr.c b/drivers/net/cnxk/cnxk_ethdev_mtr.c
index edeca6dcc3..992e2d446e 100644
--- a/drivers/net/cnxk/cnxk_ethdev_mtr.c
+++ b/drivers/net/cnxk/cnxk_ethdev_mtr.c
@@ -1261,7 +1261,13 @@ nix_mtr_config_map(struct cnxk_meter_node *mtr, struct roc_nix_bpf_cfg *cfg)
 
 	cfg->alg = alg_map[profile->profile.alg];
 	cfg->lmode = profile->profile.packet_mode;
-	cfg->icolor = color_map[mtr->params.default_input_color];
+	int idx = mtr->params.default_input_color;
+
+	/* Index validation */
+	if (idx >= RTE_COLORS)
+		cfg->icolor = ROC_NIX_BPF_COLOR_GREEN;
+	else
+		cfg->icolor = color_map[idx];
 
 	switch (RTE_MTR_COLOR_IN_PROTO_OUTER_IP) {
 	case RTE_MTR_COLOR_IN_PROTO_OUTER_IP:
-- 
2.34.1

