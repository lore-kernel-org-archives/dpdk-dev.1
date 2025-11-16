Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E4CEACEF
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 12:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B99640EE1;
	Sun, 16 Nov 2025 13:15:04 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6]) by mails.dpdk.org (Postfix) with ESMTP id E18D440648;
 Sun, 16 Nov 2025 13:15:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxbZFjfkA0mYKO1PRk5iyN9fH9LQCgeA6Oe4b5qSaW1Y8QLCXOyy+KeiFbTTbIT/qLqTUmNDLlXCJhKv4Uft4x5xQG7JFnyYnr4sjQ5w1XtscSVb5hC83T0fscle3kuVNk7E/vhb9/YnJ7/9lYeWeXAn4B23UftUvPGrz2caqJtehTMd3ynh9QhaWEOBMW0yn6ycMv34rkQZMER0e79NPEP56wSxamCDobXpcGmBPUnsIKn7Hy3itIx684sk6A/z1r8XcXw55lJMb+f3wlGbcGEJIVdJWwfyJiB5IevdIMFORbsPe4GH8xOodohFrBHHUAJSunWBhc5cngpRhKqSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Togc9DjxmcwgUJhlTlFDDhGKznnCTmTKZqrJeTgz+Zw=;
 b=J22R1IX2TZndwtHqRYEUDOJTUvueiJ/+m5IyZlUKt8Eaynr/X3jghaItm9+5GvVpWFbZlHjocdwBokZlhTsI9vkZNA5XAlPZU+7CGdKhrGfiZmJBBg5LKxEhIgZt0CKTwyLWih0hLxuJTwBLizARfXXjG2bhM+TFEFBiFoSTuZFxwpqf7eO1mwQrSXOLTZbUyIinzo5uKhQV7POwn4sK9jouON7QGxhBv9/JwWA493zw5pZbr0hiMr5yv+aFPFXmsLn+LMUDMmzTmq529CnuK57izzAYk4b/NhYaB7IDkGp1PGCpSxYRTJ1Zo8Wt+BLnh75ZYsD+U1ymLPzmQcNGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Togc9DjxmcwgUJhlTlFDDhGKznnCTmTKZqrJeTgz+Zw=;
 b=idhZxUA6CLuQSmQOIx2NGciDoAbJZfxU7PUa5tsWMTI+15vjk6zCTFUibHIMksnoOk2DAnKuVfRr6FugWBW44BlvKO2WZMOLveiHt3gnW0MrSW7wdmkPcICZEhLcfYfJb/KSHAff9bGQFv7uTv0Y3OSPDgimCRh2sXhZQbkgdJ1T/v2c+nG/AWP+AXsjrXEmDu2I1AEhd6s6cL0BxDtgGL5IudUZ5HE88zmH5gUopDir8OujJuwYeIgzbG/lSxBQDWwKfjgh23f2VYjkbXxsMA1bqA2nfIfvFS3KgPDTawoEoO0goyyDdmhB9ooPXzv4I/HdxzPtk37Ou9rmu4V2aw==
Received: from BYAPR08CA0060.namprd08.prod.outlook.com (2603:10b6:a03:117::37)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 12:14:57 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::7) by BYAPR08CA0060.outlook.office365.com
 (2603:10b6:a03:117::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 12:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 12:14:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 04:14:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 04:14:45 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 04:14:42 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH v2] app/testpmd: fix flex item link parsing
Date: Sun, 16 Nov 2025 14:14:37 +0200
Message-ID: <20251116121437.159702-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251113201726.10597-1-mkashani@nvidia.com>
References: <20251113201726.10597-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f7e094-b5b5-4b59-db51-08de2509c20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WINm5RZwYyaIo0EBN9zRGX7hjG9U5/BFyWrYfAtxu8HeIC6o1kvhCdFBBhqz?=
 =?us-ascii?Q?eZX6UC9fkce3NUnNrJwUNplMR6zPDoCeXv6LMSkFkYwGyX7q4OT65E1PK7g6?=
 =?us-ascii?Q?4KiJ+4cL0/5ahznuf5sqXtXQqEFkAfc8qrlh0M0xP/CANSTwmfI6OocrBaeY?=
 =?us-ascii?Q?FPYGpTWjP2qQpnZGgsrL9y2hh6Zt4DFCaxZPH/swKNQ7NutL9kqO5nTFHS/y?=
 =?us-ascii?Q?nopSLF54Yt+NHPHXybPPweAYkWoGW/cJikOtsTLlISIswGsDl6Xyix7gLP5Z?=
 =?us-ascii?Q?JKhDt6o7CMQ+Lj01ZCUja5Js5f90xUd7ii0CTs23SGt05EhQ3Gdqt7+Jl4x6?=
 =?us-ascii?Q?zxQxJHhp8Y6D0zYZ2kmp4V/Wtuyfu/BxECkNRltB8c4FAYZ9OQpGzUD91pge?=
 =?us-ascii?Q?bW3dhLAS5COQE0ui5NEKke4Vn03Yd7SF9Y5aALZwsZrvfjhfB+3cX3IRIcxU?=
 =?us-ascii?Q?Gysxj8D+RJFJNPBIEut8UTqVVRpyHxuzd+CAccmBBIJZK+PSnTL62iTO4dVL?=
 =?us-ascii?Q?CsxZoRwD25MvGWBZX5mtNVHL+Vr2qou+vfu3Z44oqwF0hG2YEWvuOBxKF9KZ?=
 =?us-ascii?Q?f0NnatDALlwvgakyJ2wY3iamh8fBY3nLZW2u0MKliy/uklh8LHgv3TXuUALY?=
 =?us-ascii?Q?mTExYSRcNvtekp2n5ZLxd+WKSgcnGZINXTuVnx38g6UneHKWTP+u3h5LAjb5?=
 =?us-ascii?Q?tzFsVskzMYOokhB04yBAwMK/zuguUS/0wyzB9WGw0wS46LPu4K08NHKxckm2?=
 =?us-ascii?Q?RKrF09aOm2pYm+k4ePW+L+5qIhxhT7+6/F9IsCoHMJNymMlH/zbq1yS8quZU?=
 =?us-ascii?Q?XQsQPdTELdXVkVX3vpFhMgjzSTeRa4KQ3PAnWgy33CO4bBwgrR9nO8O6ogr6?=
 =?us-ascii?Q?4bFGaWY0/jiB71iz47wN8tR1DyVtkk9grM3+74PQRoTgGOKTAnzrsbCto4ZV?=
 =?us-ascii?Q?R+ANKCM/F8lRJrikyQbw9IIBOhwQ+gHBfEI0TNy498fdPUyO2EmCXYRM+Hcb?=
 =?us-ascii?Q?lD/PgPZxhrik7Od8KGrlpXS+cvV8brue/7iMZezPaZjG7uAsBlhbDQgukCNp?=
 =?us-ascii?Q?KFdcKYn9RBWeJskbx3nIWONRfI0j6aXYjZt0r+0s1WTEmSy+jnibqRY2skDS?=
 =?us-ascii?Q?5LJqJG/Vl9glbEyHlW431abrbafnPP6LrRHn9Uqiw2NOElxYON4TwPiqWtUG?=
 =?us-ascii?Q?XPV7Ez29M4/0/DGpxqYXHJ4LLSmGCi19czgOhIlyc1bs0uTBtin7Ji2DvwJ5?=
 =?us-ascii?Q?0F/87IqEn/wvcXfOY1VZTfEFvOkz3as/Bf6r9RZKqf71YMyHCG32SbSD+7hX?=
 =?us-ascii?Q?MXOKZa4Dd+aqZ2siF15ZJPZd95Kd++KDhpbRFDqu3H+sGrxZuVttOChAc8Vu?=
 =?us-ascii?Q?2xT5xPYOClM1eBLctn4mWtyDWlO6Tcpt7doe3p3Y/VT/p+CuiqURFdaS7k7w?=
 =?us-ascii?Q?/n2JRs2EM2cT+76De7GhucLclq4MQ2PZEYyduA91r7RywIbERNak5wKeKhTR?=
 =?us-ascii?Q?6MOFb8OGE65ooPBkdDRJsM+caLZ1pyTOg64cfk9eXBXF/NARD0SlVbDACT3x?=
 =?us-ascii?Q?ClZGPYIL3IIF3/tr+k8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 12:14:57.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7e094-b5b5-4b59-db51-08de2509c20c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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

The flex_link_item_parse function was using FLEX_MAX_FLOW_PATTERN_LENGTH
for all memcpy operations regardless of the actual flow item type. This
could lead to copying incorrect amounts of data.

This patch adds a switch statement to determine the correct size based
on the actual flow item type (IPv4, IPv6, UDP, TCP) and uses that size
for the memcpy operations on spec, mask, and last fields.

Also adds validation to reject unsupported item types.

Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/cmd_flex_item.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index e6e1cefeb3d..af6c087feba 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -143,21 +143,22 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
 	if (ret)
 		return ret;
 	item->type = pattern->type;
-	if (pattern->spec) {
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_MASK, NULL, 0, item, NULL);
+	if ((ret > 0) && pattern->spec) {
 		ptr = (void *)(uintptr_t)item->spec;
-		memcpy(ptr, pattern->spec, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->spec, ret);
 	} else {
 		item->spec = NULL;
 	}
-	if (pattern->mask) {
+	if ((ret > 0) && pattern->mask) {
 		ptr = (void *)(uintptr_t)item->mask;
-		memcpy(ptr, pattern->mask, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->mask, ret);
 	} else {
 		item->mask = NULL;
 	}
-	if (pattern->last) {
+	if ((ret > 0) && pattern->last) {
 		ptr = (void *)(uintptr_t)item->last;
-		memcpy(ptr, pattern->last, FLEX_MAX_FLOW_PATTERN_LENGTH);
+		memcpy(ptr, pattern->last, ret);
 	} else {
 		item->last = NULL;
 	}
-- 
2.21.0

