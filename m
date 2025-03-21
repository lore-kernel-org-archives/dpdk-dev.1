Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFEC36002
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 09:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A67CD4066F;
	Fri, 21 Mar 2025 10:48:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D751340276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 10:48:27 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7kD9w017847
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=iBQqwVyY98FEXcjDQSvxhCd
 ixVkA3Hm5BjkczIhQj2o=; b=Cq5ugJQdkwnt5llbd/9gbe6ekszPPfQWMCLd4V4
 fUoeSGiJ7E82o6tKtdl1FoSJ7wGqxG+BvtWJKQH7kpknxfIOtiwluU4BWS05Nizd
 F8Ch3mwhP699DxqKmyAv+JKHVxVapYhVAmoQ1aOl+35/CgmmWi3pIxZwasWNBsMm
 ZQAifoFV14c0r/4kfKgoGLg6Q3BmJf+NgM45jusvaa3UUkJ93e7K2n1XgOXfLMCa
 48qjzsjM1DRqGjpXl4ulj4O6AyEU45l+zIXiSjTR6BFKlG0lMWPTivja/m/2qzZG
 cg7PWl6H/QO24opa+sEfmS6pnY+ilvMAwNvcAWo6P3ulxXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45h40xr6hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:48:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Mar 2025 02:48:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Mar 2025 02:48:26 -0700
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 830AC5E6871;
 Fri, 21 Mar 2025 02:48:23 -0700 (PDT)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: [dpdk-dev] [PATCH 1/2] common/cnxk: support fragmented flags in KPU
 profile
Date: Fri, 21 Mar 2025 15:18:19 +0530
Message-ID: <20250321094820.3311252-1-psatheesh@marvell.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I+9lRMgg c=1 sm=1 tr=0 ts=67dd35ea cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=EHSVFVtSShkB71JC5PgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _MFn7IokZNwp4f9lekMKXzi4zznmbeZx
X-Proofpoint-ORIG-GUID: _MFn7IokZNwp4f9lekMKXzi4zznmbeZx
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

From: Satheesh Paul <psatheesh@marvell.com>

In the CN20K device, only 4 bits are available for flags.
Adjust the fragmented flags to fit into the lower 4 bits.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Jerin Jacob <jerinj@marvell.com>
---
 drivers/common/cnxk/hw/npc.h        | 12 ++++++++++++
 drivers/common/cnxk/roc_npc_parse.c | 12 ++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/npc.h b/drivers/common/cnxk/hw/npc.h
index 4164c6ac2e..52b41a1a54 100644
--- a/drivers/common/cnxk/hw/npc.h
+++ b/drivers/common/cnxk/hw/npc.h
@@ -314,6 +314,18 @@ enum npc_kpu_lb_lflag {
 	NPC_F_LB_L_FDSA,
 };
 
+enum npc_cn20k_kpu_lc_uflag {
+	NPC_CN20K_F_LC_U_MPLS_IN_IP = 0x20,
+	NPC_CN20K_F_LC_U_IP6_TUN_IP6 = 0x40,
+	NPC_CN20K_F_LC_U_IP6_MPLS_IN_IP = 0x80,
+};
+
+enum npc_cn20k_kpu_lc_lflag {
+	NPC_CN20K_F_LC_L_IP_FRAG = 2,
+	NPC_CN20K_F_LC_L_IP6_FRAG,
+	NPC_CN20K_F_LC_L_6TO4,
+};
+
 enum npc_kpu_lc_uflag {
 	NPC_F_LC_U_UNK_PROTO = 0x10,
 	NPC_F_LC_U_IP_FRAG = 0x20,
diff --git a/drivers/common/cnxk/roc_npc_parse.c b/drivers/common/cnxk/roc_npc_parse.c
index 0aaf86c768..b52024f434 100644
--- a/drivers/common/cnxk/roc_npc_parse.c
+++ b/drivers/common/cnxk/roc_npc_parse.c
@@ -1,7 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2021 Marvell.
  */
+
 #include "roc_api.h"
+#include "roc_model.h"
 #include "roc_priv.h"
 
 const struct roc_npc_item_info *
@@ -708,7 +710,10 @@ npc_handle_ipv6ext_attr(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
 		flags_count++;
 	}
 	if (ipv6_spec->has_frag_ext) {
-		*flags = NPC_F_LC_U_IP6_FRAG;
+		if (roc_model_is_cn20k())
+			*flags = NPC_CN20K_F_LC_L_IP6_FRAG;
+		else
+			*flags = NPC_F_LC_U_IP6_FRAG;
 		flags_count++;
 	}
 	if (ipv6_spec->has_dest_ext) {
@@ -822,7 +827,10 @@ npc_process_ipv6_item(struct npc_parse_state *pst)
 		} else if (pattern->type == ROC_NPC_ITEM_TYPE_IPV6_FRAG_EXT) {
 			item_count++;
 			ltype = NPC_LT_LC_IP6_EXT;
-			flags = NPC_F_LC_U_IP6_FRAG;
+			if (roc_model_is_cn20k())
+				flags = NPC_CN20K_F_LC_L_IP6_FRAG;
+			else
+				flags = NPC_F_LC_U_IP6_FRAG;
 			parse_info.len =
 				sizeof(struct roc_ipv6_hdr) + sizeof(struct roc_ipv6_fragment_ext);
 			if (pattern->spec)
-- 
2.42.0

