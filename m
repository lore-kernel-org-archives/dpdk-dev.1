Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781ABCD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B1040676;
	Mon, 15 Jun 2026 18:26:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 501D0400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:14 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFcxKp1076467 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 SNXIBgBkgKzw872sEYcmblL2xFDdQUA1jWGIC60/74=; b=YFRp/voud0S0OYzvm
 ZnkEsVj+No64bC71Uns5ZrLuFWTLGHLR7jMPY4XUnm1+yNqhge0UJg7PJsgsIfpD
 W3+BRizEw+s8mOMGqbXX03XF1cbk7a9CrhuuAi7x4UFHh25X0TYT5HP4NnC1/Hg+
 WdAC83m0tZmUuLZ3gYE7wrYBF4vEDNVxD6M/JkeIZzl7UzWTbjtWPOVVdKGoELSX
 cezMXWMB1LmUTz0I1RO3KywFPVZEPTBmDd2cKBf5khs9TfahnqzibbdiACxcZJ83
 VbwP4zTHYKe/sVcKqQdiblyp5tAFTC6+tN+xuu9S088O1o2ppUZwvyDkpWVZd8rc
 b75bQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qefvec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:11 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 134603F7065;
 Mon, 15 Jun 2026 09:26:08 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 04/20] common/cnxk: update NIX irq handler
Date: Mon, 15 Jun 2026 21:54:30 +0530
Message-ID: <20260615162446.578336-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7yoC0ugj-6ObBvu7fTG5GTtHnlFsGOOS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX1AqJZtaD4qcE
 02cQnhkszZm26cKP9oxMqiiPgx31IL7H1+2K9creb7RNl9ziShsExVPiX6exYk2O6YeHRARCeV9
 zcKBmrDuaOspT25TPkPFImAKmKFxOA8=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a3027a5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=-4IbYDqaWuWiCa0XXUkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7yoC0ugj-6ObBvu7fTG5GTtHnlFsGOOS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX21DH+SQuVqr2
 sWXe8ryJ9A02IC2ANu6EBu55jdDbOqkEM1ErqY/SyOktICozRJ/hWwb5Fyxz5pMiIi8ixq8CPl1
 qTGwCGb0pY88oWnMlSm4LJfqdbktzI+/bJQ2YAcxjBEe+29ni5pSjciZKmZFsFpTR6iCkDlVKKZ
 ow5nRTGynVWhNU+bAg0ifm+bCT4Iad8gnqt/20WbjnrQf0874j0Va12NgPzgOkjmu8m6oKUtWKo
 L//UHXUkFsdfL2F5ncMkb5A+WWejubJMhm3ZGu1IbDddQYVnr+m3lhSeqRQ6RRzAS3cqwip20sh
 th7mtOv9XPZjii4mtDnzXCh26PenBJG9XH1pI4W3zh7+3/ZRtnzQxYdfdWhT84g9mej+m7+zn+g
 HAXFugwzLYQ9U0uqAnCDa84AUeBsiaUKUaKja+rdJaOKszdyfPmGqTcGlJv6Bw0m2pvrSuXnbsB
 m4+nnFhnkqKoPC0w/Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Move queue context dump and register print before interrupt
clear in NIX irq handler.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_irq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_irq.c b/drivers/common/cnxk/roc_nix_irq.c
index 2b731302cd..6874435a4e 100644
--- a/drivers/common/cnxk/roc_nix_irq.c
+++ b/drivers/common/cnxk/roc_nix_irq.c
@@ -168,7 +168,7 @@ nix_lf_q_irq_get_and_clear(struct nix *nix, uint16_t q, uint32_t off,
 	reg = roc_atomic64_add_nosync(wdata, (int64_t *)(nix->base + off));

 	if (reg & BIT_ULL(42) /* OP_ERR */) {
-		plt_err("Failed execute irq get off=0x%x", off);
+		plt_err("Failed execute irq get queue=%d off=0x%x", q, off);
 		return 0;
 	}
 	qint = reg & 0xff;
@@ -262,6 +262,10 @@ nix_lf_q_irq(void *param)
 	plt_err("Queue_intr=0x%" PRIx64 " qintx=%d pf=%d, vf=%d", intr, qintx,
 		dev->pf, dev->vf);

+	/* Dump registers to std out */
+	roc_nix_lf_reg_dump(nix_priv_to_roc_nix(nix), NULL);
+	roc_nix_queues_ctx_dump(nix_priv_to_roc_nix(nix), NULL);
+
 	/* Handle RQ interrupts */
 	for (q = 0; q < nix->nb_rx_queues; q++) {
 		rq = q % nix->qints;
@@ -323,10 +327,6 @@ nix_lf_q_irq(void *param)
 	/* Clear interrupt */
 	plt_write64(intr, nix->base + NIX_LF_QINTX_INT(qintx));

-	/* Dump registers to std out */
-	roc_nix_lf_reg_dump(nix_priv_to_roc_nix(nix), NULL);
-	roc_nix_queues_ctx_dump(nix_priv_to_roc_nix(nix), NULL);
-
 	/* Call reset callback */
 	if (intr_cb && dev->ops->q_err_cb)
 		dev->ops->q_err_cb(nix_priv_to_roc_nix(nix), NULL);
--
2.34.1

