Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1650CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF59740E11;
	Thu, 13 Nov 2025 05:38:26 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A834840E09
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:38:24 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACNSDkF4031698 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 89LgAKOrJ3kMDTxVRsN7j0FeVWudl+esnytPcdgODI=; b=Y4ja8xn1XOT7IZtJe
 uJaGNpujYuSo94vatG7Bq25mvOyp90/ARDe5Tm1NdY3fqlMf0lUiRgRNpaJmaGU1
 Kc0by3waM2tnF6fVEY3jkdQ3vNIU2T9DgOF69N3vHVOrxVhR/Lv8Ambm4xD7YdZh
 iYotgeGqP0BIhFVwQjfr52fTUNnAbIw2FImQAS8cftE/twcHch7KryKy2jun8hLO
 I5pReboWY9tAHi39vEfGz2ZzzYvA3O2XqMahob1J4vrBMv18fm92MturUdYmJ9vL
 O1guSEKW8L3sOCPlBfgFrOceWWUpu72j7rcfaLgfhbIFme4ZQ2n3ovYqqg95oxDX
 kgqXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbgk9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:23 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:38:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:38:34 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 688853F70C9;
 Wed, 12 Nov 2025 20:38:17 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 02/23] net/cnxk: new tree for SDP interface
Date: Thu, 13 Nov 2025 10:07:47 +0530
Message-ID: <20251113043808.1180851-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: udqqALzYlxMm91WDbSjiUmAdF4OYDMr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX7e3+pz/QltDl
 PshnL43XBtGlwtegALx9NsAldxoWEOCR6g+s6cVndJ+S5UiHOianDW5JurUd/NvPYih6sseq5Zy
 nAcJtWYA0JBTvzEANhE2Zc+cMaGSwG6NnwepjybAYSf+6GVHnBfiDHr34+4GxDaNBJaCJK0dH1g
 DLS4qubQO62lr6iR3RmlpIj7PHzxOZgzCAY+Pk29sLvXwq+3edeTPrhLuBbC6Fq+vmkTdLAZ6nz
 n6vxYng3PmG29ap0jBwZviaAGhiGFCiQvm92y/o0HlscaWYuZ67xx0owv7AdXST0xTy7RHuxv+Y
 6Se2BQGjw/VBia80+njn57Xqs5sFVAumtWQxCeH9irhokwgB++EW/MA09IFBtnwxai05iGrNkIi
 /h06GaRGMS29sZwbof70sVcxOJAsFA==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=691560bf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=pDSVT7ON_-t1wQNCaMkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: udqqALzYlxMm91WDbSjiUmAdF4OYDMr9
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

From: Satha Rao <skoteshwar@marvell.com>

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 7c1aa34de2..69830a1280 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1539,7 +1539,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto free_nix_lf;
 	}
 
-	rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
+	if (roc_nix_is_sdp(&dev->nix) && nb_txq > 1)
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_SDP, false);
+	else
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
 	if (rc) {
 		plt_err("Failed to enable default tm hierarchy, rc=%d", rc);
 		goto tm_fini;
-- 
2.34.1

