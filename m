Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802ECCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 738EC40B99;
	Fri,  7 Nov 2025 11:48:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD8B40A4B;
 Fri,  7 Nov 2025 11:48:49 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A782sZ23942992; Fri, 7 Nov 2025 02:48:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 KZNrq65QzB3G/xyC9eU4Y73BNZhLRwpqe4O4XuR7/k=; b=kxAKZbcxL8Joq+O+9
 xfU/ncrUQ+hQoHdLiJJPl9djaufGV0Zk+jkDgegLqUgW5rWLrU1CZJ/IwYfUi0uI
 waZUagOhY7M8ez4PymH/asX1wG9l3i3vkqP+toVMVq4fl8ITzGn8b6H6oqpgFpSK
 FYrb7oCliBDPFROpLUu94RdqRiqu0WMc7HmyaHg55o6Z3XL12CKe96umWAo6txCl
 lQ6KncFsMIApugs8SRaVGs1ev5ETeZpEnJAagsC6vKLru+uqa8jMP5H3HOCVTjt/
 zc3VolEE+JQ6B/4qeAmMXtHaS6dTHwE1xFlyeW910HUGn0Wz38TsnD0YjLSlARcS
 OioTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65spw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 02:48:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:59 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 4F5953F70C7;
 Fri,  7 Nov 2025 02:48:45 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v4 18/23] common/cnxk: fix error handling on inline inbound
 setup
Date: Fri, 7 Nov 2025 16:17:42 +0530
Message-ID: <20251107104747.1131008-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce90 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=Np0JFEGaXBVNt86ZIjUA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: beKA2hAhq8PUHYH1gFZM0bTs6VkQSHQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX/m89i52JRREo
 7LuLxwzwA8851SLxUC/JtX8VdlfHvSRR6sp8sVbQcz/zrtpjWNdgvRCUoknlVtA6VrC7ZdqsMer
 nDlugJA75nw0eoHrX+6IPqbRMTsee5bqCEVZ6XHIT2vVuuav80wJQjQZcnTXAy074d++TJ02nDk
 6AEMop1esTVfwZSquj5bnpz2stFOLrSfhYX8UH+gWJlXRd5rxMWThsBM5IAI4RtfBtmUfk3Uo1o
 v2M/tF+DkIDk11SYRE0wwyyGMKfFV+yiRxj4TC65AvuOQl7/5HD70h+f4ReN5Xj8S79FxXx2uuM
 c68GqYSr/42z6I+KF3M2/KP/9dgeUHhpxBuFQYKqomjBroMsPJhmj4U2GW21kjtWI6b69YkfXKh
 UfEqYkrit/LdB9rQ9g1JvnVaX+1x4g==
X-Proofpoint-ORIG-GUID: beKA2hAhq8PUHYH1gFZM0bTs6VkQSHQp
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

Fix issue reported by kloc work.
Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
Cc: stable@dpdk.org

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index bc3aa60ab9..1eb96f913a 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -247,7 +247,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	if (!cpt_req) {
 		rc |= -ENOSPC;
 	} else {
-		nix_req->enable = false;
+		cpt_req->enable = 0;
 		rc |= mbox_process(mbox);
 	}
 cpt_cfg_fail:
-- 
2.34.1

