Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D637EC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 07:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F6C402C2;
	Sun, 23 Feb 2025 08:17:30 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by mails.dpdk.org (Postfix) with ESMTP id AED9A402C1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 08:17:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljU/LXI+oCthCW+vJs5MbV6up9cIOfQepqpwqAyZTQm46XGWlEUiMrO9CmJTPr9WPGDpr048+ViUhSg3QSX0yqXV2UXOdbsjGuteLezi7T+C6Jna8eoVJaaGn/rXpthwP+psW/aB0vzN5JY03LZoQblcs/cbAd1PmRZXAuU/0sy73Iqa/4bmC+HZRrjYZkuz23F+5uKp4+UCjHlPKVIlEBPuh6fGiOqEgoAM+G7f+ihMHoGkU3lx8fkDaxzVsXWc+iL1xSgX9JmqsYIbqV2WHh/2pg0JMy1rmyNicG3svxjgu/luqNXMM25vwThL2SAIeY6k2+WMh8LKI2yuVj8drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smwZgULCGu2a8ULREZ3k44JOsbOrJgxX5C+2lqy/gVk=;
 b=sKkaGxqHr3w3GFHGtAVwjIAhTslTPwGglforC3nQSJvdWImJfiVbo+ibj7PpyZgFzuMmtz0EWjL4Cmm3mT+3kBbtc8XXO7+ltWzrIE9BsfbkJ1HxrMkbTDZ5t1lyi65v0E3y5pTud5JbylstHv71GI2V8ruDeKjb5m5CMZXVLxYLhONbymlRZN0LveMnJ10Ro6g287UJQLhw/ARgCOCM1zNhdVy4xI0lNZtUgaeOpZF4yHUZBk8/kKi+Q/ZLY7vnQ58I7mYF7JQ2jdNhFiivy2O9AwTc5l3fjlFG75fJh3P7GFkop7hUu3V1SZRt8oP+ICDXmf7IX4UHza6W3OlAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smwZgULCGu2a8ULREZ3k44JOsbOrJgxX5C+2lqy/gVk=;
 b=rvt4pHIgL8v7MKkYKPQI3tsD45gmcOQyLEv2AE5PTc4Nm3cCVTZUwngkXMUdYobIiPOw2OF3xrKgBpDaDjK98Vf/4pLnYgR+uHSvAiZy/F1itYEJIDbnQV4HnSVHf7VCbXxE80rAehB6tKP8fpBOHvihzhUHMFb4yspCF3d54i2h0edorptbpQgBR6/VZ93xc9JnQj33h7G5DR+z2fYgs2V5VyIYIU/jVydBac996SwlQ48pbCtSpEcVeX/EhN5q4eBhphjkLetNBAPDMxvJYghvB/GG/CXx+ZThL42GOoTFu9WAIpYWAAb4m36mxhynquxNY7drmLRQmf/sn1I3gg==
Received: from MN2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:208:23c::33)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 07:17:19 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::5c) by MN2PR18CA0028.outlook.office365.com
 (2603:10b6:208:23c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Sun,
 23 Feb 2025 07:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 23 Feb 2025 07:17:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 23:17:05 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 23:17:02 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] common/mlx5: add ConnectX-8 device ID
Date: Sun, 23 Feb 2025 09:16:47 +0200
Message-ID: <20250223071647.60542-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbbaf03-05ac-4889-804b-08dd53da1bbd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1OIewAWhBX8DRG9yR61+cBQd03ZseDRPHIrRLBfPuqJ02GErFirxId7cq7y?=
 =?us-ascii?Q?ST6ee402zJn79PtmJq1NYQteF8K6qXH68iFmh+XhjfcgOBYLwgAd7czeU586?=
 =?us-ascii?Q?eEXU+iWqFD3r8gSwOSRxtmrUwF3OnbbTjUEm40LafOhwoLIpmBYaXzFhm8MY?=
 =?us-ascii?Q?GQ78V1dfyt8vWgtXaHx7dSk3xgEXHEbTS2Q9EGXazyl7rCffDNnKjzMJEcVH?=
 =?us-ascii?Q?08XVsS1h6cZqgC8ojrvXgtHjhuhTXlvjbJQ4IC+BhbYk6qxf9K4+jkKeDeQx?=
 =?us-ascii?Q?F8j0lp2ssAF05cExXnZTT3NPHdrRXph06FA/RqYFrwGPXMtIzkTmOC2Kxj/n?=
 =?us-ascii?Q?GtMfC2FJL3RPAE4G2Os9dt7bwR6orHPnCy3yuLqKunxmHYuWUUvDiNyeueqJ?=
 =?us-ascii?Q?UVep+JNqPlDxlVLme0dyE0w5S/EjUxBQHSYHRQVlQbn2nRyqOHqtq/dcxsok?=
 =?us-ascii?Q?nUpL3HdaUTD5XRBeQKlWbm29It4PqMXmqdleiYeaXRhywqxvczc/lT2AY3Yn?=
 =?us-ascii?Q?6A+HVZBLXyqqQukkhZbun1A853zEY70yTFNG+eVYc9ouZ1RhIch5LSPCQZup?=
 =?us-ascii?Q?qmdgeDTiAGTKi8eVLxIGCJ7SiIuaaJuYvAFVhLdpe1AXibY424NZ4yDTlqQ8?=
 =?us-ascii?Q?EkF5FgORRRTqpG6WioBdgvFrOssWDtw1bsWGojTXELNssGLn+W20mqRaO5wh?=
 =?us-ascii?Q?PTUo56/wr+Ta431wb4I+rNVQtaEc4AbANtnMLmJpK5zQLRtPTfWjmRgDB9x1?=
 =?us-ascii?Q?7rHHszmbplBVYmgJtqxToQ5g2XUMuiAm7bmHnoNsVQ0IchOeyx4ZFpUvEg3E?=
 =?us-ascii?Q?1qTR5H9/P04YRMAPIeihIwoWDhHap2USSrpsEtxYnRnmS1Fa/d0FV7O05zHf?=
 =?us-ascii?Q?BGlWv5RO/HxqH5OxzSLPMzpyNfxVcy244qk3RmDTYfWrjF9iwjnXT4vp692T?=
 =?us-ascii?Q?jYMkVaQYXZgBOX+tRgOSB6z4XscPyywaYwrGrtss8DrYUHvZUyTwG79fhvAM?=
 =?us-ascii?Q?L6xlTLJ1F/IjmBDBwAaPDlXCv3ZpGEZxCD1AlQ8Ux/V0/9lqA/Gz7oEEp0Xb?=
 =?us-ascii?Q?zuZM6jbtj30vd7gYC7hRuCORugmKufkvjnPg9vfxCV4JoWSw6nFvJz2snTsY?=
 =?us-ascii?Q?0pqz5qoqTX0RWNezivAaBaOQZwtAAkjLFaXygEqznJmcb4F6cyyhosS1bWqN?=
 =?us-ascii?Q?fsoPqcih74JbcqaSyuUfjtvy9K+os2qtkOITZ+BLjlBVovs0zkPHdW+6h2X3?=
 =?us-ascii?Q?lWxzvGfREnI0eyYfnZlbe7nd1AkSys2EjzST5LypxZPff5/3T9ndBnl4y/Hz?=
 =?us-ascii?Q?+fusNvFs7lyAA4YM6zV+lUq8vTa7U2MT5plZTpIfQzFowIm7tJETeld7Xrt7?=
 =?us-ascii?Q?f9U/Kqq9Lx0rHmxth94kq0ApRKOAOFe88oR1wsnzLWOC1IKV29Z1LcjNTmn7?=
 =?us-ascii?Q?+qm/AmjClD7maBZfDkgQKLXVHv4Y3OqXwFbTmX1TIIkOG6fn4k056aK3pggg?=
 =?us-ascii?Q?OtE7Sv+a0IIjHKM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 07:17:18.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbbaf03-05ac-4889-804b-08dd53da1bbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

This adds the ConnectX-8 device id to the list of
supported Nvidia  devices that run the MLX5 PMDs.
The devices is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/cryptodevs/mlx5.rst         |  6 ++++--
 doc/guides/nics/mlx5.rst               | 28 +++++++++++++-------------
 doc/guides/platform/mlx5.rst           |  3 ++-
 doc/guides/rel_notes/release_25_03.rst |  1 +
 drivers/common/mlx5/mlx5_common.h      |  1 +
 drivers/crypto/mlx5/mlx5_crypto.c      |  4 ++++
 drivers/net/mlx5/mlx5.c                |  5 +++++
 7 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index d9ce9257d1..9abbd3abda 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -15,8 +15,8 @@ NVIDIA MLX5 Crypto Driver
 
 The MLX5 crypto driver library
 (**librte_crypto_mlx5**) provides support for **NVIDIA ConnectX-6**,
-**NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-7**, **NVIDIA BlueField-2**,
-and **NVIDIA BlueField-3** family adapters.
+**NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**,
+**NVIDIA BlueField-2**, and **NVIDIA BlueField-3** family adapters.
 
 Overview
 --------
@@ -214,6 +214,7 @@ Supported NICs
 * NVIDIA\ |reg| ConnectX\ |reg|-6 200G MCX654106A-HCAT (2x200G)
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx
 * NVIDIA\ |reg| ConnectX\ |reg|-7
+* NVIDIA\ |reg| ConnectX\ |reg|-8
 * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC
 * NVIDIA\ |reg| BlueField\ |reg|-3 SmartNIC
 
@@ -240,6 +241,7 @@ FW Prerequisites
 - xx.31.0328 for ConnectX-6.
 - xx.32.0108 for ConnectX-6 Dx and BlueField-2.
 - xx.36.xxxx for ConnectX-7 and BlueField-3.
+- 40.44.1036 for ConnectX-8.
 - xx.37.3010 for BlueField-3 and newer for AES-GCM.
 
 Linux Prerequisites
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 690b46a974..8c2d147209 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -17,9 +17,10 @@ NVIDIA MLX5 Ethernet Driver
 The mlx5 Ethernet poll mode driver library (**librte_net_mlx5**) provides support
 for **NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx** , **NVIDIA ConnectX-5**,
 **NVIDIA ConnectX-6**, **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**,
-**NVIDIA ConnectX-7**, **NVIDIA BlueField**, **NVIDIA BlueField-2** and
-**NVIDIA BlueField-3** families of 10/25/40/50/100/200/400 Gb/s adapters
-as well as their virtual functions (VF) in SR-IOV context.
+**NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**, **NVIDIA BlueField**,
+**NVIDIA BlueField-2** and **NVIDIA BlueField-3** families of
+10/25/40/50/100/200/400 Gb/s adapters as well as their virtual
+functions (VF) in SR-IOV context.
 
 Supported NICs
 --------------
@@ -34,6 +35,7 @@ The following NVIDIA device families are supported by the same mlx5 driver:
   - ConnectX-6 Dx
   - ConnectX-6 Lx
   - ConnectX-7
+  - ConnectX-8
   - BlueField
   - BlueField-2
   - BlueField-3
@@ -67,6 +69,7 @@ Below are detailed device names:
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 200G MCX623105AN-VDAT (1x200G)
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
 * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+* NVIDIA\ |reg| ConnectX\ |reg|-8 400G C900-9X81Q-00CN-STQ_Ax (2x400G)
 * NVIDIA\ |reg| BlueField\ |reg|-2 25G MBF2H332A-AEEOT_A1 (2x25Gg
 * NVIDIA\ |reg| BlueField\ |reg|-3 200GbE 900-9D3B6-00CV-AA0 (2x200)
 * NVIDIA\ |reg| BlueField\ |reg|-3 200GbE 900-9D3B6-00SV-AA0 (2x200)
@@ -633,8 +636,7 @@ Limitations
 - CRC:
 
   - ``RTE_ETH_RX_OFFLOAD_KEEP_CRC`` cannot be supported with decapsulation
-    for some NICs (such as ConnectX-6 Dx, ConnectX-6 Lx, ConnectX-7, BlueField-2,
-    and BlueField-3).
+    for ConnectX-6 Dx, BlueField-2, and above.
     The capability bit ``scatter_fcs_w_decap_disable`` shows NIC support.
 
 - TX mbuf fast free:
@@ -1110,9 +1112,9 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
   - POWER9 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7 BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
 
 - ``rxq_pkt_pad_en`` parameter [int]
 
@@ -1125,9 +1127,9 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
   - POWER8 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
 
 - ``delay_drop`` parameter [int]
 
@@ -1364,9 +1366,8 @@ for an additional list of options shared with other mlx5 drivers.
 
 - ``txq_mpw_en`` parameter [int]
 
-  A nonzero value enables Enhanced Multi-Packet Write (eMPW) for ConnectX-5,
-  ConnectX-6, ConnectX-6 Dx, ConnectX-6 Lx, ConnectX-7, BlueField, BlueField-2
-  BlueField-3. eMPW allows the Tx burst function to pack up multiple packets
+  A nonzero value enables Enhanced Multi-Packet Write (eMPW) for NICs starting
+  ConnectX-5, and BlueField. eMPW allows the Tx burst function to pack up multiple packets
   in a single descriptor session in order to save PCI bandwidth
   and improve performance at the cost of a slightly higher CPU usage.
   When ``txq_inline_mpw`` is set along with ``txq_mpw_en``,
@@ -1410,8 +1411,7 @@ for an additional list of options shared with other mlx5 drivers.
 
 - ``tx_vec_en`` parameter [int]
 
-  A nonzero value enables Tx vector on ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-  ConnectX-6 Lx, ConnectX-7, BlueField, BlueField-2, and BlueField-3 NICs
+  A nonzero value enables Tx vector with ConnectX-5 NICs and above.
   if the number of global Tx queues on the port is less than ``txqs_max_vec``.
   The parameter is deprecated and ignored.
 
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index 9799709a61..ab3107209a 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -17,7 +17,7 @@ NVIDIA MLX5 Common Driver
 The mlx5 common driver library (**librte_common_mlx5**) provides support for
 **NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx**, **NVIDIA ConnectX-5**,
 **NVIDIA ConnectX-6**, **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**,
-**NVIDIA ConnectX-7**, **NVIDIA BlueField**, **NVIDIA BlueField-2** and
+**NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**, **NVIDIA BlueField**, **NVIDIA BlueField-2** and
 **NVIDIA BlueField-3** families of 10/25/40/50/100/200 Gb/s adapters.
 
 Information and documentation for these adapters can be found on the
@@ -145,6 +145,7 @@ The following dependencies are not part of DPDK and must be installed separately
   - ConnectX-6 Dx: **22.27.0090** and above.
   - ConnectX-6 Lx: **26.27.0090** and above.
   - ConnectX-7: **28.33.2028** and above.
+  - ConnectX-8: **40.44.1036** and above.
   - BlueField: **18.25.1010** and above.
   - BlueField-2: **24.28.1002** and above.
   - BlueField-3: **32.36.3126** and above.
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index ca67c17c5c..fc90ed9444 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -122,6 +122,7 @@ New Features
   * Optimized port probing in large scale.
     This feature enhances the efficiency of probing VF/SFs on a large scale
     by significantly reducing the probing time.
+  * Added support for NVIDIA ConnectX-8 adapters
 
 * **Updated Wangxun ngbe driver.**
 
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 0b9a8e8547..e7bd4c6ec4 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -153,6 +153,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_CONNECTX6LX = 0x101f,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX7 = 0x1021,
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD3 = 0Xa2dc,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX8 = 0x1023,
 };
 
 /* Maximum number of simultaneous unicast MAC addresses. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index bf9cbd4a6a..2319c6920d 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -485,6 +485,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_CONNECTXVF)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_CONNECTX8)
+		},
 		{
 			.vendor_id = 0
 		}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 91fd9346a9..e2ebe7a6f9 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3767,6 +3767,11 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_BLUEFIELD3)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_CONNECTX8)
+	},
+
 	{
 		.vendor_id = 0
 	}
-- 
2.39.5 (Apple Git-154)

