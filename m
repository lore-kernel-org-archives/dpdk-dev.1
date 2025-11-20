Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA033CF8845
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 11:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F43F4026F;
	Thu, 20 Nov 2025 12:25:58 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42]) by mails.dpdk.org (Postfix) with ESMTP id 8A42C40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 12:25:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLYum1JbvREoCFEVW4koqknaFOS3x1mv38BPTd8mLIBI9hRYNUH14cbNmLtGoGZs+QQMnz/tg0AwR+xcywa54tAy00AhWMkq1Mp0zq0hZLSTnWr9yXkohOYEsBfZKBT//Hxrot7qr1rFvIhHTmZa1LNZfAmCS0+BGJjLVbqwCaTfkCu/5sdQqWwiUMZx7n/vYabkQjLYH5rgMuB7Blqt3bNtAMiOe1WQqtcgpAy8H0cBeZ9O/Vsdnp2BwpJAcnSaHRt3fcOGRnc4zxXLtR23osGYloG6VO4FERv+BHjerho6L2CVMxE/DBnkUIYvLp3C4tIeEQFv62LojGV+0yyY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyk8VzsGXblwvtKk8RffGAyQMZ8d1+rme4eMD0TDdz0=;
 b=OYBUstwmx165JmWS4yIkZfx3NSgPQkaw03DynH4tYTKSVBsiesWPzdrB1WLM+n4eZEcNZMLJZi65bZDr0qW7J9MubfjLOZ0OrJRnVjyhb6OHIGZ1/fYvL2PqbnBOmKnfqay6ZfZXa38ROm854m11zuCuh25uG/8NZzqEFix8r/gY/pvcVnbrbBUGpi4aEJdIJJeko6WECjHNXzIeZQAAXxHMh7b6AlzlpZXS9pFqjaO4vrJmG/5NlC8Z8EByqEKved2RN+aN4LNEzZ9ZKKwB33u8estQ1EbQTacbgNvc/e7hdbVsOjV5/eg8+Zkw6YxbWqBbIMOJI498fMJoBRYioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyk8VzsGXblwvtKk8RffGAyQMZ8d1+rme4eMD0TDdz0=;
 b=uE9nbJDUCuZsJQSdU4ncJTg8rSbdF1kuILVRy/IRgO58Jl7wKKcKza36ieiYKIOzvOzmx7c39JTi6aSSPUzQU+kra6YCgMU0HJ3yO/LTI1YjcCO2jrULZZOBupADqZ90oKs+48KiyWOa7mSLO/U3bgDvKJxOdZjjI/4TomfdZ25SWbrXskGiSXbjgpIbOQC5mubI5x8z62dcg/wVmGbpZrgqp5cOpcXbU/gKDt/0uqJprrQ+zak5deKU2sltRIZ72x7udCdSeuw9smLz1KgDF/NYVO1jfJxBgLB00440ZtoH4grkqWWyGfAsYeoUFL09LnwqbPg8slUoztKNyWssrg==
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 11:25:53 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::b5) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 11:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 11:25:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 03:25:39 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 03:25:38 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Thu, 20 Nov 2025 13:25:26 +0200
Message-ID: <20251120112526.75674-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f248639-eb11-44e1-3ee7-08de28279120
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRTKo5BGKbeaFzRfV+gnaz61knwVU8mJL2hUSJkTKOgdiHsMZynFuUCoOlFK?=
 =?us-ascii?Q?0/A4HnMH58D/nhJKSR4HDgjIKD2lAptR39wTyPamNt8ywJiSCZZXvp+cM1ln?=
 =?us-ascii?Q?jIsA4huJj4Se5jHSeThob1Zsr8eMvZiwA4reAee8/XfxPpr2sfR9XaTlC1Ar?=
 =?us-ascii?Q?ivqcJ+UKxlqVJNnu2yYSlfg4ZNvUZsO1OzSZ4IxfnwImROiUstDh9BcyYekU?=
 =?us-ascii?Q?7v5xRrgeODapUZ/Y3myY9ebM9A8COukntlLNK7EsX+b2TCiEveurYiaMSM/A?=
 =?us-ascii?Q?Y9E1FyV71lu8bOk/EQnBeOiMiy6iCuefNOf+ivIKsmSJpHvRZOed9mmUGz2H?=
 =?us-ascii?Q?jc43WuQ9qmlQXsBwcG/cOT+rxfza9kDOsHOeTF1Kp1EYj3ULZrPk67DOVrMN?=
 =?us-ascii?Q?L6jrtl5jbEIEjtSv28Yfo74pO3EoUqJsfXXrFDwIOiluFnkhsMeIYzjrj22j?=
 =?us-ascii?Q?n4IBh2qMToIUAVSE103GxS3FOSC+CYN+9W7sN128FXS9jLbFxsrULz582e5f?=
 =?us-ascii?Q?ludh6HzxrAMkMJRmVZtbBbfAkcLlq7vyNmS9MAkR7S5bzT0bPE64xVzMy8Fu?=
 =?us-ascii?Q?QV2HDN9b4fvkwD4eyhi7BhPEgKdqdmgIaUyNO92683ylCIn6E5m9CvlHbU3z?=
 =?us-ascii?Q?8aCYBgbtpb6ay50coudn7nGmhxs3yTUC5yro8G4tFPemKbEry+zF0dOxQVqI?=
 =?us-ascii?Q?O/eEE3YWjnuOBy/gmBASni5n4UXzSAAc+rb3xqmfzTWvOyFqtl+ayHnxj9O+?=
 =?us-ascii?Q?powztzlRIygBBAx8soljKmgzLXD7x5PQeGCAHQgCNTp9v3RkacjN8YKl0/0L?=
 =?us-ascii?Q?MH6+ZCPbhb+SYDFyUwHZLLZ+VAj0057KIlJAt017ArU+KnhhTWExzkZ1fLPf?=
 =?us-ascii?Q?jvKZ0jCfoDJ5pOwVVKLFiVSFNekEqtA+/nPq9wCUu4G9SO6wZ+ZmZ8KZwmUl?=
 =?us-ascii?Q?JYVELhJ/EmuWxObwlFNSX2fz8dHrwlrmxdZO6UdVK+3FQaPDt4PXOn9oTwEf?=
 =?us-ascii?Q?iZ3dnKh5c6yuJfhSVVnLt4cHLoud+9FQ5S4uP1xUsMZjgS+aDwYA4Fou4FJ8?=
 =?us-ascii?Q?jVQqNOpVtPD3sZ1RHOx+/oZYio5Zc6UNm5D7QY8Qt02SIGaj7QhtFvUSnWSe?=
 =?us-ascii?Q?Tt8osJHB+bu/TbvkuzoA0KXAhC4BfPmBSrfenR6tlK7eNbeTfmpr5UptC1uG?=
 =?us-ascii?Q?Ha+e0QqUNPCWPVK3eyKX8Eta5ifQYddCAEdHtN2l1g9IF25WIpVP4+C54VEA?=
 =?us-ascii?Q?p6NB55eR3UMCLN8AKSFT8Ro81WudJ6r8XZojiSLGDC+Ys4GNZ0HBpz3lTqyU?=
 =?us-ascii?Q?So8Eg2mqk3YxoOunLfbog487IDBvwcjvP72ldfl5HRLTVGjNcRASDL6mUzbl?=
 =?us-ascii?Q?Vxjj0BHtfsnC8C2Y/RmaMJuL8gFnwJbikDoHCOyHxTU3Nq8YBU36IEK3R6Aw?=
 =?us-ascii?Q?Kvaazyg7Q9HUxbtLr0zMXH1TDfMim4pexP7ZBdj5SDPsquvtJEVX1S/FMHko?=
 =?us-ascii?Q?DW/bYS6+K/B2MLh8DInJfDGWWclkfHy2HT4HTajJdjQsYHqUGuBIkKMNNETB?=
 =?us-ascii?Q?AStMJspG/GjV4YFFWno=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:25:53.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f248639-eb11-44e1-3ee7-08de28279120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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

Add tested platforms with NVIDIA NICs to the 25.11 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_25_11.rst | 118 +++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 83e86ada64..28d1249ca1 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -345,3 +345,121 @@ Tested Platforms
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
+    * DOCA 3.2.0-125000 and above.
+
+  * upstream kernel:
+
+    * Linux 6.17.0 and above
+
+  * rdma-core:
+
+    * rdma-core-58.0 and above
+
+  * NICs
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.47.1026 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.47.1026 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.47.1026 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.47.1026 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-9 SuperNIC 800G  MT4133 - 900-9X91E-00EB-STA_Ax (1x800G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1025
+      * Firmware version: 82.47.0366 and above
+
+* NVIDIA\ |reg| BlueField\ |reg| SmartNIC
+
+  * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
+
+    * Host interface: PCI Express 3.0 x16
+    * Device ID: 15b3:a2d6
+    * Firmware version: 24.47.1026 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.47.1026 and above
+
+  * Embedded software:
+
+    * Ubuntu 24.04
+    * MLNX_OFED 25.10-1.2.8.0
+    * bf-bundle-3.2.0-113_25.10_ubuntu-24.04
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
+      * Firmware version: 22.47.1026 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.47.1026 and above
+
+   * DOCA:
+
+      * DOCA 3.2.0-125000 and above
-- 
2.50.1 (Apple Git-155)

