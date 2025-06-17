Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A1C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C54241157;
	Tue, 17 Jun 2025 17:43:28 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by mails.dpdk.org (Postfix) with ESMTP id A26FE41156
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:43:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izONUE5RVKqk0WzTJzRbZ29rqFOC7kuOKeqKx0USSA805puChofXAe33uStLzT74sSgPIgYGmMKNQcR/24vylKlJHsYUxd6ku0ynFHhAxuUA2W+tn4GPZw+o+nSjYdxMMpsVdQCAEnb+2jUyORvB14HTFRwNst3Nn5Qn6sqcu/xl0Bn+JZmVDgo0Qpn8tSBI9Kkh7jbQvkxIa7PmYkPIskimeabMmhbnrZp41YiS+PfRMuF0HZq7Ajkmw7jaYBSvfm6J1UiS8HiSXQ1vRPZeCSH92knC2p1m0ZlugySDgZNj1QXAj8I4MQM2+E2vPTbpt7j48qIUAAwXDSlz1iBbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3dK6mepCwRGgqbH3eR+J7wS6qx9QrKek5JMAYRqw2Y=;
 b=CN9gprTH9gq9TgmqpFmu5w/09JjzVYshelCvLT2ipoYXquJnH+ubDkAa8uATxsHvDgO2wtmrfcNbN4WRL54ZrgDIScIqGNXAeRIVakRv0lCZNdhZeBkO9CgViQtWRzcSob9gGRc5WyGMb0nFJ1Z+3a81XPgpzdL4lr73YBs8RcD+UxwLlds9pUo0Y9e5O8BHBOB0g8JCgawVpb8TlENK0MraF+35cJMemxyTQZJecyuY7txB5y4INSK1y8A3uHPY1vatXQIRN4THdinQxLklLWxaKxEnNx8nFjDbnzezzuvOBo+dB5NL9HWp8yI6r2bso/wejJvjwTj5FkhpHkcAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3dK6mepCwRGgqbH3eR+J7wS6qx9QrKek5JMAYRqw2Y=;
 b=qfjBk7hID5UqiBKDtlGgVKK+m2oSvbf5GGOK1ESgaZmI+JDMD9Z4iUiAxGbdpkthpuhwFWjQB3oik0GQRFhYg7Zu6gGaRjXFQnYW12EsHOROUH6G/TOB5VuqTUnzXVHJS5xjoabszNBbKK7fkCJpFzYXoJqEDT2BiIKCY9uxAymynO2XROqgUIZJCEkIG9nz7SOgVMR3Jx9LZekDL26w+JY796kx79Z1KtmYIP/Mo4QK98oNYiLas0P7HehLsfm1kQmSepNz5mUlOUpXogk8ApeCtaMuKtd1L5pvtHSsLlrjt5sxpECk0qLpNBp8ZEOEQbXrx73bg3zW8/rU6M96lQ==
Received: from CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::12)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 15:43:24 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ca) by CH0P221CA0037.outlook.office365.com
 (2603:10b6:610:11d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 15:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 15:43:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 08:43:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 08:43:05 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 08:43:03 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>
Subject: [PATCH 1/3] doc: gro API changes notice
Date: Tue, 17 Jun 2025 18:42:52 +0300
Message-ID: <20250617154255.190093-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: db0bc42f-1ec6-4ea1-9d27-08ddadb5b130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z0e9i6XGw0fPylr7Lnk84QWaA/eQnLRFFB7QsHeE2VWaLp8+SYgp/xbkxhsY?=
 =?us-ascii?Q?biSkWB9bd0yzmgoxdpePQjfgqD6fpRl0v94nfokpK5Kziy2V8FyaN61GgmpV?=
 =?us-ascii?Q?Xae1TNPA9GkgbMC/ccqV9h3VbVETUyxQXqK9kjVO2HjiNenR7g2weYD9lNj1?=
 =?us-ascii?Q?YhXbQbdb1Tnv69y/E9Kqc1NwXtAdbOgdSEUmkqZLDPBM8ft5lHR+VIiPlkPL?=
 =?us-ascii?Q?SH3DzGdEPVkY+klDw0CWXl3b/PtvXmptPu/KXIqLlNy1pZIoEFa8j5WoCLnE?=
 =?us-ascii?Q?41H+q/5TkkYx2JS+1oFFGXLbn2Dryb+o57F0qm+0TVf/i5uDg4qKgUf+wGXj?=
 =?us-ascii?Q?N2TQd19uG/At4OlpDBjnL1dSdieQILNtkYxmqmMvWuftHO7TjAji6tyZ82c5?=
 =?us-ascii?Q?GSgpy6MNqXBJuIPXWv0ZJ17IK4utVHm5UlL7AqODHE7Yko6cAzKzmzSBl3Pw?=
 =?us-ascii?Q?gA2FmkzO9ncM3CATBS0xk4lU4z03nJ1bU5oXcSZ5ScJfcSO80Vx+2O8FvV6H?=
 =?us-ascii?Q?sOSBA3+2JqAD9kYNIGr3AYrwxj9xMgitf6Icen0FzEYj3eH67QahdCa0rjaA?=
 =?us-ascii?Q?+sYXBAn45xaHrQecDyPNWLdL9QOlnjQ4xOgBNYmyOhwHS+BIlXMmMdqfMFkR?=
 =?us-ascii?Q?JMFxh6rB+YpQSRz3NP/3HZLolNfOqmE2gbXSf79jWUK+KdgugxwKOaUag8H8?=
 =?us-ascii?Q?YQH6Qx+3tUAk94DdTdmFVKP9PCPk+CYfhEwSXY+sDyz1OhKpxVMmj3Kw/Rov?=
 =?us-ascii?Q?9fH5ZQ5SYwwd7/IFejXiw3mqg9JuWVYmkEzekPOEss6Q2u+Mj6NRoyAAa08k?=
 =?us-ascii?Q?4A/Ip3+MWBex+QfL6ySAcOhfM/WVDkO+Ctx9Vh8FMWUZ9IeKEFoX5+zgwpYW?=
 =?us-ascii?Q?mhIAO/xk8OER6T1nlYO44D31rBFijJNdOBzqyvZ0l3THAyO603WlHGoNtwVA?=
 =?us-ascii?Q?wUMkjtBA0kovnPQmy/TU8u1ol4tzEp4UJJym5tepNPCdplnFZyAB+vznNiyn?=
 =?us-ascii?Q?PsM9vHtDqzdJGSH9sfDl+WCt8GuhTf4g8yZxfbqhTbqL/UEKI+jj7wz1r8RK?=
 =?us-ascii?Q?jsO01ef/pDXPbhHX2UsY2Hl9uCuZU2MQ4xCc5g0AVLSWsNyo+RTua1ymOU1G?=
 =?us-ascii?Q?n5cTRU0xgy11HUBq2Ee4NzYPCdA7bBLiiWrcg1tiVDoFA210vgbHHdBsQDWs?=
 =?us-ascii?Q?o/bXTLYXwsUdIU2StPtVM5+OzDuMk7RS1c1JdjU21+rkdwIDPtUlGq3R6jdS?=
 =?us-ascii?Q?4LO+/MSHmd945lKOiBtfIEwMRTE9MM30yzVLj2EPMEOCXqLyLB31sqaHgUL+?=
 =?us-ascii?Q?x0pblP9eue0E3oO6YHVnRuSXWkHam6CT4dPTYz34C9Dlk1QsvAsjR9zqU8UD?=
 =?us-ascii?Q?pbbFHgSmW2asLBO2+o+Yh6PfJKhbyecupgg06B5kpQWhEiep23hp9kicMHZH?=
 =?us-ascii?Q?7vfQ+lc/KqYvklP+Gr8b7aAdoLgKv7wdKvi0zuIoMKpYP2r/WWKi89d5PDeT?=
 =?us-ascii?Q?ljOMxPyrPcnU/VxSXjHy8i2t37bUvsV0G2A4?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:43:22.8391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0bc42f-1ec6-4ea1-9d27-08ddadb5b130
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

when using --no-numa option,
gro should be initiated with SOCKET_ID_ANY
to allow using cross NUMA.

API changes notice:
Changed socket_id field in struct rte_gro_param from uint16 to
int32 to support negative value -1 (== SOCKET_ID_ANY).
Changed gro_tbl_create typedef to receive negative socket input.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 doc/guides/rel_notes/deprecation.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68f..5d534f49d53 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -142,3 +142,11 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* lib/gro: Starting DPDK 25.11, to enable using negative socket value
+  (``SOCKET_ID_ANY`` = -1) for gro init for cross NUMA initialization support,
+  perform the next changes in API:
+
+  - In ``struct rte_gro_param``: ``socket_id`` type changed from ``uint16_t`` to ``int32_t``.
+  - Update all ``gro_xxx_create`` functions to use updated socket_id type.
+
-- 
2.21.0

