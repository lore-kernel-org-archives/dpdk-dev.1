Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B857FE9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36CBF40DD6;
	Mon,  2 Mar 2026 12:35:26 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by mails.dpdk.org (Postfix) with ESMTP id 8577840DD0;
 Mon,  2 Mar 2026 12:35:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVWMns5WoIWDEw01jZPQy1SbO5SCglwAb94YvP30lJZbhDXSRlClAO2pWrt+DnmB+lAgknD+fSEQ6Z0xHN2do7hx4I0wSIeQt3wgzBsUzXQ9AHZtxEybc19a9A7/DGQMpVj+QR21m2qKvlip4sW3MqrzHMsmM89EZYS0SG7NrN1vdpisX9Ll9MiXabYTpDP0op3MVechE1GPQcAdDWEGlyfpx/NBlJfg0Sgo18N7xS+8sCWY2QU53XiClXO0WbEWmPZu1fiA9CoUoFq/nsE2VWUYtomEcVd+ImVUUpzV7coUuiqx7QjEwMCsx3gXmhsH11rtD5qpBof+JkEwvIOVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBe8Gaiq/fYXobilHJZbPukcY7xKKZ6LZjOGRTzuFHo=;
 b=vCYekVh1p8dMCOe/hDyiz/aS9ZUwUofMQcbM51+AxLobxIUYVRSzLF2QT4Reuxa0HtgxKIgw2i3o2qs7a1ojoIFZQOQ2WmxLhmR2+vqnMWU+o05F997e02xPQEmBsSjMoi4RjnDj2H41HXvXFsG2fhfDn4TbjSkauQnaKp1M88trb7AsRP7knWQmZA3JUE4j+GsJOxbj/L1Qye4rwY4qw5Tl0uKYKzJ3AroT+xZYVdY06PrmptETzl3Z9ZlmQZU4plvwa7gTtynyWZMVGlK/A/wtSuhw4hhU1TiEQ+trnQn/6yJelbg7wVreLs8Oj259s7fKlbaJe58nIe3oJfH38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBe8Gaiq/fYXobilHJZbPukcY7xKKZ6LZjOGRTzuFHo=;
 b=AOQ+i6TugnD6fWJimO/kHXHVF4+WDHbYO8wJR/UOjFyPzeRurzEjGVRxzSx3VDjhIgCZt6U75HvJ3OLHUkUODZ09qW/vigehU4mqUIDL/cUNoAEGIFGRdwKvEp7U5CtSIs7UooqO3+w58lvJLPOX6/7VM2jbQLfvbRpf3qsdzkAR6BnztFpDfC4QXIt2jA9QFoI5wLoWwkEnhvUZPZh8+wEI5LCGYwYKcJPXIM+N6o1sb1TyQYCwfzc7Yuc5VfS92Tr/FaXmh905mVS/82dCP6Zv4w7/CqCf1jqmCPBbafO4wn2klNJ421eyYDgrf+hy45vr84MWuudChdP3dSosQQ==
Received: from DS7PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:3b5::19)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:35:20 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::b5) by DS7PR03CA0044.outlook.office365.com
 (2603:10b6:5:3b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:06 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:03 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Rongwei Liu
 <rongweil@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 1/5] common/mlx5: fix bond check
Date: Mon, 2 Mar 2026 12:34:39 +0100
Message-ID: <20260302113443.16648-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302113443.16648-1-dsosnowski@nvidia.com>
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: c552d1f7-e295-4b9d-59ca-08de784fc8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: m9X8mesS6wpJWApZ6Vy75iS4BQlmkWTv3VW1nQvjQ/3PEfHXvAAaVY7Dy+WU1+V+/c8Es9BVLdZFOkVwIZj1GN0uKo0cTSr9Pv1W2bHY/85TZWT5qnMomScjMlBDfkr2dsebLv94Rhg30JNZ0x8d8ulc6B6wlC2vXzepwhQ1dYVxj3p+VAhECKHu9q8Gmwa6wbmqGLGvRvE8fw7u4QhZSli4Qlm7IDxFYemgy4dBHLn9kfKp/K/VgVJICfVYD77orZyKLQi08NcacBBc44U/xFGC1gB1yovG3nnALapn4EoJbIB//WiDl/Jj9JuFgh1oIF8qM2rgRfrsZxAqyNzJ/VGfoJ9JMjwMHhqUDCGSpeKsS3csQcfVUYcIZ47s74hZwBSiqO215F4ZMFsUCvN7NmJ1V+sq85qLxDvSMnHSdeBF0g7ODX0PXhl6aSFFS7NXcBfy3gI0buRT2CUpVGrT5T3rOLFMwEFgxOQ8j6XP2cv4x0LkSmoTDcdl6Ktk6cWcI0ytVJdOTpwPt18X3NgCK/vmRLqmNSvuNbAJEB9qiIfxBwTRGFopWOtg6KlLsZ2mPWW+6dypRN8YevkbsJ0v6zDx8JZwavYj6EgvwKTB9WT5KCP4FVDnaC3rzck0J8/7f+XdZ/Q5nshzRoBNRZb6Sz3ctqNodx7cxx6HRAkb1+CjYPSAJtOMqc1Q+WyiC9owl6uMY2uhjiE5olSaWhguto8kBYHvbH4QlR1clCU+gIxmS3u/RLt6vq2ps09znvrkYgL/2DahceJvNHEcYA2iq5L0hOZT6ex0ygB/i51qBbjLj4x729slag0coqVsgu01KJgT7EJfyf1bDSyFXaopLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /YzS2+Aqiz8RgT5bObvdQnv44RLUzmHNA4oePBBAM36x+Z/w+4se+MhB65EkDxQx0CN1fG5kx8qSfqzeEWG+7aE3jrOl2CqcW9ob9Z0BniIW3kwC/9dpn/vlyxmJ1/2vbelPjCw989mi1LUK1Hk/PjEybnJo0AOZ68/B6nY0T3EMdF2Q8iADwPdmWOJ3le77cCURw8WWzS3wqzqxSHFSNZ/lyhLIPKD+0fu8/thpWe0SSsbcE+Bf5l+JeQ6GxxF+3QUvaQCJbogqrTCiJCGt+rhrA56QD2jOnVdSzPjz35R0LDlC8sN2wSvJFQ9PPdEAT1JZPbGvbwBuPsxyLMMXVyCaTWtXtVWNYul8N0wPkuF6q6L0geSxDzHUNjvFguj/KUfRvjpEvXxhh+S30FKEgaVTxO6p4ZDrYwLM7RvLKX5EcBlDInkiJXn0LiFVW/za
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:19.5969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c552d1f7-e295-4b9d-59ca-08de784fc8a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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

