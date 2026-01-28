Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F2CD3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83165402D7;
	Wed, 28 Jan 2026 07:04:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 509EC402D5
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:23 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RFOp0D1390656 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 5WUoCpP/rhZhx09+MXnlyJlvwol4JijwXliLCrZ92M=; b=j4sTxAqIF3DkiMr/H
 hRDadtAoOSG5czxXmjCK4tK71KPIkDyOjzr6IqCLBGrcTB9tbcGT0N3neKsQBpuu
 GHazPoeD74gGYKkPZLw/zqGssgXNvQXgEQwVXwyZilkqZ9iHWhuj+h7PH4gzdKKY
 h9TMQJtoKhYOWskDSMRGnSWL139JrcuUlK1Aq0k2VqY1FodmtgU8hHEBoKEQ1iBA
 jp812oM6pb1kX5mbdgjCU1aNAHd6ckjFeXtLBvmMWLmFeUGwAuzQaOQ5+0LgWYps
 X7WXOLLJv0PpA+jrFKTsPLF49/vx6FyzxpN4fj/Y2Ldf/QPBebsgEFw/AAfvCDLT
 SI93w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:22 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:37 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2DB5A3F706F;
 Tue, 27 Jan 2026 22:04:18 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 09/18] net/cnxk: skip write SA for cn20k
Date: Wed, 28 Jan 2026 11:33:07 +0530
Message-ID: <20260128060316.3967610-9-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXxGRnJX5sFUr1
 GYIJezy8PZlfoHtZ0/6jFhwFqSB2/46Mw/Slmbo+m3xfWQsvgZAwWWGdS62DC96r8Fvi5t7Z/t5
 E4+a29UaiUI/9kZGNeILA//7HvTwgcYIgjBASg+zHXoUixjZ/399KyXqbcayHHmTtn/B+pqaCZO
 RMOlOytfybJpLiVixMgaZ2vdrieXkQ/Y1NzPItXMhwB2gJC2FT9z3EGIYcOTYs7Mei8Ud9Z/mdA
 eObVUIYkGNMJLQPZP5Z/rj7ctMKmXDP0q12oq3eiTwFIYkGhQewknRyfcogGhvgeD57C6fXi22/
 3ovCUF9K042aAlufkD8quSB7cL6GN3MtDNirnWHz5rQQ0ZkIwFByHyqkCWn+sxUpirIdHHZBHnS
 KEBKQzG6p54lKF7KyJhkH5g4xSYDzLQWjCo09tYyFgsQxXWEORniiXAvDQ/zs26rGTgZN4gJu6I
 2vosfhe7Ory/PPpD22A==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a6e6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=BKW1DrDHoMYPnvtcoMkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SO-tUPFEa2uaguqQqVbfonUJuu25tuJx
X-Proofpoint-GUID: SO-tUPFEa2uaguqQqVbfonUJuu25tuJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Skip write SA for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 20be35c0e0..7e9e32f80b 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -948,8 +948,8 @@ cn20k_nix_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 	/* Register up msg callbacks for PTP information */
 	roc_nix_ptp_info_cb_register(&dev->nix, cn20k_nix_ptp_info_update_cb);
 
-	/* Use WRITE SA for inline IPsec */
-	dev->nix.use_write_sa = true;
+	/* Skip WRITE SA for inline IPsec */
+	dev->nix.use_write_sa = false;
 
 	return 0;
 }
-- 
2.34.1

