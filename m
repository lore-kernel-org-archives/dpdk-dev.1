Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC47CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC8C340666;
	Fri,  7 Nov 2025 11:48:02 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A515240650
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:00 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKjba2930134 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:47:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 bclCcxYad4T/Irwi8e2xb93JNizHtZORI6YgmvCTAw=; b=aHNoh1FkdtWE3vYKs
 55ovZFYARgl/Y5YaOwBAoGYUcLcWvr2ZFqBerbjHo4TTZPZak5jUQq9fCgSDkY8G
 EAxVzBTZigQXzaKs3dJtt1DsPIBoGwImDlJj76fzjV6o4L4s1btu15R4Ly4ClFiS
 SMfzgCfWX71LbQLrNtCBFC5I6115Ukmn5acJRR0I0rXgy8D8xcNv1wgOabYT/MRm
 v5bG386ML3jCw0V3436DTFrOwVl+iWCQcrSlhsOFtNJV9EKg+LZKtnuaigOXQWnM
 7RePsLnsg5V6/Y5+2dA4XrVFa7H2KvyuVYARAvZP19iRNH1KVi+958APZCB2dJCZ
 AjbEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:47:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:10 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 8C5D83F70C9;
 Fri,  7 Nov 2025 02:47:56 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 02/23] net/cnxk: new tree for SDP interface
Date: Fri, 7 Nov 2025 16:17:26 +0530
Message-ID: <20251107104747.1131008-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX5F6IOP1+S1KU
 Fok2H4NXiPdbNqK4tFJyG+nmr0U+EA9OEpVF2NgU8axuneeus7336NO1dxspL58qS++AHzl6lHG
 xeCBscCAVTbVm9vTlEEKFVKiWMUbeLKTNuwLVoayOSwRXBeEaztPjcW4hte938yATxD5Z92M9Io
 FQ/c5do6jcE8/9y36hTD8oDHkIN/wbOeGiOYrPmxtBvY5MyuURJNMb+rAOt2xVkn6etznHoUB5N
 AIYzcHBgROdZSwbCI6Jbdz2YaAjI4Des8YND6ZdhWdC0nL3/nkNqGwMH/4gC+uxJt9UPTVnXZsb
 rV2X+2zDv4ts9haUKtDFbfbowCFW1yGLESrmR8j+6RM5ientFMOkyEtYQGsH42EcB6MaNTQ0i+S
 ECzuc3lA/sgfcOAxLIMWFQnJm21Bgw==
X-Proofpoint-ORIG-GUID: jhbpDJnjvUt4477DZzkj9KCySgeF0QYV
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dce5f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=pDSVT7ON_-t1wQNCaMkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: jhbpDJnjvUt4477DZzkj9KCySgeF0QYV
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

From: Satha Rao <skoteshwar@marvell.com>

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..bfef06ae4a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1451,7 +1451,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
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

