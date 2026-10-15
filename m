Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2DFCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1214140BA6;
	Thu, 15 Oct 2026 16:39:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
 by mails.dpdk.org (Postfix) with ESMTP id BD43040A73;
 Thu, 15 Oct 2026 16:39:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Blr/dEFnJh//si6T7If5ZnFHKMIeqD9qin9pZnVDjQfDXUZDDLRm1Wqw+6ThqRVfVPO/xPeY3W0hBg46t9X0yEYJx6WetCicIiJBGIctXYRd8z4qu1MPhZbXrFnU68MfsPXgKJ13c372xFZ52og27/wqaQ9X6wSbCZ6hqWN2VbxT0KeMnc6kSAdYZ9mwCIkdhHYgjmVVPkZLsOmLCohmSfMnRQfI9cXTVn+NR1DVtHqY4fJBrmM0ZNoK8I5yGO6bcjT3ffZbhmcqKtFKIDaTWhnBzOp+R8FNlCaBKscmMhfPl+e/W5nA1a4Dm+Rp3cpF7MFwIBSd2GWJ83QVE5skHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhiFdg7Gb0Mc0zkoNYGSmJw4UkKCHT/JTBGR36XMNFU=;
 b=N5VXn1NrznKUi+HHlbKOq65p96/V2sFcWXjE3J6Zl79LNwA4GizYb8EeE9jn5+46BBXzbOWF9SPTm8Ue0W0By1cMkRl/8+IcRyDMKCk6U+YLxRKNn+T1e71HZ7wq27HwXl/+bqRv1hoCgpQqeE4RmX2NGqk7fZq8y1ghk7viTOCnFqSFbOq8LmnYtmhNoEU9oPAQmiPIuoV8KiqD21sOyIvQ91lpbRZSMxszLxrKRYthtTHoCGAfhpXknmiYRMpct2FP+gHTOivbRnzpGq6/8MTEGvbOdUvEYMYpOsBCRP7s4iwjskRKLaKgK26o8Lgte1WxwwoRK0sdVHsZXX0vXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhiFdg7Gb0Mc0zkoNYGSmJw4UkKCHT/JTBGR36XMNFU=;
 b=iYuYBW7RaAI3mszTG/Lj4gjw1opBNnxTwMy88S1CpVMxPMKcCooQ+rsRrlB8Hpa56tlBhyxc53+jVccGnnEJhbZkvJAc/R04DqPG0mjlqfTKabJMPSoxx/ltLkgmRim82EmHXP+5G1P1Si+7MK68jMrrRugJB8/nKcFwGd/tmcjsoGFxrBt9+qlqLLRXYp4r1cJmDFNWHZMWZk+uctCS8qg0iIY08NT0DFgg0U5DlD0rsiTO4mu1U5dsteg/KJQG1vdybvN8ZrZAJ3BCuthhgU/rvetAnUYQC3Zo6Et7iqoMawyEUXh9Kt+VvZbr8NfyHpZMvN270j08SyKtWKTmAw==
Received: from PR3P193CA0012.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::17)
 by AM0PR07MB6226.eurprd07.prod.outlook.com (2603:10a6:20b:154::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:39:47 +0000
Received: from MI3PEPF00008550.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::a) by PR3P193CA0012.outlook.office365.com
 (2603:10a6:102:50::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 14:39:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008550.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:47 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:46 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 7AADB4020A84;
 Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 4A3D560B034C; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 3/8] net/memif: do not close EAL-owned memseg file
 descriptor
Date: Thu, 15 Oct 2026 16:39:40 +0200
Message-ID: <20261015143945.2150772-4-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008550:EE_|AM0PR07MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 172214d6-8c6b-44e2-88a0-08df2aca2916
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8A8XPjxdf1FHkIp+hlhWwiZoQRY/QsM/NdxvtiNVb79Hudtyaw7t8SOhfIhd12WyD8XzBo5UIZnZFgN2tkNFIB/KkQUrR5BDQMawhvm+vfUOek0O+mcD4mHJqZZaEvqne1fSVbmckIpluUsnVDGWo2NO82wIT047nuyYudSJqwIVaF9GQdY0yUE56HqBAlL4u7gWHfqQ1O5nH/V6XkEYdJPD4uQcu4H2G2YIQQCVVqZsN7xsYFnfvpkmFRKZARsbWI5f8uvKYmzefwyWldos/8wn6d5hSpeouBh9MKXFLydN8Wrokr9O6ws3A2FSGLfRGezYg0SqfoNxnO9OMohdYGBh8NoJbjBW2CRbeQLtl4qgxw5OR/9pmy8IhSYB6ndYN0UebVG+RfIIHRmqAPVUyZg4JjfRM+deS91moyNs7yRI/JeAo5qHISenVeQz8zA+v5XZ6mGSAU7Dcic5LeobtQ11fQirh+kI4rqzv7+YddCzMgesvyu5XwOrQxaM8/wxeyMFppBZbEiYas1yTaqQ7UzR15rOjjTR5CLEErxAQG12W/pvmfcJE/sKB5hmyK0rRj5kl6oKri1C8eH1igL1d8jOO0Kdz6X5OjqTdkE4GuZ2khDYLQOphgUipV9JnNHeN2YvxLTQqLVtXAIW0bMBJ/NwYePaGb+6jgYtscyajwg/EP7C1C7auStcjOku0VI+Pwl2JUcR+ZZ6VeByqS7amg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X6oJx6wa/g6x/gKo6qaI4uWFbe1e7uyVoy0cETV9L5PvBQKYVCn/0FpHtAJhdIeq5d8teEYFqHG7bg93vOgQUMW5XP1OIKjCnL6jyR8cWcdBE+IMEUEqwv9hX5YDq2EygMd943/SPVQMmTovgsVUwpBnC74v7BIl/5kNBx1Xwe9qfPMcLRvfvjjjh0qtHm0CogvZyZ3veD6V4nMgKlDVR3tFHlXC0srOfAw14TBjqxXPaZckv/5D/SBkSGw4ln1E5agMp8uarA/vAzsC74yND8JPLlPkAdo5y/egkGebGo5QNEY+0dbdRJG84HWHWjdUZ6g7uaISCT8PhYVyeNyRWOSXErseMUpUSpQQdsc5QSTTYc72dya4jG4MnUafGujL6UN0YjNs93Aza2Sp5AWEX78e3agHTOAkY7RimsaXxpb7lOZOccxEtica8YSHIGoo
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:47.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172214d6-8c6b-44e2-88a0-08df2aca2916
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008550.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6226
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

In zero-copy mode the per-memseg regions (i > 0) take their fd from
rte_memseg_get_fd(), which rte_memory.h documents as EAL-internal and
read-only. Both memif_connect() and memif_free_regions() closed that fd,
so the next connect handed the peer a stale (possibly reused)
descriptor and the PMD closed a descriptor it does not own. Stop closing
it in both paths and just clear the region fd; the fd is not ours.

Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 6d8d55e570..fb82117d9a 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1289,9 +1289,9 @@ memif_free_regions(struct rte_eth_dev *dev)
 		if (r != NULL) {
 			/* This is memzone */
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
+				/* memseg fd is owned by EAL, do not close */
 				r->addr = NULL;
-				if (r->fd > 0)
-					close(r->fd);
+				r->fd = -1;
 			}
 			if (r->addr != NULL) {
 				munmap(r->addr, r->region_size);
@@ -1611,8 +1611,7 @@ memif_connect(struct rte_eth_dev *dev)
 				}
 			}
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
-				/* close memseg file */
-				close(mr->fd);
+				/* memseg fd is owned by EAL, do not close */
 				mr->fd = -1;
 			}
 		}
-- 
2.43.7

