Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D871CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:07:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75ACA400EF;
	Tue, 30 Sep 2025 14:06:59 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by mails.dpdk.org (Postfix) with ESMTP id BB0F5400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:06:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy1Q0HnGOyzhCNmNndsgCP6st9zVYuCCzDLcu+U0c8wJ8fUW7rNHrEnuolyXkLP5C0TwAtJK8togBUjjz0xjX1KXRJTbxR712djVhvrhFwM+I4HTR7dGKiWV86wl7T3W5ZdElkvwMH2pGcucVuHAo++m2QYuMgcyFE4cgKoaPYeukvsOz8BWcKwOLNaBE5QSfRcJ2ZlULXkSBjDpoMqXxBeye0YXdQveTmD12XQ+UgEFixNTh265wSkUKDcLcm4TKXQ9kuH5NQdt5gGfxU9ruxZlPGM6D6HBWEwi6DyVVmhWG+jQEHu0nNnYlp6WRcnT/Z51fm9ysuNhp1b6eJ0RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBgi/RIy9reifXo2M3dklSzxqx4X+iAz3gXTrOxo9cg=;
 b=DeBuqsb7dincb8gW8dyBmnKlHPupb9CCIFUPFOUz7Lf1NkDohwRTreqXZ+VKh1nG7enAoxdxTpCEI6uBvLKuQ75mXaPuGmocHo+YrW0BzyPP+O1SHupGFkhdeli03K2kbSwBZM4nikKkjnKtxRs6ALIeBVFbjCg0ymwCZUZwDNPnratQ4qkAmHmjGFCPOcseqYikdWa1bQS/XHfF2DQB6kMurWL6QvMsh7DC7hTKA14nWVMiuNIVBvZi3KL4nmVJ5eHAPvh2egK7dKtnUEUpcsg9/fDLIZ6dTA30nbzpruxHTA7VbiRjuyXMPn3CDZKkJcyjPhOEgr8Nt23UsD0azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBgi/RIy9reifXo2M3dklSzxqx4X+iAz3gXTrOxo9cg=;
 b=iTdb7GhXIVX0GSIu5o+JXZtEa6DbEwMLLHcmQIKA/OvnHp7FBQoSWaWN7Zy8HTsDv2wHrLeiHtTq+fsrl75L3Tq3unR1s7RBr4ayjeEGsbT/sQwPyPgpMLEfSXDg9Sou3InSDqPieC3yDW9QtET/n6KgPaM3yn/p2i9ppiTtPQUVxWz1fTrsiIBf4VkT9jLPWfZMhN6foLolT5X4ijQ5O0oXn9xyZxAu5uJSndYNCHY9qQRcArCuwVHDK7xeCg0h9O7lGUTppYsv79gSbE55MnWph7chQEPWcKt5aIKml/k50+RfZ9ftuGbXkAzvTbwzvhbM9omKTe2U77KXM+2Bvg==
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 12:06:55 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::5) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 12:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 12:06:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 30 Sep
 2025 05:06:37 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Sep
 2025 05:06:33 -0700
From: Jiawei Wang <jiaweiw@nvidia.com>
To: <bingz@nvidia.com>, <dsosnowski@nvidia.com>, <thomas@monjalon.net>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH] doc: update the doc for support multi-host lag probe
Date: Tue, 30 Sep 2025 15:02:47 +0300
Message-ID: <20250930120247.24926-1-jiaweiw@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f81fab-a60b-4914-d57f-08de0019d949
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K0+H/NdKG9ofZh43BdfwJvrtL00Z1pd72Q/u3z2T6liIJWmnfKJ5Ka54vBdv?=
 =?us-ascii?Q?H1gNEEUxfrra4D8ytnxYiyknWE/Iw2S10EKxL3c5ymXR/QkCqvq81iaureXE?=
 =?us-ascii?Q?QT5V/kw0v8pT6DoEOQjlp1oGao3187V/eFkb7M7tGfEL8MS+3kzqv+fUxmnL?=
 =?us-ascii?Q?otzEM/Rem9gx9FkGH23kmUw6xpxW3f/P1kJmmC6CXHMF0e7sFpcl4VujhTdt?=
 =?us-ascii?Q?9H+PgVE1dw+OY9e72sKMlDyDXHw66Zf0AS7KIel/SdUDv4KsUksOl2bqC0TN?=
 =?us-ascii?Q?UT4ODU6jbPA5i8NwVO4dSvP1UvdpHyy/TmEXq3G6Y1DMti3FvLKjmUOlbJWT?=
 =?us-ascii?Q?WeVkQd52P+Iwl4agl6Yk7JqO3eMv+KTJ4mrph3bN3P8KSbviND/7lTgkkeJ/?=
 =?us-ascii?Q?0cByR9HtGv2S0j5I/eUP7vUhuWoFCFPvhnQfRat8PZAJljo4qpiR0XXhXl7b?=
 =?us-ascii?Q?/wRT3Ba4F85ksQ7wgOBKbzL3bB/uXFxlPxBT2XmNoqz0FcRB4Pp07w3HL5zI?=
 =?us-ascii?Q?WGRNxWdD5TV7KA2uZcG8SeoCKfgAm0TUKfCQ+pWDvlCMQFiSQuytjG/rNN/j?=
 =?us-ascii?Q?4PkL14TkP1b2/QAwYCBk3O2xoAi6lFc0lVdhIKI1Wye9AK/KKjMsYn8A7bTt?=
 =?us-ascii?Q?ME90I7z7SY4d9AZqmP+15KxV4yroFL6FThgd2/m/dhL32rCAXqLaDBBfqsuN?=
 =?us-ascii?Q?wyQXA+p51OEHbKSnJS70dw6DmqvyVb3iIg6hyLK/7WKOGP/MPi0JzkCi56xg?=
 =?us-ascii?Q?3aPPFqWc14sFLG8s6+5RkRyfAxxLJ41Oa/UbYxz7WR//o3K1c9jPk4/Jh4VA?=
 =?us-ascii?Q?K7G5Xin3847t8nihJHUCPtMV2g2b8Cnp6QSOpzt1cKxrOAHzVM/0fKE5vca4?=
 =?us-ascii?Q?In9nLikiMVAqHJFMWtW46fxgS4KDR1OBxEvs7qGMMuuBut/UVHP0sINzkBmf?=
 =?us-ascii?Q?mCR++6AxjuZDo5+S8l0KaFMONZHbtBHt+h6sEXUQcfi0p9WD0x4GEEEEiprv?=
 =?us-ascii?Q?nObEevnJywih2H3EGN6LpZmj4GHVoGCOD4vUvIveKQfpAP+svlZbDtCrEujL?=
 =?us-ascii?Q?hY4NDEoPGlp3OwnTbCiIxVonYkgvDl06+1o7P26T2kKPd1ZqBOZ40cMVwuQQ?=
 =?us-ascii?Q?YuN94Q6OnwYw9/y3EpBf7W5rrWR5ZV3Y+CWbsktJW2uFfwX/6Mf5DllAhIJL?=
 =?us-ascii?Q?HnXfv7ThxO8+hYLsbU9at7dRudSwcUgGd61aNqFOy45fm9YKgWJf1C9QTSSt?=
 =?us-ascii?Q?9ZvEagh2MA9uByiW8xoAkvDF6/LBymuv6IoWzPyddL8xuFROlK+/3iMsJoTQ?=
 =?us-ascii?Q?qCGxVIK42rESDPQ1nmzZlC4BxJqtA5v0JRHZ78V19EqgfJE2b3WSb32PT9MV?=
 =?us-ascii?Q?dznuv4LieLsF9SvnRGlX6RV1ZYykLVlakHoFnPgQgdCbZqGGKk0wQfku40y4?=
 =?us-ascii?Q?FOElE8+3I4pNiKybHwilsHCVwHLrrj70aYhNowVmpUp4oTYDQ3/cS4vMKXr+?=
 =?us-ascii?Q?CqZwZ/9YWnaFxGHsMCQ78VPpFOwMyqaAVV5N1DRoWVxCCnZfGODLNMVEd7IL?=
 =?us-ascii?Q?PrC8t8VVWnv/Wp/UYd8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 12:06:55.1290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f81fab-a60b-4914-d57f-08de0019d949
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

On the ConnectX-7 Multi-Host Setup, the PF index is not continuous,
user need to query the PF index based on the return value of the
related sysfs entries:
    cat /sys/class/net/*/phys_port_name

Example output is 0 and 2 for PF1 and PF2, then use 0 and 2 of PF index::
   -a <Primary_PCI_BDF>,representor=pf[0,2]vf[0-2]

Signed-off-by: Jiawei Wang <jiaweiw@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20056f61d6..4aeb5b49da 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -744,6 +744,16 @@ for an additional list of options shared with other mlx5 drivers.
 
     <Primary_PCI_BDF>,representor=pf[0,1]vf[0-2]
 
+  To probe VF port representors 0 through 2 on both PFs of bonding device on
+  ConnectX-7 Multi-Host Setup, the PF index is not continuous, user need to
+  query the PF index based on the return value of the related sysfs entries::
+
+    cat /sys/class/net/*/phys_port_name
+
+  Example output is 0 and 2 for PF1 and PF2, then use [0,2] for PF index::
+
+    <Primary_PCI_BDF>,representor=pf[0,2]vf[0-2]
+
 - ``repr_matching_en`` parameter [int]
 
   - 0. If representor matching is disabled, then there will be no implicit
-- 
2.18.1

