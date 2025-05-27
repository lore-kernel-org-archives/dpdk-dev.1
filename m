Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A700C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 23:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F8640656;
	Wed, 28 May 2025 01:41:34 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D5AB44028F
 for <dev@dpdk.org>; Wed, 28 May 2025 01:41:33 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id DF7F02113A49; Tue, 27 May 2025 16:41:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF7F02113A49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748389292;
 bh=hVDtlaq7iVFPN2191nAXB8r+Bph3PakKLI+t/kFpcpo=;
 h=From:To:Cc:Subject:Date:From;
 b=VhZgQmO4b6y3zdmQ0STUNV7p/TtC73Y0I4pW3IZnO99VJdSb5RviFrn08kdLSrSP5
 pl0oQQ/KmhdcEqlDkLXceXaDkxOhdKwQXZMMwKgLUogZ5Ivry4tSXhvEyTeQL0Tc2K
 lH3RvOJJJpvmdXOhROcmsuXgIUYE8Bh2QP94LsPM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] common/mlx5: avoid warning about operation mixing different
 enum types
Date: Tue, 27 May 2025 16:41:25 -0700
Message-Id: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling with MSVC, warnings like the one below pop up:

../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
    are different enum types
    '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
    '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
    to silence this warning

The values in both enums indicate that this sort of mixed bit
manipulation is intentional, so this patch just uses an explicit
cast to avoid the warning.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 39a4298b58..1a3f4580d8 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -552,7 +552,7 @@ mlx5_devx_cmd_query_hca_vdpa_attr(void *ctx,
 
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, NULL,
 			MLX5_GET_HCA_CAP_OP_MOD_VDPA_EMULATION |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr) {
 		DRV_LOG(DEBUG, "Failed to query devx VDPA capabilities");
 		vdpa_attr->valid = 0;
@@ -851,7 +851,7 @@ mlx5_devx_cmd_query_hca_parse_graph_node_cap
 
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_PARSE_GRAPH_NODE_CAP |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr)
 		return rc;
 	attr->node_in = MLX5_GET(parse_graph_node_cap, hcattr, node_in);
@@ -884,7 +884,7 @@ mlx5_devx_cmd_query_hca_parse_graph_node_cap
 	/* Get the max supported samples from HCA CAP 2 */
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE_2 |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr)
 		return rc;
 	attr->max_num_prog_sample =
@@ -943,7 +943,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr)
 		return rc;
 	hca_cap_2_sup = MLX5_GET(cmd_hca_cap, hcattr, hca_cap_2);
@@ -1127,7 +1127,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		MLX5_GET(cmd_hca_cap, hcattr, aes_xts_single_block_le_tweak);
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_CRYPTO |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr)
 			return -1;
 		attr->crypto_wrapped_import_method = !!(MLX5_GET(crypto_caps,
@@ -1152,7 +1152,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	if (hca_cap_2_sup) {
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE_2 |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr) {
 			DRV_LOG(DEBUG,
 				"Failed to query DevX HCA capabilities 2.");
@@ -1193,7 +1193,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	if (attr->qos.sup) {
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_QOS_CAP |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr) {
 			DRV_LOG(DEBUG, "Failed to query devx QOS capabilities");
 			return rc;
@@ -1229,7 +1229,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	/* Query Flow Sampler Capability From FLow Table Properties Layout. */
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_NIC_FLOW_TABLE |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr) {
 		attr->log_max_ft_sampler_num = 0;
 		return rc;
@@ -1286,7 +1286,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	/* Query HCA offloads for Ethernet protocol. */
 	hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 			MLX5_GET_HCA_CAP_OP_MOD_ETHERNET_OFFLOAD_CAPS |
-			MLX5_HCA_CAP_OPMOD_GET_CUR);
+			(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 	if (!hcattr) {
 		attr->eth_net_offloads = 0;
 		return rc;
@@ -1355,7 +1355,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	if (attr->wqe_based_flow_table_sup) {
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_WQE_BASED_FLOW_TABLE |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr) {
 			DRV_LOG(DEBUG, "Failed to query WQE Based Flow table capabilities");
 			return rc;
@@ -1378,7 +1378,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	if (attr->roce) {
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_ROCE |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr) {
 			DRV_LOG(DEBUG,
 				"Failed to query devx HCA ROCE capabilities");
@@ -1396,7 +1396,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 	if (attr->eswitch_manager) {
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_SET_HCA_CAP_OP_MOD_ESW |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr)
 			return rc;
 		attr->esw_mgr_vport_id_valid =
@@ -1410,7 +1410,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 
 		hcattr = mlx5_devx_get_hca_cap(ctx, in, out, &rc,
 				MLX5_GET_HCA_CAP_OP_MOD_ESW_FLOW_TABLE |
-				MLX5_HCA_CAP_OPMOD_GET_CUR);
+				(uint32_t)MLX5_HCA_CAP_OPMOD_GET_CUR);
 		if (!hcattr)
 			return rc;
 		esw_reg = MLX5_GET(flow_table_esw_cap, hcattr,
-- 
2.49.0.vfs.0.3

