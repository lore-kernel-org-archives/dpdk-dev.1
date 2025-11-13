Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A4ACD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C440740ED6;
	Thu, 13 Nov 2025 05:39:56 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 140BD40E3F;
 Thu, 13 Nov 2025 05:39:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMqaWM1056308; Wed, 12 Nov 2025 20:39:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 KZNrq65QzB3G/xyC9eU4Y73BNZhLRwpqe4O4XuR7/k=; b=emwsd0mx8eUepWJfk
 N4XEFo26KY6Nj7iunfReDNLFd2SfXGfvRdvhgzR2eFdrwlR0erA+E6CU4mpPPE0h
 7Rj4P2dkEHB32TFOmKjim2SX0Y1f6Z5vve3RY/qcuJ1aDWLtt636ZMG+dL/BwHfq
 KgeeMPS2IqGUYHdsG7I4KTmH+s7JbFME9JsdmqD/FVExs5kGlCihSJAuTTx/ImYC
 GmI/6C4gca3v6l7VhGtd0A2m0ozq/AG6JY6vDYGrBEADM8wf7CIaNhZagEPt4oM/
 RsVnnNcl6K0yrR5SBTWOfYc6ohqLMKjEZ+L/cAJEytgpJbbywu8E+Ty8KNVO1u0Z
 oEN0Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aaae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 20:39:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:54 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 4C6D23F7076;
 Wed, 12 Nov 2025 20:39:51 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v5 18/23] common/cnxk: fix error handling on inline inbound
 setup
Date: Thu, 13 Nov 2025 10:08:03 +0530
Message-ID: <20251113043808.1180851-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=6915611b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=Np0JFEGaXBVNt86ZIjUA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0D8wN07b-kJTvhM44EDCZ3KGdMsYfWAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX1pKr5n0jFayD
 ExrrNaE9PQvwLkpQ2ievwDYLlVgv/UKLuC/LiRCxpt3oF3wlU7mGkvGRVoGPRpjKslx8SzMRBJd
 bmLizzL84E8pryrrQGJ1163XuZ+FwiOpwn8BvQJLiqFbjOM79nk8lOYT6ICh5TMazAS9oBGH7Pm
 Fl7Cc4WuCg7J5/iUZpmQ93aQ9slekIirvP801jStNvXhhtA6H8Q/E/CRFyVhTS4p8pBdIhylr+z
 9ioQdSZqSLUY8U6kG+C88FIlHcq7bnpMyCOvt31AZuhpngE5XNcCu2qZoIgbZJniqY317KgzcTZ
 Ivot0TQVbNqQYqNmW90t5rELLEGErd+r4SMophpiPdVSVERhOqkWHLJ3eKEjEskjCl0KAw5QPYY
 P9gQy+y0oZvzYIZe1n8+Zn5wALcN7w==
X-Proofpoint-ORIG-GUID: 0D8wN07b-kJTvhM44EDCZ3KGdMsYfWAT
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

