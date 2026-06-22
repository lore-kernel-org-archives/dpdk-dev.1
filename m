Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54053CDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07766402E1;
	Mon, 22 Jun 2026 10:02:57 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41]) by mails.dpdk.org (Postfix) with ESMTP id 5D8B94021F
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:02:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWP0W69DsDlpIivgvqRDoQB6MLKSTpWmOh6bQzUiKxL2/hnsPmdW0Jwbja/1HLDOi3IvoBFHTl5r5i4DQ8phqGE+RoweBDM3lKTaxLnNd3gIBQU9S0wPsK6CDvZuFiX2fciXSdUDUt3vAECPc1XzN9LEn9xNl0ioTfZ1lFvoX/1xb9wFrQzQb7NsQUoaKfpZJnPQSojg6X02LyanO1N09uxlU0Uz0SVP1dU8NS5UvS4pl/SbCSY3tnJpMlKNz+BQQbnYGfaPHR5/soxKjXWjyEsjMss4ADwOCWt2pLQdt4viupnDfd/PywVVXdVeyeHNgkP88eKl8JUsJPKQiQq3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G8vX1Row3sz4AWa+/juR0s50/fD0e0Qp5TEyze7HrA=;
 b=Dg1WFoDlpdTsf+z9sTys/F3FFnSyMmDI0pcaaEwjQi24M0OXV0bYyQ6WH0BydR2bQdc5Z5igk88vpLNxClQ9o18mfE5hJ7wC5FqKYtdZbJDQgNFRlwoyEyhHpX3PtDyZD/UwKxELLJAcBXd4HhsuWvNmlao6KERvUQ1L9csO51s0wrW7KqebieJPeFSziB50jcoZT5ykN2xlKpyC3RoFCO7gvzW91Z9aFHaPIXVoOt9UVkZM8f06hgmobDuFJUPfN4YzdLwcxsFL4tobYbf/LhrKxndWRrNuwPGxM6NWYZBQFevR2ht7lyVBBjQ1fvoH6ZK23tllaogeuRCJ9QfBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G8vX1Row3sz4AWa+/juR0s50/fD0e0Qp5TEyze7HrA=;
 b=uK0OgLARtDxY8nK6eu1UNRNpEgMxut25kPhCCiLaLkLvrGSL2+Fu2CRViB+uC0HQbUpGsgaxbTLe47MFjdSLEdUE2wYfiubBEEyVDOwhyoRIwN7sFOOh5DgfJNaNyXeog0SWltdTh4upynt0G9IxGcavWIqHV4J1yHT6t7b3Ih8bo+6PMZ0pJpzyvnFtoF11upMqc9jsJ+Mh5yDM6x8pKNHZga/AANWRFd7BPX5aER4NVS91IjaGuUcWexElNtn0KATGStTN2nKV8nt2WJn8ry7GUqP2lqM4KsFFC5jKrq1CHR7GNScWSdZbKe+6xhVeGZXUMSFh+WgvoPApSezBTw==
Received: from MN0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:52c::26)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:02:51 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::41) by MN0PR05CA0019.outlook.office365.com
 (2603:10b6:208:52c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Mon,
 22 Jun 2026 08:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 08:02:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:02:30 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:02:28 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] common/mlx5: add ConnectX-10 NVLink-C2C device ID
Date: Mon, 22 Jun 2026 11:01:49 +0300
Message-ID: <20260622080149.11394-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f642e5a-188e-4225-b4de-08ded034a7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: oa7L7K3S+z4haAfU1NPj/J7Ej3OGPnp4C3IOS26dDFwSXKQffEF0kF7L4I6gZWSfKIBr3+M1TIk74v7/ds3dQc1jbKlgGpWcJCRX2r2vOxWZ4BNfGoOI5tOBNer9UjSrZq7K1KkIE+UUhU+oYASMZvcuE1FuKngFIOAykdwSjB8TVAirTlDKA4u9IHR6gTaOjrB1HlcepLZuaKmWiAI6gGMTd1HB3h6mqN6xXLESKFuTKfPE+PjtlLjssbBG6zrqqByjiu00VQqIV1aS8H74a9tn3bkwKtM1Ri4S+x2ShQGwWVn0QW4RuKDLNOrEWC8AZHmK2Q7g+x/M9gEgV0gZHXyIDRLlgh/vYMJAcnwzROlSR93a7qzl5ku4Vw4J+1mf60zO4l7Pm0yOmVRHYfkNglnMcf5MSzeXaczPJPMhgA0n0O9ObcAxGPhvTHdnF3Hj1whHfmGiLBcMLb7Apfg0xE7uEd0TlgFAB/IeW/Efnqn+BdDQurXDp0C3ItuCT1zQm1I3T5bAE447i87cYauZG77K+/da7k6aE6DCx8kMW+AiG+OnDd5TygY84O6MFeHXcCJsr/abMlVSwgjX0eI0C97IVbnGpU+W55FX96swsEUPGXIdlA8xbswc1OSoYf/tHZHXER31WLJ7zt8zl5pNVkpL8fD91PkWo1NkLi7RGcPwRFPZJL7POHGwuoDi/s+H2LwJ+DRs40qIOHtoUWpUUA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fs7G5ooY+u1xeWqE0TM1mHCFYXjnt8/YuWAmXi4lEN5merUA+xB6jWz5PZH1QPxGLiVgG2WEmcqajCE8TK27R9G6Gm7WHqLgr19OVvjAFtWdMz1Cnoq+U1+EvmHddENtYpKreXBjaSLAsoCHFP17hqfEEEOxvlxg5zoRRt6LCZ6km1zl5wgvS4BfzUSU9eeFe2lN8Ak4BAneWwll4fx7cDzKkan3hc2OGhh9lSfuupGTNHdi6X2CyJZWaSc88JphMs5q1+VetNKpIckcVVu6E3NKhhqRXDMnYB3QZk3GBub5T5eGD1o4BKGFk/3qVb0pF8v2+BEJB7FjuUAP2bsFnrHohyzsQkxQ1E8o8E9RmIriZE90f0Pu77Y4aBKVW0qVZIIU18wZSzjaEtDBxMlSSpA7aIorybjf0nxR906YttcfBg/4LK4PP8mNcd4qAvS0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:02:50.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f642e5a-188e-4225-b4de-08ded034a7f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

This adds the ConnectX-10 NVLink-C2C device ID to the list of
NVIDIA devices that run the mlx5 drivers.
The device is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.h | 1 +
 drivers/crypto/mlx5/mlx5_crypto.c | 4 ++++
 drivers/net/mlx5/mlx5.c           | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 3e66c9e6c8..3767020823 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -157,6 +157,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_CONNECTX9 = 0x1025,
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD4 = 0xa2df,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX10 = 0x1027,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX10C2C = 0x2101,
 };
 
 /* Maximum number of simultaneous unicast MAC addresses. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index dd0aabb6d7..c9aa858a54 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -499,6 +499,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_CONNECTX10)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_CONNECTX10C2C)
+		},
 		{
 			.vendor_id = 0
 		}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 61c26d1206..3fa38694e5 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3936,6 +3936,10 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_CONNECTX10)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_CONNECTX10C2C)
+	},
 	{
 		.vendor_id = 0
 	}
-- 
2.53.0

