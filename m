Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158CCCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF5340EF1;
	Thu, 13 Nov 2025 05:40:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 677B140FDE
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:40:15 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMrE7L1057311 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 am0fSgfdjMC6Q+1ePkGZs+iG38GDxc4dOin1kkGteQ=; b=TTqgH4eBi6haZXB6w
 qBd+wTKYkrZNjP9tmATq8g8RKJFBrBQvWPTK/CPcD7laVVtKHOLb9mgZ9ZWx2bHB
 ZVzKSTbZZOkdLPM9yJ3L1g3aOWCM/RvUA/YlOdzhTD22Ugg6UmnWERyJx/4PnwBD
 d/LLbzrg8tue9e3cBrw7B58TtucX5ojar+YiuqIsu92DXBH4P/RCIt0ThaZ13i0M
 mBUyTA5xiVRBt9iF458ETPjyGcAEe3pcfrYGcMCpRWk0iUxreFIyAJRPtU9KPYJM
 Q1Z3jTAbhoC4hf0i4OHMVt8pR2IHSkLZb1YzKWqJPIFrqMHmP93bLhn864OEfs31
 ZVCxg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aabw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:14 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:40:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:40:14 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id EAF3B3F7086;
 Wed, 12 Nov 2025 20:40:10 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v5 23/23] net/cnxk: check for invalid default pre color
Date: Thu, 13 Nov 2025 10:08:08 +0530
Message-ID: <20251113043808.1180851-23-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=6915612e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=82TJYTXjL4OvB1Y1nJoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: caFIh4vlMGXygWpBYTgAyLu0JXYp_sVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfXyznMFDFE5cmU
 ujBriQFCNehLrQtuXgoh/0JLBKL7DXLPouXF+yc3M3s6PYUuhI/EbBOXifEAvk5q/IHCvtWchtl
 ICx/oHnzn19zen/78xUtcYU100xopgYLwWQ0DFgvM28P7ZQwV1db6DqFHZIH8euzZL8dFipobv+
 FWbm9as1IksGDRCzXAZA6avDXDLbnKj8+ALzmAhtmIjqJR5wYFPfc8G0uTs2K1bj4m19QaWT24R
 cn0lRawpwH4NajyCcXGk7SNLhJeb/vLnwJFr3DE0BDUCoG5eGl6zWiKdyB2LxzenueAdX77w4j8
 o+M79/AqC8lv2gsMnEcYbpxuVQwPwQgWlviukIUk9kZ6j2z9of+qet484EgAauNtDaqm0hBp0XZ
 iQjC2LBC64AFMvkLZt9nf2OTC8mn5Q==
X-Proofpoint-ORIG-GUID: caFIh4vlMGXygWpBYTgAyLu0JXYp_sVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

