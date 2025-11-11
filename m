Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF9CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 12:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFA8D4026A;
	Tue, 11 Nov 2025 13:17:02 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47]) by mails.dpdk.org (Postfix) with ESMTP id F058040144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 13:17:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNEYLfaFmc2QXmuLY5Otizzu1nc/AJMKSKzuCUCKid+wWTJTwjtY9fb8FuTBwK6XRFY8e9AmCXgh2CHra/RJk1eo7yMj3recmwtEfy+tNnDCPtO5R93gbYX+l1ei5n6Qn69jZbzuQ8gBvQiRh/yYZNwDetPDhtX6S4+3a/K+RXESFXOXceoFMYKpdZZKyNSOoqskRP2Enu5TOJ/85ssq+4fHVWI9OFA8C1ZARIaL3/9Z1u0vlcVl6WwAn/QslSjJZ8tuLPyxFJiCpfAtEVvlsASolVa6qlb5a6RmlRuSqyx3d62xlJYNMXkOhsyj/EEnwCxqXq8sK7OfqEmytOsnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw8gtXcJJ0x5QvROP2BodkhtvsVAe/wMWLaxlaO+ZFQ=;
 b=T8WjBmCgMJCRFSpj+aXt8NgPKgvjgB0bWazAbDFttM8uJ+jnv3K4L7qJ5rDVmtum2geu6NVvQJn9WSwAsN4dIEOvZvFcMfK/ZroHjvSZUypDOxderpF3/sbCRFZr1gbW7H3TGMPESGW74OZqimeSYJ//8sKROUQ8FFxyhrKndIN+QRmRAPjkdu7rS/KIDnO48TUYjjF9zKxRZyUy1Q6UinRyaKDjbKR15Bg5eEK1leMpVmjyjSCWjVRzUGwzyEGrlhKdr3XYo8TgEZuV3/QF5tlmljyVEzL8le7SprJ3KPfGa97PfrXQlCrlPpQamkE5BJ9nRm1DFNzfiKIdKUSaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw8gtXcJJ0x5QvROP2BodkhtvsVAe/wMWLaxlaO+ZFQ=;
 b=Bb8s8zNPr12AFAk2Gik0Y/EbPsHz4KWMkfZ9blyOYLt1zb+mayoHawjOC4qmwPbuq7wkgz1Tg98I+2MGczTzHrkVH6vQR17gPmUbEHXfxP/nrLnftuESoXGueQeeuKlqbOnL3zO/b6IgAS+QKwPOSsEO6K59bqJI6638eUl7CfxAxNyARBWwBlf+9GDy412GCFfWbZOO6O6iGwfNfVJv05sxv7ovDePSFTnW9MDGGavLXmWKNOSeej6DDVIUHHHzUMNr9AX6hk08LUSttbphPzKIU6qESF8VYMmJXJYcHfoVDpR0rQbgB95UrwZlIPom2+SPsGEMdAQDfKuX5BUBGA==
Received: from CH0PR03CA0435.namprd03.prod.outlook.com (2603:10b6:610:10e::9)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:16:57 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d3) by CH0PR03CA0435.outlook.office365.com
 (2603:10b6:610:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 12:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 12:16:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:16:45 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:16:43 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] common/mlx5: add BlueField-4 DPU
Date: Tue, 11 Nov 2025 14:16:28 +0200
Message-ID: <20251111121628.75282-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0d4c87-272c-43ea-3183-08de211c351c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?flqYbBBTx19Z78W1uAa1hGzxagGNhCNvo6vFgefQfYD5jdZxRsOJQ22tyFpk?=
 =?us-ascii?Q?R7IiijJUk9LAOfoyFQQJ9c7coNCZx05ZxeQRVFr+9rNnMcB8Pi5iOXhcEs64?=
 =?us-ascii?Q?+I6MKRyGX0+4NUTLvZ7fW1NIbfezayvZTawDRZiTxiRKJ88jFk9ikHCCfFRp?=
 =?us-ascii?Q?r3MAhsahqdOjfaBwi6yA8eeCBgQVJ9TUukiK5tvUnXxcyH98LoOint8b/dxZ?=
 =?us-ascii?Q?HSNsQYoNbfJ1odDUjFCHeQA3x+192o0zxWj37BKUH7tyzg1JoKVFcjbe04mK?=
 =?us-ascii?Q?tDvw5AUM6GlJ8cxpojTN5c9hXvTnKltfRHOYu+LyDZPhKBT3KdRw2vLM0b4U?=
 =?us-ascii?Q?F96m2SOYukuJvbfdwxKqIj3bGpHHfp0i00x3c5zwzKpgAkVJIGfhc5NLTHMB?=
 =?us-ascii?Q?KoJnRCHqFiqdkBd1bTpJ1fcJPQA0i530hO+4fJVVlxtiaOZTWzoZ+n+ykVCY?=
 =?us-ascii?Q?oyrqgOd/6aVt+FgjOsYTjhVmfmUSM0xt9r1V+GFWRyoxYJp9qbUaee5Xy8oT?=
 =?us-ascii?Q?lPPJlAsz/uGxZfSX4qk4oKIoHp9E5QP0xqw5L8OKy0kU3y5LxJ2g/yLyWeOI?=
 =?us-ascii?Q?F6PynCiq2Z19zyIyVsF2W98RJaLGnTMmhP9mCVZJJ030ij6hirHWR1+4H0aq?=
 =?us-ascii?Q?INDvwtdAVdE4e51DZob2EI/Tg/eI8o72CN7Llry/mfMoMCuQCQB0u+LQkrj6?=
 =?us-ascii?Q?CNzbD5lYRlYtialAKL0Fzwm3esh/xZ860P7X/PR/wKZ2DrWLNgCcIJEru9X6?=
 =?us-ascii?Q?AZtc0CO6ZR1Hnqjhj7u+B+amrp7zQw8auEXIX9aE+PnA68LSZYdVt/4DC7rS?=
 =?us-ascii?Q?minLmNKJ6MM+2x17YXLidPahU4p/Ohfxa4o0OF0v8BQrsHP72det3nsv4CWt?=
 =?us-ascii?Q?/4dcvUa1BYrnY/J28BtC3fGvwqKpU5dYrAfHjaq4KQVuhXLciwgfzkX8QvBc?=
 =?us-ascii?Q?akPvXpFcKzee4uaHoiavIV7TM2z4nVQEMD1fdqNGcqrouW6MTBPafhghPUIP?=
 =?us-ascii?Q?4sJJgrCubFq8RD0M8qduhRoHOyJcKOEaYOSEG4T0gqcLbVa3huTSDOrjNhSl?=
 =?us-ascii?Q?+lEIisOh3XJwqqwV1XRHaBwTZjBXm5ASBnks6lV+WmEWwJnjX/MRuww9tJ4e?=
 =?us-ascii?Q?9jdsJr8kj51rcZaFeHTddJBSrD+Ep2iSrFUTs7s5WegygTiAlQuqzDEFV9sf?=
 =?us-ascii?Q?QiD6ii1ulszuLCxDmrVSrSu/5xnIKbRku/dCMpW30chLN9NTa8GsIPL2BQ9M?=
 =?us-ascii?Q?JKqZRtDjeMHLKOSwBjQPBUdNxxEaC5VsJOc7o/nvwJfcuPnze6x5zamym6ai?=
 =?us-ascii?Q?ZvU5K5X8bo/bPVytcjbKUfjUOV4EaXN4eu2T5xGkkfMu/5uMDKs7nL7eL3hh?=
 =?us-ascii?Q?ja7H+/VoJHIQ2nwkTIWWSBm6sZM+J6v4j8Jv6TLvNXXcJIeA3WoZ5wbhX+qA?=
 =?us-ascii?Q?GOHcdBMeayI3Hm1YpPPxepg+tSI0Gh03Xo/ex4f3Kvf7WcTn2NJQPZwwVDcO?=
 =?us-ascii?Q?dnvYY13pX2+3accIPofE5BIXf/NDvUDqYpBP2jXDOiPi3ziARCtrsCJSCj4n?=
 =?us-ascii?Q?Oufw/+OHkKnLUBe7qBM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:16:56.5464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0d4c87-272c-43ea-3183-08de211c351c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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

This adds the BlueField-4 device ID to the list of
supported NVIDIA devices that run the mlx5 drivers.
The device is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.h | 1 +
 drivers/crypto/mlx5/mlx5_crypto.c | 4 ++++
 drivers/net/mlx5/mlx5.c           | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index bd8b5add24..6f82b8d8b5 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -155,6 +155,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD3 = 0Xa2dc,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX8 = 0x1023,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX9 = 0x1025,
+	PCI_DEVICE_ID_MELLANOX_BLUEFIELD4 = 0Xa2df,
 };
 
 /* Maximum number of simultaneous unicast MAC addresses. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 2699253d87..240e8bb858 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -491,6 +491,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_CONNECTX9)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
+		},
 		{
 			.vendor_id = 0
 		}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 666216c21a..bdb2f57fb7 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3819,6 +3819,10 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_CONNECTX9)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
+	},
 	{
 		.vendor_id = 0
 	}
-- 
2.50.1 (Apple Git-155)

