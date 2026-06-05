Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054ACD6E6B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 537FE4026A;
	Fri,  5 Jun 2026 10:16:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD0D40269;
 Fri,  5 Jun 2026 10:16:35 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654LPj303891271; Fri, 5 Jun 2026 01:16:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=C4Z2j/3dmuds9S9wzInj6zy
 My7X0RlqO0UenFWVtOlQ=; b=FkJ3ljSRk5YPCd4A6VDOtRkhBfFiUF6AzByiPzd
 4zI8BBHtVH3tmwSgFJL0oFLln9J2HA0LEONdCxL+WWP5WjiuicBzI7HZiv8Gxpx5
 jOp14rElb791G4AtxqbItN+yI4/Ik0QFNpYOmwIRZfff8sro/1tFdpsFY/weQTSW
 dG2EwwcsVbobKP3DfLXOIi/c192R8cx/pcYJsx9ryZCDt7qfq1GjVWg41qoUyKo4
 hb8Zc7dkVYHXQF5Ko+etSS/jqgRTA/81ZpibcMGPP5vUccIJytolaGk8kIylKliQ
 OnKBoO2L6t1u0sabinEY7bk2C7oPf36jjOOLaD4iwmR0GOA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekh8x9mxu-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 01:16:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 01:16:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 5 Jun 2026 01:16:27 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 640293F7084;
 Fri,  5 Jun 2026 01:16:24 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Radha Mohan Chintakuntla
 <radhac@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH] dma/cnxk: fix crash on secondary process cleanup
Date: Fri, 5 Jun 2026 13:46:19 +0530
Message-ID: <20260605081620.97056-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HJti4crglqq-k5WHtnBmthC8wZMif21e
X-Authority-Analysis: v=2.4 cv=DqNmPm/+ c=1 sm=1 tr=0 ts=6a2285e2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=_j5PO1fiChC6nIc17HsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3OCBTYWx0ZWRfX0BgMJSb1qZqY
 v+jlyh5buYgVCPaGxwrYi1ILXJMhvzl66QnZVLtgQq0bpH1/tdgSpvK9rrx2aeCA9lkRKJOw4UK
 nakB4j7eXEGxC2+ShppbE9cAdoDp/K4BlqGII8qr89LuBOCFbE05EETnc/VHM2SfSWypjAexC5S
 speNgqf5eo9yp2Hm3r6Op0z8FJemByrsSlF23t8NUsKSnH26Ye2XzeSfq72T+EGOnTBq7KQ8dG9
 kZ18/gN1vypwBsJoz0zbJ3aNKtgqk6oFMJHAFKfUa/8YFh3VxwwI9Ec7mcWFXzKDscvP0vLWtDE
 JCKnhN9nRl5vUKDv7GtodAUgoy4u5fybBVV/u2r9zjt3Jde//18kT4rn5aX+RJqS9rTnR1i+9wQ
 ///5sYYge+TZ9Tr0QJziYQT8TmRuYgcXMGnCf+5N4o/t7opjaynuSAXu4ViEu57HVTKkX7xFuGQ
 3NJ6ai+aw4qHfTSStFA==
X-Proofpoint-GUID: HJti4crglqq-k5WHtnBmthC8wZMif21e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

cnxk_dmadev_probe() ran in secondary processes too, overwriting the
shared rdpi->pci_dev with a process-local pointer and marking the
device ready. With buses now cleaned up on shutdown, the primary's
roc_dpi_dev_fini() dereferences that stale pointer and crashes.

Skip HW init in secondary processes: attach to the shared device data
and return, leaving rdpi and the device state untouched.

Fixes: 53f6d7328bf4 ("dma/cnxk: create and initialize device on PCI probing")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/dma/cnxk/cnxk_dmadev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 0dcebc1b0b3b..6ae7fdca3b1b 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -617,6 +617,9 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_de
 	dmadev->fp_obj->dev_private = dpivf;
 	dmadev->dev_ops = &cnxk_dmadev_ops;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	dpivf->is_cn10k = roc_model_is_cn10k();
 	dpivf->mcs_lock = NULL;
 	rdpi = &dpivf->rdpi;
-- 
2.50.1 (Apple Git-155)

