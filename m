Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C5FF495D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 08:15:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDDE440265;
	Mon, 30 Mar 2026 10:15:34 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by mails.dpdk.org (Postfix) with ESMTP id 6317440261
 for <dev@dpdk.org>; Mon, 30 Mar 2026 10:15:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwJMBn01fnTY0EoRsKYjxLXTtBRw/u7iO3aKtk0fS9QybmGa1BxPGIESquVOinpZ+nffE8pTHiMN4GHnFQd4ZCNAoXSZKiXzLwnEHC7pTpBOLwd4IakTxxaQ7G3JyxCl2p5BjJZ5cdfkXUrMwuhif9xuo2h4uxoJKoELUMmhj+UuUrLk1EnxRuaGKP6kdfdXwSsIC6/AIKWsZTHf3fIrW/82V5tWrgSTU8GSx2bnsQEXGNtCNE/S78rO413xjAuu/+xwVPPiljzG997WjuLI7FS8VV88jf48iVYwhOdfwPtQu2w+QoDiP+rlfbY+6Paz+q2CjedwOAqwvT3f80Gcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YrlcCXQr/qYsMUVWNOSBg58f0ZYlZPIeNZtg0xHALc=;
 b=WW2y6GPTMBxoejxzpsnKWXucbKmKcHaVGoKdXcqCt2CPPAjTuFrD9oHtJbibSbru3M0ZT1FvogpV4V8ARmOv1VWw5oM3fSvuXc31LdqYm8PpC6b+t8HKfw4T6+d2Vet9+DzhdIDVXFNA/v6wwxu9J+8F22WeJOxVmM6QfoABL5ZHlrPu/Ps14YaAl29xK52GS5j2TDDcmihPcVITSDcX9pXoovzqCVLiVg7kJUNzOmKhMPkC9nLSsjsSVJ24dZQBX9+tyrgvMq4sx6qfEro9/FJLczSXnFm3yJA+/U/tLjkbjkf7KqMTJCEok3kELQ+IKpcTL1ppgiMVFq0wENIEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YrlcCXQr/qYsMUVWNOSBg58f0ZYlZPIeNZtg0xHALc=;
 b=iCwmmy18EWUDjj5hbi8RtKHVEHMT6uMfIe8nPbDxW+LLRyK1AC/l+HWMKHHieSmNbWOvCTfKG6ikaIiII7M21VTPN3W7zi+4dve/DseMpq7+cdGkDAdYzulhFOUEvyVgwQrJs2uj8Lft+l9ylPL32hRUa83NQBwGqNfvlAy3Lrt7wDOC//gWNjOX/WMwMcur50VC7KFdwkmG5nN2tI5IAyLJ41VzymU+Sxmsk/Z1puOWlOwNuEImCwV1swXPQGmKdkMWFZZ1yTF+y67VO00WViY7xfOAd0/9Nlx0qDernvEhiNOD7+/YVRhp3rTknW9V/fhHW3sofSqE+/jSZkCL9w==
Received: from SA1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:806:2cf::25)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:15:28 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::40) by SA1PR02CA0023.outlook.office365.com
 (2603:10b6:806:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:15:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 01:15:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 01:15:12 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs for 26.03
Date: Mon, 30 Mar 2026 11:14:51 +0300
Message-ID: <20260330081451.16700-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 040034b0-9b9c-405a-fdcf-08de8e3480fb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GCwIwr/JMumMOHcUVSlVy660T5M7bAotauKuk+Qmh2ypQtCup6uyFRocEsWkXw/Pj1czCYriTtxZpf2uUM85oLIEUTuGxxWclL5BCJ6SC/PcrebmgfUYdkgUqi0sgThqwdygzL9SUKcXL/qkqoqlVKkpjK7faRzVtMiRD1AYK4MHpndSXsQl6gZ3g8W9/zDfweTKP0lT3iklRsZNCtO20cBqnf8htMIe+j1zGqmhyvz1TYTwRInJzrZh5hSjjrjXxEONra38Lat2VM72lTqVZlzP99cfX0xKCjCloU0IqWKNY2UL4ChyAOIiLHRcukBnl/2EOWcWu6uA3FTRE0ePKJCYynPM7pdmaKwpCSHN4++P+OfuBRhCIR444qb0LCHDrbzyE8YZTKLluIqz7aWzX9QfoZSBNv2uAfPG5jrQVvFilSxg5/8939H4XbOd3R7HQjuJ3T6U11tumXLj+mAfdQwg9CmjjScszgRTb+68Y696eu7K7T3WTnKlTEQ6Bnw77b9YEoxaXW02NX+H7khqqIwa9OLKYeHZTJy+CsPMwOTgf6Yh4NcJFCqYo19GNcm6pCDyptyOaRntzfNvCZCzocMQyxOxBwAY6jJe8IrzhkfpL3/IBh3rWU7j82xcvKO2NhCAdKsG7/HwX+3wjYcwdsNGY9XRBlpDkezOYkCmV3YTs6SYMst86s+Z/5fc8JNXpC8hAnyua0N3oNmpd/UcF0jOTCTkWAH9YvnIemfCPUHXk3weg3EM6kN83Q3W1kLIpqSm6w3UHL5tvlaC2xrxyw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0R7FPAUL6JbBkY+YP+gM6qyuyZx1aKFq9gkzJQwLssyQUwCld82fuhtCNkh6mPkM5RZ75KOnfTmp1J9zBSz0I9c0tyifsCvbzSZddnEsPnXIf8x2ZXJsYVEVdALLzEe96smDbVeuWOMMkwB+EOWi6VcjND1VbWK9iYdaHgnaRrZKsdqg3ZUCAtCapgSIH6/s9wgkpQXWDAY7PfKCfFxnCVqn3qcd1SlXnYXX3Ay4EKPaZi7+tuLGiZ3ufvnFMYTLi7JPkze0hNomk/JutiHyZCjJMvmI23vEWBWDRJSQYyj73XGX2UOyKOR675Ry5Dt/e4SXTfUO+AGgtZdmqjx9oJUs3LCLiHvKuw2sXGwU6sZCH0urlC4Vjp8mhpLVsw8GxPWNPV4/y4di4UtTsyoA8rChDyHTK54NQwwhRf9oufdG7AEf01PK7WQZIHRckMPQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:15:28.5127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040034b0-9b9c-405a-fdcf-08de8e3480fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

Add tested platforms with NVIDIA NICs to the 26.03 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_26_03.rst | 117 +++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 9f80d627a8..a0c5345d4f 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -386,3 +386,120 @@ Tested Platforms
       * Firmware version: ci-ts.release.2.0.0.11126
       * Device id (idpf/cpfl): 8086:1452/8086:1453
       * Driver version: 0.0.772 (idpf)
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
+    * DOCA 3.3.0-088000 and above.
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
+      * Firmware version: 22.48.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.48.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.48.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.48.1000 and above
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
+    * Firmware version: 24.48.1000 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.48.1000 and above
+
+  * Embedded software:
+
+    * Ubuntu 24.04
+    * MLNX_OFED 26.01-1.0.0.1
+    * bf-bundle-3.3.0-202_26.01_ubuntu-24.04
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
+      * Firmware version: 22.48.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.48.1000 and above
+
+  * DOCA:
+
+    * DOCA 3.3.0-088000 and above
-- 
2.50.1 (Apple Git-155)

