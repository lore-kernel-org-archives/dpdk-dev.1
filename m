Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21495E9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F14440E21;
	Mon,  2 Mar 2026 12:35:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43]) by mails.dpdk.org (Postfix) with ESMTP id 7BD8E40E24
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:35:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAtbvKTQOVUtOJFl59aqoEiCc2bzwy0cESmDbuYK+Y4EQP3BrjUIOjmSFWcROgr0jKYezKVcLb0oibLkb+OH9RlHdTlb2kLmDdR33W1puND7GvLdyrhdKcjjkyX0ldVbFaXLj7M3Uxs38Dg9feBMwD9av/gL876F0LgV4Mv3Yu6JYTDDrYr5f7uEg0C0CbuV++86tiprGWcEAfobVPQL3miZ2BLZRZtTpKHU78RvVIsKBkhqL6o2TFUjNADOJEmtXak5S3Hb0Di5pG2wgUpFwB3O2CsTz3x97khxMT2rWjCFFlWJ3P6NAbHEYWOfxukzxTzqYmd4GlazTzGjO3wgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pimyw/H+u3CXzW9bNZTtx1LWgdG7LyImuOQNMvE/8j4=;
 b=JsEBC3l5G+ZWB9b/FTgJjX3XcHKcZLnDWrSbMHq8ZLY5KvBrB2BWl89IMOtyQtWd2DNI2qXg35heLs4ktWeGyoFR5hZ8Sd2Ol4gwZWqfqZ4LCIeSSa2Y54NFG8GXudLGG4VWUmWyC+PcWer5liTCYlvrMsSapPxMzv0WJsZsLhov8ACyazNB4CGoU9rsKErtOVqcd4xQecwLZmhBKk8rPM8A/88IeMjJNAvtxpqD0dbhQlTkEoVpBW75PElAcKSMGSpbMpwbp2tmqsTzDcgRlL+YMuDibmwp9Oc8q8X4upYLrNkz/p+Wts76nbnKCHlmOltKBFwnFmii0OT/QXwPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pimyw/H+u3CXzW9bNZTtx1LWgdG7LyImuOQNMvE/8j4=;
 b=lP055fLhWnWsUM0PMuLr5D7xPLffglk3QGBLZjY9CRGxh0fIipDRoU8UQMK2Eqa21HCfeAP5EnDA5xvoCHiysH2fwyUfYhH6wfzUy7yeXtjY7EKuazM1i8nUyeH+jD2f8c9TWahESUrXrsRq1rmNIwH1Cnr3QxXwADVcIaD5EnUb0UBrCcxSfPxrsUcXk6LNM44S+pZJJ3QQlr2clN21AvdKECYZ6JkMtRx0a5V/81W7DqCaayVEbfNzILnI6tr1fDDpEZmZbawsqDRBErZIThDvPw0mww9chPU0LQfgggdqF0lPZIo/0P6qyaTF1s1mD8lCHZktmRp30g+qj7C+XQ==
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 11:35:29 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::8c) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 11:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:13 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:11 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 4/5] net/mlx5: compare representors explicitly
Date: Mon, 2 Mar 2026 12:34:42 +0100
Message-ID: <20260302113443.16648-5-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 778507bf-8006-40df-c9b6-08de784fce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: 65GHsacf3lo7su7ikERdgUg5SGYenG1vilAA5ymYhn5oARBRapY5h2oCREncA4oJA9La2bvV/CSVTbfWKfF+SQRI6UdM9oVDXNSD36xDcubDIgToNeQ4nH5Mdh5RaI1Ihk3FexZ+u2Ua+mxmTAioWcHoh5ITUDVnDfjxpoBnvsN51vxp9gxemogQ1DNgAHJghARwdx7a5MYvBryExHvFjemc5hxLMkgDprBwy11+cO+oE+wDOan7CAICPYTVD6IsRnZ65ux5NRTks6O0Yd5a2wFrNwAZECMJsZyAifvIpcwUhOOIc1klaRLdmf8Mv6vfDSWOzwkfLA/wFLVKHwLCWom/V+qoFngxKU9sgtdr20clX1ar1swHCq0x1nemY8u+vDoxZkJtGinrrxCnIn6z9uBelztGpImIlopWSKIdBwejNxDrat9l/p25SM7e934kcONTUCIjoqj72gOdNup2n6y7Ekmhrs19L55JRrbLJVnT5XHmrXh09OAQ9SpS1NvZhPn7qBALfERBrsl7OemDD7+BMzfhep8tk4CQ4sYlou2Ibq8HX3CqibMAWmVoVu8IOZ7qu7EafnMHjSM/QMtMOSaWyBwcU3P+D45UKk9mmnvmG8qo9AV+evAIz5IB5xbL6erCsX+4h3gCVNEpuFMNx5wX2fcgLoXMcoqgHnn6+hOvkjJeQqxEFG79Q//fKAZX59Ie8SzI2ReeJT2W8zDIe1nP4mSxo8UTBJWfriSpvJ6FBhzeMx3zPIAKgsuiwS9MsNpsB2B+1BFClsrcjVba5RiDNnFLKeeigykA4qzJEYY7pwQU95QryE1ZnG3x8OpQRmhTWXceLtzYGxNKJzQcog==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VpZ+Mv/qBrEbMT/smJBisWyl3wB0Y1QUIuQPoJkTambcgHTMfpJW99+krSplRJPzZCYp+tV5JwBkNpgl+jJr4J5FQNPK1vA3iz9rDS+7dIAPHPrnSEObLqHk0BeBeJGktPkMaifmsUR0wcaMKk8McIf2HbFIdmxG3F6ulcZrsRQSR8pad33Z3Q9EGvQWhCLGqCkvAvcc25+GeSajxbzfZpPhtbl/dQeqj6hD41MhuM+bmt0JODubigVhv9aiN1M9h8EE7FJHNqaDu1IG4/He9G1TOFO4F9akNKB1f1B5hNjLEXnSu8EcxOGyGDCrOHiD2S0FZ4ujStAYtSyPWJRnp6aSd7ipR4oovbJ02TlBE8KBnmY8cfMvor3S2SK7npYekucspU9dWHztk6euaBGmngJnkNF1av1twcTszypyc7X81Cz511ofJWOM/l37gAln
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:29.5204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778507bf-8006-40df-c9b6-08de784fce93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

When probing ethdev ports in mlx5 PMD, driver attempted to
match IB ports to passed representor devarg values.
Specifically, for each IB port found on matching IB device
(matching through PCI/auxiliary bus) mlx5 PMD did:

- find corresponding linux netdev,
- read and parsed "phys_port_name" through netlink/sysfs,
- compared parsed info to representor devarg.

Comparison was done through representor ID calculation.
This representor ID however ignored the controller index
requested through devargs or parsed from phys_port_name.
On setups with multiple PCI controllers available
(such as BlueField with Socket Direct),
this could lead to collisions on PF and VF/SF indexes.

This patch reworks the comparison to rely on explicit
values parsed from representor devarg and "phys_port_name".
Controller index, port index and representor index
from representor devarg will be compared against
controller index, PF index and VF/SF index found in IB port data.

If controller index is skipped in representor devarg,
controller index comparison will be skipped as well
and first matching IB port will be selected.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 154 ++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 53 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index f9f3b2c38b..d30106c4c5 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1053,6 +1053,87 @@ mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
 	return (eth_da->flags & RTE_ETH_DEVARG_REPRESENTOR_IGNORE_PF) != 0;
 }
 
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
@@ -1069,54 +1150,29 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
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
-		if (!switch_info->master && mlx5_ignore_pf_representor(eth_da)) {
-			rte_errno = EBUSY;
-			return false;
-		}
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
@@ -1129,21 +1185,17 @@ mlx5_representor_match(struct mlx5_dev_spawn_data *spawn,
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
@@ -2822,16 +2874,12 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
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
-- 
2.47.3

