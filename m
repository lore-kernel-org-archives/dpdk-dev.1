Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A61C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 10:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C1B1402D1;
	Thu, 22 May 2025 12:11:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 95788402CA;
 Thu, 22 May 2025 12:11:25 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9HDZi007707;
 Thu, 22 May 2025 03:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=9LP5eXnJCMB7H1eXLRehSVX
 Oj7Cpzgm1/zU031uSAKQ=; b=f+djd5Ofwt1cyjtuo/ws+JNeiytPsNKoixEd+el
 rxUaZRrlJisj91KKj2/+0oMzTjxQw2T67OFT5gp9kdkFXXDLO08Cj/qJCbpm23Ww
 nMShhZ9xSLiQ/2QsKkEleOya3p9JaawSP2NchVEV7mU4Tyr3/WqzAv0zjeP1OF+p
 /hREy69zbvpwJx7RAz28Zcd0Yit3Qb+8VP/+I5d2+ayGf4Ayx6ggLcyhHz+Psvjp
 uTf/Rmh/14vsieb7C9UXVDetOUUspafTh526oU4OLdeysUgldVorzX+zzAGghU4g
 rTdXbntZs4MboBt6LNzjOu8lV8392wDiXabN2Q65X/p6tGA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46t15jr3st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 03:11:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 May 2025 03:11:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 May 2025 03:11:23 -0700
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 275553F7083;
 Thu, 22 May 2025 03:11:19 -0700 (PDT)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>, <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH ] common/cnxk: fix E-tag pattern parsing
Date: Thu, 22 May 2025 15:41:16 +0530
Message-ID: <20250522101116.2134691-1-psatheesh@marvell.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: maZVpMfE_bGYYzdd2iMttAjfB9jnW8Yn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwMiBTYWx0ZWRfX1LMmDHWID7Xa
 ZOmVijP4d5eIWxeNWXPuM37wI3KIv3Ki0Ll1qjCcSP9MyFHS8LtTkG3z9/qgtSEvP3IOWNkz6sc
 JOEuTUOJ406o1j30135tLfBXi4QaIgr6OYDFqQQqTrinCtKeYMY1/h/72wtB1/u+VZjQirXWO1R
 esMOa2mLn6I91tS6hzsFE3GlNn+0c7g4LbUHFksMKGBrIAUS5k6HiLqHBUA0zeZ3LB4qfjrI4eH
 mp6t48EBoa4tbNYZpiAPpCfqLKtjuBWRCwbDwHIoknEVWKzhVJCrtN0W8cmTcK2GVMp4lzjQC4c
 gUCuxGBz2xlm1/eeqfLlsMcS+eICCcGfcMoBIfjf8iOAN9R4xdin2+T+jWpQr5ybuBFdOgXza+4
 QyFLwDT2DXFmHR53uqz88CYBYFL9VAolYZg/qS0A77GH5wWoQYjnCKbcs11P8e+uFnMQTlb2
X-Authority-Analysis: v=2.4 cv=HOrDFptv c=1 sm=1 tr=0 ts=682ef84c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=1uL9xh9gfbwcqrQVKPwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: maZVpMfE_bGYYzdd2iMttAjfB9jnW8Yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
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

From: Satheesh Paul <psatheesh@marvell.com>

E-tag pattern parsing was using wrong length leading
to a segfault. Fixing this by using the correct length
of the pattern item.

Fixes: c34ea71b878d ("common/cnxk: add NPC parsing API")
Cc: stable@dpdk.org

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/common/cnxk/roc_npc.c       | 5 +++--
 drivers/common/cnxk/roc_npc_parse.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 3fd59667d8..3fa3ddcbfc 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -995,10 +995,11 @@ npc_parse_pattern(struct npc *npc, const struct roc_npc_item_info pattern[],
 	pst->mcam_data = (uint8_t *)flow->mcam_data;
 	pst->mcam_mask = (uint8_t *)flow->mcam_mask;
 
-	while (pattern->type != ROC_NPC_ITEM_TYPE_END &&
-	       layer < PLT_DIM(parse_stage_funcs)) {
+	while (pattern->type != ROC_NPC_ITEM_TYPE_END && layer < PLT_DIM(parse_stage_funcs)) {
 		/* Skip place-holders */
 		pattern = npc_parse_skip_void_and_any_items(pattern);
+		if (pattern->type == ROC_NPC_ITEM_TYPE_END)
+			break;
 
 		pst->pattern = pattern;
 		rc = parse_stage_funcs[layer](pst);
diff --git a/drivers/common/cnxk/roc_npc_parse.c b/drivers/common/cnxk/roc_npc_parse.c
index b52024f434..37b43995db 100644
--- a/drivers/common/cnxk/roc_npc_parse.c
+++ b/drivers/common/cnxk/roc_npc_parse.c
@@ -531,6 +531,7 @@ npc_parse_lb(struct npc_parse_state *pst)
 		 */
 		lt = NPC_LT_LB_ETAG;
 		lflags = 0;
+		info.len = pattern->size;
 
 		last_pattern = pst->pattern;
 		pattern = npc_parse_skip_void_and_any_items(pst->pattern + 1);
@@ -545,7 +546,6 @@ npc_parse_lb(struct npc_parse_state *pst)
 			lflags = NPC_F_ETAG_CTAG;
 			last_pattern = pattern;
 		}
-		info.len = pattern->size;
 	} else if (pst->pattern->type == ROC_NPC_ITEM_TYPE_QINQ) {
 		info.hw_mask = NULL;
 		info.len = pattern->size;
-- 
2.42.0

