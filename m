Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC57C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 05:22:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1B940156;
	Tue,  4 Mar 2025 06:22:57 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F080B40041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 06:22:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523MDJuU000813
 for <dev@dpdk.org>; Mon, 3 Mar 2025 21:22:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=oAhbUHm+RLCkUHzLgeYcyec
 gD/mYiRR8GTBQeytVNnA=; b=hro+8z0fot+BpawPXTggc2QZVwiHlTOdEFc+BbR
 cdFR+VqrXBy+N8z22DpMPh2mVOiU2Bp1hZi03M4HjVuOmtI/7huhhh7GLmY0P2mu
 tZXRFkbkiB8ewge9aIPcyVagnQInv8kBRpCrWoowyODfo43zIsaW9LLpI2bRFyMQ
 dBPm3sVE8FVSx6ohhqvVL83zAxrB8kbovRFECv4REjMUaz9uCuyGNElh5kaA2VDc
 TCLchPpOKA9S7tsxwphD7ts4hfva7037XMX9Wb2JOVzWXammV8TH7N+8LPApZb5b
 Uw30uTubN5px39wi54ZUZ/bBkcYlTmEwBbpU4cDyMaM+CBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4542mudb43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Mar 2025 21:22:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Mar 2025 21:22:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Mar 2025 21:22:53 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 0EC313F707A;
 Mon,  3 Mar 2025 21:22:50 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Ashwin Sekhar T K" <asekhar@marvell.com>
CC: <jerinj@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: fix aura offset
Date: Tue, 4 Mar 2025 10:52:17 +0530
Message-ID: <20250304052217.796506-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -eMmTCV90up4FBoYRnDv3nklgPH760xo
X-Authority-Analysis: v=2.4 cv=H6Ihw/Yi c=1 sm=1 tr=0 ts=67c68e2f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=Q9PX9vfYviZGOdXgr3EA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -eMmTCV90up4FBoYRnDv3nklgPH760xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
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

Fix aura offset in NPA_LF_POOL_OP_INT.

Fixes: 620fc02bf7eb ("common/cnxk: accommodate change in aura field width")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa_irq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa_irq.c b/drivers/common/cnxk/roc_npa_irq.c
index 0a19319ebf..9505194207 100644
--- a/drivers/common/cnxk/roc_npa_irq.c
+++ b/drivers/common/cnxk/roc_npa_irq.c
@@ -104,14 +104,15 @@ static inline uint8_t
 npa_q_irq_get_and_clear(struct npa_lf *lf, uint32_t q, uint32_t off,
 			uint64_t mask)
 {
-	uint64_t reg, wdata;
+	uint64_t reg, wdata, shift;
 	uint8_t qint;
 
-	wdata = (uint64_t)q << 44;
+	shift = roc_model_is_cn20k() ? 47 : 44;
+	wdata = (uint64_t)q << shift;
 	reg = roc_atomic64_add_nosync(wdata, (int64_t *)(lf->base + off));
 
 	if (reg & BIT_ULL(42) /* OP_ERR */) {
-		plt_err("Failed execute irq get off=0x%x", off);
+		plt_err("Failed execute irq get off=0x%x reg=0x%lx", off, reg);
 		return 0;
 	}
 
-- 
2.34.1

