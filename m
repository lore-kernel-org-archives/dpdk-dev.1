Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E76C61CE8
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Jun 2025 07:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A03402D3;
	Sun, 15 Jun 2025 09:42:08 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by mails.dpdk.org (Postfix) with ESMTP id 93AE440267;
 Sun, 15 Jun 2025 09:42:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzqHTqR4fCSt9THRGqKdCGHj/DovPJWZkTBXL/4qBtFVtDRNsamXD9wOU8tDvLbSoqdfqVrPPA5f2wnpaEFimoRoaiXpSilda9A3EztjC6H1rz3fXhbpgUzObEG71hUijwJRZyCR87o1IT8lOCMmyJOJusFNfauufyR4g5WeFGTlyVV1aPYIBE8MbryL/pKRqm30+6E+LxfGP8qYBwJmGhV3gFuOQYOLAlPK2BHUAEg0fjotjNMHPBWhPpAcYzlS8+7AVDLEWTh9hD/WHzz1P9C11+dRfTiTy9x5gyw6MP9JEfP5SPgIl1hpYV0FQT0Kf8wNv2B8BcbxZMV+QeziTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb1bp5r7/8SX0gW3jDwcV5VzoS31MufMiyLJDkrHqFA=;
 b=ipm5YaEmD1zGRUlesa6noqhzjBWkcoWiSJD9HlzSvJL6WITrnsI7j0boFq+mqt22y+H5aZrEmN4yyzEiI5NK3kVx5MS379+bhBxrM9elOPUd05svb/XWLF/+SYPJlImlmLzODKkmt6pmrPTqagzNN4Qn+oZHL7Fw8HdVAXxthXC/02Pyl75YMNO9PmrSNxOh2JwEGI6gvgs349MivVeWFgcGfIavG3ykfMMP/XmJnwpQp7wxQ7hYDRaP+0jtTTMrU8GjsOvRQQcHK2qBmW5PJhjmhjOzMdhTIEM2RG7PZ67HbuLg2hnSYGdMNsoP+EbAtZz70wfd6BY2utfH3KhNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb1bp5r7/8SX0gW3jDwcV5VzoS31MufMiyLJDkrHqFA=;
 b=P+5NbreoK6sLfAHIVjwB0go69R1/cvZVSIdT+HuGcYLeLAdf00u17bbV2V9lWIzYgyoqQJR43AgX/e0u3eIkvGt2Ih3ZVaHBLExLyDPKabCxpr2sURV4jaLGFO2vUGck2kXok695vmn99XzpWUq/tKkbXq1TlEsAqUZIOh2mkbSn1TIgY5w5zBvYdMD6GOdDhB/Gux14K89vHasNh6YNl6BcaW466tNXftWZbwLednf+yuw3u1p8P/VdPgTM161OoZO5/uVpDF3EBNvCOWqKNxaYlIOMDGS/kXU11grRwt+SPx10RWjkMC34gfEPbCukOdwKwLuOjta8rjLJRFwjRQ==
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Sun, 15 Jun
 2025 07:42:03 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::e3) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sun,
 15 Jun 2025 07:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sun, 15 Jun 2025 07:42:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 00:41:49 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 15 Jun
 2025 00:41:44 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
Subject: [PATCH] common/mlx5: fix extraction of auxiliary network device name
Date: Sun, 15 Jun 2025 10:41:29 +0300
Message-ID: <20250615074129.52396-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64f688-b972-4552-2154-08ddabe01e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RsDNVGsZ7F8OKg3SHDqWMuXp6rr5sgsKgdmvFthFjOyhS2yXTq7MG32plvZb?=
 =?us-ascii?Q?XcW1m4RtRpHwp84lGXwirwK1W5JqAuks12wCNXmsZNw2+oj3ibh12GX5CjpP?=
 =?us-ascii?Q?SdO4Nczx2jSO2ng92aZZfybOY9ONDqyYVwSChQae4We+VVrLzUjHjDMx7tUm?=
 =?us-ascii?Q?Zv8i5aMb+pjHhQhBlDY46AG3KIdXlXZPdudhrfL/7FT6hQ6weiQdKbGLTN1x?=
 =?us-ascii?Q?pGt0W6jU6aTzzSqcnvnVJd2vxwtwzdkKnkFPJYq4nhE2IsuxFu7gex0FrUmM?=
 =?us-ascii?Q?D7FVvuGf+oDCWdN5/vv+YDEvItUsE8HmkWaW1Em4x/27mEzJlRSAOM5zOIGA?=
 =?us-ascii?Q?CM+/jirJfEijvfS9XrsItPRqpUJHlCq0em7Dd6bf4HZRRhpTtc8yno0HgySw?=
 =?us-ascii?Q?vRE+K3W28EVH0aS7VL+dx1uOaTwNXbxVL5P94F18LrGLe4t1iBvELlHnR1/g?=
 =?us-ascii?Q?YAq41xf0yHLpqzqB8q6jiEcJ/1jlS9Bx9fY93oqahjztIF3De6YFnTy2CPyP?=
 =?us-ascii?Q?sgw3Aj3Gv1Cqjd+uDt3HZX4tqhJ/VyDCn2HZGvGJKTQ9Xj1zwGVlLzIl1bVm?=
 =?us-ascii?Q?R3zLMjhPgJ6TKylxuMJSUCMbKNg+8P3OGfibwe1AAt/a+7vweg++DOMMKf2m?=
 =?us-ascii?Q?zD5u6ijCOfMit+BLyrlKTf8tamwBeQTHWrH5C4cqF9S6I3C2YzZrbwjlqV7Y?=
 =?us-ascii?Q?2SmQf1m/y54NFPdCnnz3XDQZmYnCIC7x9qlCwzZ8A0vvWCc0qge9myVdVW/V?=
 =?us-ascii?Q?L0d9FifQTZQZCKp/UIZiToQzX9sdO39YFaBUVeSa9l/lWOa66KaYZpcfOhcN?=
 =?us-ascii?Q?gGl6c3LoIF2FFjxCYc7YpGu+/uO6pRkTTzLm+YELIMqW9UH/NEa0FPllSU81?=
 =?us-ascii?Q?FKY/JNLUBsKeha+T2ep0VTSeHKqIkV+m1P2Fb+uwgQH+QWOSlRyxmdZkE0cD?=
 =?us-ascii?Q?TX7To4jtb0QHGvYotVxmerGFAenfuTjsGxkmVaCCFRddHo2bB7kb5qPimwol?=
 =?us-ascii?Q?3Hu0F74b15SkRkdY2WpTGOmy+H/6Ch26k0GqCQ6fGKA7aVG5jZwxt9rFHsP6?=
 =?us-ascii?Q?RfV9GLajts7La6TAcwaqtHA3eUHPiL20crjZbus1/jLJ+BmWJ0bz0EHQPolo?=
 =?us-ascii?Q?0DS4njahJKTRM9UGCSUyHhdbMXrOvPmEk/zsgHVfxN2zIaazV63fucfb57B+?=
 =?us-ascii?Q?+EWw7F3DxnioXiMB6XCwx12Zgpb6TigTu6Ry0zPKSrkR7GsSKwrmi0YuU1bx?=
 =?us-ascii?Q?ZHxyvBADTCAnmB6qapR8PSjRBSPmkan5LMMc2MfbwzCUpJJqhA7UwnJmV3KH?=
 =?us-ascii?Q?TLv+P4GgCWgxI/ObyPhEJsu18b76M6FqJIYxToSjUqCiapKf4W83EfLG4dYn?=
 =?us-ascii?Q?+6n6aT+TZLvPDISwImygo1gcnqiXzd2nQxgcWE7HQ+LR/mz9G6+FbHuZgFqi?=
 =?us-ascii?Q?WiQGZ/jhZLOkAhLoxe64r7tc+OHAPpoDqKo9UyCmQkQbideT9+MEyj3sZx/S?=
 =?us-ascii?Q?HWq/d88m2yY/RJ8EwKnu2QzaEugrLcj9OosB?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2025 07:42:02.8598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64f688-b972-4552-2154-08ddabe01e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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

The PMD reads auxiliary network device name from the Linux SYSFS.

The current implementation closed directory context before it copied
a file name from that directory into internal buffer.

The patch closes SYSFS directory after file name was copied.

Fixes: 777b72a9339c ("common/mlx5: support auxiliary bus")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_auxiliary.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
index b4ea604820..d2a7758285 100644
--- a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
+++ b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
@@ -26,8 +26,8 @@ mlx5_auxiliary_get_child_name(const char *dev, const char *node,
 {
 	DIR *dir;
 	struct dirent *dent;
-	MKSTR(path, "%s/%s%s", AUXILIARY_SYSFS_PATH, dev, node);
 
+	MKSTR(path, "%s/%s%s", AUXILIARY_SYSFS_PATH, dev, node);
 	dir = opendir(path);
 	if (dir == NULL) {
 		rte_errno = errno;
@@ -38,14 +38,17 @@ mlx5_auxiliary_get_child_name(const char *dev, const char *node,
 		if (dent->d_name[0] != '.')
 			break;
 	}
-	closedir(dir);
 	if (dent == NULL) {
 		rte_errno = ENOENT;
-		return -rte_errno;
+		goto end;
 	}
 	if (rte_strscpy(child, dent->d_name, size) < 0)
-		return -rte_errno;
-	return 0;
+		goto end;
+	rte_errno = 0;
+
+end:
+	closedir(dir);
+	return -rte_errno;
 }
 
 static int
-- 
2.48.1

