Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABADC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 434334279A;
	Tue,  4 Feb 2025 17:23:10 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 72BDB40609
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1217D210C33D; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1217D210C33D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686168;
 bh=ZPS/L28btd1uIsyaf4eDFI/mEOlNgYYzcA0fTqjUX9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DiN/Ck2WmGlgNvZEFY6tbr0GVpbyiPraGt/LW0X9pL26EnFdDanZMF3hEldqEQTSX
 CUR/9k2iZ7Off1rOpFfBjO7+qzAEtGDMTY4tVBsO0Y98bxmaZgoJLZND+PG/7Pw0Oz
 n3e+WVgqxvt15QUsbJwaUTIOPGs903C/eQN/coeM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v20 17/27] net/mlx5: remove use of VLAs for Windows built code
Date: Tue,  4 Feb 2025 08:21:54 -0800
Message-Id: <1738686124-16173-18-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
---
 drivers/net/mlx5/mlx5.c      | 5 ++---
 drivers/net/mlx5/mlx5_flow.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 6e4473e2f4..979e54686b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1598,14 +1598,13 @@ void
 mlx5_rt_timestamp_config(struct mlx5_dev_ctx_shared *sh,
 			 struct mlx5_hca_attr *hca_attr)
 {
-	uint32_t dw_cnt = MLX5_ST_SZ_DW(register_mtutc);
-	uint32_t reg[dw_cnt];
+	uint32_t reg[MLX5_ST_SZ_DW(register_mtutc)];
 	int ret = ENOTSUP;
 
 	if (hca_attr->access_register_user)
 		ret = mlx5_devx_cmd_register_read(sh->cdev->ctx,
 						  MLX5_REGISTER_ID_MTUTC, 0,
-						  reg, dw_cnt);
+						  reg, RTE_DIM(reg));
 	if (!ret) {
 		uint32_t ts_mode;
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 3e79754b83..bfc44f25bf 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1479,8 +1479,8 @@ mlx5_flow_item_acceptable(const struct rte_eth_dev *dev,
 					  "mask/last without a spec is not"
 					  " supported");
 	if (item->spec && item->last && !range_accepted) {
-		uint8_t spec[size];
-		uint8_t last[size];
+		uint8_t *spec = alloca(size);
+		uint8_t *last = alloca(size);
 		unsigned int i;
 		int ret;
 
@@ -8481,7 +8481,7 @@ mlx5_ctrl_flow_vlan(struct rte_eth_dev *dev,
 			.type = RTE_FLOW_ITEM_TYPE_END,
 		},
 	};
-	uint16_t queue[priv->reta_idx_n];
+	uint16_t *queue = alloca(sizeof(uint16_t) * priv->reta_idx_n);
 	struct rte_flow_action_rss action_rss = {
 		.func = RTE_ETH_HASH_FUNCTION_DEFAULT,
 		.level = 0,
-- 
2.47.2.vfs.0.1

