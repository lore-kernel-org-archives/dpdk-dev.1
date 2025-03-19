Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86DFC35FFB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 12:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9589402C4;
	Wed, 19 Mar 2025 13:14:31 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by mails.dpdk.org (Postfix) with ESMTP id BABD24026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 13:14:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmetq1HmGhz50wyY1O05LS5s/oAcBjI01aP6fOEHZpQdGn5KxubGc7bXN2dSlkfQCrklEigl+QgoOKKBRRJTD3OSk5E+pGt+WZz4y05NA3gKbU0047eJGtwB1uN6PqCNW1Qc8nHczW5kjL3psLKdNlAT3WSyeOoZ6+i4OBliYV+nr37nDSgeQyCamdgWaQIrpgWaa9gsZxg8RO68LABk2uBlTqZFWnUNj6+vdFB3T+orODdYXt7Au0pRs1zorMCVkaiI/0H4JxI49F6vrdYxA7uX57OuRwriJPy0XP3RFPhS2SUno3yWMTGqyU4COo+Uv6ygfI656J9kRnHMQaPREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYUDja1ZDOgBkjYWrGkYlXr8j3wIlnnzYKFo0L7n75k=;
 b=b9PpSrJ79q8SN+I047fpW7ebQMEoE3UHTUzPjEr9nHm8mXPRDDRrfbqJGXORX8YwEDCdwHWimualoTZ37waQhzLIH02KDE/M9Uz/ilzHYd4bfq9vIi0NPFi+oIpp7nXYkp3XQa09vdGyPK+kGIAunNS7hQmolY+8KIYm/8O9mOQWwVSgTMvM+tspef+qr9rIc4e01nZL4gwy5dadV8DPNf+C7fWGf3hEhxPVHwG8CfwWbA9Klto0stQCmhvsOJfewV7jpqRjiB7JDof0SFirOq2F1iUeWbAg3c2724LRNq0YnxWmatJRnnA0S7cTI7J5fJ/A8UEk5jqM4AICKgbEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYUDja1ZDOgBkjYWrGkYlXr8j3wIlnnzYKFo0L7n75k=;
 b=e1jkGjqWCWgB3mqQWt3Os3ZqSrntX0iHuLOTaJtzvOy8HPF/Z1o3dqEGt/KHvT+eMINd8LsqpFnOdMwzw0AM+SkAxAieDXaMMSVL+c8lV2UubfcHd71ub8sUGwub6DxjbTU89GNwE7ZRVs39/jY53eKXSKxmRzM3kVEMWwoVUvqgOcgvoK+MIz/tc40TEt/EaceA9fuvpUoLyy1qTZA6oyKnw2BHsvJ23i1YDae+GLS3eacQMIQ4MjVteMdOJpmemed8ArPu/kw+oZTgTrRCM9wGISn6w3dCFNQFiPw2ckTqKg8jDVNCllkCTFJZDeQOos62wT4R6BOMiXsVc+L7ZA==
Received: from SJ0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:a03:33e::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:14:27 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7a) by SJ0PR03CA0041.outlook.office365.com
 (2603:10b6:a03:33e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 12:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 12:14:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 05:14:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 05:14:13 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc/bluefield: add comparison between BlueField versions
Date: Wed, 19 Mar 2025 14:13:59 +0200
Message-ID: <20250319121359.32365-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc2638-6da8-438e-95fa-08dd66df977d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ne5CgpU1ve/6mymKpG0G20b0UkO1X4uXGfAaGB6FJitCu6X3xtRh/fyMxqKX?=
 =?us-ascii?Q?J+vt/vfy1CKseeTQe0DQizDFOV2ZQvEpCwWqjbn27QDbi+TlgSLmTs9Y5ZkC?=
 =?us-ascii?Q?q4dupKRXjxfVlMaee1pRHJoFZEFZx8Ub5VuFLrTDUQUZJgT8PVx5YhEGM0uN?=
 =?us-ascii?Q?8BNg4X/Qb2bEx3FtIus9hsdg51vX5dyq1iEBvzwsmyzifd6hncsiKXiDXzWq?=
 =?us-ascii?Q?QEv+IRvdx7XVm9V7I5RzKT+pPUHy/k30cVLYGQR4YGLXWz0z25GROXe3VosA?=
 =?us-ascii?Q?0b+yGSSb8l3MJNN5YDzbVVzN5x9krU0J4bTOHSZOUi/9rw/jMgOIq11kn0zD?=
 =?us-ascii?Q?xhkcI/m6oCCKbb+L/yAcKXxm8pOh8QgYrzH2he3xMYQSJ4Ngct5aY2dUhOtt?=
 =?us-ascii?Q?5IR8zFa1R3Qc19C3tzcoV82QeQ9F6AED+SHD6USvkY8k5lnuoT8BoP345aB1?=
 =?us-ascii?Q?NaBJgAnBfpLar/brS+vdahCqlBspwAm10JGWETTZf/oaM7rF91j73YayH6oV?=
 =?us-ascii?Q?IWYHf9faNF4t9pYb9ij6kmDLiTFc8xlfauVLh/PzieHzwoHO8Fu4wT9P1y4k?=
 =?us-ascii?Q?Z5PEqanNKbipZK6cvaqkzRsxBfs7LKJ+XZUG6ngujVXS7fYWqCBVI/6YH5F3?=
 =?us-ascii?Q?zfAU8N0+UeEqCp+/Fcd4nZkfWFF9dJ0TM/vg401kUMPTZDuULUf34jF+iyC0?=
 =?us-ascii?Q?2E5Jhwwd1F1Vl/LyKeVBkrCy6JR+AbDWHyX0yVzgW2nX5PqdwGgFOr/O7QET?=
 =?us-ascii?Q?q/eEIs3uR3XAAvfURXK4nc/f4JJoK+7oLp1IkO4qFXRPrBdR7NikhfscHREr?=
 =?us-ascii?Q?lSMeSo89Ha09PgL2IkxoSGBBnQmw0ST3qRpbvvGvt1xLfhjHxQqe5rGXMPPX?=
 =?us-ascii?Q?zrsFoS2s32Tm87+3iUi1tBj+LlybCC0AvDCQjcrRQbhIaXnNKbnGDLCdMlL/?=
 =?us-ascii?Q?wr20QaIww2njHoFk1V2VPn0eVMFSWfN1H6xGYrJ5XL2YQWkNYiRKUcUWIUPA?=
 =?us-ascii?Q?bqjshYp9QeZ0qOfg0gzyEjQmIt1SV9J7xbY6Tx4IV5yXxWv1fXq1I/I2GuYP?=
 =?us-ascii?Q?IRn3ZDN6kuCBD2PAwzeQ70HSwtRz0jbWjJUKXWRQ5kWsXyWT/xn4zIRuMVLo?=
 =?us-ascii?Q?shBtGsuUs0YNhaYsprT1hco0JbsDVq+x8XQF5a6SOEwdNTj/Lh4jxsKg9kSB?=
 =?us-ascii?Q?foPnD6woYd11yF9R1qgEdUbOtZXXxKruU/dPbYp4uS9m/I4rW0mcnzWYMluy?=
 =?us-ascii?Q?czhMFtsZsv7lbHs5ot87Rl+kAD949hwBhE7cENBTW/7GnrebDYprJ9W2geJv?=
 =?us-ascii?Q?vTfzB+VMrTUkhxFNA3NNaeSCR/Jgu1WWwzZaDN846P2Threlk1jyBJ5Z6riv?=
 =?us-ascii?Q?AJVxMoNJUStGR50Ek8dFWQ5cTddO+8Js/RHfm7Y4zBcfZClyHnE4HhNaVL5F?=
 =?us-ascii?Q?9TB3ssCjvv8J6SjzJXsK4MDDyl9mXjwu2c+vvzYvjEltAg/9XtUMYoqch3hp?=
 =?us-ascii?Q?idAh4BN79hVJT2w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:14:26.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc2638-6da8-438e-95fa-08dd66df977d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

Updated BlueField-3 documentation to include a detailed comparison
with BlueField-2 and added notes on compiler requirements.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/platform/bluefield.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/guides/platform/bluefield.rst b/doc/guides/platform/bluefield.rst
index 954686affc..e1f8e2e38f 100644
--- a/doc/guides/platform/bluefield.rst
+++ b/doc/guides/platform/bluefield.rst
@@ -22,6 +22,20 @@ Supported BlueField Platforms
 - `BlueField-3 <https://docs.nvidia.com/networking/display/BlueField3DPU/Introduction>`_
 
 
+The following table highlights key differences between BlueField-2 and BlueField-3:
+
+.. table:: BlueField-2 vs BlueField-3 Comparison
+
+   =========================== =================== ===================
+   Feature                     BlueField-2         BlueField-3
+   =========================== =================== ===================
+   **Networking Speed**        Up to 200 Gb/s      Up to 400 Gb/s
+   **Processing Cores**        8 ARM Cortex-A72    16 ARM Cortex-A78
+   **Memory**                  16GB DDR4           32 GB DDR5
+   **Integrated Networking**   ConnectX-6          ConnectX-7
+   =========================== =================== ===================
+
+
 Common Offload HW Drivers
 -------------------------
 
@@ -54,6 +68,13 @@ Compile DPDK
 DPDK can be compiled either natively on BlueField platforms or cross-compiled on
 an x86 based platform.
 
+.. note::
+
+   Starting with DPDK 25.03, using the ``-mcpu=cortex-a78ae`` option is required for optimal performance on BlueField-3.
+   If your compiler does not support this option, you may need to use a newer GCC version or specify
+   ``-Dplatform=generic`` as a workaround for native compilation or use the
+   ``--cross-file config/arm/arm64_armv8_linux_gcc`` configuration file for cross-compilation.
+
 Native Compilation
 ~~~~~~~~~~~~~~~~~~
 
-- 
2.39.5 (Apple Git-154)

