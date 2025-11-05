Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2CFCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D1640608;
	Wed,  5 Nov 2025 19:02:21 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5F9704021F;
 Wed,  5 Nov 2025 19:02:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLqH3MZ9yNHpT1oZNaCXiJGWViVZ9afGcJ4j2KA990IWE6zx0kspRsODo2MjNvm3I2a5ZXvFrQZTyAi5JGGbWUAmlGtamxz7ablTZCp+5kmSXsw5OgpVCdADrAFevsLGV1c1ykppED9pIYBnLdRC9yBkiR3eABdhSyDZ8yaBF9Yye9SwtB9BLnNdvP4F7sb7ezFeQU2nWBTZyllCZaxdlH76yC1Tm/L4goz8XTKSrMvFXN/iLDyCGfRprs92ysRfpX+zRukjWtyaqC+jJOIq+Kcp2Ezng400KDs1YoLIiq2UvbGgQ883uvPDQbw1GoB+CXAaECBr+J0isvKzDVrOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIwD7toF6JSPxztapptXZ6Giz8HmfEH/auVQRyn/6VI=;
 b=BTYHFa5xSdxHL/a6yxzyEXM7/YCMRMAZVSb4AbMeFEqjwGZnfD8oea3wZgvMEwUjHnN/mSTB/GWjLmOEmGcOwElAxDKdeZ1AGvxcj4txlGbSM5UDZoNGSV6RXPDzP6x2ZLFr+UtL0+9PmseMpRa5TOcYirNhgL6PCwu0bwfj0THbD6Tpc9UTRu+HPWwJrtSK3oLzaNK+Y1qwb/w8LoQ6ijRD35YruucrXcNqvceM8Do8AxT65rVvVxaW66EaB44vlNWaU54MIYVHwRrh4kDYaUnxM6pK7xuwpDisJO1wCFR0uPwoFuKfykKDVgZFIRWZj/uS5kIISRS4eR2m7LUUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIwD7toF6JSPxztapptXZ6Giz8HmfEH/auVQRyn/6VI=;
 b=VnFy7M1H2f0LOQ/RArGz1ZVuTTwOLRnIbKTsEZpSf5Wn3nGBPz+93iURRFxmv/wgCX47QSNxNM6GSeU1N0DZYEg/lns3jHgIVT0lG8SxYOGHMIQb51piZzpg1NUzhN87a73jDsMJYuEvtonDFFIbmEQUuI+k7VWBO6VKQNo1pHl3kD7IQ5GrzvxBhyNpirV66bEO5tGgBHNZPb7lSH4OriLUkcWBUakFnU94qeE9oj+zHN8gMO9Thk3FDuAcewCVNmhPQ52XIECSsozOxhfDk/eTVGuXLG/9VHzigxEBdS1ehfpkAY+EGvBHX/B91IhUOHdF+V/hHB1jGIbkifcv9w==
Received: from SA9PR13CA0063.namprd13.prod.outlook.com (2603:10b6:806:23::8)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 18:02:11 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::13) by SA9PR13CA0063.outlook.office365.com
 (2603:10b6:806:23::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 18:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 18:02:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:01:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:01:43 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:01:41 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, <stable@dpdk.org>, Chas Williams
 <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>, Pawel Wodkowski
 <pawelwod@gmail.com>, Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH] net/bonding: fix MAC address propagation in 802.3ad mode
Date: Wed, 5 Nov 2025 20:01:35 +0200
Message-ID: <20251105180135.1181619-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: f831bc32-b649-4a45-b8b8-08de1c957133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LNfk36I1ozY6zscpAbCROviu6dZBRJO3io9RAp7XXsui0waLNwUMELdT7vV5?=
 =?us-ascii?Q?Coo4LRtVdB/AQ3ROAE0rCOAKjMYxeaRXzU+u2YpN5cEW0LGWx4JEirk767Mm?=
 =?us-ascii?Q?nB6rCl+ES+5rjmKjBLYyVQ5KOjr/C7N678Rd4O9p23jOcz9lZbunSySMFJPH?=
 =?us-ascii?Q?YWF4YalEsC+S04w59vKlwDWtXLrTFR453s8Y2crX6A41ydvbnjAHysi7kgKL?=
 =?us-ascii?Q?TvN+EPo4Bj5YKwiXD+8ig3PmDsC2tfG8lq7YVd7kBjvvYEYOWkF/76I4TJn0?=
 =?us-ascii?Q?hTbRyeeoovN7og5m59wIfHVy/8J+k+QTZsqgojNmn0qKAGXaZMt5D8ZAvFA3?=
 =?us-ascii?Q?i3k+4Zuc7/UNeTVt0GFAXx688kYvnPwcvzs8Bqge5vWp3NYNirgz3ndLC+8k?=
 =?us-ascii?Q?2YUESz1jgDev/hvfuCcBIfRv2504uK6JFZcdm20BzZTfE1LEHuOmxmNSM7ir?=
 =?us-ascii?Q?4sTEZHZMAgmNqjdFnAWsVxTeMxjxz7Z8R8zzCNdngDmBMd5gteb/8rGcDosu?=
 =?us-ascii?Q?zjkDhixiUS33HfN8eJtvVj2+giUP+4Ge7uup2HMsBEI9zUfUqdivlOVo9ZmG?=
 =?us-ascii?Q?iDjKPBUjKSwCh9lvtlx2I/phlqFMOOY2qJ/MrKunbXwqAsEHq5Kc0axaKkxl?=
 =?us-ascii?Q?jE3ZqZ/W0kYCBe0bwzy59/WDI7RYUntP0KE8sUFSobOE+AzdWsLPko/xpamE?=
 =?us-ascii?Q?8HGRtycwCiTwezXKHmbtHaQr7cEJluppnpIEYDW4GctxG5vg8taslIKeBIe+?=
 =?us-ascii?Q?m1Bdykdhv6WL1ua8LINrCSNr/LAABweppXlyFvIdA9QrA88WJznpP7sr6OPG?=
 =?us-ascii?Q?UFH6+CHnvIxTXvw7OuoNQQSl/DIwH2ELAR41xU4+BKDEyzylmCqmciJ6P/Do?=
 =?us-ascii?Q?Q63Q27F7SJ2cYFWv778GUA363HsJmVhLNCg5WVNZ2BgoL5cSg2zFnT0uY4my?=
 =?us-ascii?Q?n6SyVkqhkV+yEjL6zXKyQIzPashNQk/vIieNqFvREz2+/Peemeh5xBQiUGTD?=
 =?us-ascii?Q?mUJWW38SahXmIuCJ5dZA/zoeCgHZnoCyL+XSGe6uR62ezIvxkn+3gTx6Xd12?=
 =?us-ascii?Q?ZdGuqPRxyMWutcHCBUrdYE4cGmqCiH5WJTibM6DuFyNbQwyflGEvV1+qDs8p?=
 =?us-ascii?Q?L1KA4ucI/wTXZ29KiPsVXe5YWz8MYNnrhBZu/qpQysgMfozj7fqN9NMh9+ir?=
 =?us-ascii?Q?F3GFilKegi62q1Yku7B5xpxxiH8rUjdcU7vzQ3EOyG8yLyecTiVrEN2ZBGHF?=
 =?us-ascii?Q?UA5j1djWeAJcu18wm1UWNKxDNP8PiaQVS0A8JlDKaoegjyEgm6mgx8i8iwrr?=
 =?us-ascii?Q?S7yDpsnx3xoMQQs80GLbfUrdS34cJ2+YeI4JsfPvTgSW3ujM3iFyJsKKLMaC?=
 =?us-ascii?Q?ZyReLJXQa/GbghFPu+bs8jxbqw5XScc5VrF020xvUK25fzooZssE0zHNNWYY?=
 =?us-ascii?Q?apAx0UqbzId7o/U/ZqIY0iEsk8zahta9ob00xPMrAyly4S3LYgjTbXwwfk4y?=
 =?us-ascii?Q?VxOwMHeshz8YUXwfE2XC0TF8IRrR9qY/jcluX2EzbHbJduSu41obCf8UM3iP?=
 =?us-ascii?Q?r8b7g6ylvepJAvYL/rM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:02:10.6744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f831bc32-b649-4a45-b8b8-08de1c957133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
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

When changing the MAC address of a bonding device in 802.3ad mode,
the new MAC was not propagated to the physical member NIC.
This caused the physical NIC to drop all data packets sent to the
new MAC address, resulting in connectivity loss.

It happens because the MAC update function only updated the
LACP layer (actor.system) but not the physical NIC hardware MAC
addresses.

This fix adds a call to rte_eth_dev_default_mac_addr_set() to update
the hardware MAC on each member port.

Bugzilla ID: 1158
Fixes: 46fb43683679 ("bond: add mode 4")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index 1677615435..a3579f7bc2 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1186,6 +1186,15 @@ bond_mode_8023ad_mac_address_update(struct rte_eth_dev *bond_dev)
 			continue;
 
 		rte_ether_addr_copy(&internals->mode4.mac_addr, &member->actor.system);
+
+		/* Update physical NIC hardware MAC address to match bonding device. */
+		if (rte_eth_dev_default_mac_addr_set(member_id,
+				&internals->mode4.mac_addr) != 0) {
+			RTE_BOND_LOG(ERR,
+				"Failed to update MAC address on member port %u",
+				member_id);
+		}
+
 		/* Do nothing if this port is not an aggregator. In other case
 		 * Set NTT flag on every port that use this aggregator. */
 		if (member->aggregator_port_id != member_id)
-- 
2.34.1

