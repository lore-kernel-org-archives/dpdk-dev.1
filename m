Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5320EC83F1B
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 06:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C22D84025D;
	Mon, 14 Jul 2025 08:39:21 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by mails.dpdk.org (Postfix) with ESMTP id 63295400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 08:39:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo8h6Lq6fUjSfyncn4iFgjcg+p0cQ3ffqVRP5gd4HkHi8Sugs4cJkn1flHyrSGW9aMQ7k/1X0tz0dltkqqj4eOqfC+ePd1XBYlFIPiiFLplIdLEn5SpUoKEyw7yQwqnH75nkNHa9wcHH4x1Slv9Rq+EcPVCOFTNsZFok2auMt515qtV2s2ZXnJ4vGub1G1vI1p2m5obXof3eY7EuGX/+QIrUyTgKkdrOFNwjzZ8H9zscR3lMwU0RPhq3Fef+QYKeRN0gC9ocXeeGRoZaBigSpfaTzhxoTnQHByu6fT6X0GUtcGHQxWz4h1f2y3pO/3fcCiFBx7X58EjqxcLRu6FjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56ClNYw111Ovf5QfHx56pXwReoykwSIhHp/CkD78ZFg=;
 b=ERIUdobc7ueeOs+xNCwdT8J/xaKzFAz+E9STb2Z1zLvp6zdz+T7RVWZmWOS7etZQNdQ68hP8WqH2XZ8C7sICpt7EL+TfzNQFbM2gHGRMb61SypBU0kTeUhCd76M1JBi7/0iQozfpEM6/Z6r31DbeD8L9hAX7dWyQXePzyoAwLoQh/Cl6CrR4hg/SQmE+/Rdhq3Qn9dmzb9UxrRgkvBk7+ELkG5I+OnJzW6Tn0nhU1EnqnZ1fsjCfG3LwIG1TmJzHfXnnAPQxDCs0R58pj39CzzngXNCbyXbh255GVWLemmzWPXeiGTYFgCxvBDVrEBWE1VUNRwifDdiKh83teT0nYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56ClNYw111Ovf5QfHx56pXwReoykwSIhHp/CkD78ZFg=;
 b=uZcnR+JYFGqvrnaAi7+JJ3JNY7Pib/4FwmxqWVBhEZPgC+W3bNkaCQL5TJW1vwwmbjxVOqx8KinjZpEoXXl5dVQ2eip7DII2r80sJc5AglknbUjBGGYtrXS/OZM7wyRVcJvxvengHSbNYlBXBqDU1+shEwjHrGWebLGE68nKrkG2lV1Jpn5rj+n0iseLhQ+BFBIXUEtO9HsiBayxpkKMGTA8gCSvJnlaZ4yWOdcqliNtdd/aepVK2VuBgOEtHUFWq537PHCFLUoFzTh1EI7IA9hSvAorpB2toTj+40HJOT+nrI7ynxwZpgfGDZfZ3b4AVb0z73liYO4mmmUKkTOXcQ==
Received: from SA9PR13CA0087.namprd13.prod.outlook.com (2603:10b6:806:23::32)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 06:39:15 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::74) by SA9PR13CA0087.outlook.office365.com
 (2603:10b6:806:23::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.8 via Frontend Transport; Mon,
 14 Jul 2025 06:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 06:39:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 23:39:06 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 13 Jul
 2025 23:39:04 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Mon, 14 Jul 2025 09:38:48 +0300
Message-ID: <20250714063848.56503-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: a398f8fb-d1d8-4c41-9cb6-08ddc2a126dd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zB8PmPFPQTBricvYehhS3N/ufGyRLRABGUQIWTyBGhX7BNmKT1fHbC1XKCmm?=
 =?us-ascii?Q?3qgcYbQsmD+d2vk4QYk3Ngk4FaWr8JwDoAOsQgyO57XuEFrOxyOVFcQUpMd4?=
 =?us-ascii?Q?gS3UiBmhP7OtiYrh1MY4VybDRJnXmvCNVGKF7EoB3PNJzAtjfE1GcaSVD/pF?=
 =?us-ascii?Q?J3xvY1KEgiHw7K775xYcZaI+ufsfwRmdLFFjVbSJqNUdvtjxxtgk2Gnrryv4?=
 =?us-ascii?Q?/zpv3W48ovFDza3Gw5Hj/cNsWgs2st8JUbn1zIztw3ilkaO4Ov94hIFEH1lB?=
 =?us-ascii?Q?PhqX3s5gkC88mHBcqP6NgtjgaNfMZYChEkuhcS2t3VOA3C2oMeZCuaVgPlhE?=
 =?us-ascii?Q?/DGExeMHfTYQhfSNS7NedHIN/+NdSuWcF/NjPFaey+EsAWyRAotrEYkqIh99?=
 =?us-ascii?Q?JjRjpcjW9PPmIegnx4ip5gojL6s5q7Du0NR+1czKKf63hClD2sqj1WerPIdy?=
 =?us-ascii?Q?27ld2X9ZIu68pGsIfOXA4GbPrg/tl+pQ+u/NGAD5gt9haa8klmJr1BNrlRK1?=
 =?us-ascii?Q?WCew+wcVPcrEhwTs3ezrst8aSaXRWeZ//Hh2TO5x+kaCaxE0AkNUyowa45kB?=
 =?us-ascii?Q?686ggy5HNxl+tIGGLo6a1gev/S1UJfZ7i/51hXCcSzLJS3PlbR2kcprAHm6B?=
 =?us-ascii?Q?qGS4z7VlVkZNFWLk45hUsn2rECa6Aat0hWQzb3mFnjSwqmCXuKeNHmbQ5rYX?=
 =?us-ascii?Q?q80eIUWeAUR5AlOjcrKLss9f4KK5iilSRKwK80jk050nBR2ORvkKstIpTXJJ?=
 =?us-ascii?Q?D0CfZHBOUnu0fp2I2qfVBHhnY14XRPVEv0pLpcuQH99vbnqIfp8uqgMnflXh?=
 =?us-ascii?Q?xLC1Pj1DVIE3xJ8F25PrVWTHlfqOO897/7nY/VYLmE3ayxrVN0wxxWjUqYcd?=
 =?us-ascii?Q?ncnQ+lsCNxzvdg1nBC8Zv2dJYS5pb9T29PNX50vTV6sLMABPtNvlGnEnErks?=
 =?us-ascii?Q?wvKwL8VC/wkBcs7pyJ1Q6LJ785E98g84wiKz6JUdm7lXb+cSQU+EnyeaU5yQ?=
 =?us-ascii?Q?5Sj71dlbuLgxHQGX8gGEPubAcb9WwIi5Uv3lrnRNuG7NXjHKY2oIYvNJZvBw?=
 =?us-ascii?Q?loh6JMzEpTmd2X3FggRUWy3gQKautt09iriQCuPzNcMqUW4+2ti86iZwN1ij?=
 =?us-ascii?Q?p3RjwQ5GBJS0IOXe9n6UqsiYC2XviZ3INZErV11SpeJNrdZn1ACq+zGl0vBM?=
 =?us-ascii?Q?417T5LDK6WMIblFW5Gu2Iu5umWCMIK4c4l2aDAKtTNyRqk7eKwSAC03IP0Tk?=
 =?us-ascii?Q?lPx5oqxy6J0kHQz94WvMaF9UJJGPvmwWnhG7/yEvwHAU3LsqJJ5oYd2HhIzU?=
 =?us-ascii?Q?K5S7LzMDJqaTvNVE7ruaWMsRQ8zRcGPpdNQ5vHnzgab3fNstnh2kh9O6brd0?=
 =?us-ascii?Q?b9blpqxVfJSNr0rhI2PYgFTIy0opD8Pkt1rr3voqRMyICS1u32w6Ec84/4fz?=
 =?us-ascii?Q?bbqfURd0C8iNrt+o/l3+uvDXoSSe/b8XiLdGnrsP6Y5/sIDIDrAIWr4t0DVk?=
 =?us-ascii?Q?UJ1cnFqS4huUH0Aq8ln/XhYBYSLAxWkVTHEW?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 06:39:15.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a398f8fb-d1d8-4c41-9cb6-08ddc2a126dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

Add tested platforms with NVIDIA NICs to the 25.07 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_25_07.rst | 112 +++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 0b8300a718..5bae8fb140 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -318,3 +318,115 @@ Tested Platforms
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
+    * Red Hat Enterprise Linux release 9.2 (Plow)
+    * Red Hat Enterprise Linux release 9.1 (Plow)
+    * Red Hat Enterprise Linux release 8.6 (Ootpa)
+    * Ubuntu 24.04
+    * Ubuntu 22.04
+    * Ubuntu 20.04
+    * SUSE Enterprise Linux 15 SP4
+
+  * DOCA:
+
+    * DOCA 3.0.0-058000 and above.
+
+  * upstream kernel:
+
+    * Linux 6.15.0 and above
+
+  * rdma-core:
+
+    * rdma-core-57.0 and above
+
+  * NICs
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.45.1020 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.45.1020 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.45.1020 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.45.1020 and above
+
+* NVIDIA\ |reg| BlueField\ |reg| SmartNIC
+
+  * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
+
+    * Host interface: PCI Express 3.0 x16
+    * Device ID: 15b3:a2d6
+    * Firmware version: 24.45.1020 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.45.1020 and above
+
+  * Embedded software:
+
+    * Ubuntu 22.04
+    * MLNX_OFED 25.04-0.6.1.1
+    * bf-bundle-3.0.0-135_25.04_ubuntu-22.04
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
+      * Firmware version: 22.45.1020 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.45.1020 and above
+
+   * DOCA:
+
+      * DOCA 3.0.0-058000 and above
-- 
2.39.5 (Apple Git-154)

