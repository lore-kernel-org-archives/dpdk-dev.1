Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE7C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 11:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A11C140E17;
	Sun, 16 Feb 2025 12:05:29 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by mails.dpdk.org (Postfix) with ESMTP id 7082F40DCE
 for <dev@dpdk.org>; Sun, 16 Feb 2025 12:05:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIwZtW6rl+V0vmpgd/fN3AkdvWy96zKK4NhoxNDeezp20dtLKryiU7LoVeCCgaAvDonVd+L+6Evjgdg5GMCA6RxFXw2O+MEEaj5RUGcbVFTVQmCcohwXNK4DbTIHIwHTxc9OpF0Prm1w5CyWW9lU8GwDs+o3MTDcDqMdYDbpkGCwO8YKTdKltKdg2jLd7QNYyrbouiW5h8XfGN9R3/ZOCHMjubp320bPY63t//AIs8EYCUDQD6ob2xVqdq2jrWxJTJJ39eLp3u/Fkk+VvHqQWhGQ8AB5I8zcUlsRaz/qSMtLGG+QRQhaUzw02zrfKTycleG1iVtP4JT0UXMy97lQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9evtpE1aKRhHihr6UyS0DK2FHikAj32d4K9zWo15Mw=;
 b=XDZZRXMlbVoHSP2IR4Qf1sZVTdg/ZXgTu/3pj5BQPMQkhSJRbMJ+/WXMH4GOxfIxhK/nOrX2Y9U3x6O9hKeMf77Owscftrb7H9RL45vja3RWBQ5G7szPkupQyxiZjxZHTuyt2lj+7rUKukcUnthx58mYaBwIydzRtgwK2/h2U9Ll2qRSW4QLQfquaoAIWl3NpUeiDESGmmv8q+uyB8rW11lKjI81DUNS3gBQa/QC1dmUKGHV6hcZMh+ARDrEjZQVFWzxjP/E7SU7psCMVEQL4YcRWUD+Cpzqe2qNbtoYM4PR51/rxZ1W1ruAwJo9yY0HGEzMgmbmuoA+z6LHwW/RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9evtpE1aKRhHihr6UyS0DK2FHikAj32d4K9zWo15Mw=;
 b=fmkOueyEfaFgPubBNelm+lc5l4Z1byMSZ/emCaJG1UHYKKD4txOTIQ4Zh4MCiARBASKAWKDQeQ49D61OD9Avwb/6dJ078iZHXUE4YZCziYAJDtgbc2yrOnfcNgAKKkVzd99Vy9zmL4LNFWkHOTMEvcNQ+I2T2YH6M2JVqtw9c27BczFoBQU3oGSg9FzpdrpTMHj90tXduHzyMrLJktZsrKQY4G8MLtSdu97ajR0GaihPSZvfMvnf8kj5gMbmUFus5avdE6xJn7Mqw2U1XUYnt8tOn6quQiCd64L8g76LKiCRJwYaxDITqLsQ+jtEqa7UHghFysb1EI4PU5bKwW1rHw==
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Sun, 16 Feb
 2025 11:05:23 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::86) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Sun,
 16 Feb 2025 11:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 11:05:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 03:05:07 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 03:05:04 -0800
From: Hamdan Igbaria <hamdani@nvidia.com>
To: <hamdani@nvidia.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 <suanmingm@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH 6/8] net/mlx5/hws: action changes to support unified domain
Date: Sun, 16 Feb 2025 13:04:12 +0200
Message-ID: <20250216110414.10926-6-hamdani@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250216110414.10926-1-hamdani@nvidia.com>
References: <20250216110414.10926-1-hamdani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2f8ad0-e984-4b17-99c8-08dd4e79cf2c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ij6RkyCfBfBE+5iV47lUqspGAeLZDVAxnyMz18/GDP1jkZ74o2k0p8hvh2IT?=
 =?us-ascii?Q?ldhtUwAvCT6e5XO2HxDSlG4ptsFLJuzg/5uekNB9vaLgl2QWpy+f8FBz7x4b?=
 =?us-ascii?Q?FykrSX69TtpKUrgPhWLLQ5wMG2b1mW657fal7wHxy+gOx/OoOvmORia6Hznr?=
 =?us-ascii?Q?Fl4tXoc70n7mDaSlgTXtqBPT2GX/DCN8izTbVtpSukcJV38nN/00k09rFQc/?=
 =?us-ascii?Q?vOfkXHttx0yuR7R0Ia2bUxberojjsYFRJzEBYZ4lc3bX5jgVEPtY9ap2bKD9?=
 =?us-ascii?Q?ESU5ITTv6MD8ueLcSA/fH3IN3URfq3De3HFw4FiaXzydqFwECzhs4a/ZEUbw?=
 =?us-ascii?Q?eEu5OBYd7HbGSYTSt1jUmAb7St9IsvSko8jm0gRdoQ87az4MTRqx5USM4sN5?=
 =?us-ascii?Q?lB4N2l6f62/p/EbP5OYCA/cBvZdjfhMk2xFwZ3cda70ubJqcR/Ecm07Fts0y?=
 =?us-ascii?Q?9Sdfkp5Y7tJNCLQm70P1e1olks3LPTIEvEq/kgRfVNS75uroQKDqs0imIp/a?=
 =?us-ascii?Q?EtwDTNcAj7C+zVoRWNH6Vu85Q7ygoyoEQLuwWkmt+KOr57BCHLUCfhaoFft+?=
 =?us-ascii?Q?x59MCK2/6s0SMTl7qC13fH05427txp+Wppn4LWpAUZS9pltKo6cXJ8lbKS+c?=
 =?us-ascii?Q?xSdWLlUVxSt5SieU09ho06uHNJTGLwCmJtKnnGgW1k1sQ77GrGyio5byf8y5?=
 =?us-ascii?Q?wWkD/VgyNPlmCkl1SajWZIFQWl/9c+8ea3ZZxmjdlnpQuKtFgdf+TRZPJLvy?=
 =?us-ascii?Q?7Il1axKRqCtXpYjWhKdJVcUWClwuSfW/EI8nfXs+aL8YwIp+uNNud8fQEtdn?=
 =?us-ascii?Q?i0ueIxnd4/aVlQuDQ8cT+6GZ6mRwIIN2CoLlrcFaQaVdU6ovwVBrg+f109PL?=
 =?us-ascii?Q?RAVP9ZsJfwigaIl/k/8It4izXm7+7DVN1STaR7rvXMGu70ASq+cRhBYaVoCq?=
 =?us-ascii?Q?42WzD936mhffd5G2NZ28jmJ/4npjkmGD1My2syeD3yBI817TzMbXjrwMedqH?=
 =?us-ascii?Q?1AnssFkVbL24fEBDERjNxzJqvQlRhW/OrrD1grfyT2HqOG00Hwau1Na9/fn0?=
 =?us-ascii?Q?GwMi44MWjfbqdlTg3V26jamkuoXyuOB+6qOJD6h+0JQdfVaHz+scsjO98ie3?=
 =?us-ascii?Q?xOis4JMG7OFrXmJzSY1s2Ty9dF06IIkDWbNykoQwJ3bVdNIZr2qR23D0qrky?=
 =?us-ascii?Q?X6fqRhzyVbag1FgXkVgQPL0e85RlTUj/kDiZwGLZJPUixr700U0PI6ZDuDqW?=
 =?us-ascii?Q?cUzJI3TvFoQ4UlIIlheHGeVGindygZeRazErCJMZAdMyBnDyTivMUhX8/0V8?=
 =?us-ascii?Q?bXms9mZfu00aQGtY4sLRsv4Vb7TwtDZ9dyf2zUJk3VQVx600OwZ66bNjBdgp?=
 =?us-ascii?Q?BaMU5NRDtMv97FTZ6poaGchHPHL7wsW6uXh6os5FWEGDeDrhYkadUAzx2cnW?=
 =?us-ascii?Q?Qd1pmFAPa+n/ssUi9aWtxNz2LuZvRI+wOQZ6/YAIggxfy+pXZeQwxAGqrTf4?=
 =?us-ascii?Q?0Z8uIQDcDMh4I+M=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 11:05:22.9044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2f8ad0-e984-4b17-99c8-08dd4e79cf2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
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

From: Erez Shitrit <erezsh@nvidia.com>

Actions are depended on the sub-domain that will be used.
So handle the actions accordingly.
From now on we don't fix-up for actions that doesn't fit the right
domain, we will let it be failed by the FW while creating the STC for
it.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr.h        |   5 +-
 drivers/net/mlx5/hws/mlx5dr_action.c | 222 +++++++++++++++++++++++----
 drivers/net/mlx5/hws/mlx5dr_action.h |   2 +-
 3 files changed, 200 insertions(+), 29 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index e0e7f5c147..58526fc08e 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -66,10 +66,13 @@ enum mlx5dr_action_flags {
 	MLX5DR_ACTION_FLAG_HWS_RX = 1 << 3,
 	MLX5DR_ACTION_FLAG_HWS_TX = 1 << 4,
 	MLX5DR_ACTION_FLAG_HWS_FDB = 1 << 5,
+	MLX5DR_ACTION_FLAG_HWS_FDB_RX = 1 << 6,
+	MLX5DR_ACTION_FLAG_HWS_FDB_TX = 1 << 7,
+	MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED = 1 << 8,
 	/* Shared action can be used over a few threads, since data is written
 	 * only once at the creation of the action.
 	 */
-	MLX5DR_ACTION_FLAG_SHARED = 1 << 6,
+	MLX5DR_ACTION_FLAG_SHARED = 1 << 9,
 };
 
 enum mlx5dr_action_aso_meter_color {
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index 8e95abf7da..b9452a3ebc 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -10,6 +10,12 @@
 /* Header removal size limited to 128B (64 words) */
 #define MLX5DR_ACTION_REMOVE_HEADER_MAX_SIZE 128
 
+static struct mlx5dr_devx_obj *
+mlx5dr_action_get_stc_obj_by_tbl_type(enum mlx5dr_table_type table_type,
+				      struct mlx5dr_pool *stc_pool,
+				      struct mlx5dr_pool_chunk *stc,
+				      bool is_mirror);
+
 /* This is the maximum allowed action order for each table type:
  *	 TX: POP_VLAN, CTR, ASO_METER, AS_CT, PUSH_VLAN, MODIFY, ENCAP, Term
  *	 RX: TAG, DECAP, POP_VLAN, CTR, ASO_METER, ASO_CT, PUSH_VLAN, MODIFY,
@@ -220,8 +226,47 @@ static int mlx5dr_action_get_shared_stc(struct mlx5dr_action *action,
 		}
 	}
 
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX) {
+		ret = mlx5dr_action_get_shared_stc_nic(ctx, stc_type,
+						       MLX5DR_TABLE_TYPE_FDB_RX);
+		if (ret) {
+			DR_LOG(ERR, "Failed to allocate FDB_RX shared STCs (type: %d)",
+			       stc_type);
+			goto clean_nic_fdb_stc;
+		}
+	}
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX) {
+		ret = mlx5dr_action_get_shared_stc_nic(ctx, stc_type,
+						       MLX5DR_TABLE_TYPE_FDB_TX);
+		if (ret) {
+			DR_LOG(ERR, "Failed to allocate FDB_TX shared STCs (type: %d)",
+			       stc_type);
+			goto clean_nic_fdb_rx_stc;
+		}
+	}
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) {
+		ret = mlx5dr_action_get_shared_stc_nic(ctx, stc_type,
+						       MLX5DR_TABLE_TYPE_FDB_UNIFIED);
+		if (ret) {
+			DR_LOG(ERR, "Failed to allocate FDB_UNIFIED shared STCs (type: %d)",
+			       stc_type);
+			goto clean_nic_fdb_tx_stc;
+		}
+	}
+
 	return 0;
 
+clean_nic_fdb_tx_stc:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB_TX);
+clean_nic_fdb_rx_stc:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB_RX);
+clean_nic_fdb_stc:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB);
 clean_nic_tx_stc:
 	if (action->flags & MLX5DR_ACTION_FLAG_HWS_TX)
 		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_NIC_TX);
@@ -250,6 +295,15 @@ static void mlx5dr_action_put_shared_stc(struct mlx5dr_action *action,
 
 	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB)
 		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB);
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB_RX);
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB_TX);
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED)
+		mlx5dr_action_put_shared_stc_nic(ctx, stc_type, MLX5DR_TABLE_TYPE_FDB_UNIFIED);
 }
 
 static void
@@ -689,14 +743,37 @@ static void mlx5dr_action_print_combo(enum mlx5dr_action_type *user_actions)
 	}
 }
 
+static const uint32_t *
+mlx5dr_action_get_order_entry(enum mlx5dr_table_type table_type)
+{
+	switch (table_type) {
+	case MLX5DR_TABLE_TYPE_NIC_RX:
+		return action_order_arr[MLX5DR_TABLE_TYPE_NIC_RX];
+	case MLX5DR_TABLE_TYPE_NIC_TX:
+		return action_order_arr[MLX5DR_TABLE_TYPE_NIC_TX];
+	case MLX5DR_TABLE_TYPE_FDB:
+	case MLX5DR_TABLE_TYPE_FDB_RX:
+	case MLX5DR_TABLE_TYPE_FDB_TX:
+	case MLX5DR_TABLE_TYPE_FDB_UNIFIED:
+		return action_order_arr[MLX5DR_TABLE_TYPE_FDB];
+	default:
+		assert(0);
+		DR_LOG(ERR, "no such type: %d", table_type);
+		return NULL;
+	}
+}
+
 bool mlx5dr_action_check_combo(enum mlx5dr_action_type *user_actions,
 			       enum mlx5dr_table_type table_type)
 {
-	const uint32_t *order_arr = action_order_arr[table_type];
+	const uint32_t *order_arr = mlx5dr_action_get_order_entry(table_type);
 	uint8_t order_idx = 0;
 	uint8_t user_idx = 0;
 	bool valid_combo;
 
+	if (!order_arr)
+		return false;
+
 	while (order_arr[order_idx] != BIT(MLX5DR_ACTION_TYP_LAST)) {
 		/* User action order validated move to next user action */
 		if (BIT(user_actions[user_idx]) & order_arr[order_idx])
@@ -787,13 +864,10 @@ mlx5dr_action_fixup_stc_attr(struct mlx5dr_context *ctx,
 
 	switch (stc_attr->action_type) {
 	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE:
-		if (!is_mirror)
-			devx_obj = mlx5dr_pool_chunk_get_base_devx_obj(stc_attr->ste_table.ste_pool,
-								       &stc_attr->ste_table.ste);
-		else
-			devx_obj =
-			mlx5dr_pool_chunk_get_base_devx_obj_mirror(stc_attr->ste_table.ste_pool,
-								   &stc_attr->ste_table.ste);
+		devx_obj = mlx5dr_action_get_stc_obj_by_tbl_type(table_type,
+								 stc_attr->ste_table.ste_pool,
+								 &stc_attr->ste_table.ste,
+								 is_mirror);
 
 		*fixup_stc_attr = *stc_attr;
 		fixup_stc_attr->ste_table.ste_obj_id = devx_obj->id;
@@ -845,6 +919,19 @@ mlx5dr_action_fixup_stc_attr(struct mlx5dr_context *ctx,
 	return use_fixup;
 }
 
+static struct mlx5dr_devx_obj *
+mlx5dr_action_get_stc_obj_by_tbl_type(enum mlx5dr_table_type table_type,
+				      struct mlx5dr_pool *stc_pool,
+				      struct mlx5dr_pool_chunk *stc,
+				      bool is_mirror)
+{
+	if (table_type == MLX5DR_TABLE_TYPE_FDB_TX ||
+	    (is_mirror && table_type == MLX5DR_TABLE_TYPE_FDB)) /* Optimized ORIG in FDB_TX */
+		return mlx5dr_pool_chunk_get_base_devx_obj_mirror(stc_pool, stc);
+	else
+		return mlx5dr_pool_chunk_get_base_devx_obj(stc_pool, stc);
+}
+
 int mlx5dr_action_alloc_single_stc(struct mlx5dr_context *ctx,
 				   struct mlx5dr_cmd_stc_modify_attr *stc_attr,
 				   uint32_t table_type,
@@ -854,6 +941,7 @@ int mlx5dr_action_alloc_single_stc(struct mlx5dr_context *ctx,
 	struct mlx5dr_pool *stc_pool = ctx->stc_pool[table_type];
 	struct mlx5dr_cmd_stc_modify_attr fixup_stc_attr = {0};
 	struct mlx5dr_devx_obj *devx_obj_0;
+	enum mlx5dr_table_type type;
 	bool use_fixup;
 	int ret;
 
@@ -869,10 +957,13 @@ int mlx5dr_action_alloc_single_stc(struct mlx5dr_context *ctx,
 	if (!mlx5dr_context_cap_dynamic_reparse(ctx))
 		stc_attr->reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
 
-	devx_obj_0 = mlx5dr_pool_chunk_get_base_devx_obj(stc_pool, stc);
+	type = (enum mlx5dr_table_type)table_type;
+	devx_obj_0 = mlx5dr_action_get_stc_obj_by_tbl_type(type, stc_pool, stc, false);
 
 	/* According to table/action limitation change the stc_attr */
-	use_fixup = mlx5dr_action_fixup_stc_attr(ctx, stc_attr, &fixup_stc_attr, table_type, false);
+	use_fixup = mlx5dr_action_fixup_stc_attr(ctx, stc_attr, &fixup_stc_attr,
+						 (enum mlx5dr_table_type)table_type,
+						 (table_type == MLX5DR_TABLE_TYPE_FDB_TX));
 	ret = mlx5dr_cmd_stc_modify(devx_obj_0, use_fixup ? &fixup_stc_attr : stc_attr);
 	if (ret) {
 		DR_LOG(ERR, "Failed to modify STC action_type %d tbl_type %d",
@@ -916,12 +1007,15 @@ void mlx5dr_action_free_single_stc(struct mlx5dr_context *ctx,
 	struct mlx5dr_pool *stc_pool = ctx->stc_pool[table_type];
 	struct mlx5dr_cmd_stc_modify_attr stc_attr = {0};
 	struct mlx5dr_devx_obj *devx_obj;
+	enum mlx5dr_table_type type;
 
 	/* Modify the STC not to point to an object */
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_DROP;
 	stc_attr.action_offset = MLX5DR_ACTION_OFFSET_HIT;
 	stc_attr.stc_offset = stc->offset;
-	devx_obj = mlx5dr_pool_chunk_get_base_devx_obj(stc_pool, stc);
+	type = (enum mlx5dr_table_type)table_type;
+	devx_obj = mlx5dr_action_get_stc_obj_by_tbl_type(type, stc_pool, stc, false);
+
 	mlx5dr_cmd_stc_modify(devx_obj, &stc_attr);
 
 	if (table_type == MLX5DR_TABLE_TYPE_FDB) {
@@ -1131,7 +1225,7 @@ mlx5dr_action_create_stcs(struct mlx5dr_action *action,
 						     MLX5DR_TABLE_TYPE_NIC_TX,
 						     &action->stc[MLX5DR_TABLE_TYPE_NIC_TX]);
 		if (ret)
-			goto free_nic_rx_stc;
+			goto free_stcs_rx;
 	}
 
 	/* Allocate STC for FDB */
@@ -1140,22 +1234,59 @@ mlx5dr_action_create_stcs(struct mlx5dr_action *action,
 						     MLX5DR_TABLE_TYPE_FDB,
 						     &action->stc[MLX5DR_TABLE_TYPE_FDB]);
 		if (ret)
-			goto free_nic_tx_stc;
+			goto free_stcs_tx;
+	}
+
+	/* Allocate STC for FDB-RX */
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX) {
+		ret = mlx5dr_action_alloc_single_stc(ctx, &stc_attr,
+						     MLX5DR_TABLE_TYPE_FDB_RX,
+						     &action->stc[MLX5DR_TABLE_TYPE_FDB_RX]);
+		if (ret)
+			goto free_stcs_fdb;
+	}
+
+	/* Allocate STC for FDB-TX */
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX) {
+		ret = mlx5dr_action_alloc_single_stc(ctx, &stc_attr,
+						     MLX5DR_TABLE_TYPE_FDB_TX,
+						     &action->stc[MLX5DR_TABLE_TYPE_FDB_TX]);
+		if (ret)
+			goto free_stcs_fdb_rx;
+	}
+
+	/* Allocate STC for FDB Unified */
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) {
+		ret = mlx5dr_action_alloc_single_stc(ctx, &stc_attr,
+						     MLX5DR_TABLE_TYPE_FDB_UNIFIED,
+						     &action->stc[MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
+		if (ret)
+			goto free_stcs_fdb_tx;
 	}
 
 	pthread_spin_unlock(&ctx->ctrl_lock);
 
 	return 0;
 
-free_nic_tx_stc:
+free_stcs_fdb_tx:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB_TX,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB_TX]);
+free_stcs_fdb_rx:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB_RX,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB_RX]);
+free_stcs_fdb:
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB]);
+free_stcs_tx:
 	if (action->flags & MLX5DR_ACTION_FLAG_HWS_TX)
-		mlx5dr_action_free_single_stc(ctx,
-					      MLX5DR_TABLE_TYPE_NIC_TX,
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_NIC_TX,
 					      &action->stc[MLX5DR_TABLE_TYPE_NIC_TX]);
-free_nic_rx_stc:
+free_stcs_rx:
 	if (action->flags & MLX5DR_ACTION_FLAG_HWS_RX)
-		mlx5dr_action_free_single_stc(ctx,
-					      MLX5DR_TABLE_TYPE_NIC_RX,
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_NIC_RX,
 					      &action->stc[MLX5DR_TABLE_TYPE_NIC_RX]);
 out_err:
 	pthread_spin_unlock(&ctx->ctrl_lock);
@@ -1182,6 +1313,18 @@ mlx5dr_action_destroy_stcs(struct mlx5dr_action *action)
 		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB,
 					      &action->stc[MLX5DR_TABLE_TYPE_FDB]);
 
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_RX)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB_RX,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB_RX]);
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_TX)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB_TX,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB_TX]);
+
+	if (action->flags & MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED)
+		mlx5dr_action_free_single_stc(ctx, MLX5DR_TABLE_TYPE_FDB_UNIFIED,
+					      &action->stc[MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
+
 	pthread_spin_unlock(&ctx->ctrl_lock);
 }
 
@@ -1198,7 +1341,10 @@ mlx5dr_action_is_hws_flags(uint32_t flags)
 {
 	return flags & (MLX5DR_ACTION_FLAG_HWS_RX |
 			MLX5DR_ACTION_FLAG_HWS_TX |
-			MLX5DR_ACTION_FLAG_HWS_FDB);
+			MLX5DR_ACTION_FLAG_HWS_FDB |
+			MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED);
 }
 
 static struct mlx5dr_action *
@@ -1336,9 +1482,13 @@ mlx5dr_action_create_dest_tir(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
-	if ((flags & MLX5DR_ACTION_FLAG_ROOT_FDB) ||
-	    (flags & MLX5DR_ACTION_FLAG_HWS_FDB && !ctx->caps->fdb_tir_stc)) {
-		DR_LOG(ERR, "TIR action not support on FDB");
+	if ((flags & (MLX5DR_ACTION_FLAG_ROOT_FDB |
+		      MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+		      MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED)) ||
+	    ((flags & (MLX5DR_ACTION_FLAG_HWS_FDB |
+		       MLX5DR_ACTION_FLAG_HWS_FDB_RX)) &&
+	    !ctx->caps->fdb_tir_stc)) {
+		DR_LOG(ERR, "TIR action not support on FDB or FDB_TX or UNIFIED");
 		rte_errno = ENOTSUP;
 		return NULL;
 	}
@@ -1436,6 +1586,12 @@ mlx5dr_action_create_tag(struct mlx5dr_context *ctx,
 	struct mlx5dr_action *action;
 	int ret;
 
+	if (flags & (MLX5DR_ACTION_FLAG_HWS_FDB_TX | MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED)) {
+		DR_LOG(ERR, "TAG action not supported for UNIFIED or FDB_TX");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
 	action = mlx5dr_action_create_generic(ctx, flags, MLX5DR_ACTION_TYP_TAG);
 	if (!action)
 		return NULL;
@@ -1588,7 +1744,9 @@ mlx5dr_action_create_dest_vport(struct mlx5dr_context *ctx,
 	struct mlx5dr_action *action;
 	int ret;
 
-	if (!(flags & MLX5DR_ACTION_FLAG_HWS_FDB)) {
+	if (!(flags & (MLX5DR_ACTION_FLAG_HWS_FDB | MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+		       MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+		       MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED))) {
 		DR_LOG(ERR, "Vport action is supported for FDB only");
 		rte_errno = EINVAL;
 		return NULL;
@@ -2317,11 +2475,21 @@ mlx5dr_action_create_dest_array(struct mlx5dr_context *ctx,
 		return NULL;
 	}
 
-	if (flags == (MLX5DR_ACTION_FLAG_HWS_RX | MLX5DR_ACTION_FLAG_SHARED)) {
+	if (!(flags & MLX5DR_ACTION_FLAG_SHARED)) {
+		DR_LOG(ERR, "Action flags not supported, should include SHARED");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+
+	flags = flags & ~MLX5DR_ACTION_FLAG_SHARED;
+
+	if (flags == MLX5DR_ACTION_FLAG_HWS_RX) {
 		ft_attr.type = FS_FT_NIC_RX;
 		ft_attr.level = MLX5_IFC_MULTI_PATH_FT_MAX_LEVEL - 1;
 		table_type = MLX5DR_TABLE_TYPE_NIC_RX;
-	} else if (flags == (MLX5DR_ACTION_FLAG_HWS_FDB | MLX5DR_ACTION_FLAG_SHARED)) {
+	} else if (flags & (MLX5DR_ACTION_FLAG_HWS_FDB | MLX5DR_ACTION_FLAG_HWS_FDB_RX |
+			    MLX5DR_ACTION_FLAG_HWS_FDB_TX |
+			    MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED)) {
 		ft_attr.type = FS_FT_FDB;
 		ft_attr.level = ctx->caps->fdb_ft.max_level - 1;
 		table_type = MLX5DR_TABLE_TYPE_FDB;
@@ -2363,7 +2531,7 @@ mlx5dr_action_create_dest_array(struct mlx5dr_context *ctx,
 				fte_attr.ignore_flow_level = 1;
 				break;
 			case MLX5DR_ACTION_TYP_MISS:
-				if (table_type != MLX5DR_TABLE_TYPE_FDB) {
+				if (!mlx5dr_table_is_fdb_any(table_type)) {
 					DR_LOG(ERR, "Miss action supported for FDB only");
 					rte_errno = ENOTSUP;
 					goto free_dest_list;
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.h b/drivers/net/mlx5/hws/mlx5dr_action.h
index 8ce4ecd5ba..b779e578fd 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.h
+++ b/drivers/net/mlx5/hws/mlx5dr_action.h
@@ -160,7 +160,7 @@ struct mlx5dr_action_template {
 
 struct mlx5dr_action {
 	uint8_t type;
-	uint8_t flags;
+	uint16_t flags;
 	struct mlx5dr_context *ctx;
 	union {
 		struct {
-- 
2.21.0

