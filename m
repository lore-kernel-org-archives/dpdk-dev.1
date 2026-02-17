Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97742E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C2740615;
	Tue, 17 Feb 2026 06:44:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6F4064065D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:03 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1hJdT839342 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 hHshMwrmsZkDcXrmTpQGRaeFV/cVGvkhUKYYNCW3yk=; b=O+7vrFWq5UqH5/3Y1
 RcMFfZk7jHRjue4Ceqy4ETmUJdBihByTD3WRD6wRL7wDEhl5C021GktxiJP7rzgi
 5wQkQnJwTLSjkgWof/nju0G1ASSivOtJtkvUJvOWeifXFXSV7bKnnAzuI1yJ7dfF
 27zEaZaw49/Ax0NMquEWwh5vw/u+wPvMXyEg9XIj02YGhZjPe2VX1lTszQcm3wNA
 P2DGIxoS2bbZ+eyHrk5RhqiW2IbQKkseIa8od1/hqX8z8UKK38Av3QF+1iaRCsiW
 5te0h7Rc/f5gisDlgoT2fo7T1tyTgahP/e80r3VdMwc1B5sILpHw3D3Miv/jFpl8
 f5J6A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8cyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:18 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 6AC4B5B696D;
 Mon, 16 Feb 2026 21:43:58 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 02/18] common/cnxk: remove dependency on cryptodev for RXC
Date: Tue, 17 Feb 2026 11:13:29 +0530
Message-ID: <20260217054345.2759687-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=69940022 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=9npsj7kXmYjgGsbYTpYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfXwjL4/V7MZw+v
 /1mDX/O5H62nY3aqOq/tyaVeVH/+wbxyhLc4xEHnppy9NVwp6YtUx1GHu9LGvHEhd3atbD2qQpQ
 tyybWiVEwi9+rU8afj/Nienw0xS75TVdc4bm2wPBHOIIDzCkR0g1GJ2jvcE0LIKYHpVvJFCBaEO
 sk1KhFr6bFuCEP/dETqUjalZoBb1ypqPhkVUoXp1nbmvdpAlZNeqwLRIifaFW35608LnWhL9+qs
 MGackhZH5DSNEzRL2qOfe5duxBAdCLbrOlc17hgsHNyToZSw/vLFhWOIIWSf7Er4P2/6kXzmvP1
 fUXfpHhEry0yaortSzWVdM8qERxNc5BQu79UTUfqUO1+mP2mjvAuwNJDK7YMFrDnuJa3+OWULWd
 pM0fT35CFpDubeQS+kaBRBJ/7x/wcfbA/O0XBIVPvRLd3d+2LvsvTI5ap9AT6UqFvadPdP+raSU
 n6y1j/FeIMbpSKz0pvg==
X-Proofpoint-ORIG-GUID: DlrXMPqnPjv9EglteDi3hGAfjMdX1T5O
X-Proofpoint-GUID: DlrXMPqnPjv9EglteDi3hGAfjMdX1T5O
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

Removes dependency on probe of cryptodev for reassembly
configuration and included RXC queue config for cn20k
platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_inl.c | 15 ++++++++-------
 drivers/common/cnxk/roc_nix_inl.h |  2 ++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 683a9cc7ce..86bafd5c33 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -968,12 +968,6 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	if (!idev)
 		return -EFAULT;

-	roc_cpt = idev->cpt;
-	if (!roc_cpt) {
-		plt_err("Cannot support inline inbound, cryptodev not probed");
-		return -ENOTSUP;
-	}
-
 	cfg.step = req_cfg->step ? req_cfg->step :
 				   (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT);
 	cfg.zombie_limit =
@@ -985,8 +979,14 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	cfg.active_thres =
 		req_cfg->active_thres ? req_cfg->active_thres : ROC_NIX_INL_REAS_ACTIVE_THRESHOLD;

-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k()) {
+		roc_cpt = idev->cpt;
+		if (!roc_cpt) {
+			plt_err("Cryptodev not probed");
+			return -ENOTSUP;
+		}
 		return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
+	}

 	inl_dev = idev->nix_inl_dev;
 	if (!inl_dev) {
@@ -1009,6 +1009,7 @@ roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_
 	req->zombie_thres = cfg.zombie_thres;
 	req->active_limit = cfg.active_limit;
 	req->active_thres = cfg.active_thres;
+	req->cpt_af_rxc_que_cfg = ROC_NIX_INL_RXC_QUE_BLK_THR << 32;

 	rc = mbox_process(mbox);
 exit:
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 7970ac2258..68f395438c 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -41,6 +41,8 @@
 #define ROC_NIX_INL_REAS_ZOMBIE_LIMIT	  0xFFF
 #define ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD 10

+#define ROC_NIX_INL_RXC_QUE_BLK_THR 0x40UL
+
 enum nix_inl_event_type {
 	NIX_INL_CPT_CQ = 1,
 	NIX_INL_SSO,
--
2.34.1

