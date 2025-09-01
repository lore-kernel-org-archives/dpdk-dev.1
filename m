Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E9CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:32:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63F494067C;
	Mon,  1 Sep 2025 09:32:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 71C0340671
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VMpa07016446
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:32:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 9NODqopvSdVIAx0Dhh8KxGJ5fko7WhOogKr1cLlqNU=; b=EhYt80pxqWQB/7638
 JFZazOq2Jx4bRdw7/DZmWs7zOLw2N+ih+gIRlhbtK4ssKXpNEV3oeumLO/Q9xgza
 Ylfb5rVpakv7Pf4/9E8Qmiy2dr9zlkUrxk0C0ymtmXRJ+4tUezMOqKEhETdQ07/k
 Y5NH3pprp4s/b0QSCvnU7e7UTlckpjTfwl4W/SaubpnF6ROy0kY5rw7hGhaKUubx
 m7fMYgRFI4ekxhiTNwasYg3lULhqm0vC2e235v7KR9Z2ybvHn00UTPJng9zFPsQR
 4otVZuBTsUThFUfSqp54xu2Ws4J6HUsJDtzLqAQfD7IjJ/vR5tgRYYxpqUisY/VJ
 M1HNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48uxnktgvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:32:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:59 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 4D9563F70AC;
 Mon,  1 Sep 2025 00:31:57 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 12/19] common/cnxk: fix max number of SQB bufs in clean up
Date: Mon, 1 Sep 2025 13:00:28 +0530
Message-ID: <20250901073036.1381560-12-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4U3pSyIwOg_qV3-NlJjpyV8IuCQhanNE
X-Authority-Analysis: v=2.4 cv=EqTSrTcA c=1 sm=1 tr=0 ts=68b54bf0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=3m7XhV8NHwqQqn6gr2kA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4U3pSyIwOg_qV3-NlJjpyV8IuCQhanNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA5MyBTYWx0ZWRfX0R9yiNJwz3A1
 xrLsyiWNcL8miqGzprvDqXKzC/Iu6H76+GcSgtQEzJzUomo2KpDhtHu+RCl8/xGZ+zzEsHf2IJX
 rx7oRa02i+0VC8DkfFDtsxbNXlFO+lfvOGBieqFESHgJYbxvtOrPhaBmbDXVrT+4F0uxngX3+fp
 BvU0/b7pBgfoeCP5sG91g3GmMnytQ1WvHgrEVPgUCnDvwg/dooTEVhoEnmq009kauwSMSldJMCE
 eKAdqZhy2Q03xzONQ1LYUhcupbSjA3XE9vKBFo4Gwaiap7Yk8eXRCvqCIAmo9Ni5up3jcQHjewr
 7+5KmBf8yc+5rcst9UJ7wREeKTuFLau7EHby30kIHJPWK/GEqLO4wEj3e5hq1IrZFY611Ms/Uih
 yUmb8Zj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

By default, SQB pool is created with max (512 buffers) +
extra threshold buffers and aura limit is set to 512 + thr.

But while clean up, aura limit is reset to MAX (512 buffers)
only before destroying the pool.

Hence while destroying the pool, only 512 buffers are cleaned
from aura and extra threshold buffers are left as it is.

At later stage if same SQB pool is created then H/W
throws error for extra threshold buffers that it is already
in pool.

Fixes: 780f90e951a5 ("common/cnxk: restore NIX SQB pool limit before destroy")

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/common/cnxk/roc_nix_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 356367624f..8737728dd5 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -2057,7 +2057,7 @@ roc_nix_sq_fini(struct roc_nix_sq *sq)
 	/* Restore limit to max SQB count that the pool was created
 	 * for aura drain to succeed.
 	 */
-	roc_npa_aura_limit_modify(sq->aura_handle, NIX_MAX_SQB);
+	roc_npa_aura_limit_modify(sq->aura_handle, sq->aura_sqb_bufs);
 	rc |= roc_npa_pool_destroy(sq->aura_handle);
 	plt_free(sq->fc);
 	plt_free(sq->sqe_mem);
-- 
2.34.1

