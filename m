Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1906CFC72AD
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 13:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1654042E;
	Sun, 22 Mar 2026 14:49:02 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 0E8D640658
 for <dev@dpdk.org>; Sun, 22 Mar 2026 14:49:00 +0100 (CET)
Received: from localhost.localdomain (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 672D47804FD;
 Sun, 22 Mar 2026 14:48:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774187340;
 bh=A/Pp7twgMHo/krwrH+1TQj90uTacUsori0kQRR+mLck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uv9tRMkpooHykxWeYk0RlKJxNHuGxdKmkYIxhGDtx4OF3d+yDRUa9TJE1osnUspH0
 X28AFlKuHBeC4FYVwYhsq0PTxNS/jPv+b+cG4naupkJ4X75JDyfoUcdZBhPYVmlicp
 0gsu8kVUiXTq4a2wUzT20OQwgQ/V9sxt3wvTatolxMCboSK6mfQKwsJD4tdoLk9qLP
 pll3h30pmeayUOKH2394Wz6jmo7AAPQseWeeVxV+SjZHEldfrOEVU9gEDpcFbg9b/f
 u38VMXb1NBz4S6RL4w7WP2aL00zaReJ5kkKMEZWGG4iTSklXYV75ATq72+ZT4P/hGf
 TwFo4QJ7excIA==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 08/10] ethdev: add getter for per-queue Tx rate limit
Date: Sun, 22 Mar 2026 14:46:27 +0100
Message-ID: <20260322134629.94633-9-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322134629.94633-1-vjardin@free.fr>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
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

The existing rte_eth_set_queue_rate_limit() API allows setting a
per-queue Tx rate but provides no way to read it back. Applications
such as grout are forced to maintain a shadow copy of the rate to
be able to report it.

Add rte_eth_get_queue_rate_limit() as the symmetric getter, following
the established DPDK pattern (e.g. rte_eth_dev_set_mtu/get_mtu,
rte_eth_dev_set_vlan_offload/get_vlan_offload).

This adds:
- eth_get_queue_rate_limit_t driver callback in ethdev_driver.h
- rte_eth_get_queue_rate_limit() public experimental API (26.07)
- Trace point matching the existing setter pattern
- Generic testpmd command: show port <id> queue <id> rate

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 app/test-pmd/cmdline.c           | 69 ++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h       |  7 ++++
 lib/ethdev/ethdev_trace.h        |  9 +++++
 lib/ethdev/ethdev_trace_points.c |  3 ++
 lib/ethdev/rte_ethdev.c          | 35 ++++++++++++++++
 lib/ethdev/rte_ethdev.h          | 24 +++++++++++
 6 files changed, 147 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c5abeb5730..cc9c462498 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -8982,6 +8982,74 @@ static cmdline_parse_inst_t cmd_queue_rate_limit = {
 	},
 };
 
+/* *** SHOW RATE LIMIT FOR A QUEUE OF A PORT *** */
+struct cmd_show_queue_rate_limit_result {
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t port;
+	uint16_t port_num;
+	cmdline_fixed_string_t queue;
+	uint16_t queue_num;
+	cmdline_fixed_string_t rate;
+};
+
+static void cmd_show_queue_rate_limit_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl,
+		__rte_unused void *data)
+{
+	struct cmd_show_queue_rate_limit_result *res = parsed_result;
+	uint32_t tx_rate = 0;
+	int ret;
+
+	ret = rte_eth_get_queue_rate_limit(res->port_num, res->queue_num,
+					   &tx_rate);
+	if (ret) {
+		fprintf(stderr, "Get queue rate limit failed: %s\n",
+			rte_strerror(-ret));
+		return;
+	}
+	if (tx_rate)
+		printf("Port %u Queue %u rate limit: %u Mbps\n",
+		       res->port_num, res->queue_num, tx_rate);
+	else
+		printf("Port %u Queue %u rate limit: disabled\n",
+		       res->port_num, res->queue_num);
+}
+
+static cmdline_parse_token_string_t cmd_show_queue_rate_limit_show =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				show, "show");
+static cmdline_parse_token_string_t cmd_show_queue_rate_limit_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				port, "port");
+static cmdline_parse_token_num_t cmd_show_queue_rate_limit_portnum =
+	TOKEN_NUM_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				port_num, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_show_queue_rate_limit_queue =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				queue, "queue");
+static cmdline_parse_token_num_t cmd_show_queue_rate_limit_queuenum =
+	TOKEN_NUM_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				queue_num, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_show_queue_rate_limit_rate =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_queue_rate_limit_result,
+				rate, "rate");
+
+static cmdline_parse_inst_t cmd_show_queue_rate_limit = {
+	.f = cmd_show_queue_rate_limit_parsed,
+	.data = NULL,
+	.help_str = "show port <port_id> queue <queue_id> rate: "
+		"Show rate limit for a queue on port_id",
+	.tokens = {
+		(void *)&cmd_show_queue_rate_limit_show,
+		(void *)&cmd_show_queue_rate_limit_port,
+		(void *)&cmd_show_queue_rate_limit_portnum,
+		(void *)&cmd_show_queue_rate_limit_queue,
+		(void *)&cmd_show_queue_rate_limit_queuenum,
+		(void *)&cmd_show_queue_rate_limit_rate,
+		NULL,
+	},
+};
+
 /* *** SET RATE LIMIT FOR A VF OF A PORT *** */
 struct cmd_vf_rate_limit_result {
 	cmdline_fixed_string_t set;
@@ -14270,6 +14338,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_uc_all_hash_filter,
 	&cmd_vf_mac_addr_filter,
 	&cmd_queue_rate_limit,
+	&cmd_show_queue_rate_limit,
 	&cmd_tunnel_udp_config,
 	&cmd_showport_rss_hash,
 	&cmd_showport_rss_hash_key,
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..0f336f9567 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -762,6 +762,11 @@ typedef int (*eth_set_queue_rate_limit_t)(struct rte_eth_dev *dev,
 				uint16_t queue_idx,
 				uint32_t tx_rate);
 
+/** @internal Get queue Tx rate. */
+typedef int (*eth_get_queue_rate_limit_t)(struct rte_eth_dev *dev,
+				uint16_t queue_idx,
+				uint32_t *tx_rate);
+
 /** @internal Add tunneling UDP port. */
 typedef int (*eth_udp_tunnel_port_add_t)(struct rte_eth_dev *dev,
 					 struct rte_eth_udp_tunnel *tunnel_udp);
@@ -1522,6 +1527,8 @@ struct eth_dev_ops {
 
 	/** Set queue rate limit */
 	eth_set_queue_rate_limit_t set_queue_rate_limit;
+	/** Get queue rate limit */
+	eth_get_queue_rate_limit_t get_queue_rate_limit;
 
 	/** Configure RSS hash protocols and hashing key */
 	rss_hash_update_t          rss_hash_update;
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..6554cc1a21 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -908,6 +908,15 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_eth_trace_get_queue_rate_limit,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_idx,
+		int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u16(queue_idx);
+	rte_trace_point_emit_int(ret);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_rx_avail_thresh_set,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..0a28378a56 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -347,6 +347,9 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_uc_all_hash_table_set,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_set_queue_rate_limit,
 	lib.ethdev.set_queue_rate_limit)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_get_queue_rate_limit,
+	lib.ethdev.get_queue_rate_limit)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_avail_thresh_set,
 	lib.ethdev.rx_avail_thresh_set)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..5e763e1855 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -5694,6 +5694,41 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_queue_rate_limit, 26.07)
+int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
+					uint32_t *tx_rate)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (tx_rate == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Get queue rate limit:port %u: NULL tx_rate pointer",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (queue_idx >= dev->data->nb_tx_queues) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Get queue rate limit:port %u: invalid queue ID=%u",
+			port_id, queue_idx);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->get_queue_rate_limit == NULL)
+		return -ENOTSUP;
+	ret = eth_err(port_id,
+		      dev->dev_ops->get_queue_rate_limit(dev, queue_idx,
+							 tx_rate));
+
+	rte_eth_trace_get_queue_rate_limit(port_id, queue_idx, ret);
+
+	return ret;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..e525217b77 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -4817,6 +4817,30 @@ int rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on);
 int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 			uint32_t tx_rate);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Get the rate limitation for a queue on an Ethernet device.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param queue_idx
+ *   The queue ID.
+ * @param[out] tx_rate
+ *   A pointer to retrieve the Tx rate in Mbps.
+ *   0 means rate limiting is disabled.
+ * @return
+ *   - (0) if successful.
+ *   - (-ENOTSUP) if hardware doesn't support this feature.
+ *   - (-ENODEV) if *port_id* invalid.
+ *   - (-EIO) if device is removed.
+ *   - (-EINVAL) if bad parameter.
+ */
+__rte_experimental
+int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
+			uint32_t *tx_rate);
+
 /**
  * Configuration of Receive Side Scaling hash computation of Ethernet device.
  *
-- 
2.43.0

