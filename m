Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C021090222
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 12:54:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E175F402D1;
	Thu, 19 Mar 2026 13:54:19 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by mails.dpdk.org (Postfix) with ESMTP id A5F0F402D1;
 Thu, 19 Mar 2026 13:54:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr88QL/Zmt4HZznIn8cKehdQZzdB+yDOP3XkfWrMlXqfBm/BZGDaJkQFqe9L7VQpzQWqtHGB00WglJRrlaCT/f1PyxEi2HxDtC6mX446efVS3vWmrktADKEAxCNQc+ugoE8ObSZotlmtpOiUONWDTdZ2/B+DEmx0bNipeu43O51rV2Jzubjl5v9ZCgoTZ4lfiaSNoNqWRWex3WwO9P2Hz2QnKouPvFK3RQ6NVWgvRQlKcb+DbzjhmAtaj6BvwH3WP9IMGSAolEf+OPsKD4+4dwQmvKFPWKjiFbMNMLqTyeYm66q2s/xC8q2l2pdDTdFugCv1yoZynyl4CCW3PoMHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC8FwqMzfBS2hOHBUnAPERilQTTWs456crqPR7pTzrA=;
 b=RIsTwzEQTfhMITQH26DTG4vD55icEI/ohs7Yg04adgtr0qW4CAlG4dZjMGb0taDKEyuLw1KzXSa28i3vDUsFUYGZ2ZvjjKQCusYFNidglYBgwQc+Tze4JMCou4EMrN/DnO8dD/5m1TcRq73NY8m9+sq91pwwsA4Y6TDuosqqzqU1lGsh9Nzlqc0l9uZW4z4Yj9iU1VgKVRqoBnNAg7dG12BAsLoEHpDB0FI07hzjrPHfiwGD6/ZTTo0j5siikMJg11giwh0a8jENLzj3ZsPtkqrjPpL7NhouUGObhGPsFXtTkvRSBPIdbWy/24IkFddyiOL60kaEFbebm3kyEx7z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC8FwqMzfBS2hOHBUnAPERilQTTWs456crqPR7pTzrA=;
 b=lF4RHyNJHTspcC22I7DIOqXpmb7u/dzn3mAaXM5q8qhZbkPps6WfxwWyzpVHsWhSsHjqStKVzwHZHdHMJtqT4lJyRLw0C3H1iLdL2Wv7WtJheqqded/34E4UZNCVGMoGVBLCESB9xs33JfCtOp4AXcAk7a85vOuqDReljURXLlO5ZqoF68Wj1yIXnEEpOcVtTKiySDOMBcpiUnxfltvuroBzzU2AwNgbKO18ukt+Y2PNw6/Ci+EJQLY+AasJ0lSG1bKg/Z50PeSFVdY2uZjXnkfeB/wPFmatD71aEre01O0k28uJFcxlrD+2ORCTjsbdYtDzDG7dSyKYJQctppPNaA==
Received: from BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 12:54:11 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d3) by BY5PR17CA0014.outlook.office365.com
 (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 12:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 12:54:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 05:54:04 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 05:54:02 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix VXLAN and NVGRE encap in async flow API
Date: Thu, 19 Mar 2026 13:53:45 +0100
Message-ID: <20260319125345.664772-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bd27d1-94fd-4cdb-2f51-08de85b69df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fenzxJ7Vs7KSYLD3mNtL+AMJtb2GrvcneJyzRzaEDzCMtDlUIggio68OymVnGm/y4wEvWC7cSbFXfTrOqG35gQvgsQCFwUTiz+hHgN420P+3ogJd17NUdihA7gQcZtNR1ho6K5Fd8zpjDLa8CVz/YQ6Jl++JtIY3KR0QAr0fP2wGibvkF93oqAPL+Ugfbxt00dG6eIkEGNLCH0aarLAyewG7eHto6SMg0pmPQQFLS6K3HlB9ozlPpwVJaR0qYQtaNcSYaVhm74Yxv95+wUCgpzFjnbZA70I9fyFmfeb3bDo7gEc3O2rDvXEJoQrBYVY3590feZm3Ap1CvFNCeAh8u6h3OjeCAiZ1Z93egIXXrW/JzCBjAw6U5dEL+c7PDIm1Z26ZyKYMXhIeYaTlc9HtgW68XZiZ9ghQ7N4SpwcSRVJGqtQzqEqR+G1pN6C0GEUTHrG0bvk6fUH/vUiSo5JEJla6Q4wYb4oh3JWAsXmUeXXy4A1nnI7exSy8IoLyE/mlVEF0uGwA9vGXzleYzoF34BvLgVSxV7b+HJhzPrMa+HcR1GuEaCKAGcoHbLIZrZSFei12ytsBPGuuYFJI+mIz7zRAV6klGpA9k/BTsJJ84GSR0fJRH46C04G4PNiiNzWetBjZOZzjhnrxYKw36bu68AK0fi+pFstS0jk2eXgy9KSSlnKue1DmCrMYENq02LVI730PJb+/JHaEGiINUrRu4waZAcDJFdHYHQTrWoXG7FKh2UWSuD9K1cKiwgXqvmXsgA/04rk1F5klF+77NSGHXw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1AiI0x6TXKeMoWTiQsFCnGNxMkcuP5Iaw8nGy5SHydbUwq7rAWBWT1BLn4FPlJTzdQxSNLLZDQpL5dxzIq8vi5plj27zrATUEK9ANC68P04yr9kgmr6GClHUQyXLbRCwSWqMg8bQC7J1T2G44kjd1jtzqDnqJeix09VnM2Vbo8Dz1UezJy3CwDwhnLJI+hlsSIUJKSYef8VuuI1XD2DDy+czYFzO5G//uZsJhNjz/Cf6CsR5KUEmqetxZ1sRsLVIFFrAE8iMeLUt9XuJAbu7KTuKTppkJALwA3xLCZGvw13iI/6zq2ah0vG8rf+ybE0jlZolMiuumpxeZbAMOQZ997fyHxc+iDO6MyDfGF6lWvm4FYHxtpFzzknSRm98CDCSsz2SgHZxJjut9QX86JQWbOFTmGsCl0sbTRbSV+x6CHduIYZlyy2FQnU0im/45ZVk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:54:11.3156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bd27d1-94fd-4cdb-2f51-08de85b69df7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
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

If masked VXLAN_ENCAP or NVGRE_ENCAP flow action
was used in actions template, then packets were being
encapsulated into an empty header (all zeroes)
instead of a header based on provided item definition.

Offending commit has decoupled translation of VXLAN/NVGRE
tunnel definition from creation of HW action - previously
this was done in a single function mlx5_tbl_translate_reformat().
This was done to adjust HWS flow engine for sync flow API.
This decoupling has introduced a bug for async flow API.
Translated packet tunnel headers were not used for creation of masked
encap action.
Specifically, mlx5_tbl_translate_reformat() function has properly
translated tunnel definition to tunnel headers,
but a result of that was not propagated to
mlx5_tbl_create_reformat_action().
As a result, zeroed HW buffer was used in place of real data.

This patch fixes that by moving tunnel header translation out of
mlx5_tbl_translate_reformat() to dedicated handling for VXLAN/NVGRE
encap flow actions and ensuring that this data is propagated correctly.
On top of that, translation code for VXLAN/NVGRE is unified
(it is functionally similar) to reduce code duplication.

Fixes: 9bbe38744a57 ("net/mlx5: set encap as shared flow action")
Cc: mkashani@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 95 ++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 041066a94f..bca5b2769e 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2305,6 +2305,60 @@ table_template_translate_indirect_list(struct rte_eth_dev *dev,
 	return ret;
 }

+/**
+ * Translate given encap action and mask to raw tunnel header buffer.
+ *
+ * @param[in] action
+ *   Pointer to encap action.
+ * @param[in] mask
+ *   Pointer to encap action's mask.
+ * @param[out] conf_encap_data
+ *   Buffer where tunnel header will be written.
+ * @param[out] data_size
+ *   Pointer to tunnel header size.
+ * @param[out] error
+ *   Pointer to error structure.
+ *
+ * @return
+ *   0 or greater if translation was successful.
+ *   Negative errno value otherwise.
+ *
+ *   If returned value is 0, then action is not shared in the actions template
+ *   If bigger than 0, then it is shared.
+ */
+static int
+translate_l2_encap_action(const struct rte_flow_action *action,
+			  const struct rte_flow_action *mask,
+			  uint8_t conf_encap_data[MLX5_ENCAP_MAX_LEN],
+			  size_t *data_size,
+			  struct rte_flow_error *error)
+{
+	struct rte_flow_item *conf_item;
+	int ret;
+
+	if (action->conf == NULL)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION_CONF, NULL,
+					  "Missing VXLAN/NVGRE encap action configuration");
+
+	/* Only these 2 action types receive encap data as flow item pattern. */
+	MLX5_ASSERT(action->type == RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP ||
+		    action->type == RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP);
+	if (action->type == RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP)
+		conf_item = MLX5_CONST_ENCAP_ITEM(rte_flow_action_vxlan_encap, action->conf);
+	else
+		conf_item = MLX5_CONST_ENCAP_ITEM(rte_flow_action_nvgre_encap, action->conf);
+	if (conf_item == NULL)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION_CONF, NULL,
+				"Missing VXLAN/NVGRE tunnel definition in action config");
+
+	ret = mlx5_flow_dv_convert_encap_data(conf_item, conf_encap_data, data_size, error);
+	if (ret < 0)
+		return ret;
+
+	/* If mask is provided, then action is shared */
+	return mask->conf != NULL;
+}
+
 static void
 mlx5_set_reformat_header(struct mlx5dr_action_reformat_header *hdr,
 			 uint8_t *encap_data,
@@ -2318,8 +2372,6 @@ static int
 mlx5_tbl_translate_reformat(struct mlx5_priv *priv,
 			    struct mlx5_hw_actions *acts,
 			    struct rte_flow_actions_template *at,
-			    const struct rte_flow_item *enc_item,
-			    const struct rte_flow_item *enc_item_m,
 			    uint8_t *encap_data, uint8_t *encap_data_m,
 			    struct mlx5_tbl_multi_pattern_ctx *mp_ctx,
 			    size_t data_size, uint16_t reformat_src,
@@ -2328,22 +2380,12 @@ mlx5_tbl_translate_reformat(struct mlx5_priv *priv,
 {
 	int mp_reformat_ix = mlx5_multi_pattern_reformat_to_index(refmt_type);
 	struct mlx5dr_action_reformat_header hdr;
-	uint8_t buf[MLX5_ENCAP_MAX_LEN];
 	bool shared_rfmt = false;
 	int ret;

 	MLX5_ASSERT(at->reformat_off != UINT16_MAX);
-	if (enc_item) {
-		MLX5_ASSERT(!encap_data);
-		ret = mlx5_flow_dv_convert_encap_data(enc_item, buf, &data_size, error);
-		if (ret)
-			return ret;
-		encap_data = buf;
-		if (enc_item_m)
-			shared_rfmt = true;
-	} else if (encap_data && encap_data_m) {
+	if (encap_data && encap_data_m)
 		shared_rfmt = true;
-	}
 	acts->encap_decap = mlx5_malloc(MLX5_MEM_ZERO,
 					sizeof(*acts->encap_decap) + data_size,
 					0, SOCKET_ID_ANY);
@@ -2615,8 +2657,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	enum mlx5dr_action_type recom_type = MLX5DR_ACTION_TYP_LAST;
 	const struct rte_flow_action_raw_encap *raw_encap_data;
 	const struct rte_flow_action_ipv6_ext_push *ipv6_ext_data;
-	const struct rte_flow_item *enc_item = NULL, *enc_item_m = NULL;
 	uint16_t reformat_src = 0, recom_src = 0;
+	uint8_t converted_encap_data[MLX5_ENCAP_MAX_LEN] = { 0 };
 	uint8_t *encap_data = NULL, *encap_data_m = NULL;
 	uint8_t *push_data = NULL, *push_data_m = NULL;
 	size_t data_size = 0, push_size = 0;
@@ -2835,23 +2877,17 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			}
 			break;
 		case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
-			MLX5_ASSERT(!reformat_used);
-			enc_item = MLX5_CONST_ENCAP_ITEM(rte_flow_action_vxlan_encap,
-							 actions->conf);
-			if (masks->conf)
-				enc_item_m = MLX5_CONST_ENCAP_ITEM(rte_flow_action_vxlan_encap,
-								   masks->conf);
-			reformat_used = true;
-			reformat_src = src_pos;
-			refmt_type = MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L2;
-			break;
 		case RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP:
 			MLX5_ASSERT(!reformat_used);
-			enc_item = MLX5_CONST_ENCAP_ITEM(rte_flow_action_nvgre_encap,
-							 actions->conf);
-			if (masks->conf)
-				enc_item_m = MLX5_CONST_ENCAP_ITEM(rte_flow_action_nvgre_encap,
-								   masks->conf);
+			ret = translate_l2_encap_action(actions, masks, converted_encap_data,
+							&data_size, error);
+			if (ret < 0)
+				goto err;
+			/* If masked action, then use converted encap data for shared action. */
+			if (ret > 0) {
+				encap_data = converted_encap_data;
+				encap_data_m = converted_encap_data;
+			}
 			reformat_used = true;
 			reformat_src = src_pos;
 			refmt_type = MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L2;
@@ -3133,7 +3169,6 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	}
 	if (reformat_used) {
 		ret = mlx5_tbl_translate_reformat(priv, acts, at,
-						  enc_item, enc_item_m,
 						  encap_data, encap_data_m,
 						  mp_ctx, data_size,
 						  reformat_src,
--
2.47.3

