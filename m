Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13FC87FCF
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 Aug 2025 13:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62E0B4025D;
	Sun, 10 Aug 2025 15:24:37 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by mails.dpdk.org (Postfix) with ESMTP id 88EC1400D5
 for <dev@dpdk.org>; Sun, 10 Aug 2025 15:24:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASGjpHa3f19qRl7Md1Wyn/L/pHuHz8FfkpQpqWaxVDeRsGvbhXWi7JcUZrnSGHzOxearQYnuIJNr5E+mCcE1PMq7304M4+yZSwS+/nYYdhmi2CIKWw0P2gJ7NdWnjGDSWSBAAXGrmOYqfvqxRNUfYUeosc8cdltlaqE7FexK12ac924P0H0DlC56u1PN0kMOGb5qpRxcPCQQfkrjmHxlqtlskm9ZDuFbJU/ZM8Jt7CsOJEFdfoumyKiFVWDUvSsDAknW/FSku2VGL0W7Lwp6JNjvRi7RI80nzS/aUB/Nfq9qeHSzQK3Iee+jb+ALkF3gR2ZdNTgPBFCkzpPXhHPNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdtQmBQy7i5eBfXjIf1Urn92WVWzY3yc2cd7US8l4dI=;
 b=J+XqRUNbruoqkuUihUXfvbdCcsb6a2h39v6Eq8SfcFaDcu60SLz2dKsrV8wOV2sFVlJo+GwqE0+36z4TBkfbHyIuXGIhtvZfcMV8ZFcQlmbNVk3QKGhNrrVXaqhslBwkbVBGDr15c/XCZL2pD4gtEisqphSzC9RDl0rQl9mqqjYhs8D/jmvrJQ6Yq9cDGTMvluyZndU22Om19Ccwd1OuJqiDZb6GXNXMo/cPdLtpwASIfJ9WSwlZZPaBMHDde56umFIMJfHe3oaXANgfYBJJe1dw4vumOEZTmgkL6Wh4HpfZsOIx6VeiifxI14WSJtU2O4YpF2PAt5MJIeRkN4vDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdtQmBQy7i5eBfXjIf1Urn92WVWzY3yc2cd7US8l4dI=;
 b=Aj17tqDciwVaYK69lGf8YJHS3LoODE45nQcBxItOjx1tJgl9//TKwKnGX4C4CRykp5jyQIrAJuVOpf3KOBgDZAc3DKHFrS1B+C81ciOq7kkheQLzY0OFf6897T3vyoJDbI7q5DBDsHYQ83qIm/ODJpNOUrNjmM2udxNdik9wobYy7Bq91zkDRKrW/s57A6GUhQTgFTkV+ce21j9hchPzRoRYjgUToFtlpnkGjVQlefQlW4keoQs+nFfzbKQuLavUAd7VrZa6HB1OSZ8ig4RBPZfZrY+fkkMFj93K26TQBqSwuq2R6fSW2W/pmPVcVMR354GvLP9ZEsNe3X4UbFlhig==
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 13:24:28 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::95) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Sun,
 10 Aug 2025 13:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 13:24:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 06:24:21 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 06:24:16 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
Subject: [PATCH] net/mlx5: fix interface name parameter definition
Date: Sun, 10 Aug 2025 16:22:59 +0300
Message-ID: <20250810132300.124429-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ee3699-0cc8-4a44-d5d1-08ddd8113b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xIWeDPj0tN1wJeJgfotC34hdl3yLUS+XjFc6Xz1s1wV1FnQ7C9xAXc/4YmeI?=
 =?us-ascii?Q?rXq+dvRh4JEP7lNLhOZAhUtedNpduxmNu4vGGJhHNQKbNr0IZ/nu38IuorCT?=
 =?us-ascii?Q?YbsghQ7ks+wdWumnldFQlfKXJlyXLuKuA5AL2imy/GmQOMm2l6R1DJFFYTw+?=
 =?us-ascii?Q?UPsVBZGMHDu7reUdpbVT/oAa35Aj8SeTdoekBFCDTIwYr5VEaeRLFTWlfnpp?=
 =?us-ascii?Q?QYpQcQLGQyXYA9oVpfHLsQv7IwdtBcRQV04zQtARcT1/3/QhreG6DAmB9ooD?=
 =?us-ascii?Q?I8yhHyPv4qA0WUwotYTYopk9uisi8AeAZfcS0nR5rE3cv0j38cDIkZhUiZrn?=
 =?us-ascii?Q?U4kGPaktiMPulrGBxiFEt3C6lXBGVtQtZC7ikJlYDaJ0F4P2K8FoDcEb4bSF?=
 =?us-ascii?Q?b1KvcUivrtFxd8C7cA5k3Ysmiwd1gL2MADHmBD8YvHugW3uczQWuMLAHXfdD?=
 =?us-ascii?Q?HEh9lOxd72dyIIoABIWhuUhEUmFXiwOZZVk0v0QMQ+Vyv64VoDNUvOtDQYMd?=
 =?us-ascii?Q?Yc0MhzVKD3p1PvOy8HyUiPhmJGytjHEUQZ4rc0UPW/vE0qi47rQopDu8aukj?=
 =?us-ascii?Q?zBLTLyQApkFDHZ5C94Mt7t/H/BPJd5HZ4Yo1Z0M7CAhIu43YG76h1nBNSJXf?=
 =?us-ascii?Q?9IzKwq8Y618TTDE/ipnuDMgGa1o2PFfRUNaE98dPxGOk4t2aFVqUBdiDGgDF?=
 =?us-ascii?Q?O940ro7EZr/0Qrme+gf9wSPWt7Vuh26w7VamyDY1uK+Wzqoj1R9GilmXkLZa?=
 =?us-ascii?Q?c1TdTZFiAmIEebR67mZZbzu9fO2v62/FnRWpeBTDcJ1pYRWpx4yYm552pyBV?=
 =?us-ascii?Q?6+OxUkwyUhCTisAZ5EdYCqAXt2nYDVmJptsNl3SIb55j8QTYhpbMdYBUj4e0?=
 =?us-ascii?Q?VQp9+HvyULeIgBBUCfrk54npmNM6cTyxvZ0TlS5erf7nJ8dxqaJvojRwIWnH?=
 =?us-ascii?Q?/hCsK2p89ovcEIz4CGZ0zIJxgVgWZdeIld8CCQv65h86NUOz9jjygjiP9LIT?=
 =?us-ascii?Q?gId3wMfoUHe4IaK8miXxSYWfanO8yHmpskYndGRoD1mLTO7gL3lnqEUVvOMx?=
 =?us-ascii?Q?wt1By5ynhTgbBGaP61CnTxe27A+8Xk4ks5MH7n6NI6lk0k3f0sc4hBaQ+JyH?=
 =?us-ascii?Q?nBr97yzerEDF8I54nsmvXX1LGQMdSx8EmYfydMiS0k8/x6huLUo3y8sVWna1?=
 =?us-ascii?Q?tJYP7edlWf7kDaCmdG60Se2aYIhXx5ALwBZmG38gF58eh6/CcUG2lGx8eOkp?=
 =?us-ascii?Q?T2c5kiqlXIi6zYoOfJ9RAUKYuJxnlXcUJaAGj3cYECFaVWptqP0nQ4sRw4Mz?=
 =?us-ascii?Q?qwqpR7uDvqB7v3FO1FmTV4a4H2Jczkfxk/1f2EzCplaes7D+Ialal59Klg8z?=
 =?us-ascii?Q?CILotW8IuLFCA9JpQk4UoRIiGUWXW5A6S1RAusAGotSjzYvsnqr7K6NpOIrD?=
 =?us-ascii?Q?r620Mj0Yg4aO/Wy3cxMUB1LFyxCDhW95dE9lQk8SdC0AtWUndLKiJRKfco5U?=
 =?us-ascii?Q?1VbCDcuStTIXg9Ufdq3Jc0ROzR6gZ4uUCgZR?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 13:24:27.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ee3699-0cc8-4a44-d5d1-08ddd8113b84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

The patch fixes `ifname` parameter as a character buffer.

Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c   | 11 +++++------
 drivers/net/mlx5/linux/mlx5_os.c          |  2 +-
 drivers/net/mlx5/mlx5.h                   |  3 +--
 drivers/net/mlx5/windows/mlx5_ethdev_os.c |  4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 9daeda5435..eeb95bead0 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -73,7 +73,7 @@ mlx5_auxiliary_get_ifindex(const char *sf_name)
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-mlx5_get_ifname(const struct rte_eth_dev *dev, char (*ifname)[MLX5_NAMESIZE])
+mlx5_get_ifname(const struct rte_eth_dev *dev, char ifname[MLX5_NAMESIZE])
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int ifindex;
@@ -87,12 +87,11 @@ mlx5_get_ifname(const struct rte_eth_dev *dev, char (*ifname)[MLX5_NAMESIZE])
 	ifindex = mlx5_ifindex(dev);
 	if (!ifindex) {
 		if (!priv->representor)
-			return mlx5_get_ifname_sysfs(priv->sh->ibdev_path,
-						     *ifname);
+			return mlx5_get_ifname_sysfs(priv->sh->ibdev_path, ifname);
 		rte_errno = ENXIO;
 		return -rte_errno;
 	}
-	if (if_indextoname(ifindex, &(*ifname)[0]))
+	if (if_indextoname(ifindex, ifname))
 		return 0;
 	rte_errno = errno;
 	return -rte_errno;
@@ -150,10 +149,10 @@ mlx5_ifreq_by_ifname(const char *ifname, int req, struct ifreq *ifr)
 static int
 mlx5_ifreq(const struct rte_eth_dev *dev, int req, struct ifreq *ifr)
 {
-	char ifname[sizeof(ifr->ifr_name)];
+	char ifname[MLX5_NAMESIZE];
 	int ret;
 
-	ret = mlx5_get_ifname(dev, &ifname);
+	ret = mlx5_get_ifname(dev, ifname);
 	if (ret)
 		return -rte_errno;
 	return mlx5_ifreq_by_ifname(ifname, req, ifr);
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 696a3e12c7..03c5191095 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1578,7 +1578,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	{
 		char ifname[MLX5_NAMESIZE];
 
-		if (mlx5_get_ifname(eth_dev, &ifname) == 0)
+		if (mlx5_get_ifname(eth_dev, ifname) == 0)
 			DRV_LOG(DEBUG, "port %u ifname is \"%s\"",
 				eth_dev->data->port_id, ifname);
 		else
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c08894cd03..3e293216bb 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2336,8 +2336,7 @@ uint64_t mlx5_get_restore_flags(struct rte_eth_dev *dev,
 
 /* mlx5_ethdev_os.c */
 
-int mlx5_get_ifname(const struct rte_eth_dev *dev,
-			char (*ifname)[MLX5_NAMESIZE]);
+int mlx5_get_ifname(const struct rte_eth_dev *dev, char ifname[MLX5_NAMESIZE]);
 unsigned int mlx5_ifindex(const struct rte_eth_dev *dev);
 int mlx5_get_mac(struct rte_eth_dev *dev, uint8_t (*mac)[RTE_ETHER_ADDR_LEN]);
 int mlx5_get_mtu(struct rte_eth_dev *dev, uint16_t *mtu);
diff --git a/drivers/net/mlx5/windows/mlx5_ethdev_os.c b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
index 49f750be68..2e9c9d5b3f 100644
--- a/drivers/net/mlx5/windows/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
@@ -56,7 +56,7 @@ mlx5_get_mac(struct rte_eth_dev *dev, uint8_t (*mac)[RTE_ETHER_ADDR_LEN])
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-mlx5_get_ifname(const struct rte_eth_dev *dev, char (*ifname)[MLX5_NAMESIZE])
+mlx5_get_ifname(const struct rte_eth_dev *dev, char ifname[MLX5_NAMESIZE])
 {
 	struct mlx5_priv *priv;
 	mlx5_context_st *context_obj;
@@ -67,7 +67,7 @@ mlx5_get_ifname(const struct rte_eth_dev *dev, char (*ifname)[MLX5_NAMESIZE])
 	}
 	priv = dev->data->dev_private;
 	context_obj = (mlx5_context_st *)priv->sh->cdev->ctx;
-	strncpy(*ifname, context_obj->mlx5_dev.name, MLX5_NAMESIZE);
+	strncpy(ifname, context_obj->mlx5_dev.name, MLX5_NAMESIZE);
 	return 0;
 }
 
-- 
2.48.1

