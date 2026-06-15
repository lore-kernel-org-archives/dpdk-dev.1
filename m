Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB7CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7143540672;
	Mon, 15 Jun 2026 18:26:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A13A4406B7;
 Mon, 15 Jun 2026 18:26:40 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbYa71123713; Mon, 15 Jun 2026 09:26:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 NT3UFip4yNbOoqgg7b1kpLm1mEA+S0hvSSRACFNyqU=; b=eCenQi0pl8onxXgfV
 TviU/6MZSjn/yS4lDmhPReg6tbSm25v+HeH7Bdln8zJZpnTAOlqYark9heJLz5PG
 bQ/HI52sNdYklSDFsO/nrqei0ovMAGza4z2D5SsfHopqqinb4G68HWRPOBhesU/F
 pztljgA6dig9rGWKzletRxi/pIaHdbAwYhTOVD93h8bA0It3vQqJQfg/3dhFlT2P
 UR+xLIRbLw34ZH1MPkhkV5FLAULzQVHi1vDjuO7g87vjS+1Rvyw0CaNxg4nLC2kl
 mPmJPne8dfF4rJA43EayxjovL+xW6vYdXlpvwtQuUdVSZqNIiIh1I5nOHm7DqPgM
 aHDag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk0658-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:26:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:38 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 25ECF3F7063;
 Mon, 15 Jun 2026 09:26:34 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, Alok Mishra <almishra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 09/20] common/cnxk: fix cnxk xstats names
Date: Mon, 15 Jun 2026 21:54:35 +0530
Message-ID: <20260615162446.578336-9-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DQwE4rAD2qgUouKDU0U6G-Z8N1mXimkb
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027bf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=t7CeM3EgAAAA:8 a=zd2uoN0lAAAA:8 a=8AirrxEcAAAA:8 a=7_-gzSzUAAAA:8
 a=x9Bs6-6dp7P_GDFDm7MA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=ST-jHhOKWsTCqRlWije3:22 a=nDOtjJOgdVjDZ0Gs-Dcn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX+qXoJ/HA604U
 VakKrJp72k8B7IdS90LIbJvPospOLKCN/QTd1Wr+IwgklL1bfmPnQwuzCZGlsVqskOZAL7BTDDl
 zdKpmg7qbut5Meq/28vNDAyRcZkpPqc=
X-Proofpoint-GUID: DQwE4rAD2qgUouKDU0U6G-Z8N1mXimkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfXxNNNkPMpxFCm
 IfVMsY1K37wzdtjW3+yPdDOy5aOV+vBtQH/cNpZvo44KbiijYpcQREBG7JxZd0u60XiefVRUMUY
 zz+iHCLFdYRBJ0FlatJaSouxwmnLLZ2W+ub4TTjdVUylTrxonmhhbg0lC6QoGQ1RTUpPgjOCN6e
 qUO4jpJPtFk+KGAbKag/DpeX1LfNDTNgYulW9ZyWL4M0/biWbQZ5uSz1XEplxjrTr2oeCOFp13z
 h1xGatRk6YyzefPH7zmkbAMia62SGxMxnUydQeMWYi3i9Ssc4OSu2OhSu1IZ2Wsf/EZfu5OkE8y
 0K8kWlinD1IirKC8k7XuFf3d5xdI7A1U+4m4Jh+Ikn39MHUr5tGetlfOH4r4KwgJGB+CVMR6uF9
 cTH7miEezeRDSmlJjSskXX0fS59b79+lf0NG0hJrE2gJyOlVmavPdyJKqJ9l4zzJduj3G1Uhl2F
 Xog7sqA06y5OelUcE5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

From: Alok Mishra <almishra@marvell.com>

Prevent out of bounds writes when application provides a smaller
xstat name array. Return required count when xstats_names is NULL
or when the provided buffer is too small,

Fixes: 825bd1d9d8e6 ("common/cnxk: update extra stats for inline device")
Cc: stable@dpdk.org

Signed-off-by: Alok Mishra <almishra@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 .mailmap                            |  1 +
 drivers/common/cnxk/roc_nix_stats.c | 46 ++++++++++++++++-------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..efcb38b6bd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -80,6 +80,7 @@ Alin Rauta <alin.rauta@intel.com>
 Allain Legacy <allain.legacy@windriver.com>
 Allen Hubbe <allen.hubbe@amd.com>
 Alok Makhariya <alok.makhariya@nxp.com>
+Alok Mishra <almishra@marvell.com>
 Alok Prasad <palok@marvell.com>
 Alvaro Karsz <alvaro.karsz@solid-run.com>
 Alvin Zhang <alvinx.zhang@intel.com>
diff --git a/drivers/common/cnxk/roc_nix_stats.c b/drivers/common/cnxk/roc_nix_stats.c
index 6f241c72de..ec2aca8164 100644
--- a/drivers/common/cnxk/roc_nix_stats.c
+++ b/drivers/common/cnxk/roc_nix_stats.c
@@ -503,46 +503,51 @@ roc_nix_xstats_names_get(struct roc_nix *roc_nix,
 	struct idev_cfg *idev = idev_get_cfg();
 	uint64_t i, count = 0;

-	PLT_SET_USED(limit);
-
 	for (i = 0; i < CNXK_NIX_NUM_TX_XSTATS; i++) {
-		NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_tx_xstats, i);
+		if (xstats_names && count < limit)
+			NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_tx_xstats, i);
 		count++;
 	}

 	for (i = 0; i < CNXK_NIX_NUM_RX_XSTATS; i++) {
-		NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_rx_xstats, i);
+		if (xstats_names && count < limit)
+			NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_rx_xstats, i);
 		count++;
 	}

 	if (nix->inb_inl_dev && idev) {
 		if (idev->nix_inl_dev) {
 			for (i = 0; i < CNXK_INL_NIX_NUM_RX_XSTATS; i++) {
-				NIX_XSTATS_NAME_PRINT(xstats_names, count,
-						      inl_nix_rx_xstats, i);
+				if (xstats_names && count < limit)
+					NIX_XSTATS_NAME_PRINT(xstats_names, count,
+							      inl_nix_rx_xstats, i);
 				count++;
 			}
 			for (i = 0; i < CNXK_INL_NIX_RQ_XSTATS; i++) {
-				NIX_XSTATS_NAME_PRINT(xstats_names, count,
-						      inl_nix_rq_xstats, i);
+				if (xstats_names && count < limit)
+					NIX_XSTATS_NAME_PRINT(xstats_names, count,
+							      inl_nix_rq_xstats, i);
 				count++;
 			}
 			for (i = 0; i < PLT_DIM(inl_sw_xstats); i++) {
-				NIX_XSTATS_NAME_PRINT(xstats_names, count, inl_sw_xstats, i);
+				if (xstats_names && count < limit)
+					NIX_XSTATS_NAME_PRINT(xstats_names, count, inl_sw_xstats,
+							      i);
 				count++;
 			}
 		}
 	}

 	for (i = 0; i < CNXK_NIX_NUM_QUEUE_XSTATS; i++) {
-		NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_q_xstats, i);
+		if (xstats_names && count < limit)
+			NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_q_xstats, i);
 		count++;
 	}

 	if (roc_model_is_cn10k() || roc_model_is_cn20k()) {
 		for (i = 0; i < CNXK_NIX_NUM_CN10K_RX_XSTATS; i++) {
-			NIX_XSTATS_NAME_PRINT(xstats_names, count,
-					      nix_cn10k_rx_xstats, i);
+			if (xstats_names && count < limit)
+				NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_cn10k_rx_xstats, i);
 			count++;
 		}
 	}
@@ -552,30 +557,29 @@ roc_nix_xstats_names_get(struct roc_nix *roc_nix,

 	if (roc_model_is_cn9k()) {
 		for (i = 0; i < CNXK_NIX_NUM_RX_XSTATS_CGX; i++) {
-			NIX_XSTATS_NAME_PRINT(xstats_names, count,
-					      nix_rx_xstats_cgx, i);
+			if (xstats_names && count < limit)
+				NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_rx_xstats_cgx, i);
 			count++;
 		}

 		for (i = 0; i < CNXK_NIX_NUM_TX_XSTATS_CGX; i++) {
-			NIX_XSTATS_NAME_PRINT(xstats_names, count,
-					      nix_tx_xstats_cgx, i);
+			if (xstats_names && count < limit)
+				NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_tx_xstats_cgx, i);
 			count++;
 		}

 	} else {
 		for (i = 0; i < CNXK_NIX_NUM_RX_XSTATS_RPM; i++) {
-			NIX_XSTATS_NAME_PRINT(xstats_names, count,
-					      nix_rx_xstats_rpm, i);
+			if (xstats_names && count < limit)
+				NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_rx_xstats_rpm, i);
 			count++;
 		}

 		for (i = 0; i < CNXK_NIX_NUM_TX_XSTATS_RPM; i++) {
-			NIX_XSTATS_NAME_PRINT(xstats_names, count,
-					      nix_tx_xstats_rpm, i);
+			if (xstats_names && count < limit)
+				NIX_XSTATS_NAME_PRINT(xstats_names, count, nix_tx_xstats_rpm, i);
 			count++;
 		}
 	}
-
 	return count;
 }
--
2.34.1

