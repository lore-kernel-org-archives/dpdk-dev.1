Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D3FEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E1F40E1F;
	Wed, 25 Mar 2026 10:08:49 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by mails.dpdk.org (Postfix) with ESMTP id 1E3A340E1F
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0zfa0+/qA5mo6CfhqqM97Zcmy+IrE+/E9/k4kANBQh5aVwxskpdTCu6l6ZRtIKwejsNTeUzTZKJ112Az+Y6Zr7hf+sv29MngezADCI4SUydjX43JPaE1o4zbQg8FT8cwMPFtvrASZGhz9b2K0/YBNhEcuNLrBClD39hWQf08SMQtNRUh0pIq/Df0XDIEmRzENlCmg9gySa4B8PJ+qBw60cONpvl6W8Sp7C/mBkiF5EvvdZ1FKNFUL7CHmAhtGDTbtM8769+pzU4sV4Cw9TN7ALi+BvloGkAdrZy7UyjZIro7zPAjYxeCX2aBEmMD0nLXQiv3pU8YiWqi+09zV/hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0ihPDpa45agDfp6e2XYQn5q6dJZg3aKVwdhFC/z+Ng=;
 b=T9nqoq/hx/Cc/8SaGpeTOFn7Gn8Jj+4nNeKDfhvHGl21Dc64Xilo756bT5Jdq2qKDSsi0oU9Q1UKDV1rxslqXXaEJZCE5Uukl6dui3g08/X19EzJVchcQcD8NyV8fkplOCn8vJWekPO4JJt5tZ28yf/5KO2GkcXbRLltrwfCRGYn5lwOEgHZgroG82LqcheYshxz09sgRkbe45RxQHzRlD71fcuCrhlYRlF+gfrfilw3vItYI127D7WcIuSpg3T7ECC9XQfreC2qY27UxWNEoDYAjG1tqL3FIx5B9J4EEE/+CXd/1gmdbvKKgvJLCCo+ET348AKeDEkIACDWhahA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0ihPDpa45agDfp6e2XYQn5q6dJZg3aKVwdhFC/z+Ng=;
 b=mN2v2N+RwuFvNZkJ1BTi+AClav51nMwOWMXxdhBYGAYnaUzfqh5JQqfYcsmfbi14BaMv05PuKhL7XjVrKtaHvQ4lB/ZdUyyp40Mcf1ODuWrIrklgWFdJVt/d7En+W8gJOQqn4z5SLwR2mFrhpIr5aW+MjJ6duwRe0lGrtecframjSgzlFL8KWG82zsQlatQcxVH9BwBvK1X/wGJ08MAaWq6uVwtbSIZcI9e2+feewEPGnOndC+W3JhGk6HrFLlDt70uQi3kpjGr6PWn4+riOAUhvqP0XbUv+Y+7pJZiIrWIFhdaM44Zm6nUom23iv079kdiPGTnX2DGeKpwMzwtRbQ==
Received: from BL1P223CA0040.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::13)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:43 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::d4) by BL1P223CA0040.outlook.office365.com
 (2603:10b6:208:5b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Wed,
 25 Mar 2026 09:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:08:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:30 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 4/5] net/mlx5/hws: add source vport match in HWS
Date: Wed, 25 Mar 2026 10:07:56 +0100
Message-ID: <20260325090758.42403-5-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd4ec41-302a-4882-e486-08de8a4e1cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JnzOf7WkPGzp7iceR3gT7ygVS+lzTgkYpp3NeQq3+dL876YdLHecVBXBa32lcf1Xl8qUkP0w/fjnw6wJGjbjnf4DrTxZvAICC9ibl5bCRbWoOK+Lqu9b+OAofjRNLhUTaYFZOKWsxYsBubnZOiYCg8mr4qB6rCaAVOL3tjeOJdP/MWTnSKxv6Wn7OcaA0YPJLSZUgm/PtQR91kkdik5ma4AAnNiN/C4hdWuGmOSZ6HD/i0dcf+TuJwLyT0brMmJkShHcV7ectYfWl8ZeqFMMEu/0etkVREVfuzGrgIUi/UG2tWUW4sXJRUeXhkMkVR2lA+DWZS0v65XUpsp/7EgECkeiqOX4cMtTG83vgh35bcj9U5BmXgRhKVkfIQrHsacd1VRJO3cEHF98Ray0rfJxxLgyMBYEfuMxALZLtNpk14Bc0yLdca07Q1MzGrdg89ek4llkmHqcfppS6p0RqQTOdYrbYMRE+tSCXRAO7Oqrs7k+kjD37glWvmS8EP21uMrOVi6XvMn2WL9n00CITmKP9atMJFIG/SP7knuvSfixP1cyvfWsWZz9knYVy6et+CtcGRiAVuuRXUrMJDS5Wva6QSazxCheCIzvmub9+M/aylc957XgdkzFzR+jC/uLxk0KdYyitWwnGYMuKf8dkCvdObpoWgqWN6itYibjv97dTDv/sOBZvAEoI+8RcH6+EHsfm4p8nxciC8Cp2EUMJDdF+HJ3L8w52nW73wSVFQE21NtZJpkXIBHTG40pCmBrutMOwF/BfJ6p6PKI61uAFq+JqA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5oloLgnwkuvCQooJrkMOkMico8bO3S/pplUlNVgiRhjJVo+u/EHEo7ULrHg+h+UQ19lZVZXRci01Ju3ZaC9dE0UbUY7FVp7QJX9kVKhPWXWereo3Iyawi/a4vEpIVrM6k3gUigimOT0zXjPGiSJdzw21rKDk6mxseQfu7LRn30gIUmurvHmzECJuxl6J25zpciTj6Ty0oezVEpnqRsmpAa4Z/eq2GFByG6kDnCbzjb8qZtifqCGy1wQl7ksGhACzQEknlKMPSZkrohslp6uYMgBpxY+SpcLgjsVhEyheyPW36x7WrG/csxRuw38vRJFNHS44Vh5rAN/qnl9UffSHK1g2BZEtAEbeipX/ZCVcICoNWYainQhthHIkOPIWqQQHk6vps71ZKFgG2hVAZbxhEbvbJY77mPBp0Rc9Iqte+JYv+PhJ7wP2EDfjtnyOYUyO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:42.8456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd4ec41-302a-4882-e486-08de8a4e1cea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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

Matching source vport without having vport metadata available
requires matching on 2 fields:

- source_gvmi - equal to VHCA ID property of the port,
- functional_lb

There are following cases:

- If packet comes from PF/VF/SF, then it originated on some Tx queue on
  the host. In this case, source_gvmi will be populated with
  the ID of the originating function.
- If packet comes from the wire, then source_gvmi will be set to 0.

There is one edge case - discriminating packets coming from PF0 and
from wire. In this case, both packets will have source_gvmi set to 0.
Distinguishing them requires additional match on functional_lb.
If packet comes from PF, functional_lb will be set to 1.
This only happens when packet was sent from PF to FDB, and
then moved to PF again.

Because of all of the above:

- Unified FDB must be disabled when vport metadata is disabled,
  because packet from PF0 and from wire will not have
  correct functional_lb set yet when flow rules in FDB are processed.
- Without unified FDB, when separate FDB_RX and FDB_TX tables are used
  internally, match on functional_lb is not needed.
  Table type already defines the direction.
- NIC_TX tables belong to a single GVMI and as a result
  vport matching is not needed there.

As a result, functional_lb match is only required on NIC_RX.

This patch adds support for source_gvmi and functional_lb matching
in HWS layer.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 65 +++++++++++++++++++++++++--
 drivers/net/mlx5/hws/mlx5dr_definer.h |  2 +
 drivers/net/mlx5/hws/mlx5dr_table.c   |  6 +++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 3ba69c1001..7400b8f252 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -6,6 +6,8 @@
 
 #include "mlx5dr_internal.h"
 
+#define WIRE_GVMI	0
+#define BAD_GVMI	0xFFFF
 #define GTP_PDU_SC	0x85
 #define BAD_PORT	0xBAD
 #define BAD_SQN		0xBAD
@@ -789,6 +791,49 @@ mlx5dr_definer_vport_set(struct mlx5dr_definer_fc *fc,
 	DR_SET(tag, regc_value, fc->byte_off, fc->bit_off, fc->bit_mask);
 }
 
+static void
+mlx5dr_definer_source_gvmi_set(struct mlx5dr_definer_fc *fc,
+			       const void *item_spec,
+			       uint8_t *tag)
+{
+	const struct rte_flow_item_ethdev *v = item_spec;
+	const struct flow_hw_port_info *port_info;
+	uint32_t source_gvmi;
+
+	if (v) {
+		port_info = flow_hw_conv_port_id(fc->dr_ctx, v->port_id);
+		assert(port_info != NULL);
+		if (port_info->is_wire)
+			source_gvmi = WIRE_GVMI;
+		else
+			source_gvmi = port_info->vhca_id;
+	} else {
+		source_gvmi = BAD_GVMI;
+	}
+
+	DR_SET(tag, source_gvmi, fc->byte_off, fc->bit_off, fc->bit_mask);
+}
+
+static void
+mlx5dr_definer_functional_lb_set(struct mlx5dr_definer_fc *fc,
+				 const void *item_spec,
+				 uint8_t *tag)
+{
+	const struct rte_flow_item_ethdev *v = item_spec;
+	const struct flow_hw_port_info *port_info;
+	uint32_t functional_lb;
+
+	if (v) {
+		port_info = flow_hw_conv_port_id(fc->dr_ctx, v->port_id);
+		assert(port_info != NULL);
+		functional_lb = !port_info->is_wire;
+	} else {
+		functional_lb = 0;
+	}
+
+	DR_SET(tag, functional_lb, fc->byte_off, fc->bit_off, fc->bit_mask);
+}
+
 static struct mlx5dr_definer_fc *
 mlx5dr_definer_get_mpls_fc(struct mlx5dr_definer_conv_data *cd, bool inner)
 {
@@ -1610,10 +1655,22 @@ mlx5dr_definer_conv_item_port(struct mlx5dr_definer_conv_data *cd,
 			fc->bit_mask = caps->wire_regc_mask >> fc->bit_off;
 			fc->dr_ctx = cd->ctx;
 		} else {
-			/* TODO */
-			DR_LOG(ERR, "Port ID item with legacy vport match is not implemented");
-			rte_errno = ENOTSUP;
-			return rte_errno;
+			fc = &cd->fc[MLX5DR_DEFINER_FNAME_SOURCE_GVMI];
+			fc->item_idx = item_idx;
+			fc->tag_set = &mlx5dr_definer_source_gvmi_set;
+			fc->tag_mask_set = &mlx5dr_definer_ones_set;
+			DR_CALC_SET_HDR(fc, source_qp_gvmi, source_gvmi);
+			fc->dr_ctx = cd->ctx;
+
+			if (cd->table_type != MLX5DR_TABLE_TYPE_NIC_RX)
+				return 0;
+
+			fc = &cd->fc[MLX5DR_DEFINER_FNAME_FUNCTIONAL_LB];
+			fc->item_idx = item_idx;
+			fc->tag_set = &mlx5dr_definer_functional_lb_set;
+			fc->tag_mask_set = &mlx5dr_definer_ones_set;
+			DR_CALC_SET_HDR(fc, source_qp_gvmi, functional_lb);
+			fc->dr_ctx = cd->ctx;
 		}
 	}
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.h b/drivers/net/mlx5/hws/mlx5dr_definer.h
index d0c99399ae..f5d6cce887 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.h
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.h
@@ -214,6 +214,8 @@ enum mlx5dr_definer_fname {
 	MLX5DR_DEFINER_FNAME_PTYPE_FRAG_O,
 	MLX5DR_DEFINER_FNAME_PTYPE_FRAG_I,
 	MLX5DR_DEFINER_FNAME_RANDOM_NUM,
+	MLX5DR_DEFINER_FNAME_SOURCE_GVMI,
+	MLX5DR_DEFINER_FNAME_FUNCTIONAL_LB,
 	MLX5DR_DEFINER_FNAME_MAX,
 };
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_table.c b/drivers/net/mlx5/hws/mlx5dr_table.c
index 41ffaa19e3..14e983a363 100644
--- a/drivers/net/mlx5/hws/mlx5dr_table.c
+++ b/drivers/net/mlx5/hws/mlx5dr_table.c
@@ -468,6 +468,12 @@ struct mlx5dr_table *mlx5dr_table_create(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
+	if (attr->type == MLX5DR_TABLE_TYPE_FDB_UNIFIED && !ctx->caps->vport_metadata_match) {
+		DR_LOG(ERR, "Table type %d requires vport metadata to be enabled", attr->type);
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
 	if ((mlx5dr_table_is_fdb_any(attr->type) && attr->type != MLX5DR_TABLE_TYPE_FDB) &&
 	    !attr->level) {
 		DR_LOG(ERR, "Table type %d not supported by root table", attr->type);
-- 
2.47.3

