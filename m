Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB624CA0EE3
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 08:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA8442686;
	Thu, 14 Aug 2025 10:16:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C89AD4161A
 for <dev@dpdk.org>; Thu, 14 Aug 2025 10:16:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E6KlhU014157
 for <dev@dpdk.org>; Thu, 14 Aug 2025 01:16:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 c9yY5UIH5APxTtiv2hAJzwxMYJ8u7y38TaZ+cBtGlY=; b=BqsnKETcoXkJKmqFf
 Uswl/gTjtjkYg22jr/P66AnU+3NOj4GGQ6UtPyoUhaEU+qA27nG8yjdHDUIPZttu
 fS8TJ+3kPJ3Ko8y7IY3zAaAw82MCDwdiWN+KMBSjbMn3bUYO2qr/Q1SpcCxRs6NC
 amSKBQWvNit0/wJN9XuMQYgiwRKJiczlL4kq6OFadf01ua8+XWXJGONfrIemiBbr
 93tFMaMq2ILgd5N+FHR6a9qa08iNMu5i0dCU2E7F7hLojdP8s8xu+wfyz3wgg5ig
 i1z+oXRzx3TzOzPS9DarFBbeGAEC5+GOVom8nc8qPvokjim4tW+pFviSJzQ9yo9V
 L0KEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48haep87ag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 Aug 2025 01:16:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 14 Aug 2025 01:16:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 14 Aug 2025 01:16:59 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id C72A03F7061;
 Thu, 14 Aug 2025 01:16:52 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 6/6] net/cnxk: report link mode
Date: Thu, 14 Aug 2025 13:46:31 +0530
Message-ID: <20250814081637.1905660-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814081637.1905660-1-skori@marvell.com>
References: <20250813093101.1492434-6-skori@marvell.com>
 <20250814081637.1905660-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA2NyBTYWx0ZWRfX1Mfsj3GI2U71
 LQJv6dvl1jUcch9lnaYHzpIGOls7zWSjWMWXSGZ4Tl7PNt3iIlTjwWx98ITcQZGxKmeKCTpXKGI
 6CwGZH5djv9xGbRFbbGYSIryM3/F8nB7pyxZ000QiT6+u3YNtNXdraAR0Syn6HPF0ZXv0KlZx0q
 5k8puCtLQY0ypvWLibXiFgp+iQIvxpHuk+zjTY60P89odwg8VJKlZswtsIUXsIOQoASSLSwFz59
 fivyYKJ5RpVPBIBCIUcHRnB8P2/aIJNl1LD8MVjBenpzD6io7tXhI2rEKYL6qOB3juBwJ2rJ7r7
 9ZbztgzurgVDqSgmziXt7Ua+OVz++aojWNV7u9PJQzO01XcZyIxye6lj7RigvON4bvfQ5bT2Hk0
 OoTr/4Nyk760faYrEw2pLWyPm0hbSh6fCZcHs15rWiv/fjN5OkXsaQJ3o+Nckb4aDtVemfvc
X-Proofpoint-GUID: F84NJm5pqy8IA4IEFPX9bnDXH5_uJJDx
X-Proofpoint-ORIG-GUID: F84NJm5pqy8IA4IEFPX9bnDXH5_uJJDx
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=689d9b78 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=koTAqf3Ast2ZiasxKz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
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

Reports link mode whether fixed or autonegotiation

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/cnxk/cnxk_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index a074f6f65e..d2b2372871 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -171,7 +171,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 
 	eth_link.link_status = link->status;
 	eth_link.link_speed = link->speed;
-	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+	eth_link.link_autoneg = link->autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 	eth_link.link_duplex = link->full_duplex;
 	eth_link.link_type = dev->link_type;
 
@@ -210,7 +210,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 			return rc;
 		link.link_status = info.status;
 		link.link_speed = info.speed;
-		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+		link.link_autoneg = info.autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
 		link.link_type = dev->link_type;
-- 
2.43.0

