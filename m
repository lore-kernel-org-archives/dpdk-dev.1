Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E407EB7ECE
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AF1640664;
	Wed,  4 Mar 2026 11:57:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by mails.dpdk.org (Postfix) with ESMTP id 63DED40651;
 Wed,  4 Mar 2026 11:57:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKd8a6WfT4OtXfjEEmvL4F/wR08eJEwNQV/V5qpqoqrk+fNn+UovccV11GaQsSv0blk5ZoyNpPLM3OEE+24/NHDZGnwyEZ9UbL1TYz7sxVHrvVdBunjnb+H5dTBgRg/nBaQF7PZiEv19uy6yDTgxwC8z1M7/sYrIosh4e655yqdNwDrNf7StHstErZyU784eEA3Y1fVmrY0x0OzSWk3WYg+BXlVBt5879TOSSuylfIU0PKAC0fHI8HRDrP9z8U4sI+0AFlssoAHy6XpcdtYVYzozPlxJCteAoBgjsqxN23ZBsRBE6Zo6BzJLeXvaI6zKmpZ8uzOWbw7MAhJAWQMWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s33YJLlDvAWappQt08nRUT5S8/l7ML34b+XMhI5OfI4=;
 b=qBt1JTm0QXwGyvRmWBsFdqA9qDXslpnqTTm3cGnumww2HtjV0PhKpZOzQyK6jYurfV7U/S5UrlIP6Udlz96DOWLyn0Nth1DFo+Ze25FtQQlm+WR+W5d7s9jw15mxbmfuU0s/BcXG22T83tiqYfGP9MF0oDbh+txU+ju34BZdQnLADlr9/rHSxt+xKmZloefEo6nIpn3YUdGoNKJr58z+oA/dId1UK8L/WfrKGtRknPo6Qz53uqBcXOSIWXLg5fACV9P841vflyyVv/8sjqr6PHtIw4/kf8/QpO2C4K2kzRyyJp1WVQOZdu2bVfiG42wLXfA4FMu/eUCf+YYazsZymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s33YJLlDvAWappQt08nRUT5S8/l7ML34b+XMhI5OfI4=;
 b=cAekzmJPiyA01nZoKdmZt4BZTRgZfgsIeafc5wSoQg6Qkfs3uQhxiwTNRmxIunkmuwyVkw9Otkw4JvbTX0+FngYDw/28IGwHnOGQX1xpoP1EagHZRo9UsmgmrWstrikRj3xLx9DJh3LrMVoeWiA4PwKKhHqBOCr9CPxfPjHTFnZjkZ5y2jFay+vGV+RuGUsX+m2M4BH8CZ0cnttG8DILcRwrqfRxbwwm5/5uRwqn2WTjnlIXs6de8F27kEYTsloEJqezQjlcl6VUhyEWIrh50TMwrrHwKaG+1wiU2sxUgI1PN8t/cFoJAPVjDGmwQ6avsYD6BaXK3gCWFfa3AzBElg==
Received: from BY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:180::43)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:57:48 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::14) by BY5PR13CA0030.outlook.office365.com
 (2603:10b6:a03:180::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Wed,
 4 Mar 2026 10:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 10:57:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:36 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:33 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Rongwei Liu
 <rongweil@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2 1/3] common/mlx5: fix bond check
Date: Wed, 4 Mar 2026 11:57:16 +0100
Message-ID: <20260304105718.93412-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 77714904-c4b2-462b-35cd-08de79dcdf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: yfHmEv5t6Ge/TL1KZJzJIhFVXcRJ2Kxwqzs3E2Da76UKYXmx6q4xyKXDOYM1/sizvt1rMWMCsrO3klF9zH2TWaXhc6NmK3sTpyWMPgSv4I1gq9HLqrUjjrkbpDp7gELSHQng2PaFyOOCPIJQKQSiYJ6KWx5q6YeydCQb53RNfVBGxiIIm1xNc1G02qo23a85UhDfBJGGVm9bSzVaNi2X8tj7Bs1JROZ8gKI6vCv24rukxzw6txx4Tb5d/V3a5RBrx/UyU4Pg9le93EDEBb3bzVzV5hdtt2mLKPJBSLZGHhUrQ5OVOb76CUUE2AIqgtkzaDEGjBnTSTTGiG0bQewCoax/U00oIoqnRLmo4PHSI6hAd9vj8p+aAolVW0uWf/AuStyiSjR5Hj3LEzxehXJH+Mfz+X2kmKCgM+yYCDF0dZQAJRT+7Ft1x+Wg4UXWQKRaUn+GoQUu2DqDi58pCAVrsW1RVLqg1jrG19d3rW7XuOs1CEFR0EH5yMmRFfmBnKaCk6OOwGZ+A5dUo0gviwESJVdGox4hdrtdspteFNIv+PzB0+7PWDLXPpeIulfp5LpAeiI+nTyn3anZ3YlAfDcjpR9B0XEkcVeez4ArowhOBY41A3r9cSEgZeLYK3fbEnlBYJfO6uNTQeTUtnMqHILzLw8khSdEzJWPmxI8uGK2XfhM2J8bfnXO7XTPgkqYs+u/lwpB9YevhM9StCpugvM+Cf/Dk6Nuv7tQ0SthHU164JDMcWgWBJ0zE4jrvrRQRMtmXAspKHtZnrVMWZuABVqdLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E+YKESVIa0FEkMWKIiMPsQNwf5pyo+3+1SqutWNznHX7ioTrZfDqbr8vE7kEM9Y//5YwpG5aEDu1fawsjJIVz4ZDY2iWFpuAD7UkSYo7sh30Eb15jotcTvUDpIbg/IbEQrqf/0Ldg838D1Ol1Tr+anWm1EOH6PIbXCHmvA8BNwvqqzEq4NHexXXzSHjjBX8ied8rlwsIA9LI19W/yNzfu4B4ien9aITVgL6PpfBNUGfmE/E4zctWCf+3LVS03CvsxEEgNzwmVxaWcqDAKV0Uso8+OY98ug3a+6hsciRGYn01x/Fv/1OelEoqOqtSOe4C9j1+zwkWTj13ktN3fvDLEeEapRYTZLZ3yXd8dknxO4JafMHiQToKNaIKAsqe739AmpU2TZ2PHjqEGL2H1bT9rwYLB432wnc3z1JsnpEK6+K6IGjSFEsvEEH5Rk+NX/M9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:57:47.7558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77714904-c4b2-462b-35cd-08de79dcdf36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

mlx5 PMD supports probing a device where PF kernel netdevs
are part of a netdev bonding device in the Linux kernel.
In such scenario, there is only IB device exposed
which mlx5 PMD later uses to configure the device.
This IB device is created only one of the PFs.
PMD allowed probing this device by any of the PFs.

As part of the logic for allowing this, mlx5 common driver
checked if the name of IB device contained "bond", but this is not
always the case and depends on existence of specific udev rules.
This patch fixes that by attempting to resolve, through sysfs,
if any of the netdevs related to probed PCI device
are part of the bonding netdev, instead of relying on device name.

Fixes: f956d3d4c33c ("net/mlx5: fix probing with secondary bonding member")
Cc: rongweil@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 86 ++++++++++++++++++++--
 drivers/common/mlx5/linux/mlx5_common_os.h |  9 +++
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 926b56e419..fc7e9ecddc 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -560,6 +560,14 @@ mlx5_os_pd_prepare(struct mlx5_common_device *cdev)
 #endif /* HAVE_IBV_FLOW_DV_SUPPORT */
 }
 
+static bool
+pci_addr_partial_match(const struct rte_pci_addr *addr1, const struct rte_pci_addr *addr2)
+{
+	return addr1->domain == addr2->domain &&
+	       addr1->bus == addr2->bus &&
+	       addr1->devid == addr2->devid;
+}
+
 static struct ibv_device *
 mlx5_os_get_ibv_device(const struct rte_pci_device *pci_dev)
 {
@@ -581,17 +589,23 @@ mlx5_os_get_ibv_device(const struct rte_pci_device *pci_dev)
 	}
 	ret1 = mlx5_get_device_guid(addr, guid1, sizeof(guid1));
 	while (n-- > 0) {
+		bool pci_partial_match;
+		bool guid_match;
+		bool bond_match;
+
 		DRV_LOG(DEBUG, "Checking device \"%s\"..", ibv_list[n]->name);
 		if (mlx5_get_pci_addr(ibv_list[n]->ibdev_path, &paddr) != 0)
 			continue;
 		if (ret1 > 0)
 			ret2 = mlx5_get_device_guid(&paddr, guid2, sizeof(guid2));
+		guid_match = ret1 > 0 && ret2 > 0 && memcmp(guid1, guid2, sizeof(guid1)) == 0;
+		pci_partial_match = pci_addr_partial_match(addr, &paddr);
 		/* Bond device can bond secondary PCIe */
-		if ((strstr(ibv_list[n]->name, "bond") && !is_vf_dev &&
-		     ((ret1 > 0 && ret2 > 0 && !memcmp(guid1, guid2, sizeof(guid1))) ||
-		      (addr->domain == paddr.domain && addr->bus == paddr.bus &&
-		       addr->devid == paddr.devid))) ||
-		    !rte_pci_addr_cmp(addr, &paddr)) {
+		bond_match = !is_vf_dev &&
+			     mlx5_os_is_device_bond(ibv_list[n]) &&
+			     (guid_match || pci_partial_match);
+		/* IB device matches either through bond or directly. */
+		if (bond_match || !rte_pci_addr_cmp(addr, &paddr)) {
 			ibv_match = ibv_list[n];
 			break;
 		}
@@ -1160,3 +1174,65 @@ mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 		mlx5_intr_callback_unregister(intr_handle, cb, cb_arg);
 	rte_intr_instance_free(intr_handle);
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_is_device_bond)
+bool
+mlx5_os_is_device_bond(const void *dev)
+{
+	const struct ibv_device *ibdev;
+	char path[PATH_MAX];
+	struct dirent *e;
+	DIR *net_dir;
+	bool result;
+	int ret;
+
+	if (dev == NULL)
+		return false;
+	ibdev = dev;
+
+	DRV_LOG(DEBUG, "Checking if %s ibdev belongs to bond", ibdev->name);
+
+	ret = snprintf(path, sizeof(path), "%s/device/net", ibdev->ibdev_path);
+	if (ret < 0 || ret >= (int)sizeof(path)) {
+		DRV_LOG(DEBUG, "Unable to get netdevs path for IB device %s", ibdev->name);
+		return false;
+	}
+
+	net_dir = opendir(path);
+	if (net_dir == NULL) {
+		DRV_LOG(DEBUG, "Unable to open directory %s (%s)", path, rte_strerror(errno));
+		return false;
+	}
+
+	result = false;
+	while ((e = readdir(net_dir)) != NULL) {
+		if (e->d_name[0] == '.')
+			continue;
+
+		DRV_LOG(DEBUG, "Checking if %s netdev related to %s ibdev belongs to bond",
+			e->d_name, ibdev->name);
+
+		ret = snprintf(path, sizeof(path), "/sys/class/net/%s/master/bonding", e->d_name);
+		if (ret < 0 || ret >= (int)sizeof(path)) {
+			DRV_LOG(DEBUG, "Unable to get bond path for %s netdev", e->d_name);
+			continue;
+		}
+
+		if (access(path, F_OK) == 0) {
+			/* At least one associated netdev is part of a bond. */
+			DRV_LOG(DEBUG, "Bonding path exists for %s netdev", e->d_name);
+			result = true;
+			goto end;
+		}
+
+		DRV_LOG(DEBUG, "Unable to access bond path for %s netdev (%s)",
+			e->d_name, rte_strerror(errno));
+	}
+
+	DRV_LOG(DEBUG, "No bonded netdev related to %s ibdev found",
+		ibdev->name);
+
+end:
+	closedir(net_dir);
+	return result;
+}
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.h b/drivers/common/mlx5/linux/mlx5_common_os.h
index 2e2c54f1fa..7d4e3c5fe8 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.h
+++ b/drivers/common/mlx5/linux/mlx5_common_os.h
@@ -317,4 +317,13 @@ void
 mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 				  rte_intr_callback_fn cb, void *cb_arg);
 
+/**
+ * Return true if given IB device is associated with a networking bond.
+ *
+ * @param dev[in]
+ *   Pointer to IB device.
+ */
+__rte_internal
+bool mlx5_os_is_device_bond(const void *dev);
+
 #endif /* RTE_PMD_MLX5_COMMON_OS_H_ */
-- 
2.47.3

