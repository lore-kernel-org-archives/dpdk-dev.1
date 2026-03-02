Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE50E9B368
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5643F40E25;
	Mon,  2 Mar 2026 12:35:33 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by mails.dpdk.org (Postfix) with ESMTP id 2D35A40E18
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:35:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5au5jJ8J9h2rHB9ep224HJW5SZj37q1GyIf5tjVh+ibveR5H/KO8fEXpiiWtbOK9T/EIdOdo67AtgSjjxGL9YV9CMJiLNAHJu2CVTQ5jnzFem7qX/KN2vUJi9fjob44OkVJFbZbmuyhP8A4gDhy4DeAwol9gA5+LbPpmAPrcydrdHS8HCqWkKNQ8bkeMJfKVebFWxoiRLc0zGr+dqWWC6aRCTsCLawM0VUaQlrgYOmwTY2DneUhzugRoo+1FC9Fnuw377NZJXpek8NGrhLpK7+2cMsIe5s/2JWx/9HJOuX6UrF9/oKksKmivDNYr/4/gb6UMqZL/VyrTcuA7lsokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ufKrbnnh141B5FM5r4/G1mz3uwQPlrwPHAJnnb26mA=;
 b=iEgFxvkiYDWr4UMiRHf6TYD/yWfImVFNDTjNJRZzZJPJEqObsicCF+eS/V3fF6tPtYN7Yw4npzBqsPT9ottdx0TZqK/3BzZ4AH+kk3le5xzkKVP6YkqkSUbEOyF9WIvtt7nN+3w23NruZUMExL+vmwN4OC1EJxUlu7l3U5nueyw1Gx+DbwHumFU/ZNWdzr6IKJM31NREfMPfroJPtp934oEM6DfS7nEK+eW/e8d2Zq1Soai5kH3tPgjksPBY8C7tI22Vt3+z9QwVyGtHks0bBgU7vYY6XmhnviQ/xa2GDrDMT+73Nq5UPD3xh/+a9xpAAfzBJblKwirgaKc/bdxPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ufKrbnnh141B5FM5r4/G1mz3uwQPlrwPHAJnnb26mA=;
 b=s0LTRAFLdtiI9ypICybxacDD0slnLv52q2naxawRMWjJiJ+giqOAUTrt+yhc20Agp5M6tRfTIpmXNFW0wMhsFS1ErtL1+sXPgFACWGk3ysHBoZvlUIVBpgPl5LTIwdPPwbwWwN4DJkGTCxJJhxmfPVIx5r3dCJ6JSKeNI8cmYaJLh4ms01Ari9gpXgfq7TFqnM2um6wBfhopUz2jHy9W/kefaDILxgfiYd6rH4D8rOZr3THiW6uz7nTLZM0S9FUEUr4SDpl3dd1cwm4IYJ8NwZfNVxrzuJxq0VCh781t0azApSgZmkORi4ZFI9txcO+CUyfmBzE6kZV4V4toK7Kw0w==
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 11:35:25 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::a7) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:11 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:08 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 3/5] net/mlx5: calculate number of uplinks and host PFs
Date: Mon, 2 Mar 2026 12:34:41 +0100
Message-ID: <20260302113443.16648-4-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 064fe450-d162-4de6-b381-08de784fcc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: EhXmZm2tbiU3YJSkZ6hCIZjQ7peePSN2mogEkGbsG7qQkDKTNmOn7dO/jESMAC1/fHUcUFCF5HeMBJxXvswZr1kQjmBlCLn3VGnUPyiBFZVUQl9vYpjyUL/cI7EoS807C/L51tmcbnLMlAJ/yXNuTls9lGmqgX0Qc/bbmN8RnZ0Jw4veE08b/VbFnqD5uVpFVOAfT2o1+fOFLnn/iz66vCwF+EdylsTd1zoeSR325pYzpzmUqFNEBVBcIc0/RNp7f1w1crLuNa6XShnTorlmw5pWGjSEJ0jnk1XjqMjGwb+VJji54gxFajt+5nSOKX5vj1ICDjkKqTM9qI5dxrTcouMcfgSYyCzN2fVbiEfL7f6lIMkahLGv3TlJea7B/354tbLO1K/SvurVzz8Ro2pC7SjfMqvEJ4BNpo8D5q3FhJyFtuK4/rlw+ThrlXZBZazVjddKAzVh6Y/OMg+zNhoaUuWX1LWxqdXm5oJFGKuZSa6/VwM71QLCNhV17D/umusOhIbtfGgdMzC5DLqT/ZQeqCsfffJ+FkqXN++d2nu/FNPH6luDP50soUCZOrkmHnmRlGM60imgdGmQru80/oOq7qDCf8CQPKfWqwpeKgc7+8Gnld5RJBx11672MFR3pnXYh/aXUEUOFlfBjmv23Pgf/nbEswBHeYzX3E2VQbJxqAmglPq65JhTGxtqHaXUviaWN7mDzCc98Z2K4d/43/3VS7OJK7oSmTXNArjzyJ9illmzhwEW6egZ18EaEUHyDX2F7GwKyQULo7LYBX/WGhDoszMeLwEuEtwMweLTC3DVqxDEQGhyzm5QUSyAZT90yKlTs6Fn/HEVRzk0e2vLlv9tUw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W8IFK5riTeD6Bm8qXc6+xMujlF1TxgYxhekzvPd+bTqlmuRbFVHk36sCbnv0Aw31mkUTBZ2dzxFR5mjeCBvkxv9M34jmG3gZH5+5DJ/nwjfUXui+7QD52Tm2KUERz/vZNTwSupoRPEG5IwUaVXUz8lQcmy/oBcBP/42ABxERCdqIgFxB1xX1YojWXP9l1ZhIB4cVM4l/rozWtkasGgAwuawFx72aJaTEWanscdaG7ZHPBfRsGbMmbltCcU0H6QpSjkVmQ1CHAnN3r67/89SwxhvrKjy4cs0FbTlttibsgV9WW/emGivdH205xnC6dRVwat13YLyFMEPb0Zht+8Tsn1MFPilHbuO7IIMTsoWLMsLPMpM28IUANs8nL8ON5ELVGon3CNoybvQ9uVnz2Sc7w9BgpYT8sO0kLwNwzIJOa35dir4o9J0GSfteLydOBuu/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:25.2983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064fe450-d162-4de6-b381-08de784fcc0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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

Add counting of number of uplinks (IB ports for physical ports)
and host PFs (IB ports for host PF representors visible
on BlueField DPU) for all probed IB devices.
This information will be used to generate a proper DPDK port name,
instead of specific setup type, in the follow up patches.

To facilitate correct counting the following changes are also made:

- Checking RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF flag is moved to
  mlx5_representor_match() so all uplink IB ports are kept in the list.
- IB ports for VF/SF/Host PF representors related to all PFs are kept
  in the list.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 74 +++++++++++++++++++++++++-------
 drivers/net/mlx5/mlx5.h          |  2 +
 2 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 405aa9799c..f9f3b2c38b 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1047,6 +1047,12 @@ mlx5_queue_counter_id_prepare(struct rte_eth_dev *dev)
 			"available.", dev->data->port_id);
 }
 
+static inline bool
+mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->flags & RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF) != 0;
+}
+
 /**
  * Check if representor spawn info match devargs.
  *
@@ -1075,6 +1081,10 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
 	 */
 	if (mlx5_is_probed_port_on_mpesw_device(spawn) &&
 	    switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
+		if (!switch_info->master && mlx5_ignore_pf_representor(eth_da)) {
+			rte_errno = EBUSY;
+			return false;
+		}
 		for (p = 0; p < eth_da->nb_ports; ++p)
 			if (switch_info->port_name == eth_da->ports[p])
 				return true;
@@ -2297,10 +2307,45 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
 	return -1;
 }
 
-static inline bool
-mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+static void
+calc_nb_uplinks_hpfs(struct ibv_device **ibv_match,
+		     unsigned int nd,
+		     struct mlx5_dev_spawn_data *list,
+		     unsigned int ns)
 {
-	return (eth_da->flags & RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF) != 0;
+	for (unsigned int i = 0; i != nd; i++) {
+		uint32_t nb_uplinks = 0;
+		uint32_t nb_hpfs = 0;
+		uint32_t j;
+
+		for (unsigned int j = 0; j != ns; j++) {
+			if (strcmp(ibv_match[i]->name, list[j].phys_dev_name) != 0)
+				continue;
+
+			if (list[j].info.name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK)
+				nb_uplinks++;
+			else if (list[j].info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFHPF)
+				nb_hpfs++;
+		}
+
+		if (nb_uplinks > 0 || nb_hpfs > 0) {
+			for (j = 0; j != ns; j++) {
+				if (strcmp(ibv_match[i]->name, list[j].phys_dev_name) != 0)
+					continue;
+
+				list[j].nb_uplinks = nb_uplinks;
+				list[j].nb_hpfs = nb_hpfs;
+			}
+
+			DRV_LOG(DEBUG, "IB device %s has %u uplinks, %u host PFs",
+				ibv_match[i]->name,
+				nb_uplinks,
+				nb_hpfs);
+		} else {
+			DRV_LOG(DEBUG, "IB device %s unable to recognize uplinks/host PFs",
+				ibv_match[i]->name);
+		}
+	}
 }
 
 /**
@@ -2611,8 +2656,6 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 					if (list[ns].info.port_name == mpesw) {
 						list[ns].info.master = 1;
 						list[ns].info.representor = 0;
-					} else if (mlx5_ignore_pf_representor(&eth_da)) {
-						continue;
 					} else {
 						list[ns].info.master = 0;
 						list[ns].info.representor = 1;
@@ -2629,17 +2672,14 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 				case MLX5_PHYS_PORT_NAME_TYPE_PFHPF:
 				case MLX5_PHYS_PORT_NAME_TYPE_PFVF:
 				case MLX5_PHYS_PORT_NAME_TYPE_PFSF:
-					/* Only spawn representors related to the probed PF. */
-					if (list[ns].info.pf_num == owner_id) {
-						/*
-						 * Ports of this type have PF index encoded in name,
-						 * which translate to the related uplink port index.
-						 */
-						list[ns].mpesw_port = list[ns].info.pf_num;
-						/* MPESW owner is also saved but not used now. */
-						list[ns].info.mpesw_owner = mpesw;
-						ns++;
-					}
+					/*
+					 * Ports of this type have PF index encoded in name,
+					 * which translate to the related uplink port index.
+					 */
+					list[ns].mpesw_port = list[ns].info.pf_num;
+					/* MPESW owner is also saved but not used now. */
+					list[ns].info.mpesw_owner = mpesw;
+					ns++;
 					break;
 				default:
 					break;
@@ -2773,6 +2813,8 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 		}
 	}
 	MLX5_ASSERT(ns);
+	/* Calculate number of uplinks and host PFs for each matched IB device. */
+	calc_nb_uplinks_hpfs(ibv_match, nd, list, ns);
 	/*
 	 * Sort list to probe devices in natural order for users convenience
 	 * (i.e. master first, then representors from lowest to highest ID).
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index b83dda5652..bef0088164 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -215,6 +215,8 @@ struct mlx5_dev_cap {
 struct mlx5_dev_spawn_data {
 	uint32_t ifindex; /**< Network interface index. */
 	uint32_t max_port; /**< Device maximal port index. */
+	uint32_t nb_uplinks; /**< Number of uplinks associated with IB device. */
+	uint32_t nb_hpfs; /**< Number of host PFs associated with IB device. */
 	uint32_t phys_port; /**< Device physical port index. */
 	int pf_bond; /**< bonding device PF index. < 0 - no bonding */
 	int mpesw_port; /**< MPESW uplink index. Valid if mpesw_owner_port >= 0. */
-- 
2.47.3

