Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64591C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 09:39:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E1064021E;
	Wed, 16 Jul 2025 11:39:21 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by mails.dpdk.org (Postfix) with ESMTP id 520CA4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 11:39:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnXW/cBpBfo51JhxZxmzsFYVxwQZfN4ozNyv9vBj1txlq1odZwCeHndF1WdP6Xjhzjoyf2AbECWVXnqsaWKnNV4BKsmFHVXnz7I2HwwvpbNjFQWkq8oZGDr/T9w0EsB+nnr1A9vf/n0KKgb31EB5yqWbYSj8n86Hf565GDjsMSj3LXlpChBcXxJZySFvCORifBox+MTIgOUczTysTYO22ndLKw9PDeSZMAUfmRoBfd9jZ0ZCAbpzUrdsew6cIFLccK9/8oNDzjULd41MgDT1C1OhN3IS3H36KBRi6eTBfubEFAm+gmjq4Dma35GZMHzypX3zwHRZBQMhGpmVRWHKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2MMp6ZiObSNsupOqeekKedcTD/hXqP4m5b4Uj6cKoM=;
 b=vxV2qBNyWEKbeo9CCy9JF25j0ASX5nP34OwusenwPd877ghTSiAIEwL6/rwsHAFNRSzPRERMEXvctAxtOIoisUkxudwl1WnQI52IKmAvujUo8ttchVcsfAI/+WdO8BJcDnLWmAB8l9brPwTVF76gGvsmBgT/7vCiRz9GpNWJtlzKUXExxWJV81/MzHPB617ya5KHUPHwHaZOwlHISj0ggPCEqMzpnzn5C8FGmkYZv36oEQE0i3J8iYMoHbl2lKBt57Xa3WZao8f+jwQT1UzoWHtmVqfxgDqm+zg1zo4WN4NslZ5+pfhi3Mi40NwGhwX1IWxAZZJutQxeW+vLAaHkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2MMp6ZiObSNsupOqeekKedcTD/hXqP4m5b4Uj6cKoM=;
 b=QZvDLsy5uMQKXbivfZU4de7dTpnah92CC0z+ZTxswCCBLUn9bukSnaVkCrGaHW1GpmKWQn3Mg9xPqlIAqmYSbqTGDW8QJCs7q1WIUFtev0wIQnOMDbLr7tE2i1aFtqvah/u+/st3Thq3HrwnJe7eyg2sI7wT03jxvU6wFhtoAFVjPdcc/dKrRuQoZgOwK4rs93ny+pfceZG9cnlz4LcYBb8wqQNZz1PJPstty0HPBq+WzlyqsN2D/CctKkvPT4EE1iv1+O1OCcpJ4jI4IC6N9NmyGUba68Epwx4puB3R+RUW9zZvoK1Wl46jzpfnE/ixKDq+MVxg90HOJ/MREAAWMQ==
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:39:15 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::9c) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 09:39:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 02:39:03 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 02:39:00 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH] net/mlx5: deprecate representor matching devarg
Date: Wed, 16 Jul 2025 11:38:46 +0200
Message-ID: <20250716093846.1117794-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 58058d43-1399-408f-4f1f-08ddc44ca0af
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMrPpNAggJCWpnnIqiTS0QxzWiNMMTr3p3ijBXIXrcSFUEWul/Sq+4HuooPS?=
 =?us-ascii?Q?e3uQrZ/TUZxB7auEpfw/3W6Go4MFPI8c6fTXAjjskPbo1d5/rqu3slBVai+f?=
 =?us-ascii?Q?3NId1GVUvwyOGooHydc3enWCAdj49Kj1+MXQrBVR3Wisj+y+ZlW+jk9xpPuE?=
 =?us-ascii?Q?pxgT+tU51INwPPm9S3mEK88gq221zdwwvaCqVtJiWpTPAJJV7cLKXFqgZR1l?=
 =?us-ascii?Q?jNmTCWgjXD1IKZ58uriBRxY7NEOR7VXr73Cd/XgtH/cR9HiYP3f0WiG1vCWH?=
 =?us-ascii?Q?5HHZdvkx0OQ873DCvfOJJbN29HE9Aabdt4EVJAxKLvMb4Lqv/yhTfUHa6WjI?=
 =?us-ascii?Q?JLVruyGe/zIUZZRNfwyrWZ/Xuv0CPrC9eazs6Klv6KkX2A6dhHa+KdjBBsFu?=
 =?us-ascii?Q?YESOu3Ya8Qcyq5rtyn6xFU6+E7raya7yz0qQOgwK+iu4jrzOPADYU4P2V15b?=
 =?us-ascii?Q?oJksTTsDfcoihf8FHp7qW7CwScOxQsEhoESnvAjumN4aNALahzAaKDlCO8ME?=
 =?us-ascii?Q?kYRdmsYXH/TBVaXVPsKlIkDVEhh6axOiCcHR5EkJ3/ZF2FWls6yrLx8mWwrZ?=
 =?us-ascii?Q?svZQKi0/CeAkmh6UVgRCQerWyJLkaUrPjE6qXk/Ar2UHCEJboMnlUeEGyQUt?=
 =?us-ascii?Q?bbP+YvEGlnxENSyRZID8wj74vZ9rsNyD9/FymR0/H7sk4HmRhRk3O8/3CGGy?=
 =?us-ascii?Q?qA2kIh2kphxoHvckbMy5kHFNOKdAUNaMLj8lBarhTftx7dv11Zkthn7Bb8WT?=
 =?us-ascii?Q?Uto+g7guXxObL+50XhRZM1q8o7DZuobylvSyE2oqh48xp9kMpINVYflr5ohz?=
 =?us-ascii?Q?s+cTOymu1dUta0TJ12aksk8wQDpjAXlKHBVvh4bKIa/Jo3whOQ8ny0jzubh3?=
 =?us-ascii?Q?bCpTb+Ok3GOED52CpZufy3eQmlOpaVjwKVL5oJ9CPd4rlboF2sCE440a3j5G?=
 =?us-ascii?Q?a0cBxtfC5s7Z9ImgMy53wsa9gvmmaShoXNq1DvykPmATi6Lmuy5wpzfKDZDB?=
 =?us-ascii?Q?mb3n/138tFw3vcCBWAOYi92Cwqb0aMeqFFj5hgiM/Bp3gao/7mC3dtjgnZfc?=
 =?us-ascii?Q?RBfIx9X/RTU9NQUQJlEPx0ZM2cyekKFlXphwJI1PV6vbtBNjp3GqfzXlpO+/?=
 =?us-ascii?Q?pqFgz+BJEvcwjzTC4TAVURt+8TWArTWgTZbYLHHq1/t4bjs/RlaJf5iDuTwe?=
 =?us-ascii?Q?qs6tuPc8dV3oe5ny/EBivXr95at6XTb+mlMg0dEgz0JhyETCOh5dpAGjlpmT?=
 =?us-ascii?Q?/uIpcPUBLz8RUOCGXQNiMUf6lRMKpjFGOLJUMIyziGdRTcZTC+4cU5l/aZ5q?=
 =?us-ascii?Q?SN+3vpvg5rYH+9CR4ZIYhJ25ke7OMXQE9bORCZLFhTC/loWg+xzFa+YiTHpf?=
 =?us-ascii?Q?id+01GuKTV4jBHkfhYiVldnSYIYYP5lkCOVEVssErYAw8o7dL+J0ZpekBQGG?=
 =?us-ascii?Q?HiY7/azAsjrRFNeFXkNwQE7EUaCktHiOuneAtnSxE/NtnyPduK1QXTmRYQ5n?=
 =?us-ascii?Q?al3ffBgKNPJU+XSyO2BFEsYF6+oKYYY6wUfiscM+9grCXdXNSRGXDEaVNQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:39:14.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58058d43-1399-408f-4f1f-08ddc44ca0af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

Mark repr_matching_en device argument exposed by mlx5 PMD
as deprecated and schedule its removal in 25.11 release.

Functionality exposed by this device argument does not fit
current E-Switch representor model exposed by DPDK.
A new unified representor model, described in
https://fast.dpdk.org/events/slides/DPDK-2024-07-unified_representor.pdf
should be developed.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst             |  4 ++++
 doc/guides/rel_notes/deprecation.rst | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c3a350d24e..7311a9849b 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1636,6 +1636,10 @@ for an additional list of options shared with other mlx5 drivers.
     item added. Flow rules based on this pattern template will match
     the vport associated with port on which rule is created.
 
+  .. note::
+
+      This parameter is deprecated and will be removed in future releases.
+
 - ``max_dump_files_num`` parameter [int]
 
   The maximum number of files per PMD entity that may be created for debug information.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..bbc35516b0 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -152,3 +152,14 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* net/mlx5: ``repr_matching_en`` device argument is deprecated
+  and will be removed in DPDK 25.11 release.
+  With disabled representor matching, behavior of Rx datapath in mlx5 PMD
+  is incompatible with current DPDK representor model.
+  Packets from any E-Switch port can arrive on any representor,
+  depending only on created flow rules.
+  Such working model should be exposed directly in DPDK ethdev API,
+  without relying on flow API.
+  Currently there is no alternative API providing the same functionality as
+  with ``repr_matching_en`` set to 0.
-- 
2.39.5

