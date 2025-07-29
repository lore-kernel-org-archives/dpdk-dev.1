Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C916C83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 16:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5200140659;
	Tue, 29 Jul 2025 18:17:53 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id F2FD440658
 for <dev@dpdk.org>; Tue, 29 Jul 2025 18:17:51 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-b31cc625817so28774a12.0
 for <dev@dpdk.org>; Tue, 29 Jul 2025 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753805871; x=1754410671; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=EorgbdttzpoVJ9in8gzSdrANS1sYgbGTNq0iQaKldtM=;
 b=MQI918Qjnm11WcbxJ+L47PZGxcRilbIB1Mo3DhfsthRwVFLaTtee3FwQSGW1uyi+TB
 srgnbtmcTbqFZf82d9yq1WP6SGPJPoXKWCUqjgVjXa23tyqa15D1sBAgNd1Y2AgTc1eQ
 y7DwRoMi1Vk4XqSkyvrdoDXa1GAO1wg3cLKSDQtUfKmMlEzrcwcBRHb8ULIejKebDgpL
 piTtsOHFJFT6dCPKnD9hc/ccz9TVBl3XITmuiyzVI8gZsKzLJi3A2oXnTr+fHp2DSclM
 7oYvb/wSFYoYI9xTlIEcsdK2a1zCjc2jV9MkGI0D5kHGgGfKOF1VHOv9RoS+0Ptw7pqc
 C4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805871; x=1754410671;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EorgbdttzpoVJ9in8gzSdrANS1sYgbGTNq0iQaKldtM=;
 b=lHDeBhO8N8vcrYYeJqX+1mPCLY7Risy5c3vtVYfPCI4w23khcxede9TndcvjM4jtS2
 db1w4byhQWfBgcHHV5JEvIP4LHaZMcisI+kCFx3JIOERP8XM1qUhllo3LubH/Gx2RkEK
 Buy28PQ1jjVbW4ZdA0v+F2xL3NnODRMw3/XUoLus1YcFKGflceuGXY5vCSiqlMIgkoDY
 UyeDyFiZTCuEWDat63igj6jt+6HkORZouuVNS1rE7OTI5dZVWvAB9PKxzxUnTh0qc80Y
 s+XlQJOT/CIQ8JrdLPVlQOumlnH2buoTLjzsdxionlOb3ejvy1mQMFBDh2jy+GOQwdN5
 CbeQ==
X-Gm-Message-State: AOJu0YwBXmvSK7UgY8TZRP5RKU90qLHHkI04DQC9WNXJoOwLqJ2bZ/LJ
 c4zTWwhYrdeYaX4EeYGrUwzNg3ZOAta3SxHKeHhpJXl5X8ZNaMt23eFrPgMh6MHVmmm7Djrpc/Y
 CbQI6Cxp2jG4YDLnf/tylUNKpWg==
X-Google-Smtp-Source: AGHT+IEMn/ARFSWKcMKoHjW3DVd2E9Or0g7c/h7hsSk32njq0gTKZLBdkcDFFqtOcceK3ft8k0kGZ44GE8C0F+zKow==
X-Received: from pgbee1.prod.google.com ([2002:a05:6a02:4581:b0:b42:13e:a0bd])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ac5:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-24063cbd79emr58256675ad.1.1753805871013; 
 Tue, 29 Jul 2025 09:17:51 -0700 (PDT)
Date: Tue, 29 Jul 2025 16:17:47 +0000
In-Reply-To: <20250729100845.819452-1-shivajikant@google.com>
Mime-Version: 1.0
References: <20250729100845.819452-1-shivajikant@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729161747.894377-1-shivajikant@google.com>
Subject: [PATCH v4] net/af_xdp: enable AF_XDP program attachment mode
From: Shivaji Kant <shivajikant@google.com>
To: Stephen Hemminger <stephen@networkplumber.org>
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
Changes in v2:
The attach mode flag was intended to be per device flag. So making
it part of the pmd_internals struct.
---
Changes in v3
Fix the build error for cases without RTE_NET_AF_XDP_LIBBPF_XDP_ATTACH
---
Changes in v4
Add check for invalid path argument return.
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 77 ++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 5f65850a27..9858ac24b2 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -169,6 +169,7 @@ struct pmd_internals {
 	int queue_cnt;
 	int max_queue_cnt;
 	int configured_queue_cnt;
+	uint mode_flag;
 	bool shared_umem;
 	char prog_path[PATH_MAX];
 	bool custom_prog_configured;
@@ -198,6 +199,26 @@ struct pmd_process_private {
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
@@ -210,6 +231,7 @@ static const char * const valid_arguments[] = {
 	ETH_AF_XDP_USE_CNI_ARG,
 	ETH_AF_XDP_USE_PINNED_MAP_ARG,
 	ETH_AF_XDP_DP_PATH_ARG,
+	ETH_AF_XDP_MODE_ARG,
 	NULL
 };
 
@@ -950,14 +972,14 @@ remove_xdp_program(struct pmd_internals *internals)
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
@@ -978,14 +1000,14 @@ remove_xdp_program(struct pmd_internals *internals)
 	int ret;
 
 	ret = bpf_get_link_xdp_id(internals->if_index, &curr_prog_id,
-				  XDP_FLAGS_UPDATE_IF_NOEXIST);
+				  internals->mode_flag);
 	if (ret != 0) {
 		AF_XDP_LOG_LINE(ERR, "bpf_get_link_xdp_id failed");
 		return ret;
 	}
 
 	ret = bpf_set_link_xdp_fd(internals->if_index, -1,
-				  XDP_FLAGS_UPDATE_IF_NOEXIST);
+				  internals->mode_flag);
 	if (ret != 0)
 		AF_XDP_LOG_LINE(ERR, "bpf_set_link_xdp_fd failed");
 	return ret;
@@ -1305,7 +1327,7 @@ get_pinned_map(const char *dp_path, int *map_fd)
 }
 
 static int
-load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map)
+load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map, uint mode_flag)
 {
 	int ret, prog_fd;
 	struct bpf_object *obj;
@@ -1328,7 +1350,7 @@ load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map)
 
 	/* Link the program with the given network device */
 	ret = link_xdp_prog_with_dev(if_index, prog_fd,
-					XDP_FLAGS_UPDATE_IF_NOEXIST);
+					mode_flag);
 	if (ret) {
 		AF_XDP_LOG_LINE(ERR, "Failed to set prog fd %d on interface",
 				prog_fd);
@@ -1679,7 +1701,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 	cfg.rx_size = ring_size;
 	cfg.tx_size = ring_size;
 	cfg.libbpf_flags = 0;
-	cfg.xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
+	cfg.xdp_flags = internals->mode_flag;
 	cfg.bind_flags = 0;
 
 	/* Force AF_XDP socket into copy mode when users want it */
@@ -1698,7 +1720,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 		if (!internals->custom_prog_configured) {
 			ret = load_custom_xdp_prog(internals->prog_path,
 							internals->if_index,
-							&internals->map);
+							&internals->map, internals->mode_flag);
 			if (ret) {
 				AF_XDP_LOG_LINE(ERR, "Failed to load custom XDP program %s",
 						internals->prog_path);
@@ -2017,6 +2039,25 @@ parse_name_arg(const char *key __rte_unused,
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
@@ -2094,7 +2135,7 @@ static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		 int *queue_cnt, int *shared_umem, char *prog_path,
 		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path)
+		 int *use_pinned_map, char *dp_path, uint *xdp_mode)
 {
 	int ret;
 
@@ -2147,6 +2188,13 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 
 	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
 				 &parse_prog_arg, dp_path);
+
+	if (ret < 0)
+		goto free_kvlist;
+
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
+				 &parse_mode_arg, xdp_mode);
+
 	if (ret < 0)
 		goto free_kvlist;
 
@@ -2189,7 +2237,7 @@ static struct rte_eth_dev *
 init_internals(struct rte_vdev_device *dev, const char *if_name,
 	       int start_queue_idx, int queue_cnt, int shared_umem,
 	       const char *prog_path, int busy_budget, int force_copy,
-	       int use_cni, int use_pinned_map, const char *dp_path)
+	       int use_cni, int use_pinned_map, const char *dp_path, uint xdp_mode)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
@@ -2220,6 +2268,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->force_copy = force_copy;
 	internals->use_cni = use_cni;
 	internals->use_pinned_map = use_pinned_map;
+	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
@@ -2412,6 +2461,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	int force_copy = 0;
 	int use_cni = 0;
 	int use_pinned_map = 0;
+	uint xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
@@ -2456,7 +2506,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	if (parse_parameters(kvlist, if_name, &xsk_start_queue_idx,
 			     &xsk_queue_cnt, &shared_umem, prog_path,
 			     &busy_budget, &force_copy, &use_cni, &use_pinned_map,
-			     dp_path) < 0) {
+			     dp_path, &xdp_mode) < 0) {
 		AF_XDP_LOG_LINE(ERR, "Invalid kvargs value");
 		return -EINVAL;
 	}
@@ -2524,7 +2574,7 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	eth_dev = init_internals(dev, if_name, xsk_start_queue_idx,
 				 xsk_queue_cnt, shared_umem, prog_path,
 				 busy_budget, force_copy, use_cni, use_pinned_map,
-				 dp_path);
+				 dp_path, xdp_mode);
 	if (eth_dev == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to init internals");
 		return -1;
@@ -2587,4 +2637,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_xdp,
 			      "force_copy=<int> "
 			      "use_cni=<int> "
 			      "use_pinned_map=<int> "
-			      "dp_path=<string> ");
+			      "dp_path=<string> "
+			      "mode=<string> ");
-- 
2.50.1.552.g942d659e1b-goog

