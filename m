Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D916FEB7ECD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:58:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1908440677;
	Wed,  4 Mar 2026 11:58:06 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by mails.dpdk.org (Postfix) with ESMTP id E557A40674;
 Wed,  4 Mar 2026 11:58:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU2t8N1VoHRoei5PjqbYQhnhnjU+uewD42I5XtjfmfIu58nvVdihgbFp9NfhAgANBB0Ny1lw4Ar+poimc+6XVz4xFngMkQU1etimKWM9L4fs1hmf+fdjjWPcOfC7Fk/HzPnDNMtSH3L9wAvy/i9+OzkBngudTkh9reY7QMaVprA5JbPcfSIbxrGbdnZpBgx3HlKWlJlfKR58To7fBVFjOVHXAobqt8g0uQjv/N7JR1mQn0YLbugu8hpc4suw/1obynRhBoHtPODE6zPaoqQkPE3gFrdIBsddO+a2mt6cEJsY3Z85xWsrO9XU7OrXHoZ7KuLbGt2UjDUQHRfCGSjqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIASjGFbwHApOQlS2a7y0TRfS7bLcy+gpCdI6WX7kTU=;
 b=CLGv+/0RgZRC/Y+wINRh4JcJPb0lO9IL2RK65aGVMUh4NBKaM6B8GR8WDWBmcOdRwUDYvsJbl9+R7rZMNT18Tpnsiv+w+ESNCKNKm8We7F65ZvL5KrC048gvy9HCL8gKGUNjfMxr5d4mbrKnDYpD8FZFMQDg9qJGzwjaBfHcxXr0bBADdyofroqc1//J3MNeJsKA8bnIGpt0ZlIOrScOJWqq5eMCURqCkm2yvWB2N8c9f+SzwavSxeyc3PpKl15cbodcNnAwdAmurMXhorDeAFlm1BBUOgnGK4BTTx/WG3AWiTyvyxubS+lyi7EDHxyEV1qA/ZDjcx8zPyzjuuzlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIASjGFbwHApOQlS2a7y0TRfS7bLcy+gpCdI6WX7kTU=;
 b=N/9SCqBN5Qq2G2M8UE0gohYRAanS3e0FQ42I1f2cEYoxiX9Ma02m5QGxBIIbB7o6MgPfHsYX5D/ILNSAbOgar5U5bKGJQL9towr1nJxOh1BuFLKwFyJHG5sdGMDj38Gn2CD+kPu85utmuxFgDRNbv68ulE5jDwUZWWoQR8q6Lld7SkN/9yd6rahz6GQPB5ckIR9ft+PzwxNqmNR0Zia4KO5U1L9imoQvvD0zPqH3OfqwbQCXRWhQoz1/tlC8SsaluTGwJurcZm73ndMshfOtFGY/nU7VHAkR8M7vhaPx/1JNKDIH0bVq18F4jh3pQRelu/7FUwYsMWyG9rnqnQSXEA==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 10:57:52 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::91) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Wed,
 4 Mar 2026 10:57:51 +0000
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
 15.20.9654.16 via Frontend Transport; Wed, 4 Mar 2026 10:57:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:41 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:39 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2 3/3] net/mlx5: fix probing to allow BlueField Socket Direct
Date: Wed, 4 Mar 2026 11:57:18 +0100
Message-ID: <20260304105718.93412-4-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f914e3-712c-41eb-11fe-08de79dce1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: MO+lhf3bQpVjx3FbzcCU93O6RSiLAh0zOp2cP5kU4NbRbpil7CBApx+Ul4cenDrHooGSz2yNrM9wlsYbczB1mw0JeGOwNenYGV1XWB4iAUKn2zO8Ne8V/3qvOHwWWTQioZtGyAXSGK5o7MTJPhGk3L5usJmSeBYxxiWMt1Y9X2nScKOFhVwBDPG7urb19BcjxsE7ALeJaIxsXaHeOzBqURzp4B42nGdeSxdty+4OdsLevRffqkGZmA03XusOMYhpV0MeNqaKCqlHEudG2mbLXpXFpKUfHlXorgqXQdoMnQRVpuoogRs9jyoAB28BKkgdrkeUWQSOrUU7ntLCY9Mx2QAXJxd9NH+AjGrgtx9cBkWEnuiGnQ9/gooHsb3vh6HEplNF98mZQVL5h2VqmELvQxgPl+SPXk4cFn3KpmD5w8mOAJlt84+xcUSc2AfFlJLPq8re50zao1rJ9h2QfvCG/s7LVfr4Cj+Q3+hujeGhd+uYvXihn9e2c+ECjQFC0g99BMLsVt3VgzO8V4gICc9fS2uiqnGZXMF65s7fOVNcj7w6V/YIEYusg96pEGbqOp3YCgIUDOBMwFVMWQB9e2J5FgDBz0gvM6hfRVh67It9H1UYibz5O6OqA++UUy9F1lTzdnWlm88o6fCmuTpZ8UvfnGV44/TsH1lbZxQq4AGB64IP1OlhifxEpVQHZDflGSfxtMHbfBVYdGq7lap2bFt624wMXhAEBIUA1SmnFcrJgyI1MO0XSp+BDRhUNIoUAF/3HKbTOShJvPEmPpcF59hApg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T1hB77xyKXbPy4mcgaleVLN1ieDH1DumRHG8oCt5Z8QFkXhST5r5NVeYMRzJYf1gJnjSlXmgKrjTAN6ATVP4rzgQEW7GR1vLINEgawedVhQC9ZCxixWpH+BwsLa91THU5gaWLVzJiuE/6+r92HKRIWEv+hukds3+kRmfgoiUMsoKNAzlQweXdiG4UlQQ3X3jw6q9W9aK4e5S6PfJ597w7A2GuZ96pfkLlFXEFD4sds445O2papVGD62g7+4cttUlkMFIhY4nXAEn4BDDM9qv5cBdtR14FqFOtnqJsqKRzA1dIe9nz/paIuD4dAqB5Eo39tY0xHOVxDYVsqjFiKIRIvSdGYnz9/bigit0XHcMQisUNO6z++ZH4ljvLLCTvzY+azmVIOfHNa+aDHR6VO7UAE9tOmGGrmhyVZGuq4uY6nVannNL8LE9Vnyt3e1pfJJI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:57:51.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f914e3-712c-41eb-11fe-08de79dce1b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
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

BlueField DPUs with Socket Direct (SD) can be connected to 2 different
CPUs on the host system.
Each host CPU sees 2 PFs.
Each PF is connected to one of the physical ports.

On BlueField DPU ARM Linux netdevs map to PFs/ports as follows:

- p0 and p1 to physical ports 0 and 1 respectively,
- pf0hpf and pf2hpf to CPU0 pf0 and CPU1 pf0 respectively,
- pf1hpf and pf3hpf to CPU0 pf1 and CPU1 pf1 respectively.

There are several possible ways to use such a setup:

1. Single E-Switch (embedded switch) per each CPU PF to
   physical port connection.
2. Shared E-Switch for related CPU PFs:
    - For example, both pf0hpf and pf2hpf are in the same E-Switch.
3. Multiport E-Switch (MPESW).

Existing probing logic in mlx5 PMD did not support case (2).
In this case there is one physical port (uplink in mlx5 naming)
and 2 host PFs.
On such a setup mlx5 generated port names with the following syntax:

    03:00.0_representor_vfX

Because setup was not recognized as neither bond nor MPESW.
Since BlueField with Socket Direct would have 2 host PFs,
such probing logic caused DPDK port name collisions
on the attempt to probe 2 host PFs at the same time.

This patch addresses that by changing probing and naming logic
to be more generic. This is achieved through:

- Adding logic for calculation of number of uplinks and
  number of host PFs available on the system.
- Change port name generation logic to be based on these numbers
  instead of specific setup type.
- Change representor matching logic during probing
  to respect all parameters passed in devargs.
  Specifically, controller index, PF index and VF indexes are used.

Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 342 +++++++++++++++++++++----------
 drivers/net/mlx5/mlx5.h          |   2 +
 2 files changed, 241 insertions(+), 103 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 405aa9799c..324d65cf32 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1047,6 +1047,171 @@ mlx5_queue_counter_id_prepare(struct rte_eth_dev *dev)
 			"available.", dev->data->port_id);
 }
 
+static inline bool
+mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->flags & RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF) != 0;
+}
+
+static bool
+is_standard_eswitch(const struct mlx5_dev_spawn_data *spawn)
+{
+	bool is_bond = spawn->pf_bond >= 0;
+
+	return !is_bond && spawn->nb_uplinks <= 1 && spawn->nb_hpfs <= 1;
+}
+
+static bool
+is_hpf(const struct mlx5_dev_spawn_data *spawn)
+{
+	return spawn->info.port_name == -1 &&
+	       spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFHPF;
+}
+
+static int
+build_port_name(struct rte_device *dpdk_dev,
+		struct mlx5_dev_spawn_data *spawn,
+		char *name,
+		size_t name_sz)
+{
+	bool is_bond = spawn->pf_bond >= 0;
+	int written = 0;
+	int ret;
+
+	ret = snprintf(name, name_sz, "%s", dpdk_dev->name);
+	if (ret < 0)
+		return ret;
+	written += ret;
+	if (written >= (int)name_sz)
+		return written;
+
+	/*
+	 * Whenever bond device is detected, include IB device name.
+	 * This is kept to keep port naming backward compatible.
+	 */
+	if (is_bond) {
+		ret = snprintf(name + written, name_sz - written, "_%s", spawn->phys_dev_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	}
+
+	if (spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
+		/* Add port to name if and only if there is more than one uplink. */
+		if (spawn->nb_uplinks <= 1)
+			goto end;
+
+		ret = snprintf(name + written, name_sz - written, "_p%u", spawn->info.port_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	} else if (spawn->info.representor) {
+		/*
+		 * If port is a representor, then switchdev has been enabled.
+		 * In that case add controller, PF and VF/SF indexes to port name
+		 * if at least one of these conditions are met:
+		 * 1. Device is a bond (VF-LAG).
+		 * 2. There are multiple uplinks (MPESW).
+		 * 3. There are multiple host PFs (BlueField socket direct).
+		 *
+		 * If none of these conditions apply, then it is assumed that
+		 * this device manages a single non-shared E-Switch with single controller,
+		 * where there is only one uplink/PF and one host PF (on BlueField).
+		 */
+		if (!is_standard_eswitch(spawn))
+			ret = snprintf(name + written, name_sz - written,
+				       "_representor_c%dpf%d%s%u",
+				       spawn->info.ctrl_num,
+				       spawn->info.pf_num,
+				       spawn->info.name_type ==
+				       MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
+				       spawn->info.port_name);
+		else
+			ret = snprintf(name + written, name_sz - written, "_representor_%s%u",
+				       spawn->info.name_type ==
+				       MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
+				       spawn->info.port_name);
+		if (ret < 0)
+			return ret;
+		written += ret;
+		if (written >= (int)name_sz)
+			return written;
+	}
+
+end:
+	return written;
+}
+
+static bool
+representor_match_uplink(const struct mlx5_dev_spawn_data *spawn,
+			 uint16_t port_name,
+			 const struct rte_eth_devargs *eth_da,
+			 uint16_t eth_da_pf_num)
+{
+	if (spawn->info.name_type != MLX5_PHYS_PORT_NAME_TYPE_UPLINK)
+		return false;
+	/* One of the uplinks will be a transfer proxy. Must be probed always. */
+	if (spawn->info.master)
+		return true;
+	if (mlx5_ignore_pf_representor(eth_da))
+		return false;
+
+	return port_name == eth_da_pf_num;
+}
+
+static bool
+representor_match_port(const struct mlx5_dev_spawn_data *spawn,
+		       const struct rte_eth_devargs *eth_da)
+{
+	for (uint16_t p = 0; p < eth_da->nb_ports; ++p) {
+		uint16_t pf_num = eth_da->ports[p];
+
+		/* PF representor in devargs is interpreted as probing uplink port. */
+		if (eth_da->type == RTE_ETH_REPRESENTOR_PF) {
+			if (representor_match_uplink(spawn, spawn->info.port_name, eth_da, pf_num))
+				return true;
+
+			continue;
+		}
+
+		/* Allow probing related uplink when VF/SF representor is requested. */
+		if ((eth_da->type == RTE_ETH_REPRESENTOR_VF ||
+		     eth_da->type == RTE_ETH_REPRESENTOR_SF) &&
+		    representor_match_uplink(spawn, spawn->info.pf_num, eth_da, pf_num))
+			return true;
+
+		for (uint16_t f = 0; f < eth_da->nb_representor_ports; ++f) {
+			uint16_t port_num = eth_da->representor_ports[f];
+			bool pf_num_match;
+			bool rep_num_match;
+
+			/*
+			 * In standard E-Switch case, allow probing VFs even if wrong PF index
+			 * was provided.
+			 */
+			if (is_standard_eswitch(spawn))
+				pf_num_match = true;
+			else
+				pf_num_match = spawn->info.pf_num == pf_num;
+
+			/* Host PF is indicated through VF/SF representor index == -1. */
+			if (is_hpf(spawn))
+				rep_num_match = port_num == UINT16_MAX;
+			else
+				rep_num_match = port_num == spawn->info.port_name;
+
+			if (pf_num_match && rep_num_match)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * Check if representor spawn info match devargs.
  *
@@ -1063,50 +1228,29 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
 		       struct rte_eth_devargs *eth_da)
 {
 	struct mlx5_switch_info *switch_info = &spawn->info;
-	unsigned int p, f;
-	uint16_t id;
-	uint16_t repr_id = mlx5_representor_id_encode(switch_info,
-						      eth_da->type);
+	unsigned int c;
+	bool ignore_ctrl_num = eth_da->nb_mh_controllers == 0 ||
+			       switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK;
 
-	/*
-	 * Assuming Multiport E-Switch device was detected,
-	 * if spawned port is an uplink, check if the port
-	 * was requested through representor devarg.
-	 */
-	if (mlx5_is_probed_port_on_mpesw_device(spawn) &&
-	    switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
-		for (p = 0; p < eth_da->nb_ports; ++p)
-			if (switch_info->port_name == eth_da->ports[p])
-				return true;
-		rte_errno = EBUSY;
-		return false;
-	}
 	switch (eth_da->type) {
 	case RTE_ETH_REPRESENTOR_PF:
-		/*
-		 * PF representors provided in devargs translate to uplink ports, but
-		 * if and only if the device is a part of MPESW device.
-		 */
-		if (!mlx5_is_probed_port_on_mpesw_device(spawn)) {
+		if (switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
 			rte_errno = EBUSY;
 			return false;
 		}
 		break;
 	case RTE_ETH_REPRESENTOR_SF:
-		if (!(spawn->info.port_name == -1 &&
-		      switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFHPF) &&
-		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_PFSF) {
+		if (!is_hpf(spawn) &&
+		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_PFSF &&
+		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
 			rte_errno = EBUSY;
 			return false;
 		}
 		break;
 	case RTE_ETH_REPRESENTOR_VF:
-		/* Allows HPF representor index -1 as exception. */
-		if (!(spawn->info.port_name == -1 &&
-		      switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFHPF) &&
-		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_PFVF) {
+		if (!is_hpf(spawn) &&
+		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_PFVF &&
+		    switch_info->name_type != MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
 			rte_errno = EBUSY;
 			return false;
 		}
@@ -1119,21 +1263,17 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
 		DRV_LOG(ERR, "unsupported representor type");
 		return false;
 	}
-	/* Check representor ID: */
-	for (p = 0; p < eth_da->nb_ports; ++p) {
-		if (!mlx5_is_probed_port_on_mpesw_device(spawn) && spawn->pf_bond < 0) {
-			/* For non-LAG mode, allow and ignore pf. */
-			switch_info->pf_num = eth_da->ports[p];
-			repr_id = mlx5_representor_id_encode(switch_info,
-							     eth_da->type);
-		}
-		for (f = 0; f < eth_da->nb_representor_ports; ++f) {
-			id = MLX5_REPRESENTOR_ID
-				(eth_da->ports[p], eth_da->type,
-				 eth_da->representor_ports[f]);
-			if (repr_id == id)
+	if (!ignore_ctrl_num) {
+		for (c = 0; c < eth_da->nb_mh_controllers; ++c) {
+			uint16_t ctrl_num = eth_da->mh_controllers[c];
+
+			if (spawn->info.ctrl_num == ctrl_num &&
+			    representor_match_port(spawn, eth_da))
 				return true;
 		}
+	} else {
+		if (representor_match_port(spawn, eth_da))
+			return true;
 	}
 	rte_errno = EBUSY;
 	return false;
@@ -1185,44 +1325,12 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	    !mlx5_representor_match(spawn, eth_da))
 		return NULL;
 	/* Build device name. */
-	if (spawn->pf_bond >= 0) {
-		/* Bonding device. */
-		if (!switch_info->representor) {
-			err = snprintf(name, sizeof(name), "%s_%s",
-				       dpdk_dev->name, spawn->phys_dev_name);
-		} else {
-			err = snprintf(name, sizeof(name), "%s_%s_representor_c%dpf%d%s%u",
-				dpdk_dev->name, spawn->phys_dev_name,
-				switch_info->ctrl_num,
-				switch_info->pf_num,
-				switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				switch_info->port_name);
-		}
-	} else if (mlx5_is_probed_port_on_mpesw_device(spawn)) {
-		/* MPESW device. */
-		if (switch_info->name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK) {
-			err = snprintf(name, sizeof(name), "%s_p%d",
-				       dpdk_dev->name, spawn->mpesw_port);
-		} else {
-			err = snprintf(name, sizeof(name), "%s_representor_c%dpf%d%s%u",
-				dpdk_dev->name,
-				switch_info->ctrl_num,
-				switch_info->pf_num,
-				switch_info->name_type ==
-				MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				switch_info->port_name);
-		}
-	} else {
-		/* Single device. */
-		if (!switch_info->representor)
-			strlcpy(name, dpdk_dev->name, sizeof(name));
-		else
-			err = snprintf(name, sizeof(name), "%s_representor_%s%u",
-				 dpdk_dev->name,
-				 switch_info->name_type ==
-				 MLX5_PHYS_PORT_NAME_TYPE_PFSF ? "sf" : "vf",
-				 switch_info->port_name);
+	err = build_port_name(dpdk_dev, spawn, name, sizeof(name));
+	if (err < 0) {
+		DRV_LOG(ERR, "Failed to build port name for IB device %s/%u",
+			spawn->phys_dev_name, spawn->phys_port);
+		rte_errno = EINVAL;
+		return NULL;
 	}
 	if (err >= (int)sizeof(name))
 		DRV_LOG(WARNING, "device name overflow %s", name);
@@ -2297,10 +2405,45 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
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
@@ -2611,8 +2754,6 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 					if (list[ns].info.port_name == mpesw) {
 						list[ns].info.master = 1;
 						list[ns].info.representor = 0;
-					} else if (mlx5_ignore_pf_representor(&eth_da)) {
-						continue;
 					} else {
 						list[ns].info.master = 0;
 						list[ns].info.representor = 1;
@@ -2629,17 +2770,14 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
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
@@ -2773,6 +2911,8 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 		}
 	}
 	MLX5_ASSERT(ns);
+	/* Calculate number of uplinks and host PFs for each matched IB device. */
+	calc_nb_uplinks_hpfs(ibv_match, nd, list, ns);
 	/*
 	 * Sort list to probe devices in natural order for users convenience
 	 * (i.e. master first, then representors from lowest to highest ID).
@@ -2780,16 +2920,12 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 	qsort(list, ns, sizeof(*list), mlx5_dev_spawn_data_cmp);
 	if (eth_da.type != RTE_ETH_REPRESENTOR_NONE) {
 		/* Set devargs default values. */
-		if (eth_da.nb_mh_controllers == 0) {
-			eth_da.nb_mh_controllers = 1;
-			eth_da.mh_controllers[0] = 0;
-		}
 		if (eth_da.nb_ports == 0 && ns > 0) {
 			if (list[0].pf_bond >= 0 && list[0].info.representor)
 				DRV_LOG(WARNING, "Representor on Bonding device should use pf#vf# syntax: %s",
 					pci_dev->device.devargs->args);
 			eth_da.nb_ports = 1;
-			eth_da.ports[0] = list[0].info.pf_num;
+			eth_da.ports[0] = list[0].info.port_name;
 		}
 		if (eth_da.nb_representor_ports == 0) {
 			eth_da.nb_representor_ports = 1;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c54266ec26..f69db11735 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -214,6 +214,8 @@ struct mlx5_dev_cap {
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

