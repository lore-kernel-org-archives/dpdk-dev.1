Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88653F55808
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:49:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49CFA4028D;
	Mon, 20 Apr 2026 12:49:33 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9]) by mails.dpdk.org (Postfix) with ESMTP id 59AE340278
 for <dev@dpdk.org>; Mon, 20 Apr 2026 12:49:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Biuim1slY5lvpHfB1rGg0SQL3o3OHsf2kRgeDp1BxD3yl3xqHv4TydL+oG2M739O6lNGaNlJSg/6+KGqM1taPDNmuuLTt9OtnrZWREd9sOWzAzwF9D6Y/nYmzWMrbVY5bHNFJjPw97D9pduGHvTo73U3GMcBQdBZQnv6Yx+UwvJnt+71xOEXqxSfGz/b2N0QmwP4sScUvkW9Q7xnyQPjPQOfn4VmCJPmEhHNrBUyl6IzmEkjD6D2TUMJgZDD7akVP0rr1fDCnLATrq/G0y587V0tuVVKWkykibrKsDgomywARUXZkcWFwcbPiiHKVN+cOtnGEXh34zKtn7jGJn7uHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9XxwF4uEX5fTAya2Y+KPySZyQgQXF/xc7oGw9vZY2Y=;
 b=LhD/dXNmExG9fDne9MQnDHEqY5mkuoeVRBHyZxodAoFaxF2M9kXpbEOOA3Ps4TtrBNMLi7Qmabfmzd7yKM9/76O41I98MHHBuoopYFLkBRUCXv2jjZuZ6DDRNIyOrJpa+2lGuthXZoXa7vlWmLhLsCXoe6cT9LwbXkHbtXZJ51VN+dqyvtilYFihd3aY2nv00IrywNFkee6lQynYGb74CcTxgu4fOOoh9J5HehZgWJ2qgafkKwOAz+GpKue5RqFkzF7qFqhvkpcFzXS9kylJ335NEmOrX5oHMrjK74A3x6+X5gcySaRCrMZQadZ2z5w9mN0aFNiumOY0AfKBdS05dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9XxwF4uEX5fTAya2Y+KPySZyQgQXF/xc7oGw9vZY2Y=;
 b=fYpgYbzFLA3c2Go2HGX91TrmvNN818C0NFJTPFp2R9Usyc7HrqWqcOltLnspfG+6uho0/cxzhat1a1gk2QNrhIeaMI2DMAthGYb3BUG0IBMfmDGptSbWNzshlWKJfp03SDFILdGQCSXADy1LmPxnXBO1yw+AoDkwHl1wwK2JdunbksBHIe/WpdQkNJvZOs484vhCex67EOMdwXG/BmX0De4flktQbmtNm1AV6i51hf45tWpR4xHfKVgC3aSczHk9etNJEzwh8TpqTeKIBtDhSRDnlRCSb+6fAQbUZ6yNpkZgVADTzfgu7238LkzxvERYhHj9YVvlVkPmSH4f5RGE7g==
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 10:49:28 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:510:323:cafe::90) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 10:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 10:49:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 03:49:13 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 03:49:10 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <dsosnowski@nvidia.com>
Subject: [PATCH v2] common/mlx5: add ConnectX-10 SmartNIC
Date: Mon, 20 Apr 2026 13:48:56 +0300
Message-ID: <20260420104856.14187-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419111721.7301-1-rasland@nvidia.com>
References: <20260419111721.7301-1-rasland@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ea75d75e-5254-434b-66ca-08de9eca7e9c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HzGu8dQK9NFPL3mDZKXfUtPmFu1No2bgsv/ld/2TGYS1IDTHzQBoZhLtoiYNrYcvwJzamyb18suvfCbuXLv870gDBUB2CRYZwrMb0isdY3JM/w+QXt3mjY9ZXEUNXqmgtv3N1YbpFAtn0OsmgYEWAa84MJzz1yGjm5oJhH+YYZeEk9yHqt4pWv5OeBxLJ1X6gy2/XOeBd199TGhf000T2zeRDBp0AAkvdIIwglQZKR27SzGrUPO8t2SKR2iRavr6SoqLqc+Hxj03UKocT/up3P1O5+YNynWfsgVfJLoGrmMttOhYkvSMqp2jzoCHzbJklmtkPZQHfkZuUHLeoqP4sNVV0G0zs75IdY+Hvkg1+2WiW3+IeRSeoTp7LnkCurgwCKPggzgQW8nwudGvkBgwV+ltbsfM/07RFsVlO7+uLZaQnlcxPXApIInAuXqSByst5GxcZj46dBy24c3cbCJvtPWR187qpzrVr24tzTt3e/BXhwIAuDUKTBm7MaqeRtblBISrGD/9TRtASlFQOzkW9wQw4dfeIkVeHfKkeANLxfnpaCMyvTJ95WWStSl/YCcVM0akka/yU+duZg0L2kIXnHr9MPPYLvCtz8u7R2wup2hAKHr8Y4VxGh3croPLKleTUKjBywF8AjyUWzQe+PE/o5e8snuK0CWnt5KuyZ9XUwNZ6OVgjnrDR5g8lWfusPPehty1/znPP7spYD4e3ECiIDuNAmW7Y/LjXnABzdwIVYakSzkHhy1gPnJFHXZ3jcSDMRuYrReMtcHLQXLHqRQiiw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yt7TAkOx9TCbV6QBRDuu39+xiYgxY74AB++/42FaRSiCZajqYYNq8SEcVOc4b1/uLlaQEgOa0NKfy7ysMHxcR6SfebWL2FJdyQ7NHOS0H/WUKIOvFXw59BqjFZnGxdrDlJhCU3qrJ2q5mXkodZje8NNRTCCkVsoPzHCMR335HRU7Bkb/y4Tl/IF50+Fk/NYrS62Llsins9u8RdDb2E+Qseh7mmSuitBcKAJUS8XHt1SYCe7uIVXviAndgfVpuRBeY4r9nCLrhZixeqDUJuwZC3mCIPYOo3uzqzt2+AJzQ/OhwRNamr/LdyxEQn808gI3QlwL3S7pztQ0Qi+AX2mMmIwp5qYaDalgIsqBaukJA0VGh92CEudQBhSSPbmAoKC1HNaOl4UJ4XsnRJX3mWqLWd4KuCSSJAmvVxyc8n0afFMc87B3qhl8VyhiDPLWWTPL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:49:27.6565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea75d75e-5254-434b-66ca-08de9eca7e9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

This adds the ConnectX-10 SmartNIC device ID to the
list of NVIDIA devices that run the mlx5 drivers.
The device is still in development stage.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
--
v2: changing order of devices
--
---
 drivers/common/mlx5/mlx5_common.h | 1 +
 drivers/crypto/mlx5/mlx5_crypto.c | 4 ++++
 drivers/net/mlx5/mlx5.c           | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 47fcc3fb06..3e66c9e6c8 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -156,6 +156,7 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_CONNECTX8 = 0x1023,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX9 = 0x1025,
 	PCI_DEVICE_ID_MELLANOX_BLUEFIELD4 = 0xa2df,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX10 = 0x1027,
 };
 
 /* Maximum number of simultaneous unicast MAC addresses. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 240e8bb858..dd0aabb6d7 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -495,6 +495,10 @@ static const struct rte_pci_id mlx5_crypto_pci_id_map[] = {
 			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 					PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
 		},
+		{
+			RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+					PCI_DEVICE_ID_MELLANOX_CONNECTX10)
+		},
 		{
 			.vendor_id = 0
 		}
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index c24c9b306d..f190654756 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3925,6 +3925,10 @@ static const struct rte_pci_id mlx5_pci_id_map[] = {
 		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
 				PCI_DEVICE_ID_MELLANOX_BLUEFIELD4)
 	},
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MELLANOX,
+				PCI_DEVICE_ID_MELLANOX_CONNECTX10)
+	},
 	{
 		.vendor_id = 0
 	}
-- 
2.53.0

