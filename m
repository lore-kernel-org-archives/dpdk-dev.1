Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873EDC4450A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D70402AB;
	Sun, 19 Jul 2026 15:22:50 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by mails.dpdk.org (Postfix) with ESMTP id CE8C640297
 for <dev@dpdk.org>; Sun, 19 Jul 2026 15:22:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBxP8HoI9b7XIQiy8hu48CGhbrEXAn/gEhTYEQnfvtYZ98hJbznzfK5Z9X6Flc4VmDZEq5U3zRJbf3cK3ZuxLE++tpeCS+XnIzYdVuOdA+RTxdUWdFozjDZPhUMZB0F1s7QR19PPzuEBmdJEUXscM/aeaJXFte5L8v3yL9hpZ0Tdy1+C6tVGfOvhI28MenqiWKDnyTJonh76kUuA8EbB428XF/3e1T9SrfMQJVaCUugXeeUjtEKqaccPwA+otjRi5meGOqmTveAWBjeX0w2y30Qt24Is1+9KeTduBg7zv/fSxE5uSxmeYkKpJN5PZlQWjJaFgudpixLvi/MoRdL1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBGAnu1iUWeOz/m86BWCIzqx2u3LIBmZmSg5vPt2PGE=;
 b=rjKZNy3O6uUW2tShwkw9g1BLxEfmByR8CghiMH2QR6d1QTopZ4D2vsX2JyJj++PSFpRCNwqBD5BYOZHQ8s0wOCdYF/G1SxIwqs33KXGHI3oJ8u8zACTMlDu1BkdcJuK2wLhYo+DMvcDVz8BnolYFgvhZWb5CHlXdBQsTAQlsrLXof7oouAS2xLvWUnRW9SJY9yEnsWpo7S33r9hH8Wuqv9eQv1ehJF086x0fEVbdjVCIKO+jvxCX9xta1yloIM5NOh0zHb7sWJpGcjQY9WlJILHgEMMXLlIH5UFUN6U5Cie7FVOI7kTyGvSF/mxsF1NgtteLYX+Bhl0sFjM0uCXPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBGAnu1iUWeOz/m86BWCIzqx2u3LIBmZmSg5vPt2PGE=;
 b=uUxT+y1Jiq84KXE4A94WcbkMwJUMWnBQmjsYsasWLSJql3snwhhUuvipoU9NCz9YzRFoTFP1xVeeUGxQn+xv5mL2CpqduD6oZ/0NY6UMI22eMh7z9TxoBkU8ww0PrpZdF/xowJca1OpDAA0dH7REmkcDtUbzt/FtRFP+iO8o30tr6xVz7udGuAP7izpbhyCieBlvX5F3ZXQ2gI+1NEBQrnpJji373OO1gMg+XnQsYZmUXLZ+pIqpklijJEiziQgMK5a3/Ue9DME+e4T7c2WFOIRxPJXpDWA9pzMYWQ+Gk7sjoxLigPq4WS+e2pKM+baNdGlqf06FN847sbtpEB/WkA==
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 13:22:42 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::7f) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.9 via Frontend Transport; Sun, 19
 Jul 2026 13:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:22:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 19 Jul
 2026 06:22:25 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Jul
 2026 06:22:23 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Sun, 19 Jul 2026 16:21:54 +0300
Message-ID: <20260719132154.84677-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a88c02-b989-4a7e-dabb-08dee598cfc1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0wL4aKGBMkD6YjiiJ7TKxJhUKUVVhg5T5luGnZGk/MWA7jaiktTimpMpjtNTYZ+mWMO7S6+p9onTB5dzZ/UlBeMsxvql7Qrq2nzJwiWf0zyX4fJFJVOu8kpGV+2LMflxTua9OEQ6pTAxvSzq7hztZPr1Cf4fXuODW7ahZaTih9SoswghvmVVAjPkcnweAT5CU5DAcNfb3owsbyXSr6W+n81ovY6VI+5GRWiqq3j/JPRbuiiu3c7UA9Ir5C1G/Xaz8sHS2hpqPp5q000CXrCnxhILXKSuuufdJPK1Yc6L3CjmUq/07Vv0Ugd/G5HA70Gm1tAp3n4Wln/pdnMBIpZFl0P/gNRJrr524ASazuGByv8W4+YuKu6Z3BFen3XWPu1PCTVstpAzeZPkBH1V8GWkb3xK0qQC8alI37qUtPjXk1WgacyNKIFNUahc6GqVDKFl/xvBriJd8iyHAjxJ8rjQQj2YNxkgXRsPWFzEXog5x6uylLocm48fCJYekKEkjtSNeKuyj4k4VaEP1x4U/tyERH89Y3SlkVqc/yTHg//7ToiTzAmJXd2mfpL5v6+IHlWNSaPs/Soypzbdfa4BryjMGGRcy0/ns3eZa+Te3dVP85OgOJgI9xsUziNQB5vUhsD/Bkvc7WuVm04Ph3OI/mTTyW/BGnznIOh4kjBhFxSjXQ12DF7/Hu04DSfCP/FDd2Yma9tWNoE0DdfZmickH5DnYw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9CulVlVYza2D6Q9uuKfo3NBb8bRg5Da2nixiP6HMBV9PDPv3XqBiSKmCXvN+oqtaijXBmq1wdp5MIIkiDy/zbUSMsSyE6op/GtBWfMqnZvwdD3ExX76MvcYP6FiGZFL+mUTKlDRA7HIJKByLTQ3MOPHU2TE/nqAwWy8JEfk6ph6AzbWthg4FuZICCVzcNgIe8N4jawEuXzdfPHjMbCniOWrvRReeyE8cuO+6hS+lr0uZaGrR8awP5r1vhoW6hDWVolkq/DYiLzViCpIMjoyCWKYtc5uC02gPTbElzeBbkXsJS9VCasKBESbxAdf409DQt91s+dT65L4rFnccfleb4JXm75eJa8UhkYOKOg9rw5O38WtUw+Jujb4tYyAgU9OCuyezWezp+HmbEmtjYnSR8AUGOapC/gVcwvEOJgToKFVa2absio2n4TZHeImgy4YJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:22:41.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a88c02-b989-4a7e-dabb-08dee598cfc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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

Add tested platforms with NVIDIA NICs to the 26.07 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_26_07.rst | 118 +++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..fc97790116 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -403,3 +403,121 @@ Tested Platforms
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
+    * SUSE Enterprise Linux 15 SP4
+
+  * DOCA:
+
+    * DOCA 3.5.0-035000 and above.
+
+  * upstream kernel:
+
+    * Linux 6.18.0 and above
+
+  * rdma-core:
+
+    * rdma-core-60.0 and above
+
+  * NICs
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.50.0394 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.50.0394 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.50.0394 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.50.0394 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-9 SuperNIC 800G  MT4133 - 900-9X91E-00EB-STA_Ax (1x800G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1025
+      * Firmware version: 82.50.0394 and above
+
+* NVIDIA\ |reg| BlueField\ |reg| SmartNIC
+
+  * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
+
+    * Host interface: PCI Express 3.0 x16
+    * Device ID: 15b3:a2d6
+    * Firmware version: 24.50.0394 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.49.1014 and above
+
+  * Embedded software:
+
+    * Ubuntu 24.04
+    * MLNX_OFED 26.07-0.3.5.0
+    * DOCA 3.5.0-035000
+    * bf-bundle-3.5.0-47_26.7_ubuntu-24.04
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
+    * Ubuntu 24.04
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.50.0394 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.50.0394 and above
+
+  * DOCA:
+
+    * DOCA 3.5.0-035000 and above
-- 
2.55.0

