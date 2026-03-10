Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17175FCC9DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 683C640B9D;
	Tue, 10 Mar 2026 10:22:13 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 3D53A40A87
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:22:12 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 91FE078035E;
 Tue, 10 Mar 2026 10:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773134532;
 bh=qfVAU/X1uCfyGZWBLg1lXPFTYlDqRk3R49egTfHZjVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BgxtWSb+LhpUNI21K3VSkcmfW5+t6tpsrwqtL0ULqwfDX7a47j5vhhP1AzrxYRfrC
 /f3xKzV+0BfV7kTuL6SHZ/ICVpt9GvG1SHB5uxx7whSFzhFVbE9sUST6X4fcTKLCgL
 suG9Q22xGn4XilymY0h7ZSOz9pH+hsWT9vczq2Ik270klEd3WvB0zIbFhZJ/JaTdHm
 A6ujmPnZAiJwT27ySay4eDQceR1aO3NuI94bOlnfjYYq4q+azTBb9Id7X/jiJa+Czq
 oV73DIU3n7hq0Aufs8UmOu5xkaCs5PgQUFOECGELcX8sb3lvumLnQI2c5o4mzthDLw
 OUbofUIjNddyQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 07/10] net/mlx5: add testpmd command to query per-queue
 rate limit
Date: Tue, 10 Mar 2026 10:20:11 +0100
Message-ID: <20260310092014.2762894-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310092014.2762894-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a new testpmd command to display the per-queue packet pacing
rate limit state, including the PP index from both driver state
and FW SQ context readback:

  testpmd> mlx5 port <port_id> txq <queue_id> rate show

This helps verify that the FW actually applied the PP index to
the SQ after setting a per-queue rate limit.

Expose a new PMD API rte_pmd_mlx5_txq_rate_limit_query() that
queries txq_ctrl->rl for driver state and mlx5_devx_cmd_query_sq()
for the FW packet_pacing_rate_limit_index field.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5_testpmd.c | 93 +++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.c      | 38 ++++++++++++++
 drivers/net/mlx5/mlx5_txq.c     | 19 +++++--
 drivers/net/mlx5/rte_pmd_mlx5.h | 30 +++++++++++
 4 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_testpmd.c b/drivers/net/mlx5/mlx5_testpmd.c
index 1bb5a89559..fd3efecc5d 100644
--- a/drivers/net/mlx5/mlx5_testpmd.c
+++ b/drivers/net/mlx5/mlx5_testpmd.c
@@ -1365,6 +1365,94 @@ cmdline_parse_inst_t mlx5_cmd_dump_rq_context_options = {
 	}
 };
 
+/* Show per-queue rate limit PP index for a given port/queue */
+struct mlx5_cmd_show_rate_limit_options {
+	cmdline_fixed_string_t mlx5;
+	cmdline_fixed_string_t port;
+	portid_t port_id;
+	cmdline_fixed_string_t txq;
+	queueid_t queue_id;
+	cmdline_fixed_string_t rate;
+	cmdline_fixed_string_t show;
+};
+
+cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_mlx5 =
+	TOKEN_STRING_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+				 mlx5, "mlx5");
+cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_port =
+	TOKEN_STRING_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+				 port, "port");
+cmdline_parse_token_num_t mlx5_cmd_show_rate_limit_port_id =
+	TOKEN_NUM_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+			      port_id, RTE_UINT16);
+cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_txq =
+	TOKEN_STRING_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+				 txq, "txq");
+cmdline_parse_token_num_t mlx5_cmd_show_rate_limit_queue_id =
+	TOKEN_NUM_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+			      queue_id, RTE_UINT16);
+cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_rate =
+	TOKEN_STRING_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+				 rate, "rate");
+cmdline_parse_token_string_t mlx5_cmd_show_rate_limit_show =
+	TOKEN_STRING_INITIALIZER(struct mlx5_cmd_show_rate_limit_options,
+				 show, "show");
+
+static void
+mlx5_cmd_show_rate_limit_parsed(void *parsed_result,
+				__rte_unused struct cmdline *cl,
+				__rte_unused void *data)
+{
+	struct mlx5_cmd_show_rate_limit_options *res = parsed_result;
+	struct rte_pmd_mlx5_txq_rate_limit_info info;
+	int ret;
+
+	ret = rte_pmd_mlx5_txq_rate_limit_query(res->port_id, res->queue_id,
+						 &info);
+	switch (ret) {
+	case 0:
+		break;
+	case -ENODEV:
+		fprintf(stderr, "invalid port_id %u\n", res->port_id);
+		return;
+	case -EINVAL:
+		fprintf(stderr, "invalid queue index (%u), out of range\n",
+			res->queue_id);
+		return;
+	case -EIO:
+		fprintf(stderr, "failed to query SQ context\n");
+		return;
+	default:
+		fprintf(stderr, "query failed (%d)\n", ret);
+		return;
+	}
+	fprintf(stdout, "Port %u Txq %u rate limit info:\n",
+		res->port_id, res->queue_id);
+	if (info.rate_mbps > 0)
+		fprintf(stdout, "  Configured rate: %u Mbps\n",
+			info.rate_mbps);
+	else
+		fprintf(stdout, "  Configured rate: disabled\n");
+	fprintf(stdout, "  PP index (driver): %u\n", info.pp_index);
+	fprintf(stdout, "  PP index (FW readback): %u\n", info.fw_pp_index);
+}
+
+cmdline_parse_inst_t mlx5_cmd_show_rate_limit = {
+	.f = mlx5_cmd_show_rate_limit_parsed,
+	.data = NULL,
+	.help_str = "mlx5 port <port_id> txq <queue_id> rate show",
+	.tokens = {
+		(void *)&mlx5_cmd_show_rate_limit_mlx5,
+		(void *)&mlx5_cmd_show_rate_limit_port,
+		(void *)&mlx5_cmd_show_rate_limit_port_id,
+		(void *)&mlx5_cmd_show_rate_limit_txq,
+		(void *)&mlx5_cmd_show_rate_limit_queue_id,
+		(void *)&mlx5_cmd_show_rate_limit_rate,
+		(void *)&mlx5_cmd_show_rate_limit_show,
+		NULL,
+	}
+};
+
 static struct testpmd_driver_commands mlx5_driver_cmds = {
 	.commands = {
 		{
@@ -1440,6 +1528,11 @@ static struct testpmd_driver_commands mlx5_driver_cmds = {
 			.help = "mlx5 port (port_id) queue (queue_id) dump rq_context (file_name)\n"
 				"    Dump mlx5 RQ Context\n\n",
 		},
+		{
+			.ctx = &mlx5_cmd_show_rate_limit,
+			.help = "mlx5 port (port_id) txq (queue_id) rate show\n"
+				"    Show per-queue rate limit PP index\n\n",
+		},
 		{
 			.ctx = NULL,
 		},
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 8085b5c306..7051390a5e 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -848,3 +848,41 @@ int rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id, const ch
 	fclose(fd);
 	return ret;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_txq_rate_limit_query, 26.07)
+int rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
+				       struct rte_pmd_mlx5_txq_rate_limit_info *info)
+{
+	struct rte_eth_dev *dev;
+	struct mlx5_priv *priv;
+	struct mlx5_txq_data *txq_data;
+	struct mlx5_txq_ctrl *txq_ctrl;
+	uint32_t sq_out[MLX5_ST_SZ_DW(query_sq_out)] = {0};
+	int ret;
+
+	if (info == NULL)
+		return -EINVAL;
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -ENODEV;
+	if (rte_eth_tx_queue_is_valid(port_id, queue_id))
+		return -EINVAL;
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+	txq_data = (*priv->txqs)[queue_id];
+	txq_ctrl = container_of(txq_data, struct mlx5_txq_ctrl, txq);
+	info->rate_mbps = txq_ctrl->rl.rate_mbps;
+	info->pp_index = txq_ctrl->rl.pp_id;
+	if (txq_ctrl->obj == NULL) {
+		info->fw_pp_index = 0;
+		return 0;
+	}
+	ret = mlx5_devx_cmd_query_sq(txq_ctrl->obj->sq_obj.sq,
+				     sq_out, sizeof(sq_out));
+	if (ret)
+		return -EIO;
+	info->fw_pp_index = MLX5_GET(sqc,
+				     MLX5_ADDR_OF(query_sq_out, sq_out,
+						  sq_context),
+				     packet_pacing_rate_limit_index);
+	return 0;
+}
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 85959ca365..0e051b0839 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1412,7 +1412,20 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 		rte_errno = EINVAL;
 		return -rte_errno;
 	}
-	if (txq_ctrl->obj == NULL || txq_ctrl->obj->sq == NULL) {
+	if (txq_ctrl->obj == NULL) {
+		DRV_LOG(ERR, "Port %u Tx queue %u not initialized.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	/*
+	 * For non-hairpin queues the SQ DevX object lives in
+	 * obj->sq_obj.sq (used by DevX/HWS mode), while hairpin
+	 * queues use obj->sq directly.  These are different members
+	 * of a union inside mlx5_txq_obj.
+	 */
+	struct mlx5_devx_obj *sq_devx = txq_ctrl->obj->sq_obj.sq;
+	if (sq_devx == NULL) {
 		DRV_LOG(ERR, "Port %u Tx queue %u SQ not ready.",
 			dev->data->port_id, queue_idx);
 		rte_errno = EINVAL;
@@ -1426,7 +1439,7 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 		sq_attr.state = MLX5_SQC_STATE_RDY;
 		sq_attr.rl_update = 1;
 		sq_attr.packet_pacing_rate_limit_index = 0;
-		ret = mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
+		ret = mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
 		if (ret) {
 			DRV_LOG(ERR,
 				"Port %u Tx queue %u failed to clear rate.",
@@ -1447,7 +1460,7 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 	sq_attr.state = MLX5_SQC_STATE_RDY;
 	sq_attr.rl_update = 1;
 	sq_attr.packet_pacing_rate_limit_index = txq_ctrl->rl.pp_id;
-	ret = mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
+	ret = mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
 	if (ret) {
 		DRV_LOG(ERR, "Port %u Tx queue %u failed to set rate %u Mbps.",
 			dev->data->port_id, queue_idx, tx_rate);
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 7acfdae97d..698d7d2032 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -420,6 +420,36 @@ __rte_experimental
 int
 rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename);
 
+/**
+ * Per-queue rate limit information.
+ */
+struct rte_pmd_mlx5_txq_rate_limit_info {
+	uint32_t rate_mbps;	/**< Configured rate in Mbps, 0 = disabled. */
+	uint16_t pp_index;	/**< PP index from driver state. */
+	uint16_t fw_pp_index;	/**< PP index read back from FW SQ context. */
+};
+
+/**
+ * Query per-queue rate limit state for a given Tx queue.
+ *
+ * @param[in] port_id
+ *   Port ID.
+ * @param[in] queue_id
+ *   Tx queue ID.
+ * @param[out] info
+ *   Rate limit information.
+ *
+ * @return
+ *   0 on success, negative errno on failure:
+ *   - -ENODEV: invalid port_id.
+ *   - -EINVAL: invalid queue_id.
+ *   - -EIO: FW query failed.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
+				  struct rte_pmd_mlx5_txq_rate_limit_info *info);
+
 /** Type of mlx5 driver event for which custom callback is called. */
 enum rte_pmd_mlx5_driver_event_cb_type {
 	/** Called after HW Rx queue is created. */
-- 
2.43.0

