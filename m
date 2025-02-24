Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317BC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C90C3406BA;
	Mon, 24 Feb 2025 10:39:43 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 822B8406BA
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:39:42 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O8Uhm4015431
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 lo2Kl6RQFCtQfBjhJUfCJbSvmHD4qD1dBDjdVFhxPU=; b=R8RtwtyEn1rXPfjlp
 ONldoPYKqV32H0LhCWtTOkb2Fkqif09ojejPW/iZsCC6UrnblRBVl3b7/FX+L2Uf
 YOx0lqgyNTp3gZvpMfApAExNCmjO03hwG6CM6a0EpTdqZ/ZAgzuTUwGYT6cHrmeR
 1PnDokmKORLi8P04EvYHwDYKZqF2sxZmqgCt1kr/gtnwJgovNisLYrcar0Fl6EUz
 dt5iXAy0FYY5/ceWYwMqetdWePEUGIirVZ95W2u+eguVm5t27Ny0L8yNNK0NPH5d
 sR2w/JdIYirEDHteq4DPN3ttpcDlkyMAmPypdbTpTby1Tt0/ihnB+oI57zl3fUAC
 0W7Ig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450nasg4fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:39:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:39:40 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id DE0393F705D;
 Mon, 24 Feb 2025 01:39:37 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 07/33] common/cnxk: make special handling only for 9k
Date: Mon, 24 Feb 2025 15:08:49 +0530
Message-ID: <20250224093915.1253215-7-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kLa-7rczbevsSaR1NUH7eDlUAt6kxzyT
X-Proofpoint-GUID: kLa-7rczbevsSaR1NUH7eDlUAt6kxzyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Anoob Joseph <anoobj@marvell.com>

9k would need special handling compared to 10k & 20k. Update the check
to reflect the same.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 88f6044e60..a6d2d83f76 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -930,10 +930,10 @@ roc_cpt_iq_reset(struct roc_cpt_lf *lf)
 		lf_ctl.s.ena = 1;
 		plt_write64(lf_ctl.u, lf->rbase + CPT_LF_CTL);
 
-		if (roc_model_is_cn10k())
-			cpt_10k_lf_rst_lmtst(lf, ROC_CPT_DFLT_ENG_GRP_SE);
-		else
+		if (roc_model_is_cn9k())
 			cpt_9k_lf_rst_lmtst(lf, ROC_CPT_DFLT_ENG_GRP_SE);
+		else
+			cpt_10k_lf_rst_lmtst(lf, ROC_CPT_DFLT_ENG_GRP_SE);
 
 		plt_read64(lf->rbase + CPT_LF_INPROG);
 		plt_delay_us(2);
-- 
2.34.1

