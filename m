Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0DC35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 604B84066F;
	Fri, 21 Mar 2025 11:04:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D983340276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 11:04:03 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7kEh3017881
 for <dev@dpdk.org>; Fri, 21 Mar 2025 03:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=nNbvdX6S9wHfi5fU6eftDw3
 rTA3jUB4U55bB1cJC9xc=; b=kTQchpisy0KX+9/I7BhJX9ipF7b23QYuz6cypzS
 wPk7ZdGNuH4dBkbADig8LTur47bmezgt6cSKVysw0gPHv2cwnPfcbzE7wKbbDNPk
 wzW5GF/wcpYZYofhDFEnb6vYd0nMwwxtfUb97d3iyGke8eXHsL2M56xBn+QSUL2z
 bYb1i/WYTbDr7fqIngx/4lmmyzwWgqELTYoh8W6Cb2hqdPkime2YFQ7KTCNLdQmR
 VXxFbNVFonelptos8KPgVau4jkN3WdfTiLGTsoGe1Z4V3f5auwpoFlQZLjOqBDs7
 WRPnog+R0121HEfIUfivStop/dkhKwE6C9SuoG0lJH3QTlA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45h40xr7cb-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 21 Mar 2025 03:04:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Mar 2025 03:04:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Mar 2025 03:04:01 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 2018E5E6868;
 Fri, 21 Mar 2025 03:03:58 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 1/3] common/cnxk: update steer rule mbox for cn20k
Date: Fri, 21 Mar 2025 15:33:41 +0530
Message-ID: <20250321100343.1081664-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I+9lRMgg c=1 sm=1 tr=0 ts=67dd3992 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=Qdo4M9rsI19lQE8tNRkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xiEgbUCGkIq9BMKsJtEIZLRPEu-6ZBq3
X-Proofpoint-ORIG-GUID: xiEgbUCGkIq9BMKsJtEIZLRPEu-6ZBq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
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

Updated mbox npc_cn20k_read_base_steer_rule for cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_npc.c      | 3 ++-
 drivers/common/cnxk/roc_npc_mcam.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 94d5cc84f8..0d75589977 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -1885,11 +1885,11 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 		goto exit;
 	}
 
-	(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 	if (roc_model_is_cn20k()) {
 		struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
 		struct cn20k_mcam_entry *base_entry;
 
+		(void)mbox_alloc_msg_npc_cn20k_read_base_steer_rule(mbox);
 		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 		if (rc) {
 			plt_err("Failed to fetch VF's base MCAM entry");
@@ -1905,6 +1905,7 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 		struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 		struct mcam_entry *base_entry;
 
+		(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 		if (rc) {
 			plt_err("Failed to fetch VF's base MCAM entry");
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 3aa7ff56a9..dbb11b1ad9 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -1294,11 +1294,11 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 			mbox = mbox_get(pst->flow->rep_mbox);
 		else
 			mbox = mbox_get(npc->mbox);
-		(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 		if (roc_model_is_cn20k()) {
 			struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
 			struct cn20k_mcam_entry *base_entry;
 
+			(void)mbox_alloc_msg_npc_cn20k_read_base_steer_rule(mbox);
 			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 			if (rc) {
 				mbox_put(mbox);
@@ -1316,6 +1316,7 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 			struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 			struct mcam_entry *base_entry;
 
+			(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 			if (rc) {
 				mbox_put(mbox);
-- 
2.25.1

