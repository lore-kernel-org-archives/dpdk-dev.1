Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B398AC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AAA40650;
	Wed,  5 Feb 2025 11:46:09 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A8E0F402EE
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:04 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2238.outbound.protection.outlook.com [104.47.51.238]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7zdjaNtk2+yQCff9Pu69LAFouc0H1uvbtlTgZWMO1H4f6cpGBmIfRHk05FlWL4GXr5/iaebeZZZXlxoFpGDIRZnO9B+ow3dcb8+mW2/ylR1EDDUOsbqcxCJfcj8yhhMDSKHzjigSbD+75/fm+acU4mixZ+i1AnOg/jfzoMKLXgsxfvEVdaEq9s2jFY60JTmmfLk0QVa4GRhrQaKvsvBLeaKEfnuN0MiuyWv8txCt+6bMxMzaGr/IG1Rilmrmnruq0awqLDqCgZ8h73KDT365lEdvftaQRmnLIzltV0mqd0yvTvLxEpgjHaW3sdZnCoEih72Uvrc8vTgK046xf8QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHOwN2j0QqqOHW43rmJ5SH1sjM3KFtjLJIZvD2VB2iE=;
 b=X06TaX0zdHdQlhSgQl/iA2KNONq1sEHf7Hrxwmmiosl45w0jyZYwLJ4VjEmjGmTgM4I+9SzBgSJG6omFnnHdrzyBz3OAKcO217/rnLYU8ubsWHiw0ProRE+qtSLeamwVvM0sQiYZFcp8bSSvWYYuTrurSjVf2ENRt8kM8B2N6H+cmaXSnGmgSsukyops0Soosm+WZyChSVK3Pr6YNPtVWG5Ij8RWkmlLEOI4ueOka0FqtBXeKLcsIW1LCRQrdmVt605GCEswoExmZWFjiw60pyPTkF/iZrmtL5RUWqz6DuXO/XdRevKO7L1ImqZb2HzQQL9g+i6JEIozfi6lEh7eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHOwN2j0QqqOHW43rmJ5SH1sjM3KFtjLJIZvD2VB2iE=;
 b=HOgCjp1QazbrAFV4sBV4oNK6gLVXDlELyAWfCnV0J3ro9PcmJlbdKj2LJqo0vuNH7VMFCkbGKDYtyE+svwUsy0q3uKxjtrn8ZolgaqXKVzQ4hnbaLB1koqYItnrn9JTI4G4XmFMDw5TvxUAFGJBl7SwoB411+ZKM9NZHv2caJNw=
Received: from CWLP265CA0340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::16)
 by PRAP190MB1737.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:01 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::d1) by CWLP265CA0340.outlook.office365.com
 (2603:10a6:401:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:01
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 06/34] net/ntnic: fix array index verification
Date: Wed,  5 Feb 2025 11:45:15 +0100
Message-ID: <20250205104548.1533554-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PRAP190MB1737:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c0ec9eea-51e3-4c68-8745-08dd45d24873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KHBOL7xlB0twrpmojj3iMsn5aBnoNXUKGXPugrMpJSPxQsTU7feS3R/53pwW?=
 =?us-ascii?Q?pQFUReezK3cgv+GLDBQADSiU5OickXqFPiVgkRoZpW2nNnC5G8JiVMny+McL?=
 =?us-ascii?Q?HkY+rnsoBcP6XI2nQC/CpjyPvciZ/mdAnRDvkQIcwT7xjUQjhBHdp7IOwPAf?=
 =?us-ascii?Q?H7IIJIHunCf75/iFurk/Tg5lwUXBflB76OxUhEjMWcwlF+E4augGVySPqxjp?=
 =?us-ascii?Q?wwyqDWItt4Z9EFke2VvMxslNw77E/bygqE+d+HbxAVTqQ4pkiIiBkfcLYR2z?=
 =?us-ascii?Q?m1jDKWY/Pzj7/GVijDeEj/Wjo/JLP99pnhR28EGGajEljScN6BAGpErR+onN?=
 =?us-ascii?Q?mFP35p772rEgEtosniAmXXhbPPTAl141iG4UDOCbh7MxS1WPq5MY/vVYyXy6?=
 =?us-ascii?Q?XRpH12sfDKVaozVRAaEScHpNaN7vy0DRzRJQLAeVUOzyrR3gIDMCe7xmEC2C?=
 =?us-ascii?Q?lyNaIxS39CkdoVl2LW2wPPfo0Ml9//4/4kXS8W3VYSSyM+8IugJxlVfZdctF?=
 =?us-ascii?Q?++xJ03SbkVBi4E4qDEuGt2/r8I/Zzxxuf/803uBXHcC4i1WcaXadtyjZG/ge?=
 =?us-ascii?Q?bVSB7Wg/5FVCT7YiyERj1dfzL8Ef9mI0+25Ds7MRH7yaABaCS3668qwA6o5j?=
 =?us-ascii?Q?tzJN4enqnXnJfoaBsUOEDiG30XL6YzrCBFnN9JCxKxtardhulkMdVY+mS3le?=
 =?us-ascii?Q?2F6O6XNfR/t6kxaHMK4yGIKBSJUyHhScWMAChxNdazUb5N5IG+6jzFOJQXzC?=
 =?us-ascii?Q?KlGDija62gi4WWaNSy6eCJZIZKgNjsXlmWS3SBUtyhUWwiXyCFK7P5pr6rct?=
 =?us-ascii?Q?fHXCQ7fZuM0oMPEuTjzjVEc9IeTVa8FHjeAmO4gEWGnBENZLZrQRpkE0lS4Y?=
 =?us-ascii?Q?psH1Taxpv737BdwZXUmIGFEZKQFIMMm+vHJvykkbCh9n7HZ2ZAFL4sqD8oeM?=
 =?us-ascii?Q?9GTKncBYpU6ELidsfC1YiVhKJ4QHYFqSnrXPlQjUG2MUyYksj+o5ZRSLfz7I?=
 =?us-ascii?Q?zP8Im/GKRNTsTwdAH6GvvR0+VtRMaX67BobFHcHViAYwzyDOeoOg3fa9zi61?=
 =?us-ascii?Q?5R6830vpNHF2BCCZg4itOoSSS7tgujJd8Ek0MlnJK3jDiK6bDQnXhFjdgioD?=
 =?us-ascii?Q?R8ev7amNkxcIpTAodC8tnmfWMAxSj6LSjnTENmCje1vNNp34KhXoJEcORAcL?=
 =?us-ascii?Q?LZD6FGCe5jJigpidPDFtzg99B/PZuMlykvqpuKQl4760/GSr1o9uuPsivwc5?=
 =?us-ascii?Q?27S5ER7arRk2V40wTJzJqP20A5xZsP5fS3EwdVwJ9IVBEP5PMVQNaMb3XjtK?=
 =?us-ascii?Q?gYoK9Sx3qaR+A+9uneuALBqtjOlOUNEX+QS4dPm5bk30PM8YEwGUTqL65kba?=
 =?us-ascii?Q?HTCgyi+3r+gXC2yoH0FEGAkMUbuBGPitBIGJhNHmXwO05haEtr3ma99DO8Fg?=
 =?us-ascii?Q?rG+FdpzV/4s+9ZGN4fuK0RefZhJb0ciwyu4VCO9KXNJ5aSktT7r7B7J68ydN?=
 =?us-ascii?Q?LVBgegH50jyfVjQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tmExKa5AUDAvygLjvE9avMfPh2Za5Swn/xzGeI5uXNblfPRKngl9g+W+CBUrpUy1QnaeeIMGbemijWmCxrHLcTP3BsJvmBOosng1SqAyqBcBlqEmXpAPVTUjaafRIXWU9gOY2ECcstQE2PgfEe/CPdLkIefsPVGy49ctXpMlIi8pLKJUGwVTB9fO3asxRjAVSXogVtGH3yaG8jGT3DXwgIZqy/odO6Q9RtgImqJIEaYWzFeKbkSx/UOtyBjqfjNaDZv/g98eibEudu59MevXg4p7xM+u5xhxc3Yf+XXznw17wkdf9Jju/i+2MF39lbVSVIvDvCiuu5EvZ0xBo0YbPHFUb9C4JFjNWxYlkyNoPlmFwy68PqWd7B+Vk8ptTWOEWli0qZBHbo5/HNgVKRGAmEy++HsRwTFZq6Ca1Wbgl6xbFt/aHj1AWnPSXDLBWBKUjOw029R5hfWS1RQsNw0929WmSVmOuAr7wkHhsuDOsZZGq3YLxJ0QLu4RsTFezkCezFlewDnHEI2aAJ3Px0IB0yJfAnRRa+SQBL74PBPEJ8PdPmyk/4aR8eZnoKs5Dtdauyv6YQmPDRuS4Zg40Ht+UUN9Xm3HNieNfJZuNCdIXq+vpLgs79CqpMNfkAcrUEVHcrdfRCmohLS7+odO7OQSAA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:01.6051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ec9eea-51e3-4c68-8745-08dd45d24873
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1737
X-BESS-ID: 1738752363-311016-7904-613-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.238
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGRkBGBlAsySA1zdA4xcwk1d
 IiJc3UPDU5ydjAItXC2DjV1NLU2EipNhYAaqoIgUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan20-146.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

CI found couple coverity problems which were fixed in this commit.

CID: 448983 Out-of-bounds write (OVERRUN).

These issues were fixed with updating index verification statement.

Coverity issue: 448983
Fixes: 96c8249be53e ("net/ntnic: learn flow queue handling")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 620d023a71..28b086c009 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -140,7 +140,7 @@ store_pdrv(struct drv_s *p_drv)
 
 static void clear_pdrv(struct drv_s *p_drv)
 {
-	if (p_drv->adapter_no > NUM_ADAPTER_MAX)
+	if (p_drv->adapter_no >= NUM_ADAPTER_MAX)
 		return;
 
 	rte_spinlock_lock(&hwlock);
-- 
2.45.0

