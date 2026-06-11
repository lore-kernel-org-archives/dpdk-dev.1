Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ECECD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EE5D42F63;
	Thu, 11 Jun 2026 16:21:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 75EC142F01
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:06 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXbUU2628446 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 GCoD+liVrHY9A+zievig8NjPaA2+mUHZCgMhz4qxIs=; b=f1f9MpH8cbkV17BiP
 4Cdks/SIDGyLZm/0ylGQNUTgwK1jnMo2DU3YxCCEojfLDU2ctUJPRS/teCRoO3Jd
 1cUD7eZYojlRy7w2iZtflIy1M9zpA91KD+R8lgIUucd/gUxu3ky+H8/euMTFqY6C
 nX++aJpww/gBY2lrKQiOWIBsQbZcEyZTXocx8HeEn+JfJ8Cl7ytbweOhEYMUNWUo
 p1jEYggOhvna6C5Xq/w9t2J/30FA8Ovq5zOjX2vgVN1FMpylZL6Z0tEDsp/H+kTk
 yvrGTGCFbRi5UgGeiA2YDhtdoGAyeptkE/kRfawD6jd7NEiWTzq9mdsl+QkjbJTE
 MtRPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vu5qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:04 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 536695B6974;
 Thu, 11 Jun 2026 07:21:01 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 04/22] common/cnxk: update NIX irq handler
Date: Thu, 11 Jun 2026 19:50:11 +0530
Message-ID: <20260611142029.3351415-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX85JGY5YuIp8I
 9cbzRaycwNGqvw1r4qGIwiCoB0JDhLKz2taq7nFmUYE6oIW+9cvGbvDtkC93JTU9ZGKWoVA6r04
 OV2e8VCy90XjkNu5CKzXbVZy/fhyKNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXx5u5UYB2wV8P
 Eq2Lsvwmyf6Jil7Pwa1XP9w/82r/o9jXJiReMFsKS7e411T9zZecIOT1ZokfdYj2j8PZr8Zlaa5
 TWemSCDhNwcPV3SR4AZk5sbrYEnj0sTRvSiOT9qYYQ0tzRYIThtpiChM+DS3aIkdeNbxcHksDv7
 8vsl9/g9FNh0kDY6v9VBHO0SoL2TWXTvvIwdgHcmvNfZPOK7ZGOKXujY2vGUx9R3rvJpQiCCGy0
 xMvZgWALeF4mSxxe+lFE/gzKQzE6GTwPd0R+1DV4R3/2N/9fOUJVmmUWVhG0LIkbXnopclTwRRd
 9EdGv0zEiJIQP/UAFzEHY8Yd7riATQG/bh5L6dtt8kpCKYB8LDayD4ptfFmpGPpZmhI/GKveaFJ
 6eu0KwbhP4RtcPdtc2cLwcsjdbuMGYc7UZMwi5Sb6VTsH1NVtpWUHFu1RxMOT1fSJjqTKLE2y1U
 +PGxY344AI/NYuTuVyQ==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2ac451 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=J18aacAWlIc8EQhHbf8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: CkAzFHae84kcUYDE_kB6EalS7WuLTd6c
X-Proofpoint-GUID: CkAzFHae84kcUYDE_kB6EalS7WuLTd6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

