Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F2AC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 08:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4521F40668;
	Tue, 29 Jul 2025 10:25:02 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id B28EE40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 10:25:00 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-74b537e8d05so5379884b3a.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753777500; x=1754382300; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iLydthejrQqqSr/prHpTw7XDQhtiVwnq9hE49GrM2Q8=;
 b=A+pRVhDUI3EBU6FFMq3EH33eKG+NjU//p1ndqiFIaD/oL3OsBfUJoC64SKTKWt6CSm
 OjiBLi+1KC1FqNjlVyz3A3SDN+L533ZuvXp5kqHfJLgIUYclEpVWKCGI/TEB5kZYIPOH
 dGd+RyY9U0G/2aSXAnlAWQdwwRMce7tCRmNcORbM2Tz/PawHlE0aBuRSiedPW0Z2QjNv
 RGx9WhljBqoXY78y1XYY7BDf7u+vT9oei1n5d6ejcM2eNOJijZ3LCHRqFf6yYTAA6Jla
 7KDgQkrxsS7lwjUmrWbwUZ8Mm9wfY95NBciySD4YfMci/T9st+bUnHae1P2tahCNJhNL
 8jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753777500; x=1754382300;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iLydthejrQqqSr/prHpTw7XDQhtiVwnq9hE49GrM2Q8=;
 b=EqOkRH57cOu5/c0NSpVrufOCjL3UYqYmVIhlNN7neoPpqNkiNmKpOYpKG6QFJGGG/o
 B+UkXmDslUD36ZiLj9Ki7ujPj0EOA7fQoveoCljGJklqw9dJ0k1CCjjbVv+IA5w6oebI
 Y3OY6UwxTNlstTVzOiACR2v4Y1iF4PtEQTQngGK4AL0UfSromH5dnXJXqXmiylUFfIcM
 uRWOLzBq0QSAhI7s0INbve/agTEy47rjpND9X8/p8glGWzO5x2WtY4VXWHtt/MYHih+P
 tGi2g7WUa+k0qbUnGlEWcAi7vGLnL85hw7tc6y9YRND4rYhtXClFR9PUWU68w89+H/i8
 jEbw==
X-Gm-Message-State: AOJu0Yx0UcLx8ul0xP2nsYwjfl0fuRE4eAIKiPPYDYkDh78LESKfz6YX
 j5l5DLl6onQaMHKmnzlXrwPfDiZlKN9Xi9ezDZCOC/v+nlI1962z3DBgObcujcAj1b0vjfG5VVh
 khqCi+D/Mb97dwgpFsrf6il40dA==
X-Google-Smtp-Source: AGHT+IF2M098eNOIsx6lIriiI8Hh262I+5dfpM1nEHK8PA/NBHUuz9BMShJ+dckp1QpRm9rD+W/hxMzUYvZcaqe89g==
X-Received: from pfbml8.prod.google.com ([2002:a05:6a00:3d88:b0:748:e22c:600c])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9c:b0:21f:751a:dd41 with SMTP id
 adf61e73a8af0-23d70217da1mr24586247637.40.1753777499718; 
 Tue, 29 Jul 2025 01:24:59 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:24:56 +0000
In-Reply-To: <20250723074249.3264675-1-shivajikant@google.com>
Mime-Version: 1.0
References: <20250723074249.3264675-1-shivajikant@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729082456.796921-1-shivajikant@google.com>
Subject: [PATCH v2] net/af_xdp: enable AF_XDP program attachment mode
From: Shivaji Kant <shivajikant@google.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Shivaji Kant <shivajikant@google.com>, 
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
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
set of flags, defaulting to `XDP_FLAGS_UPDATE_IF_NOEXIST`. This lacks
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 75 ++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 5f65850a27..cf0077c62a 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -104,6 +104,7 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 
 static int afxdp_dev_count;
 
+
 /* Message header to synchronize fds via IPC */
 struct ipc_hdr {
 	char port_name[RTE_DEV_NAME_MAX_LEN];
@@ -169,6 +170,7 @@ struct pmd_internals {
 	int queue_cnt;
 	int max_queue_cnt;
 	int configured_queue_cnt;
+	uint mode_flag;
 	bool shared_umem;
 	char prog_path[PATH_MAX];
 	bool custom_prog_configured;
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
+	ret = bpf_xdp_query_id(internals->if_index, internals->mode_flag,
 			       &curr_prog_id);
 	if (ret != 0) {
 		AF_XDP_LOG_LINE(ERR, "bpf_xdp_query_id failed");
 		return ret;
 	}
 
-	ret = bpf_xdp_detach(internals->if_index, XDP_FLAGS_UPDATE_IF_NOEXIST,
+	ret = bpf_xdp_detach(internals->if_index, internals->mode_flag,
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
@@ -1305,7 +1328,7 @@ get_pinned_map(const char *dp_path, int *map_fd)
 }
 
 static int
-load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map)
+load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map, uint mode_flag)
 {
 	int ret, prog_fd;
 	struct bpf_object *obj;
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
+	cfg.xdp_flags = internals->mode_flag;
 	cfg.bind_flags = 0;
 
 	/* Force AF_XDP socket into copy mode when users want it */
@@ -1698,7 +1721,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 		if (!internals->custom_prog_configured) {
 			ret = load_custom_xdp_prog(internals->prog_path,
 							internals->if_index,
-							&internals->map);
+							&internals->map, internals->mode_flag);
 			if (ret) {
 				AF_XDP_LOG_LINE(ERR, "Failed to load custom XDP program %s",
 						internals->prog_path);
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
@@ -2094,7 +2136,7 @@ static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		 int *queue_cnt, int *shared_umem, char *prog_path,
 		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path)
+		 int *use_pinned_map, char *dp_path, uint *xdp_mode)
 {
 	int ret;
 
@@ -2147,6 +2189,10 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 
 	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
 				 &parse_prog_arg, dp_path);
+
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
+				 &parse_mode_arg, xdp_mode);
+
 	if (ret < 0)
 		goto free_kvlist;
 
@@ -2189,7 +2235,7 @@ static struct rte_eth_dev *
 init_internals(struct rte_vdev_device *dev, const char *if_name,
 	       int start_queue_idx, int queue_cnt, int shared_umem,
 	       const char *prog_path, int busy_budget, int force_copy,
-	       int use_cni, int use_pinned_map, const char *dp_path)
+	       int use_cni, int use_pinned_map, const char *dp_path, uint xdp_mode)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
@@ -2220,6 +2266,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->force_copy = force_copy;
 	internals->use_cni = use_cni;
 	internals->use_pinned_map = use_pinned_map;
+	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
@@ -2412,6 +2459,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	int force_copy = 0;
 	int use_cni = 0;
 	int use_pinned_map = 0;
+	uint xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
@@ -2456,7 +2504,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	if (parse_parameters(kvlist, if_name, &xsk_start_queue_idx,
 			     &xsk_queue_cnt, &shared_umem, prog_path,
 			     &busy_budget, &force_copy, &use_cni, &use_pinned_map,
-			     dp_path) < 0) {
+			     dp_path, &xdp_mode) < 0) {
 		AF_XDP_LOG_LINE(ERR, "Invalid kvargs value");
 		return -EINVAL;
 	}
@@ -2524,7 +2572,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	eth_dev = init_internals(dev, if_name, xsk_start_queue_idx,
 				 xsk_queue_cnt, shared_umem, prog_path,
 				 busy_budget, force_copy, use_cni, use_pinned_map,
-				 dp_path);
+				 dp_path, xdp_mode);
 	if (eth_dev == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to init internals");
 		return -1;
@@ -2587,4 +2635,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_xdp,
 			      "force_copy=<int> "
 			      "use_cni=<int> "
 			      "use_pinned_map=<int> "
-			      "dp_path=<string> ");
+			      "dp_path=<string> "
+			      "mode=<string> ");
-- 
2.50.1.470.g6ba607880d-goog

