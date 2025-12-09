Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC3D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 12:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59E3540611;
	Tue,  9 Dec 2025 13:24:35 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by mails.dpdk.org (Postfix) with ESMTP id AF90B4025F;
 Tue,  9 Dec 2025 13:24:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asRoJFyGoZznw0shJrlPL1NAowGRrogv75TO2FnoHRf1rpuJ1mDrI6Wucy2ktP88QSDtw2lNLs+hJ/0gljSBcphZvPaW5kLybOiOD4xPr+tkUhWSpN5ZTOnyK+DFk6fryLfS0QdVv7I5LGM9xKQ4UsF/YXcm+UXWXLY137YIWqg+rQUgI743uIWItX7Y5nckPSgykFpjk3UyG9TwU3qzPuMytiI6pZzqxFba7vtJeJG8ptgmCC/ExZszKa3A9v3fnkD8TFHj1GWnn/af0q2rn4iQuS/RSX/rkjA8cwVwfjmFA78+XNonZyGX3YYA4LEfF2gS8MZJlDBOPuIlxcH2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmwGbwD209I+YB3tKLWPdT5gdRohhJIze3QKpUuAuWA=;
 b=FNj+rDtOpGlTZZV8DOWBdEsyiYP7Hxorg+Q5/8IgAqp3FqwnVbpUBvOltcH/1Om+3UsR4iKuLCwesc39jItnCaPJqvJ3VdePhH2zz/e1g2GnXO6+uDUMZy+9rm/bSvDaNBySwrTgj+RDfaX6b9vItxXxOubWWk0/gX/HaNsnAyXlNkuWRklyzY7toSWx6vx/PZchK35uvEKR6ozfgy5qJKSOYNEO7mx6VKtuyUoFWhVa+vAfLGUq3EMLnnOBvHWhAMD/U1iDIi5HaZ3agCWv8tYzUX5YNae38IEcQPWSsZn2OvTuJZZIryjGgWr4jkmS0EZRFSnIftoC7fTu57dpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmwGbwD209I+YB3tKLWPdT5gdRohhJIze3QKpUuAuWA=;
 b=c58QjHvV44i5mxNIr/qtmSR0ob2ueX/W0wecbLqUw7DUcZtp9yFEXAgGJCxLSVf9NvOGGNhZDJDYkaoRsOZ2hn5llmqf9nnvygEgtDlh0e65Dl3IqqAwYOG6DDbrVOwogMjFridpJBmWfVVLyL7Gxcsjglg8A5VCueg/JmOoO5g8kEFlAXUmnWbJfXBlUC/y8DaZEePtuzNW/J2sSr3f6miZ4amI5xgsa2FD6ZRDl8AMRhIkZngs0bWGV5utWoA7ahCymntyH94n+91LyifMAdnSHE94iWv5BgGAwaPCnn0B8tes07QD00bZrbqi1GrHfcf/QxNv4SWq/CmZajrnWA==
Received: from BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:24:29 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::41) by BL0PR02CA0052.outlook.office365.com
 (2603:10b6:207:3d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:24:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:24:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:24:14 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Dec
 2025 04:24:11 -0800
From: Itai Sharoni <isharoni@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Itai Sharoni
 <isharoni@nvidia.com>, <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gavin Li
 <gavinl@nvidia.com>
Subject: [PATCH] net/mlx5/windows: fix MAC address ownership tracking
Date: Tue, 9 Dec 2025 14:24:05 +0200
Message-ID: <20251209122406.3364-1-isharoni@nvidia.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8a27ef-4527-4ea7-6404-08de371de626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g32M5GturV8i+kewB32igOFIQIBAuq60YjE+LWuQJdYuYrmmrI3wfDBLhmF0?=
 =?us-ascii?Q?G9Z/gypxWRnKMoz5u0NgXojqvd23A08e0jkrtCpZgfMeHIyDSgikQOnulEGB?=
 =?us-ascii?Q?julwphmHhmLEawgyyU/cU8cHdEQ9JqMt1xJEWuLOcs1CWZeINvCv94yGcut8?=
 =?us-ascii?Q?LZWhgmhKTRbVQOSvNiIlCEZZQaiQBhH3/s9mQXYWssBqn/xv9m1RbrpB7+XD?=
 =?us-ascii?Q?jFO8pZpaRq8dLz3cNJXdgp2km9FkXvjIn10wys0qgyJr5J01mdnzwJsVJxs+?=
 =?us-ascii?Q?+OUNKdaFMuzoM6M1czcl8SkNE/Lg365kYK2jgJP58Wkqd+fd7osiE5jkdwE2?=
 =?us-ascii?Q?NhDCwQNWbK0/3cAe4jM/0UNRqvi8YEgjLAoQUVOOGZ8RQ4jogLhFgsWV398K?=
 =?us-ascii?Q?a30GXwOzBcM2zEiLn8iMmAtWgtTtwJrYcCyOaDNdI37/wk2P/6UaXmVzvnnA?=
 =?us-ascii?Q?V/79iii7oK1YWaYnXSEy8PQXQXKsLyYSRdiAPCt6/GPMDyQYvsAYNUCeRVGj?=
 =?us-ascii?Q?Kb19boVWwrSbPRub0RIiMRB6MkbMort9p4tfxlSAbHc6HMrvJR0XPqBJAR7M?=
 =?us-ascii?Q?ZQ/N2OSdFNrZptPgKSv9R6kDd+n9R9Qj4IT8CdewO5UWqD/yWJ3wGuKItpuv?=
 =?us-ascii?Q?QEqgvZSW0LX20qE0xoMcreLzI7eZb8ZTPa3Gk/pCOzRi+CXWOKuZL8rVcS77?=
 =?us-ascii?Q?8MRTyUIJmHNSk6jOobDXnbSMzCKzvo6WkwxtJ48xI6sPg9iMyA7WkOIaCWLl?=
 =?us-ascii?Q?D/3zGUJq/DcUBTwCp+wHRktQnwEltUxIOF25YwDnFyMVd1mAkyUL8oBl9rPj?=
 =?us-ascii?Q?igvXbSaeP83NCRSfHREW6sMs5ZUz4TAj2MMLzNr3qPgNO3M3dpJSCPwgoDl0?=
 =?us-ascii?Q?c4lrvLCpFLNCKf71B7qRpBIT8FQoQQ+NcXogbkDHTKDvKwkN7j/rUoU4D91f?=
 =?us-ascii?Q?qX87WsyyfrmXye/3yTZiieBm3kxqgTXSurALRqUpiCZJ/3eAh0C3HkxY/SIQ?=
 =?us-ascii?Q?40+cgHPqOzl87FechMRx/ipfYagmzW0Fv/QAwY6aNuCGiUjYPevBdfVgOp3L?=
 =?us-ascii?Q?dBndOGTIVGa/yVb8rDawcwjzPNyxyjc0bKMPb+j9sT6MFyeL4L03MJSBGzU9?=
 =?us-ascii?Q?wdWjvTujWxI0cYng05k89K39VU8UGJ4xFbx455Mavkug6L+MdBjn3oQtNo/8?=
 =?us-ascii?Q?V7Iga1QED/iTvHQlP/yLlfK161H8mmnkW4OHKJreU9I14yhJtPICUsw2BZcw?=
 =?us-ascii?Q?LyQvSzYompZcx5xfwfC9qqkrrcpM+mZ2R2qKfAJ69rouMWPRwBW3S16GIK7k?=
 =?us-ascii?Q?+64ytW7cSNGfuN1P2ueLZYv/EJX59azbd2SRrI6R8Vk8dUtW+Y5RQTz+4yuh?=
 =?us-ascii?Q?c98x1mDzSIdGIf8kAqLNGuVkAGlZvVH1wR9eNX06u4qPqcnA/EnFMyj7KJkV?=
 =?us-ascii?Q?96cT6ug0QApREfmMZtWtlgxy5WIMHMOSVj60wiuKplRsKs4xooSPi7LE6aeW?=
 =?us-ascii?Q?1YMASNpEhDMwGRqdo/8JNUCmVVFfH0VYRrPzNl91PCak3AXq7KE35JWfUdBu?=
 =?us-ascii?Q?2mWOuO3hL9BnoQb1ruc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:24:28.6362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8a27ef-4527-4ea7-6404-08de371de626
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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

The Windows implementation was not properly tracking MAC address
ownership via the mac_own bitfield, unlike the Linux implementation.
This caused issues with control flow creation for MAC addresses.

Commit 8c06434cd9e4 ("net/mlx5: fix multicast") added a check to skip
creating control flows for MAC addresses where the mac_own bit is not
set. Since Windows never set these bits, the primary MAC address flow
was skipped, resulting in packet drops when promiscuous mode is
disabled.

Update all three MAC address ownership functions to properly manage
the mac_own bitfield:

- mlx5_os_mac_addr_add: Set mac_own bit when adding the device's
  primary MAC address (the only MAC that Windows supports)

- mlx5_os_mac_addr_remove: Clear mac_own bit for the specified index
  to maintain internal tracking consistency

- mlx5_os_mac_addr_flush: Iterate and clear all mac_own bits during
  device cleanup

While Windows cannot add or remove MAC addresses from hardware (no
Netlink equivalent), proper bitfield tracking is essential for internal
state consistency and correct control flow management.

Fixes: 8c06434cd9e4 ("net/mlx5: fix multicast")
Cc: stable@dpdk.org

Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/windows/mlx5_os.c | 32 +++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 4eadc872a5..4a00c28009 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -689,23 +689,27 @@ mlx5_os_read_dev_stat(struct mlx5_priv *priv, const char *ctr_name,
 
 /**
  * Flush device MAC addresses
- * Currently it has no support under Windows.
- *
+ * Currently Windows does not support adding and removing MAC addresses,
+ * This function resets the mac_own bit for all MAC addresses for internal tracking.
  * @param dev
  *   Pointer to Ethernet device structure.
- *
  */
 void
 mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 {
-	(void)dev;
-	DRV_LOG(WARNING, "%s: is not supported", __func__);
+	struct mlx5_priv *priv = dev->data->dev_private;
+	int i;
+
+	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+		if (BITFIELD_ISSET(priv->mac_own, i))
+			BITFIELD_RESET(priv->mac_own, i);
+	}
 }
 
 /**
  * Remove a MAC address from device
- * Currently it has no support under Windows.
- *
+ * Currently Windows does not support adding and removing MAC addresses,
+ * This function resets the mac_own bit for the specified index for internal tracking.
  * @param dev
  *   Pointer to Ethernet device structure.
  * @param index
@@ -714,14 +718,16 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 void
 mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
-	(void)dev;
-	(void)(index);
-	DRV_LOG(WARNING, "%s: is not supported", __func__);
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	if (index < MLX5_MAX_MAC_ADDRESSES)
+		BITFIELD_RESET(priv->mac_own, index);
 }
 
 /**
  * Adds a MAC address to the device
- * Currently it has no support under Windows.
+ * Currently Windows does not support adding and removing MAC addresses,
+ * This function sets the mac_own bit only if the MAC address already exists.
  *
  * @param dev
  *   Pointer to Ethernet device structure.
@@ -737,7 +743,7 @@ int
 mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 		     uint32_t index)
 {
-	(void)index;
+	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_ether_addr lmac;
 
 	if (mlx5_get_mac(dev, &lmac.addr_bytes)) {
@@ -752,6 +758,8 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 			"adding new mac address to device is unsupported");
 		return -ENOTSUP;
 	}
+	/* Mark this MAC address as owned by the PMD */
+	BITFIELD_SET(priv->mac_own, index);
 	return 0;
 }
 
-- 
2.28.0.windows.1

