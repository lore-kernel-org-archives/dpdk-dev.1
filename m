Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AE8C83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 07:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1614B402DF;
	Wed, 23 Jul 2025 09:42:54 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 6D506402CA
 for <dev@dpdk.org>; Wed, 23 Jul 2025 09:42:53 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-235e7550f7bso67031685ad.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753256572; x=1753861372; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Awem01PcGH6C0n4hU95QEmCQ5dumS6QL61a2ndJeEdE=;
 b=TgZMg0pYWuzmzsu1Vo6UDsdcoMQ8HxIFo7NIhRk+IBV3eIGRgz/YEmiU0CZFlYHnjS
 05uFtCE3V755H+MIi52yCLQU7hQ0ZE1tatgF6jG3OoUkx7xXy9McCY1syBE6sG2+T1x5
 pxIL8rk9BoyHfdwaNJzOE4IgCJAjBugdgw/aQ3LeCRl6EwyvW8JkEIF37D1Nav6y/WP6
 u0lrrIL54onx0EP7idhUUzkCMROk4dQwMkisrjA6rqTxpa9SaDGkAREmTuzHjuBNsf3k
 VcPV8vLEhUkg6yMcaRiVPkLK+ozb+F72HrAJGcejIAHvrjbUd5wHzbHNuZZhk7SiFVIs
 D6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753256572; x=1753861372;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Awem01PcGH6C0n4hU95QEmCQ5dumS6QL61a2ndJeEdE=;
 b=mqSkRD6R54MTPcwMCs/dmOE5imduD/O0RoYPteNQV879EKvBI0fEATBdgxeWo6WXGg
 i824anxE/EqDjymjyfbnBOImLpXd1UypsV+L71jY3oZyYEnNOYf8wy3Q8P/LmB0WrIZF
 pxVgQUMpyTvXKDHvFlRU/+sHl7jL7tpqLmoK+ILQbjeFzeCqHf9IyB8DukQ3sfXigsMS
 w59iOfS1u6efRRzxwnqVs/N9bFGAgACbnF+hdHAGQrPvKaHnfFQuVvYqdLiXLCMgNz6L
 Z9vT9TO2DIDMSVLoth3Y805PDgtGBsBjWBMKpotTaB1isdAR1Hp/anbK3QKhUmtXBttV
 /eXg==
X-Gm-Message-State: AOJu0YwmdF4EyR5o/QI3LKdeYCZPbQehFb+qPuMdqrarUjmCMwbnpNba
 vpUOd5SJh++/o2UsXy0MwfXhhnAgpJrG0wWmajsTpmOYr3HiWpSWgMcUICcJya3UAXrYdDfxjdO
 oY/+AxUsSR7cDiuXbVxRGkPN84Q==
X-Google-Smtp-Source: AGHT+IFB8rgxqkdCyskXsU4RMqFCpgN0aoySmuErfAMP5TMPNsMjBttzc68uSsEJfNoeJdS/h1kzFfQn9sQAkJKXHA==
X-Received: from plbmb16.prod.google.com ([2002:a17:903:990:b0:236:9d77:8f68])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bad:b0:234:f6ba:e681 with SMTP id
 d9443c01a7336-23f9816196amr25041315ad.5.1753256572593; 
 Wed, 23 Jul 2025 00:42:52 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:42:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723074249.3264675-1-shivajikant@google.com>
Subject: [PATCH] net/af_xdp: enable AF_XDP program attachment mode
From: Shivaji Kant <shivajikant@google.com>
To: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Shivaji Kant <shivajikant@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently, the AF_XDP PMD attaches its XDP program using a fixed
set of flags,defaulting to `XDP_FLAGS_UPDATE_IF_NOEXIST`. This lacks
flexibility for users who might need to explicitly control the XDP
mode based on their specific hardware capabilities or performance
requirements.

This patch introduces a new vdev argument, `mode`, for the `net_af_xdp`
PMD. This argument allows users to explicitly specify the desired
XDP program attachment mode:
`drv` (XDP_FLAGS_DRV_MODE),
`skb` (XDP_FLAGS_SKB_MODE),
`hw` (XDP_FLAGS_HW_MODE).
(If needed more can be added)

This change provides greater control and flexibility for users to
fine-tune AF_XDP behavior, enabling them to leverage native driver
or hardware offload capabilities when available, or fall back to
generic SKB mode for broader compatibility.

Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 61 +++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 5f65850a27..e39f2b4935 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -104,6 +104,8 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 
 static int afxdp_dev_count;
 
+static __u32 mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST;
+
 /* Message header to synchronize fds via IPC */
 struct ipc_hdr {
 	char port_name[RTE_DEV_NAME_MAX_LEN];
@@ -198,6 +200,26 @@ struct pmd_process_private {
 #define ETH_AF_XDP_USE_CNI_ARG			"use_cni"
 #define ETH_AF_XDP_USE_PINNED_MAP_ARG	"use_pinned_map"
 #define ETH_AF_XDP_DP_PATH_ARG			"dp_path"
+#define ETH_AF_XDP_MODE_ARG				"mode"
+
+/* Define different modes for af_xdp prog to attach */
+#define ETH_AF_XDP_DRV_MODE_ARG			"drv"
+#define ETH_AF_XDP_SKB_MODE_ARG			"skb"
+#define ETH_AF_XDP_HW_MODE_ARG			"hw"
+#define ETH_AF_XDP_NUM_MODE_ARG			3
+
+static const char * const mode_arguments[] = {
+	ETH_AF_XDP_DRV_MODE_ARG,
+	ETH_AF_XDP_SKB_MODE_ARG,
+	ETH_AF_XDP_HW_MODE_ARG,
+	NULL
+};
+
+static const unsigned int mode_flags[] = {
+	XDP_FLAGS_DRV_MODE,
+	XDP_FLAGS_SKB_MODE,
+	XDP_FLAGS_HW_MODE
+};
 
 static const char * const valid_arguments[] = {
 	ETH_AF_XDP_IFACE_ARG,
@@ -210,6 +232,7 @@ static const char * const valid_arguments[] = {
 	ETH_AF_XDP_USE_CNI_ARG,
 	ETH_AF_XDP_USE_PINNED_MAP_ARG,
 	ETH_AF_XDP_DP_PATH_ARG,
+	ETH_AF_XDP_MODE_ARG,
 	NULL
 };
 
@@ -950,14 +973,14 @@ remove_xdp_program(struct pmd_internals *internals)
 	uint32_t curr_prog_id = 0;
 	int ret;
 
-	ret = bpf_xdp_query_id(internals->if_index, XDP_FLAGS_UPDATE_IF_NOEXIST,
+	ret = bpf_xdp_query_id(internals->if_index, mode_flag,
 			       &curr_prog_id);
 	if (ret != 0) {
 		AF_XDP_LOG_LINE(ERR, "bpf_xdp_query_id failed");
 		return ret;
 	}
 
-	ret = bpf_xdp_detach(internals->if_index, XDP_FLAGS_UPDATE_IF_NOEXIST,
+	ret = bpf_xdp_detach(internals->if_index, mode_flag,
 			     NULL);
 	if (ret != 0)
 		AF_XDP_LOG_LINE(ERR, "bpf_xdp_detach failed");
@@ -978,14 +1001,14 @@ remove_xdp_program(struct pmd_internals *internals)
 	int ret;
 
 	ret = bpf_get_link_xdp_id(internals->if_index, &curr_prog_id,
-				  XDP_FLAGS_UPDATE_IF_NOEXIST);
+				  mode_flag);
 	if (ret != 0) {
 		AF_XDP_LOG_LINE(ERR, "bpf_get_link_xdp_id failed");
 		return ret;
 	}
 
 	ret = bpf_set_link_xdp_fd(internals->if_index, -1,
-				  XDP_FLAGS_UPDATE_IF_NOEXIST);
+				  mode_flag);
 	if (ret != 0)
 		AF_XDP_LOG_LINE(ERR, "bpf_set_link_xdp_fd failed");
 	return ret;
@@ -1328,7 +1351,7 @@ load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map)
 
 	/* Link the program with the given network device */
 	ret = link_xdp_prog_with_dev(if_index, prog_fd,
-					XDP_FLAGS_UPDATE_IF_NOEXIST);
+					mode_flag);
 	if (ret) {
 		AF_XDP_LOG_LINE(ERR, "Failed to set prog fd %d on interface",
 				prog_fd);
@@ -1679,7 +1702,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 	cfg.rx_size = ring_size;
 	cfg.tx_size = ring_size;
 	cfg.libbpf_flags = 0;
-	cfg.xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
+	cfg.xdp_flags = mode_flag;
 	cfg.bind_flags = 0;
 
 	/* Force AF_XDP socket into copy mode when users want it */
@@ -2017,6 +2040,25 @@ parse_name_arg(const char *key __rte_unused,
 	return 0;
 }
 
+/** parse name argument */
+static int
+parse_mode_arg(const char *key __rte_unused,
+	       const char *value, void *extra_args)
+{
+	unsigned int *mode = extra_args;
+	unsigned int i;
+
+	for (i = 0; i < ETH_AF_XDP_NUM_MODE_ARG; i++) {
+		if (strcmp(value, mode_arguments[i]) == 0) {
+			*mode |= mode_flags[i];
+			return 0;
+		}
+	}
+
+	AF_XDP_LOG_LINE(ERR, "Invalid af_xdp mode, choose correct mode to attach af_xdp program.");
+	return -EINVAL;
+}
+
 /** parse xdp prog argument */
 static int
 parse_prog_arg(const char *key __rte_unused,
@@ -2147,6 +2189,10 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 
 	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
 				 &parse_prog_arg, dp_path);
+
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
+				 &parse_mode_arg, &mode_flag);
+
 	if (ret < 0)
 		goto free_kvlist;
 
@@ -2587,4 +2633,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_xdp,
 			      "force_copy=<int> "
 			      "use_cni=<int> "
 			      "use_pinned_map=<int> "
-			      "dp_path=<string> ");
+			      "dp_path=<string> "
+			      "mode=<string> ");
-- 
2.50.0.727.gbf7dc18ff4-goog

