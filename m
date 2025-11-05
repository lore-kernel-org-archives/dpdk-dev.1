Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E96CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17CD740659;
	Wed,  5 Nov 2025 16:46:03 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by mails.dpdk.org (Postfix) with ESMTP id EA1464021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:46:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU06tK8lcXLXoBK/lBRUKhQeRZaa+wbDMlURlyfRu8AZhwDeXukFrqMgOm+wYqILvHzZ6MaWJpsv2H7i1Ru15lqJQxEOjcvrl/l085DCBAt8yiHd1jB+CWcBGhXhc0w6TVPLeXY1HI94CGmYhCEbaeJYvpdnr/USiOyqdiKqii96l2LyKFAoheIRpUode7u49oRA4VAqqAXNJdimiPH9RXSZrCDCxLckI7uPrWST+R/trxrhV0+WvkfE93teYqIaqnGTSBXS2POqzIcCCj6XMckbcj+tT4KDqMGrl5ibwyZUMphboykKmGuosU2VrjHBXvae+hJ9lETBH7uACSlR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBv9mza6XaLz+/EMs1lN3UeX+tmLERLQAB4Jv8Eldqc=;
 b=GLhy6eVBLSyrm3sXVJputazWXN2kcIa+ftbvi+hVaroucpdNZZ/fWWKIDwi91/78LTisVeDEAGLSxs1PMTWahNXv6FqFu6mqTf9nDtlKhnkQocTRjDa8u2X5gT8L9wiuj6srU8ZYSUmy5m+PgzlgU1IFAuWv//btwfgAgzDGvUB6qUMrTjHnFLcsk684arMLBKWAMz3Z6aTT5KJpc1xuO9W8DUhuhUDezCnA66hlufLOXelxOW/aNF2AIo9Q3EWTL3r+9iv+6CVemqLF9KGCN19QBIBUvzaGiYzB97ppbdcG5jCHOqy4GLrHwr/HFxFpeJoxZlVQDiI0iE4EvyLJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBv9mza6XaLz+/EMs1lN3UeX+tmLERLQAB4Jv8Eldqc=;
 b=Mt/ludWqbozaKag0vjhClyvTx6t80N+rgJ0/Wy5EXlOQ77Jh7XNusa5+WEtB2Nq6pNSNCKCfqyJabxTEwY8mdu79fjG/j4jP1WpXHEWmwaIaNmkgrRVaZVTiD043Ss1qmzCo0Eol1lQmFcSohvQpB01A1qEoSrOn7ytKvaPS8LRoCHkT1ITnu8j0g1vDe+qWU7TP0s+6gsXs5H+SFhXH5peAplyAicUicU+pn3DNXMfLLw2loAmmsFbKZaW47umxU0BClSCr++2w4Oyp4JRmtdYaAO/5q+5DrTQ7KOLCBDEOSyK7fvdTnmJAGqiYN8xd9D4dMD1KCtFyR3FhW+vliw==
Received: from CH2PR14CA0051.namprd14.prod.outlook.com (2603:10b6:610:56::31)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 15:45:57 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::40) by CH2PR14CA0051.outlook.office365.com
 (2603:10b6:610:56::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:45:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:45:37 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:45:35 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
Subject: [PATCH] drivers: add ConnectX-9 device ID
Date: Wed, 5 Nov 2025 17:44:17 +0200
Message-ID: <20251105154418.99211-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 751dd43c-6384-49c1-b973-08de1c826950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?97+1MNAcg0IGmL4XdxvzAW+Wcp+glaVR4dLES5/UvWnHM05l8Kh1L4kzyeWy?=
 =?us-ascii?Q?W89y2/sfxcTSfGWKwj7zqSOfSz5vKOh6EAIoRFNIVO2120tte1U0xiMtYwHH?=
 =?us-ascii?Q?Oi3sj6txa53B36M54CPNWb+eZqR6oAL/Wf7e6Qx4i/PBfzpXrqj+chJGVf0Z?=
 =?us-ascii?Q?A9JSe3lTBUh5VWYOScmZ1CYXBdSZDDJJof2f48Lyb67kbOEn3IQBjf6zxBtN?=
 =?us-ascii?Q?l/65WvZQ7oDeUKQLES4dHJrl1vbOfqDUOOKP457hEpMYYP7Bh2ii2s/8ls1f?=
 =?us-ascii?Q?tRdaZB0ueY+dT2qwxHlQvGzKvgvW4/vF2ko95zu9+Vx87Sivq2mtzNoR95JH?=
 =?us-ascii?Q?J80rrFk10AzPZ5o8VpOSk9rYyTBFNTv0te4aNr5Osz3MxgYN4b9BWPq3LnGp?=
 =?us-ascii?Q?ye8rz76jpdx5NONLGuJGKTFuO/OvAYFKvPefUi8IzUeaOksiSHT7gbartY2d?=
 =?us-ascii?Q?0pPXX1pF1rKTdy41Q9KGGOV1f9SpsTc6o0FVsXzMEHjaF5w+NGhW394hXfe/?=
 =?us-ascii?Q?ZdKYCxn7pVyYE4Dif6tMRzU67YJObm5CcWOo51jMDafkyWPa4nujhzEKtXPl?=
 =?us-ascii?Q?QtB5vzdQlRvN+IZu4i3Gw01MFF/PB5TiMr/BQgdP9r4ysj7+McL6CrrKiB4b?=
 =?us-ascii?Q?r3VKdoxlm2q5TAKi4hVfYDhXF7Cdgy38iwiv6y9uai7czqNr/vI6FtAc55Ci?=
 =?us-ascii?Q?88fNUDeLJCGvrVUBaFtiTcMkxKb+fvjNw/cXpeB2gjEzIbWCRkSCl64FfjMj?=
 =?us-ascii?Q?hIjMKVgaSj6RI38RrUNE/KoujVkCEEPSPcAdEtFPWUeH+y7e0oPBRv1b0NWK?=
 =?us-ascii?Q?P0I28m7gv2LqLb2j9EmTJY4CnmwTmv9KiXkmSnyG1ck2NTMk2Dh2j4UkPiAy?=
 =?us-ascii?Q?HNxzlRDq2XP427XaHl6SJBjhnyaSygQZgGuORtTivajCNzPqWq+jDxxW3ROH?=
 =?us-ascii?Q?pNk+p0y+F0YJ1A+8fh6MSi1Qro6MJO/IcvDP8XTcmM95Z45b8nn3EO+Koj3j?=
 =?us-ascii?Q?O417c6DK6opRcuic+d9OLNZIR7TepmjoI2cND+7/c5yi7gWF4xnNSayFqjaE?=
 =?us-ascii?Q?tR3xbIA/LjniwV0vwjOCCypIFFc3UX1ExNh6WLXm89dMQilMvUw1sADmM7YH?=
 =?us-ascii?Q?ouWsZ7yP6NcaO9ao/++WW0tvQCswJ9kiAuz0WdTdD//tPrlv/X3RlOokiwST?=
 =?us-ascii?Q?xmwDfoIrQZ+/lJnxpy0T7RVF6s/S46zGtwHi4OytLjooK04cyDovF9DwQYsp?=
 =?us-ascii?Q?Y1bcxjrVi99HE7iZuAPnojKahCGgHBcUmyfJ9razANLvzbMWf8V87jlOpgcn?=
 =?us-ascii?Q?+g0OFGXF30qWU6HvLHXQhPs93MgmSpb1VUjP57ZXdDsR8Ic1/3F43TVDWFms?=
 =?us-ascii?Q?CBUEISU/VB0fdM6Lp8KsMhRx1U4h8VsttoF+bNWm+iaz8sCmO4cqfKoTlTA/?=
 =?us-ascii?Q?Voe/9tpNFmUlMZMmFYg2q9NzNY3ZT/mDb4arZskgHqpTf49/gfPCc951Ry5V?=
 =?us-ascii?Q?/QtX5nkf+EMVNtMPmGRrJDNfjvkybT0Mt4pgYfbyupvw6rczL8BZyqDnfJQu?=
 =?us-ascii?Q?B1BzveyguOrn1uhNTmU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:45:56.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751dd43c-6384-49c1-b973-08de1c826950
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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

This adds the ConnectX-9 device id to the list of
supported Nvidia devices that run the MLX5 PMDs.
The device is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/cryptodevs/mlx5.rst         | 4 +++-
 doc/guides/nics/mlx5.rst               | 9 +++++----
 doc/guides/rel_notes/release_25_11.rst | 3 +++
 drivers/common/mlx5/mlx5_common.h      | 1 +
 drivers/crypto/mlx5/mlx5_crypto.c      | 4 ++++
 drivers/net/mlx5/mlx5.c                | 5 ++++-
 6 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index 8a2ec20e74..dc9977f5e0 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -9,7 +9,8 @@ NVIDIA MLX5 Crypto Driver
 The MLX5 crypto driver library
 (**librte_crypto_mlx5**) provides support for **NVIDIA ConnectX-6**,
 **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**,
-**NVIDIA BlueField-2**, and **NVIDIA BlueField-3** family adapters.
+**NVIDIA ConnectX-9**, **NVIDIA BlueField-2**, and **NVIDIA BlueField-3**
+family adapters.
 
 Overview
 --------
@@ -235,6 +236,7 @@ FW Prerequisites
 - xx.32.0108 for ConnectX-6 Dx and BlueField-2.
 - xx.36.xxxx for ConnectX-7 and BlueField-3.
 - 40.44.1036 for ConnectX-8.
+- 82.47.xxxx for ConnectX-9.
 - xx.37.3010 for BlueField-3 and newer for AES-GCM.
 
 Linux Prerequisites
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index fde98ae993..37495359d4 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -39,6 +39,7 @@ NIC / DPU          total bandwidth max ports PCIe        embedded CPU
 **BlueField-2**    200 Gb/s        2         Gen4        A72 x8
 **ConnectX-7**     400 Gb/s        4         Gen5        --
 **ConnectX-8**     400 Gb/s        4         Gen6        --
+**ConnectX-9**     800 Gb/s        4         Gen6        --
 **BlueField-3**    400 Gb/s        2         Gen5        A78 x16
 ================== =============== ========= =========== ============
 
@@ -232,9 +233,9 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, ConnectX-9, BlueField-2, and BlueField-3.
   - POWER9 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, ConnectX-9, BlueField-2, and BlueField-3.
 
 - ``rxq_pkt_pad_en`` parameter [int]
 
@@ -247,9 +248,9 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, ConnectX-9, BlueField-2, and BlueField-3.
   - POWER8 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, ConnectX-9, BlueField-2, and BlueField-3.
 
 .. _mlx5_delay_drop_param:
 
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..a33dbd3e3e 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -167,6 +167,9 @@ New Features
   The built-in help text function is available as a public function which can be reused by custom functions,
   if so desired.
 
+* **Updated NVIDIA mlx5 driver.**
+
+  * Added support for NVIDIA ConnectX-9 adapters.
 
 Removed Items
 -------------
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index b49f0c850e..b524ba9ab7 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -154,6 +154,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_CONNECTX7 = 0x1021,
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD3 = 0Xa2dc,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX8 = 0x1023,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX9 = 0x1025,
 };
 
 /* Maximum number of simultaneous unicast MAC addresses. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 78a9e3d0fe..938a119c7f 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -489,6 +489,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_CONNECTX8)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_CONNECTX9)
+		},
 		{
 			.vendor_id = 0
 		}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 6686dd7587..ea235cf36b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3818,7 +3818,10 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_CONNECTX8)
 	},
-
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_CONNECTX9)
+	},
 	{
 		.vendor_id = 0
 	}
-- 
2.50.1 (Apple Git-155)

