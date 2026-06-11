Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D99CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F36B432E0;
	Thu, 11 Jun 2026 16:22:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6DA3E432C8;
 Thu, 11 Jun 2026 16:22:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVkc2190486; Thu, 11 Jun 2026 07:22:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 K7FJDF8DkrctlKQTtRRc8Gq4/hsnf4/wLjYOn2bc4I=; b=WLB0jWKbSyvKU9a06
 yLIC7IuUeDV85GQJ6EEILsuVmD1mYyavSR0asnoIhc9aIlVMCMUnAAICW5YR7PPq
 cs8e4nHEyTYLFTjLlOMefOW5s3s+CLuu4FH0+SixMBNOqcIOUlcp9XJJzfmC8069
 ZQSk1Efpr2hNySIez/xqLVM8Sotj0CLvn++aVBuwgGP/KrCROYIbFrEjPHMamPwS
 Y/XrDLPd83bE2Y5o7XCp81G8txHp3vcCWjj//BedTQvoQunjKWFMp1d0oClM31Fw
 s1vjcSE8hgJ+okf9DeUPAekyxAqgSeDY9LKK2HVj6WxNFWmxEnccMuaZb5aEieM5
 JsiHQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb862-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:22:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:22:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:22:30 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E78C65B6974;
 Thu, 11 Jun 2026 07:22:27 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 22/22] common/cnxk: fix TM link config selection in debug
 dump
Date: Thu, 11 Jun 2026 19:50:29 +0530
Message-ID: <20260611142029.3351415-22-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac4a7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=Z8oDhAq_kd8QiYM-ZfAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: NKAMoi63aQOevzdYMnYbebBm0CegqYnA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXyk5eqmWA9hDF
 9GzpbXqFeWLwpCEjgL0WBR6w7rIsncQr5nHngpabo957ZJu1TbUa/lCLxxOybND9WBqLbaf2gps
 jTWLEttQ/mndOYcexYc0oJYxKDPbmws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX07cyo9d5Fz2g
 JngItR8k1Rhma2EF0Q9LCQ84EBcTYaGXDvb8GNaD5JWiTzQmjPy3RQQWQTQGrgzmtuwxdHIWNeA
 gUZQa0s0Z/f3w4o74hW8TW6wtgonfJT4afkabYpBEONqxTcWdUCFxkJ5y4DEA41ujZy59mMn3fd
 lGrAKmLBfOMmamftjjmSM/H/DBaQnt4g2gcnEjAzaYa29VKg0yerKgM8WrKl+asLJMu/cBe07lS
 7T5TTDjxZ357vduPZB3GNNjJqZJLxkWMYWTeLSuK48ZpKsuw6OtA3D5cHXqy6CEzRMwjsoBrbtq
 G3lRP/Q6ZBGoLj2kilU+D5Wy8cnmbv8gF3p5ahxmdQ1iAygpdXqNmYBqYpnOOk4NI+smQcSbUOi
 /4MCej6EwlhpedV5pZFlZztrt/ZIHlU0GH9LjRC8Q60/3oPRMb0/SlePRB01m+sEH9QcOFwAUyX
 taebc7KY/HW/1aYhU0w==
X-Proofpoint-ORIG-GUID: NKAMoi63aQOevzdYMnYbebBm0CegqYnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

From: Satha Rao <skoteshwar@marvell.com>

Only emit the TM link configuration register when the configured TM
link level matches the hardware level being dumped, and use nix->tx_link
for the register and label so the dump reflects the active link.

Fixes: fcdef46b6698 ("common/cnxk: support NIX TM debug and misc utils")
Cc: stable@dpdk.org

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_debug.c | 31 +++++++++++++++++++----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index d4b2b86916..9c3bc8abe3 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -1150,7 +1150,7 @@ roc_nix_sq_dump(struct roc_nix_sq *sq, FILE *file)
 };

 static uint8_t
-nix_tm_reg_dump_prep(uint16_t hw_lvl, uint16_t schq, uint16_t link,
+nix_tm_reg_dump_prep(struct nix *nix, uint16_t hw_lvl, uint16_t schq,
 		     uint64_t *reg, char regstr[][NIX_REG_NAME_SZ])
 {
 	FILE *file = NULL;
@@ -1228,9 +1228,14 @@ nix_tm_reg_dump_prep(uint16_t hw_lvl, uint16_t schq, uint16_t link,
 		snprintf(regstr[k++], NIX_REG_NAME_SZ,
 			 "NIX_AF_TL3[%u]_TOPOLOGY", schq);

-		reg[k] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, link);
-		snprintf(regstr[k++], NIX_REG_NAME_SZ,
-			 "NIX_AF_TL3_TL2[%u]_LINK[%u]_CFG", schq, link);
+		/* Link configuration */
+		if (!nix->sdp_link &&
+		    nix->tm_link_cfg_lvl == NIX_TXSCH_LVL_TL3) {
+			reg[k] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, nix->tx_link);
+			snprintf(regstr[k++], NIX_REG_NAME_SZ,
+				 "NIX_AF_TL3_TL2[%u]_LINK[%u]_CFG", schq,
+				 nix->tx_link);
+		}

 		reg[k] = NIX_AF_TL3X_SCHEDULE(schq);
 		snprintf(regstr[k++], NIX_REG_NAME_SZ,
@@ -1261,9 +1266,14 @@ nix_tm_reg_dump_prep(uint16_t hw_lvl, uint16_t schq, uint16_t link,
 		snprintf(regstr[k++], NIX_REG_NAME_SZ,
 			 "NIX_AF_TL2[%u]_TOPOLOGY", schq);

-		reg[k] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, link);
-		snprintf(regstr[k++], NIX_REG_NAME_SZ,
-			 "NIX_AF_TL3_TL2[%u]_LINK[%u]_CFG", schq, link);
+		/* Link configuration */
+		if (!nix->sdp_link &&
+		    nix->tm_link_cfg_lvl == NIX_TXSCH_LVL_TL2) {
+			reg[k] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, nix->tx_link);
+			snprintf(regstr[k++], NIX_REG_NAME_SZ,
+				 "NIX_AF_TL3_TL2[%u]_LINK[%u]_CFG", schq,
+				 nix->tx_link);
+		}

 		reg[k] = NIX_AF_TL2X_SCHEDULE(schq);
 		snprintf(regstr[k++], NIX_REG_NAME_SZ,
@@ -1370,8 +1380,7 @@ nix_tm_dump_lvl(struct nix *nix, struct nix_tm_node_list *list, uint8_t hw_lvl)
 			root = node;

 		/* Dump registers only when HWRES is present */
-		k = nix_tm_reg_dump_prep(node->hw_lvl, schq, nix->tx_link, reg,
-					 regstr);
+		k = nix_tm_reg_dump_prep(nix, node->hw_lvl, schq, reg, regstr);
 		if (!k)
 			continue;

@@ -1396,8 +1405,8 @@ nix_tm_dump_lvl(struct nix *nix, struct nix_tm_node_list *list, uint8_t hw_lvl)

 	/* Dump TL1 node data when root level is TL2 */
 	if (root && root->hw_lvl == NIX_TXSCH_LVL_TL2) {
-		k = nix_tm_reg_dump_prep(NIX_TXSCH_LVL_TL1, root->parent_hw_id,
-					 nix->tx_link, reg, regstr);
+		k = nix_tm_reg_dump_prep(nix, NIX_TXSCH_LVL_TL1,
+					 root->parent_hw_id, reg, regstr);
 		if (!k)
 			return;

--
2.34.1

