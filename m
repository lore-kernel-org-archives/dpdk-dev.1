Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CBC28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 08:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4742402C4;
	Thu, 20 Mar 2025 09:45:22 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by mails.dpdk.org (Postfix) with ESMTP id 12E92402AF
 for <dev@dpdk.org>; Thu, 20 Mar 2025 09:45:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0DxO73EiuZmL/GNF0K4Mh9y2TQAA4Tao1bQKLQq8zeC5byBDTeu3bzlfLM82Q3x3ZVzAgJx7SpzrYsMzkJh7QtYDSuFRwWdyAFIHGbBTCtZd6dkv5QHmdSECOE11JxG1vrRN2LHYTHCc+DUUd0yOaVLS6/mDZBfBXrH9c+ABpVmXqKkZ87jUS/9b07BgAiXCP/Gc0ZUlSPGUtg5CYkGkMsSzReLmuZyYul7SLkqLjnkJG1IH48l2KwEHh0P3415omYGkwZo3PR3JqPeudIvPBT/ocUjRkvaoNUB+D7gLOdfJYuXWsyvsAYaTdrIyoYwzHJvmSukfCwnTnVVB0qo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GsF6ofOWQ4PMzhrAkRVATZ53w4V+/bsaHR8ul2vlsk=;
 b=ORwDjAgZszax+xxopxaTcv+e46sfMH4Ru6E5ZeMGQOa9MhWQJJAWi6O/GDd6kHyTEM7l7unTH7XwEQ8+P8fLLo9JYb3IXoyM20c/IIqcrdQ6bmin3tYgoCtyx98ytkO77xJ5J1WBjUHRaBpYcczzDyxqTgum+Ehbw7zB5MmSGCRCETVEPJLq6pcRiS+leF3UYEjm4od0deLvgPd/lY3YpFHFH3rR5RLuM/r3w1JICRMoCBKPER9RrR4b0Cn2SShVQLQCckpJy4wyzydfBBqZzirb72PGfuXd5KR+6DNdVc9SbN6jui9X3VJNwTqrvSJa9HRySXGa5+Sz/VUFHM2hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GsF6ofOWQ4PMzhrAkRVATZ53w4V+/bsaHR8ul2vlsk=;
 b=QOrbRt7rImxvvIVstxvFfVY4W8qmVLykETib2iBTuXwdtoJQMi/qJj1DCR6qSNMEjOA968a4oJuD7ayDXTDgWjBxf1noU0ilfwlgKtXYe9iFNHIIyplhCUfGY2kcjBKhQcoVVBqDJmsm4n8b4JQg5wIZlvEN4J1jbCHw5lX5SPg4ipcb1+tLx1wqoqkuh9Cnlm0++tYzFrAV/RYPOJlRAfNTqCnnwb2a/UFrdhJmqv/1Ub/F4M2aFTF3t8T3VzINIBHvz3rzuX1EXr+vqQeQFnyhNyWGepTgAcUkNAzFd0vcIN0ofyizKMaVDQFBRSMUp41zy5OH7UbnDp66sHWc3A==
Received: from CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::10)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:45:18 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::f6) by CH0P223CA0020.outlook.office365.com
 (2603:10b6:610:116::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 08:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 08:45:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 01:45:04 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 01:45:01 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Thu, 20 Mar 2025 10:44:46 +0200
Message-ID: <20250320084446.82777-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fc1b64-c830-49ac-42f6-08dd678b8a51
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DEOM4YRAIsCl7QlNL3lTo37AoSaiy+SvgxxkRNWALVGUjlW8RQfsTm0ghgdV?=
 =?us-ascii?Q?ER8WcIkVgcGJyHkGmux0iBMKDVmkiOE8kTDGiDC4RtTD8KqDau8RgthF/t0v?=
 =?us-ascii?Q?xaQEJsJqXvKbuUiAebgdm7ynMz1QxtFjphe7ldVtyAeFAwnLjkmCkyjfqin5?=
 =?us-ascii?Q?IUjcnOS5aL7+VBoQodJCWk/xi5v15NKXnFTQ7Y9u790SuaYInVta8vH530rg?=
 =?us-ascii?Q?e3+Qg9XgtVGnUlUOONMoYqrlkpi/gA54nUapNqHVHBqnq+mCtH1VuvZGI0ns?=
 =?us-ascii?Q?TeRky0DWqZZ8GVNdYvjkXLlF3iT2WkC6OQ3Fd3IUoEBZlLS6XRDeOPt8LRCo?=
 =?us-ascii?Q?QvT1JIpSsHDJR3l+a0yO1vh0wWjImpiuW4Vg7WMCNTCHL6TQLoZeKsdsFZEE?=
 =?us-ascii?Q?NF2AiQbSgNCbQVZVJEZXzBVcVGMkLi9PwFQZJSUGs5ivlYcr+rW43NxdDWu0?=
 =?us-ascii?Q?kh000yOk5+Hm7HrWhLBlMINSvoqsSj1V1+u0YHyOdnPt/R9RMyyCUhmOHZfO?=
 =?us-ascii?Q?2jjUuy1DGqUXf5oZbwKMvFEmwPacMxjcZOU2tJ74FT2c4b9zC5eBWwP09Hrb?=
 =?us-ascii?Q?akwnjMp3UQbmLhg0fGtOHyetW99UgDGXI09/AwNyFq6CJGnePwpruMMBIFrZ?=
 =?us-ascii?Q?cyZz6xSskJhwQJfVgcHanfLKkuQJwD+Qq49NEUPvF31eq7nig3tT9r76zSMq?=
 =?us-ascii?Q?cjUMz5j1s+s4U5o3ELyysXmossxkC6W8BrqasBToHr4H1/niebRcaKwIQMIR?=
 =?us-ascii?Q?mjk0tUkvzOf55vFd7kS2DH48We2HJTu0aIJnlAGsZqaoK4BRTQEkusKg+Ux5?=
 =?us-ascii?Q?tIYkQn4feSeos0nw6GeYDY6lvnPiEYzt2FZiO35MxIHkvyxlKGSLA6lv/14P?=
 =?us-ascii?Q?vSoZSyZqquACkuzUvgFeA/vNXIXcokLuspQELO7dGQCHX5oDV2jCexnkBxLX?=
 =?us-ascii?Q?aq6BBy2WW+IJgq55mG/uv1iYxj28IZ8I6aETEbCpA+hOexZZutEpv3oJ+oeD?=
 =?us-ascii?Q?/AQ5Vpeo1kifinyCbfMV9llpxoieEPt5D1rlxOgfS0jmFm7I/jUD9kqr/uqm?=
 =?us-ascii?Q?5/MBwjRcTJAakXlrexTY2oivfZy195eqq/FNoD6QJclZ4mzcPc37QPkwZRbU?=
 =?us-ascii?Q?q1N4whUH5l5HZvZCifds0DxhUgEz5cWPVnULrPCHOy1tbU/3tbHOEb+TZFLd?=
 =?us-ascii?Q?8c448XwGKwC3bwUTDaHhgTvD++ncQ5PGxpacxtwyXkrrPVdVjvqIo5VEXdSu?=
 =?us-ascii?Q?PE7p4Iq6BYopTSskB3FbVKg8/3HBN68NWEe/YMUHzJZckQZAm1zc7GjDOupo?=
 =?us-ascii?Q?LUjxyZPXc9LgK6e/bN3OOecZDkYqD5jDT2zHuWXjf30cv2Nd5s0DZhH2QBHP?=
 =?us-ascii?Q?vNWBU4nmcBAjRs9884ECzc1kO3kuO8pecEThWV9AgN+q2scxVCVs7Tbgd0kR?=
 =?us-ascii?Q?6KsQRbZjZSuev1eNDliEc8otULeDIn8Wn+QrQ9jb9L49JLHFjXj4Ds02w8Mu?=
 =?us-ascii?Q?Q4W4n2e9D8z3u3I=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:45:17.3612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc1b64-c830-49ac-42f6-08dd678b8a51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

Add tested platforms with NVIDIA NICs to the 25.03 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_25_03.rst | 111 +++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index caadd05d00..9189e83124 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -306,3 +306,114 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * Intel\ |reg| Xeon\ |reg| Gold 6154 CPU @ 3.00GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2697A v4 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2697 v3 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2680 v2 @ 2.80GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2670 0 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 v4 @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 v3 @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2640 @ 2.50GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 0 @ 2.00GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2620 v4 @ 2.10GHz
+
+  * OS:
+
+    * Red Hat Enterprise Linux release 9.1 (Plow)
+    * Red Hat Enterprise Linux release 8.6 (Ootpa)
+    * Red Hat Enterprise Linux release 8.4 (Ootpa)
+    * Ubuntu 22.04
+    * Ubuntu 20.04
+    * SUSE Enterprise Linux 15 SP2
+
+  * DOCA:
+    * doca 2.10.0-0.5.3 and above
+
+  * upstream kernel:
+
+    * Linux 6.12.0 and above
+
+  * rdma-core:
+
+    * rdma-core-54.0 and above
+
+  * NICs
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.44.1036 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.44.1036 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.44.1036 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.44.1036 and above
+
+
+
+* NVIDIA\ |reg| BlueField\ |reg| SmartNIC
+
+  * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
+
+    * Host interface: PCI Express 3.0 x16
+    * Device ID: 15b3:a2d6
+    * Firmware version: 24.44.1036 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.44.1036 and above
+
+  * Embedded software:
+
+    * Ubuntu 22.04
+    * MLNX_OFED 25.01-0.6.0.0
+    * bf-bundle-2.10.0-147_25.01_ubuntu-22.04
+    * DPDK application running on ARM cores
+
+* IBM Power 9 platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * POWER9 2.2 (pvr 004e 1202)
+
+  * OS:
+
+    * Ubuntu 20.04
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.44.1036 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.44.1036 and above
+
+   * DOCA:
+      * doca 2.10.0-0.5.3 and above
-- 
2.39.5 (Apple Git-154)

