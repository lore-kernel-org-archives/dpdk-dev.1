Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752ACEB7EC9
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B450D4067E;
	Wed,  4 Mar 2026 11:57:54 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by mails.dpdk.org (Postfix) with ESMTP id F21BE40651;
 Wed,  4 Mar 2026 11:57:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGax/YJJ5h7UXOQmwVyC6jRRAtQ/Z9ls+zVELCJb6Logdzjwd/bbFQ9XRkZf5LT6c8QfW7adHN/xKrHM589YhEDAzH0G9lqEwR9CI2kvHGPxPD/mHLGKPA5n32WIJ11iJl87wA6CvVnVrEDWuHwhrUpfIMdGV7RghjuT3pStr+q8cI5TnOe2LvNQHrIsM8zUZQabHCCHTr3FH5q24kBLMShNrVEkZV5GO0tm1yZRIaKkyZDLXIH9IfPzKuEkaEZFMtnGjzCvULlfy2+zXT56ife/F6wVAIDZOrnEWGNCY8EgXwa76f3eR3cS9hYr6kCAYPLtQgWuX23dWeQa4F05Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SJoa75cDBAWPW6RWx7QqhQ7ozbX00XLS7INEJ/SaHE=;
 b=FJ9mVbwBQPANmYWwPTquyLGSDBOMcdUTZNYsoUlrBl06WcXM6nOpv+TKLRJ8IWsDAiufRHP3jEt+qCxnxk+DOGTnaWQPSC0WkHbunzBriwmruTTDAfpklw4dabNN/7aHw42L888eBUqKAKBiWZBtmKtnzTk62X/OtrCoLnPNC+mm/vnJapJqSgw1T2TH6EObtuPKcgrFYe9UefmLiqWt2OUoT+rF2jjLwg+QTdJeepAYyex9KG6LWgJZa1yUJZM8qx6f0uankDt53gdS0Z5QltQFyhyRFpmpOHofxd3rSfYfyXABQXgD+yP0Ar+cXhjh4cfGibYjqVuSmXJKe3aE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SJoa75cDBAWPW6RWx7QqhQ7ozbX00XLS7INEJ/SaHE=;
 b=QQtYmXhpcRV4nYKb0qHJ6v7MwzD0yUXJBxgUdrMuQG4JK7HJDyMTZKldUQoLPmX36FZj9vtL6c0HyL6jZ73JZOk9NpH3VRiamrclWaHS+KJIJmx0+dIbBQCH8AUB1c1dyXPCvfU7/jB9VWb5k3JEs+9rM4/yTvzVBsi/JKYRazq+GFcBc/7HT6JxplMEqMaymmJudzY1CadNeCT0MRZsu9jBJKpVhOwlr/eWSruww72fDn41+cxVha5Zez1uvmqkMnT5MCac7GnpFGSaxe1xswrLdgvab5QqebUrtjpN/IvsVh9Tx+TstCacRunn9XMWdis6ny7uV/EgCVlgQbmzUw==
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:57:49 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::9e) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 10:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Wed, 4 Mar 2026 10:57:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:39 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:36 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2 2/3] net/mlx5: fix bond check
Date: Wed, 4 Mar 2026 11:57:17 +0100
Message-ID: <20260304105718.93412-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304105718.93412-1-dsosnowski@nvidia.com>
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
 <20260304105718.93412-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: ee00d9db-dcf0-4529-ac77-08de79dce007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: Vg+osPH8AhLXkMiSiag04wwxjGiq6BfbI16F2Z7aXzTGSa69EeDdoQeSecf+uNtswWEENsqLPdtHaOp2uXgjt2XtdIlMHSbdAYYSLrjnc9KiAqkFs9WTtobR+UnstI8SDZAqD5YfuSPjIoS7LXyhJXghVJZcu+iDz3c/KF8xyymcVSDTlyRFxdDZbAf8epiMIWtS56ILuZuiye5ntfOUj2gheQYjDpRhOSHegoSeE+JWFk6qqZpKC4jwvCBPCfhj4/4WaIpcnEyUrVWx+RwSpyVegNZxcsvxig1PkAaXvVS0umhGEr8XJqEknjdaaXRcwKyI3tHVTjM+Vq+PjpqtjT27d5xJoIwTwupxZSx+oMMtKdNjexKzPWPCy7rrNqL0Wo+oU2IduXhUC99hwb3LUPSIfXIkWYrLJLCncgU6Hvv3Ru/s/HQWkfBMrVpDV+Tnxu4iNJ8HsOlpvOavatOpmkzMSjtmgeFVivRqJ/gQMDhfRKVE89CWTSmtrFMgr+eE4LzOYGzt7o1g2kmuUGhxM5LxiDAlHzPl8HNjLXY6XZcqnr3E5vJzk4LOhRA66EEEmb/qBRAoY2z5vqTH4HkdiZbVcbHJGn1x8roi7RJo2uWSgnbQBMLs7ndY1/LzIUqKcG4gG0YcXCUv22g7A6b2Mt4A7Ttab8UsbpOmwJUxVcEOAJ61fps7aMncc/kPs8b9L1xuT4CdVQC5j2hRyxviV2SgPVC2rLkKfHCzEy1KBlGcAIPNRMIAEIebOf5XsD36+Z2c6tKBpTgqrOjwyUVoXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H3gQQO0HLppmbEVQsarJ5dwidxBKj7vujkn8FC8X8FZtyb9GLflCb1ZYIIcl6IA57V91b0XREC1usXEN9aEnD4Bhhng5j/06eqvhNxmZmXoN4+lbMbOPmuViBbFbPFDkfemtzJgBaPKSu4gkFboCvDC5Yx77hcE3GJWIAC5GKaWm3Pc173kfT1DM22fCZJYR9/9mqW1LRAhz2zMjF+EektujcT9Izg05XkzSmoGesvC1GSz/+IZmREM7dwk2FAFqcArrbUFefdr7jw86graVkMqYKnWkd9eke1NtA29YmTAZfV1X93h1X79v6yMxISfyBI4QYNvAYZVeoMLZ9ifszzKDwCxxT2V/v4S4aOrFT+ROfQwcD0L3FIF6VV5cst2lOWLDo41yvWT7OKWqSA4e5cjKhwomEvgiCT9o+xhxhBnw420OEOpP7dZWW3LDF0bu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:57:49.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee00d9db-dcf0-4529-ac77-08de79dce007
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

mlx5 networking PMD supports probing ethdev ports based
on LAG configured on Linux kernel level.
In such cases, a single IB device is created in the kernel
and mlx5 PMD configured the device through this IB device.
In order to recognize whether PMD will run over LAG device or not,
mlx5 PMD relied on IB device name.

This patch fixes mlx5 networking PMD logic to rely on
mlx5_os_is_device_bond() introduced in previous commit,
instead of relying solely on IB device name.

Fixes: 2e569a370395 ("net/mlx5: add VF LAG mode bonding device recognition")
Cc: viacheslavo@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 76edd19c70..405aa9799c 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1928,8 +1928,8 @@ mlx5_dev_spawn_data_cmp(const void *a, const void *b)
 /**
  * Match PCI information for possible slaves of bonding device.
  *
- * @param[in] ibdev_name
- *   Name of Infiniband device.
+ * @param[in] ibdev
+ *   Pointer to IB device.
  * @param[in] pci_dev
  *   Pointer to primary PCI address structure to match.
  * @param[in] nl_rdma
@@ -1946,7 +1946,7 @@ mlx5_dev_spawn_data_cmp(const void *a, const void *b)
  *   positive index of slave PF in bonding.
  */
 static int
-mlx5_device_bond_pci_match(const char *ibdev_name,
+mlx5_device_bond_pci_match(const struct ibv_device *ibdev,
 			   const struct rte_pci_addr *pci_dev,
 			   int nl_rdma, uint16_t owner,
 			   struct mlx5_dev_info *dev_info,
@@ -1968,9 +1968,9 @@ mlx5_device_bond_pci_match(const char *ibdev_name,
 	memset(bond_info, 0, sizeof(*bond_info));
 	if (nl_rdma < 0)
 		return -1;
-	if (!strstr(ibdev_name, "bond"))
+	if (!mlx5_os_is_device_bond(ibdev))
 		return -1;
-	np = mlx5_nl_portnum(nl_rdma, ibdev_name, dev_info);
+	np = mlx5_nl_portnum(nl_rdma, ibdev->name, dev_info);
 	if (!np)
 		return -1;
 	if (mlx5_get_device_guid(pci_dev, cur_guid, sizeof(cur_guid)) < 0)
@@ -1982,7 +1982,7 @@ mlx5_device_bond_pci_match(const char *ibdev_name,
 	 */
 	for (i = 1; i <= np; ++i) {
 		/* Check whether Infiniband port is populated. */
-		ifindex = mlx5_nl_ifindex(nl_rdma, ibdev_name, i, dev_info);
+		ifindex = mlx5_nl_ifindex(nl_rdma, ibdev->name, i, dev_info);
 		if (!ifindex)
 			continue;
 		if (!if_indextoname(ifindex, ifname))
@@ -2396,7 +2396,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 			info = &tmp_info[ret];
 		}
 		DRV_LOG(DEBUG, "Checking device \"%s\"", ibv_list[ret]->name);
-		bd = mlx5_device_bond_pci_match(ibv_list[ret]->name, &owner_pci,
+		bd = mlx5_device_bond_pci_match(ibv_list[ret], &owner_pci,
 						nl_rdma, owner_id,
 						info,
 						&bond_info);
-- 
2.47.3

