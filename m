Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81BCD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7203540E2A;
	Thu, 13 Nov 2025 05:38:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8DB7E40E25;
 Thu, 13 Nov 2025 05:38:47 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMqYkN1056270; Wed, 12 Nov 2025 20:38:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 fX1iw2u7w59FZwn4fWT+Vcdz4uthTxChNo3xpNoDUc=; b=DSMK999sZz7aO1+IA
 AOsESrJpE2EZozIVdgrwBkdik6vzVeQoJG32oDvfBSbnpxsiFVwbZesT4SyLusR7
 Qt7ir5ZgzQHkpZGxBzWZ0QkV1xETYLyQHTTw/AsqRQjydtxUDclcOQmdxnpJDYOe
 GPebh19Uc347HZOINI7ZMs9584BufkSQaJFtMQk5M9cvfXANe9gIWcCJQmKHOTF5
 ZSG5Y1wbbW1NmdWs7voBWuSPPiRO3ycAbl0L3xkS6SZJtNZSMLLs37cnKuyxNYNZ
 cboXWKa4JxfjGVvxD3+9D8bTAvxxxd27NrfAB22kT3HIGJuMUJiVMZ/wkVoLqruG
 L4bpw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aa3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 20:38:46 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:38:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:38:56 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 7BC1A3F7076;
 Wed, 12 Nov 2025 20:38:38 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Monendra Singh Kushwaha
 <kmonendra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v5 05/23] common/cnxk: fix inline device API
Date: Thu, 13 Nov 2025 10:07:50 +0530
Message-ID: <20251113043808.1180851-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=691560d6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=a_7jAOaszgFUf3AtnaMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: aNf78aZs60a1jHRenCJl4ldw3jKO2Cce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX09eWWFCjKel0
 li/cNOe/jS5QH1Y8lY1ZWVm2rEHj+HhJg+xTM4KQECeSCDJYbZ2XUwsG+j87456uBLey/kykWeX
 MM5aAKxPGIl7uht+RYGBeO8H07V0Mv88BBqcqx/wFj3tPGfb5POmFeb1VhQsbW2yn8ZJA4xgY7K
 K+AIXMD7t0YUZk+IVow+fXcY27h9wJSveRnTpfHmWf+JUp2AY7VYUPcE6fS0rToFQtYMOi/HtSN
 492lDs5iaI4cVnJTt3pnIN+ZQafcZxmVn9SbtRQg1GA+DCdRX5yCVYUC1qa4y3i/p8m1ZFPf8g5
 dpLUqrAmEx0pUnlfM7x7HbwGRdd7WqyKVKglft7XhjWH2c/e36oZdgAo7eg174fBRS0O0n/T6NW
 xFfOnGQfW1SHof5ZXGxky+yT4yJqTQ==
X-Proofpoint-ORIG-GUID: aNf78aZs60a1jHRenCJl4ldw3jKO2Cce
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch fixes the inline device functions to work
when roc_nix is NULL.

Fixes: f81ee7133b48 ("common/cnxk: support inline SA context invalidate")
Cc: stable@dpdk.org

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 70ab8001e1..6700f556a0 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2324,7 +2324,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	if (outb_lf == NULL)
 		goto exit;
 
-	if (roc_model_is_cn10k() || roc_nix->use_write_sa) {
+	if (roc_model_is_cn10k() || (roc_nix && roc_nix->use_write_sa)) {
 		rbase = outb_lf->rbase;
 		flush.u = 0;
 
-- 
2.34.1

