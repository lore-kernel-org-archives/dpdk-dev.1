Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E9FEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5351A40E0B;
	Wed, 25 Mar 2026 10:08:42 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33]) by mails.dpdk.org (Postfix) with ESMTP id 8463C40E17
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+s8RYVFJNdNphtzHqawfthaPueCouw0jaGDKV1Ejix4zs3rRULrqbLt5KXSwR87YobJwsjuMc4KNAJx7NCAfSBmPVgq/quqWTj+8xj0NJrnLH2vK6Aq57/H2oDR6CjwrT6NbOP6wPHSZnVhPvHNIgcmx9LovSlL+1NzpLvVi8tX4XP3LOdA9ygrZx/wtb90iFtoEx5obMVQza/GMiOQJKbsUr23VQvNevaldGJ2x/Av/pqsg7Rubk0l9PcKHWYKDjoTxeTtvdK9LDY7Y4tuqroGevCScZ2o/9nMPCAW7xa1SXOY6YaRuoRRr+aGtMO8KYtZtpHzPkcJwV0cP366PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJJykKkv+Kt+G1lvkfVoHIIZp2f13edPgDUX9+E1eik=;
 b=TIi/Nrqw4jvLPptSq4hRXlFaN6VJuDB3xsS+0fm+86uWNz97HEjwzNLHFTJkxShOzgdQRbHZSZaRkaXfCgImEbyCJ+Fq+PAHWK7S6zLyQMOtvWYsBB5dtQaeBuiJTPqjPWzd0WS6ujv7uY9P/GHDr81BLtrhP9IUv0HKKFDea0MGm/jgEvxngRYCgHYo7qEeEaBlh4CYCbnPyc8mKBxyJ53ReT+gqji2aP7Xy3ujNdJ7j1544S9RtR644C67vbEE47xQFQHUdupl3pecr3XlbNZ0zFY46bPjPPXV4usR0bthfgZ/S1XUi0brykDSpsBlb4DH18WighXbA0s4seQccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJJykKkv+Kt+G1lvkfVoHIIZp2f13edPgDUX9+E1eik=;
 b=Iz9E7d0JvmJrxs8T1efMLakNOyd+1rid9safKoPwDLcR1XpbMXD+p19G4Q/j+BgD5CujDQTwTyoWaxt2l8/gWLlay3axzRnlR59qBD9Q9OcKytJzHBtiDX5civOEzjHF0Rf1QoZOtscMCtIhstD+lw+Z5sFkYs4vSlUGD6pwe/FaBSH5eo+S7JY0UIMpogeaAcYafgjeAtTB4OqYtf9+yXbsyPj0XLIBXNCg/JMr6RiUsdvc3yKx5V9Qjev2RJ5I64TZ52stULj3OcslDkeDr6SDPFORisAb8dja70VxPvr3ZscAKbS+fISHIOmeYChbL7Xw0bxcySlwnQQD4Z6CXg==
Received: from CH2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:5a::14)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:36 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::29) by CH2PR08CA0004.outlook.office365.com
 (2603:10b6:610:5a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Wed,
 25 Mar 2026 09:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:08:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:23 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:19 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 3/5] net/mlx5: return port info regardless of register
 mask
Date: Wed, 25 Mar 2026 10:07:55 +0100
Message-ID: <20260325090758.42403-4-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325090758.42403-1-dsosnowski@nvidia.com>
References: <20260325090758.42403-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 5045e992-e08e-404c-3a9d-08de8a4e1855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: J1Q0cwOi7jsVwyiBWy3iwkHtr2JQ97xz7FL3xaC9SeC6MUvlK5KJaGiF61nKAIiEdnEhW+0Wn8paVjYckkVAClxa8xiM2o+8VHzeS7rkMJzCYylT4mcLmKjqKWQ3Up0faitJdeJoggzXWuXTPQ2UecKn8viACTv8SH2gYSoZWJc0gbQT6ikG8JCk+anMXAfLv4zon+pHBOVZrrARzvEAQgV0CljwsBu32dfQ/I4JGnIQs52yRoUaYXR+Ynyq44wZpbqKWkirOXAZUS8+v3+gg/3kN/OkJct3jxJZo2v0ig301HiFR2Rqjdq3IuRf+6yKN76uj4Jxy4oxH6iTZAB58j3PRM0j2wM6Rrq49eWHd8HuWPGHRX0kbaSUhk9d7usPHzYelADkuPJ65P405iHK3lzbksCrMa5PvnWrMRkTtJGvIxb13KIegoFebOXTZWJexKDkHenp0SAPSr1qPNTA8eB2urlBsrkSEXDvTXhm3uJcVxfYUfVhweTp/JCiid7B9Ko/Bl9o0lJ5qrg7d3p3SUGhoUeUuwzzZI9KpRdDxQ7bivb/g8tHBIf4yIc2HkpzgsRTEX0m4fXhEtcRvnlkaLf5tx+Ct6S62wjAwtDJoAAx713xzlJaSz6F2LrIoZMIzh0jvzayssUqK7d/3kfhrrgh38/UCrOFz58XO+XML6laaYs+SxX3PRSvoaafXBevZgA8kEWeVW38p4oGJ7FvNrNThpq5o8Bfe+iySOkBFjJTr++hzm6tcYGrZhmpgHTnSx97VUI1w8e3LrqAJBnkkQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PVjB+4DvSzMe5CbKzERs0dRr9RZBaIm/Bmc67RC8RkxDpBjusNVbaD83h+wDwFic5hUuFbl/gwuYddGtuZ0YHBU2y3geNgRr4AW6xRdZG2VmIqfUbTIR5s95PoR/rFB3tTY3w/MIq1dK8zG9mmdWQhBWzVGyOUN4ie1O+ucI2OKbbLndU6XN5NVV6G4vCaMEIjt8M2v3IBRgkzXQiM3Lcn28moX48UkWIO6CdvjuXYbFKNCo9g73n2rXLu4GgRh75oWQbqkRSCFsGfTHW1GzdP0YHUqgnu/fbjzQNIYpO8Db8kKA09QMxP0UD2uMBhl9AfZuHt8S9G7VbwZTPp0trT7ATB7DLChqS97e4UQ8Xmm+v1UTW4mvw8htIYVsQvn6eTfH9nP7KX8w6FsJr7Wcc9RolNsffsZ0MTGCL0abqhBRi/+rkYg8kyrlSD2c7lLJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:35.2119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5045e992-e08e-404c-3a9d-08de8a4e1855
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

Previously if the port info did not have REG_C mask set,
flow_hw_conv_port_id() returned NULL.
In order to allow for support of legacy source vport match,
this patch changes that logic.

Now flow port info will be returned for all ports,
regardless of REG_C mask value.

HWS layer, depending on REG_C mask value (zero or non-zero)
will decide which matching mode should be used for
REPRESENTED_PORT items.
If REG_C mask is available, metadata matching will be used.
Otherwise, legacy source vport match will be used.
Definer handling for legacy source vport match
will be added in the follow up commit.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_cmd.c     | 13 +++++++--
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  1 +
 drivers/net/mlx5/hws/mlx5dr_definer.c | 38 ++++++++++++++++-----------
 drivers/net/mlx5/linux/mlx5_os.c      |  1 +
 drivers/net/mlx5/mlx5.h               |  1 +
 drivers/net/mlx5/mlx5_flow.h          |  3 ++-
 drivers/net/mlx5/mlx5_flow_hw.c       |  1 +
 7 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c b/drivers/net/mlx5/hws/mlx5dr_cmd.c
index 47e6a1fd49..668e409988 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
@@ -1363,10 +1363,19 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
 	strlcpy(caps->fw_ver, attr_ex.orig_attr.fw_ver, sizeof(caps->fw_ver));
 
 	port_info = flow_hw_get_wire_port(ctx);
-	if (port_info)
+	if (port_info) {
 		caps->wire_regc_mask = port_info->regc_mask;
-	else
+		/*
+		 * If REG_C_0 vport mask is available, then we can assume that vport metadata is
+		 * enabled on the switchdev.
+		 */
+		caps->vport_metadata_match = !!port_info->regc_mask;
+		DR_LOG(DEBUG, "ibdev %s vport metadata match is %sabled",
+		       ctx->device->name,
+		       caps->vport_metadata_match ? "en" : "dis");
+	} else {
 		DR_LOG(INFO, "Failed to query wire port regc value");
+	}
 
 	return ret;
 }
diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.h b/drivers/net/mlx5/hws/mlx5dr_cmd.h
index eb9643c555..3ed7c6ecb7 100644
--- a/drivers/net/mlx5/hws/mlx5dr_cmd.h
+++ b/drivers/net/mlx5/hws/mlx5dr_cmd.h
@@ -207,6 +207,7 @@ struct mlx5dr_cmd_generate_wqe_attr {
 
 struct mlx5dr_cmd_query_caps {
 	uint32_t wire_regc_mask;
+	bool vport_metadata_match;
 	uint32_t flex_protocols;
 	uint8_t wqe_based_update;
 	uint8_t rtc_reparse_mode;
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 6a016de78e..3ba69c1001 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -777,12 +777,13 @@ mlx5dr_definer_vport_set(struct mlx5dr_definer_fc *fc,
 	const struct flow_hw_port_info *port_info = NULL;
 	uint32_t regc_value;
 
-	if (v)
+	if (v) {
 		port_info = flow_hw_conv_port_id(fc->dr_ctx, v->port_id);
-	if (unlikely(!port_info))
-		regc_value = BAD_PORT;
-	else
+		assert(port_info != NULL);
 		regc_value = port_info->regc_value >> fc->bit_off;
+	} else {
+		regc_value = BAD_PORT;
+	}
 
 	/* Bit offset is set to 0 to since regc value is 32bit */
 	DR_SET(tag, regc_value, fc->byte_off, fc->bit_off, fc->bit_mask);
@@ -1593,20 +1594,27 @@ mlx5dr_definer_conv_item_port(struct mlx5dr_definer_conv_data *cd,
 	struct mlx5dr_definer_fc *fc;
 
 	if (port_id) {
-		if (!caps->wire_regc_mask) {
-			DR_LOG(ERR, "Port ID item not supported, missing wire REGC mask");
+		if (caps->vport_metadata_match) {
+			if (!caps->wire_regc_mask) {
+				DR_LOG(ERR, "Port ID item not supported, missing wire REGC mask");
+				rte_errno = ENOTSUP;
+				return rte_errno;
+			}
+
+			fc = &cd->fc[MLX5DR_DEFINER_FNAME_VPORT_REG_C_0];
+			fc->item_idx = item_idx;
+			fc->tag_set = &mlx5dr_definer_vport_set;
+			fc->tag_mask_set = &mlx5dr_definer_ones_set;
+			DR_CALC_SET_HDR(fc, registers, register_c_0);
+			fc->bit_off = rte_ctz32(caps->wire_regc_mask);
+			fc->bit_mask = caps->wire_regc_mask >> fc->bit_off;
+			fc->dr_ctx = cd->ctx;
+		} else {
+			/* TODO */
+			DR_LOG(ERR, "Port ID item with legacy vport match is not implemented");
 			rte_errno = ENOTSUP;
 			return rte_errno;
 		}
-
-		fc = &cd->fc[MLX5DR_DEFINER_FNAME_VPORT_REG_C_0];
-		fc->item_idx = item_idx;
-		fc->tag_set = &mlx5dr_definer_vport_set;
-		fc->tag_mask_set = &mlx5dr_definer_ones_set;
-		DR_CALC_SET_HDR(fc, registers, register_c_0);
-		fc->bit_off = rte_ctz32(caps->wire_regc_mask);
-		fc->bit_mask = caps->wire_regc_mask >> fc->bit_off;
-		fc->dr_ctx = cd->ctx;
 	}
 
 	return 0;
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 3a9b019601..75a2936023 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -387,6 +387,7 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	sh->dev_cap.esw_info.regc_value = 0;
 	sh->dev_cap.esw_info.regc_mask = 0;
 #endif
+	sh->dev_cap.esw_info.is_set = 1;
 	return 0;
 }
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7ae9129e46..8cd6562633 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -153,6 +153,7 @@ struct flow_hw_port_info {
 	uint32_t regc_mask;
 	uint32_t regc_value;
 	uint32_t vhca_id;
+	uint32_t is_set:1;
 	uint32_t is_wire:1;
 	uint32_t direction:2;
 };
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 4c56e638ab..c9e72a33d6 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -2156,8 +2156,9 @@ flow_hw_conv_port_id(void *ctx, const uint16_t port_id)
 
 	if (port_id >= RTE_MAX_ETHPORTS)
 		return NULL;
+
 	port_info = &mlx5_flow_hw_port_infos[port_id];
-	return !!port_info->regc_mask ? port_info : NULL;
+	return port_info->is_set ? port_info : NULL;
 }
 
 #ifdef HAVE_IBV_FLOW_DV_SUPPORT
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index adbd4f33b0..4871594c35 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -12307,6 +12307,7 @@ mlx5_flow_hw_set_port_info(struct rte_eth_dev *dev)
 	info->regc_value = priv->vport_meta_tag;
 	info->vhca_id = priv->vport_vhca_id;
 	info->is_wire = mlx5_is_port_on_mpesw_device(priv) ? priv->mpesw_uplink : priv->master;
+	info->is_set = 1;
 }
 
 /* Clears vport tag and mask used for HWS rules. */
-- 
2.47.3

