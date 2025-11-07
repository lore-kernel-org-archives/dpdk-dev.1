Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913D440DCF;
	Fri,  7 Nov 2025 11:49:07 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8B5AB40B9C
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:49:05 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKcQk2929983 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:49:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 am0fSgfdjMC6Q+1ePkGZs+iG38GDxc4dOin1kkGteQ=; b=dldJYcvluH0dBZS78
 T4j3XfN5QhWapszG82tAxoAW6PaUIgpkLcTzHPDrTOo1jwzP3KFMnppAxCEAaZz1
 gjAR9YdZNUdGrv5LaPvm4CvcbHc4A3agSUiWtVwuaLwTRASeO0KQTlLqcCn8WxnC
 FFX2nm9+WHcnlGx2+91S5SroZ021G6arCCMeztr1EssR5DSacJQVNg7OlRjVnc3U
 bxtPQNHJi1M6FbbzMzCx6hbB1NWKEN6scOOq4rQCcwBbtho15BIVG95e1rgTcYFp
 0TMciSCc1MLJ2bIAQDn9L51U1KI46cDyBjYrTaDjJZvN4H5itDqkyrTozJ+Vw836
 SvLPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:49:04 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:49:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:49:15 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 770463F70C7;
 Fri,  7 Nov 2025 02:49:01 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v4 23/23] net/cnxk: check for invalid default pre color
Date: Fri, 7 Nov 2025 16:17:47 +0530
Message-ID: <20251107104747.1131008-23-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX9+ytKsL3CXEJ
 gLatJEDTxRK3iZ/YX3Tn6+HCDiaq3tlsCfJzeAZcuwAcZg+IFy6NXfaMFJCIM7zbOZot2PnNClw
 KW4bFm3Cmev3hldgDG7+nZgkeIpZPSbrIuyXH70ELZR/K+Ddm1zl7koBxiFk1qPsrISds4NqX26
 gP8ehIbPd8rH1+g6pS6/gBw7b40nkKNQI+YFdlDvEvbZznStLe+viIJaEN8uSHwc+1C8S24pVgV
 KYEcZD8nY2+k5r6NQ6DNNfwaHSQP7SgLPZxNGPAiZRX+bF5aPrLzSZX/lkLrpgVDA8BC+NohEaU
 BoCLxyeSVJv6+VTbwFZE1jO312q6ztEwNHAT//8mrewgjkAkxtkjYGYBcMqiTwkPysua119d4FI
 SNu8f6nYCZ6BY/4TLr2jn8FzENtONA==
X-Proofpoint-ORIG-GUID: -4pkY5snVchcv5GPwqdTj1o1ZXQFXim7
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dcea0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=82TJYTXjL4OvB1Y1nJoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -4pkY5snVchcv5GPwqdTj1o1ZXQFXim7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

While converting to HW specific icolor, check for invalid
default pre color.
Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_mtr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

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

