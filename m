Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82737606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=TGlGSnW9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FEC140299;
	Fri, 23 Oct 2026 13:40:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BCB0D40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:40:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NADY6e3273187 for <dev@dpdk.org>; Fri, 23 Oct 2026 04:40:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vPsYDYme8/R5Hv1tEmXfVKB
 nTzkwp6/1glPzZZOOViM=; b=TGlGSnW93hOrOUg1Y2IprThVBvvt0LVZWZEV5D3
 UGMAAbeMcpd8C7s+RLOUWanYVwcd7dY4hRBRZpZ3LRtZASf592pvN20YtaZn8yZ6
 YFhb6jNxxK6jdKPTBTNwbu2O82PTsyMtyIy4XKY1xXnNyntbnTWGELIv+JvKWG9q
 I+968UMhM4FqTudalcM7YZV2PZvr4jERhLumltCtyTAS2ASvSx5D/4j1Ft63fzds
 taogq3BuNl9vOn9Z351WAPI+AJzCb3ZWuzhS7WkhR8N28sZGKF7gK/GbATCnF3VM
 67t5SY4KGsq8cyU0pONBH1t7A+XtO3TnQqFqnbErXYSdRqQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hf94b9k3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 Oct 2026 04:40:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Oct 2026 04:40:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Oct 2026 04:40:53 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.42])
 by maili.marvell.com (Postfix) with ESMTP id 615253F7045;
 Fri, 23 Oct 2026 04:40:51 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <gakhil@marvell.com>
CC: <anoobj@marvell.com>, <vvelumuri@marvell.com>, <ktejasree@marvell.com>,
 <dev@dpdk.org>
Subject: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
Date: Fri, 23 Oct 2026 17:10:50 +0530
Message-ID: <20261023114050.2939835-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZZVO7q5lRn6PIFfkssEiR6QqPz9Vww3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NSBTYWx0ZWRfX9YNmNOC79Qfe
 7KRrl/jNbWUff6cRRo0VICHjFvOLS/GuEX+qeMDlLgwymDcp0QVAgh0Y5jgOUUhxJ5U9HF43bPL
 atTbR46tVvO1POuHJHRFtblAACEgNBkIS+M6afYiCWytYcrE4cIgvwxLE0hQUkBNDVbGgrFnvEZ
 kkI+d/8UoT7HGVnDrX3tv3Gzxf/rsXpQeFLMq+g61PyhyL2OIwQvWwzs4ibb8913iXhRBQlVBEe
 +ofgfume3Aj+eO5L2IO/jy8SFM4dgXVZHDHPnZkKFEF61hy1HnXTsHiMoKoc6nDyDH6nt8TTh8V
 Rrbk8jiRyZxbOZqMOL1v31veH/E2XmGsXkl/NGMPP+S/WuX3es5v6QGVDrF3VrsduTbuN8MlCtA
 CNPd6CNvIG4uKz3LHlBtrwn6l24KcTTbzPGxBt+n5ZSNJ2yN0v+dOCr+99Ze5+6G3cSIcRn9g/0
 PvVNRzk5JCQp3CCJsFA==
X-Proofpoint-ORIG-GUID: ZZVO7q5lRn6PIFfkssEiR6QqPz9Vww3o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NSBTYWx0ZWRfXyWLVv6CnpWh2
 5f6tffq8+Q3459YlbhkEeZ5g6LFG+qYcyZ65qL8KPnps+i1AcXe70tvnaODlZ5Lk/2+hS6D3DXj
 l8R9EAzsQuwFPvsJYdJTTPrjCWvV2jo=
X-Authority-Analysis: v=2.4 cv=OrDaWC/t c=1 sm=1 tr=0 ts=6adb47c5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=pkbQFECsS2bYRWXtoVwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch add changes to align with ZUC 256 V2
authentication microcode support.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/roc_se.c                      | 5 +++++
 drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 5 ++++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c          | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index 1cec536169..ce0e7fe84a 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -255,6 +255,11 @@ cpt_pdcp_chain_key_type_get(uint16_t key_len)
 static void
 cpt_zuc_const_update(uint8_t *zuc_const, int key_len, int mac_len)
 {
+	if (key_len == 32 && roc_model_is_cn20k()) {
+		memcpy(zuc_const, zuc_key256_v2, 16);
+		return;
+	}
+
 	if (key_len == 16) {
 		memcpy(zuc_const, zuc_key128, 32);
 	} else if (key_len == 32) {
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 577f080ba7..b941567015 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -2091,7 +2091,10 @@ cn10k_20k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
 			caps->sym.auth.key_size.increment = 16;
 			caps->sym.auth.digest_size.max = 16;
 			caps->sym.auth.digest_size.increment = 4;
-			caps->sym.auth.iv_size.max = 25;
+			if (roc_model_is_cn20k())
+				caps->sym.auth.iv_size.max = 16;
+			else
+				caps->sym.auth.iv_size.max = 25;
 			caps->sym.auth.iv_size.increment = 1;
 		}
 	}
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index a5b8aff146..14a4b0fff9 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -672,8 +672,8 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 	bool ciph_then_auth = false;
 
 	if (roc_model_is_cn20k()) {
-		sess->roc_se_ctx->pdcp_iv_len = 40;
 		sess->roc_se_ctx->pdcp_iv_offset = 16;
+		sess->roc_se_ctx->pdcp_iv_len = 32;
 	} else if (roc_cpt->hw_caps[CPT_ENG_TYPE_SE].pdcp_chain_zuc256) {
 		sess->roc_se_ctx->pdcp_iv_offset = 24;
 		sess->roc_se_ctx->pdcp_iv_len = 48;
-- 
2.34.1

