Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E9CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2809142EA5;
	Tue, 29 Sep 2026 18:38:43 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 985D542E6F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:23 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469f204f6so2147470b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699903;
 x=1791304703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hW9ygDpcbVVgnECf3eo89zeWTtHq4X9QPTtD0AZ5G/s=;
 b=QGYtGdziSoarczbqx97Orn1t8qCvpcoR1Ni+xsN/6gBrD5RjCH3tv0MJ1H4uAFIhx7
 5YnwunjxoBwIF1cJHlwG2aZ5sVduyyUScRXikFxjRPPL8/Yo2r9RC9AqAcZVbooe4MZi
 marcnyCqdPrkCjzoB+NF22w3QVsa0fNt9kboDsVAO88tsDT/jCYFJBpQQZreK4xoM5XM
 LpBfGvY55wdFqt73aR0WZKz6xLpjIm0d7f9DTDq6YoaQ2/C4CLFS8x4F+2LlX9hJxTvr
 3dAr2+5svjCs+5Afuujs7yokNaMd4abu8rdvOJbwWfU8VVzemKGAF5QRq8rgtt8JSQCo
 jpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699903; x=1791304703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hW9ygDpcbVVgnECf3eo89zeWTtHq4X9QPTtD0AZ5G/s=;
 b=GU1SUNHiPwYR54JrhdDC7sybWKeVuS8va4EusmK2xTxeV3LJFVJNN7YRzTK1OhSV9o
 ECwdOZnai4Nkmagfi6eyLk8MS+1xpPP5Wl+wa4sNO/pIgKi+iyl8OEDV8lMjeIuQwEHS
 7dNX2E33WQoZXYqr16oWBHHuUyYVlVikjYt8TqxXo1mxmbS6LgBB4wU7k78d4kxvYAd7
 90xW9oLwJq8axZeSaG7qF69aejxMbyiOOPEnU7tgB5pPqg4uR6g3XEuAweqoUMZEFk1j
 Re7CK5l/7kK4TLMM90a7C/kRsaiMdKLoyBMuBlHnvZz/gdK4Wt3LEh9O0uszyOloNo+I
 1yZw==
X-Gm-Message-State: AFuF++mlh0rBSe27chW08NAgwnXzSOANubpAoX2a7yt0RI9zEcFxekEi
 4rTmIpmswJV4gyhf9SjIS0QwX1HW3WblTWPUo39CcnHlY5bk/O92iaQoRrVvFB2orFMqQCz0YAN
 nZkwX8Y4=
X-Gm-Gg: AYBFou0shpHWrC2JrHmfmYfmaYuqTYMqUdb1ehKToj4juBm9zQMu2CypMMQeaDV/tWe
 zDhw9oX235CPZ9V9lTvzl6PDtD7d5pmqAgDPNAMjV+jicY06RWw764+oXBrBCg7nDtH5OEYqsGg
 2D3vCA6xVbIsMztsKads0xIgVdQPMAXrXo03P/G+gJrMGJmlmWqTyiDFeUSEZD12f2qs8s6UxNr
 7dFbhqx5tX9L4+3uTqj2+kaIpvmTfSO8u07Am1yXog15jIdHGe8eOPhSPLeJGFO35R2Ogtg/1cG
 QTtCHSgpIIHcjsOf9QcTdHksFcd1UiEjpcG1HCwsbdQHVRF0Jqd7xlDtj933eLc45P+JjBE0LOy
 GUDFcu1afu4EClce0tL9csG/f2sODVf+DopqaQp97maha7ZOqcaZ7yFYJmUQwni07T4tC1jCYnu
 SqMC3/HI48tmALkAp5HFkOP/zfxtd6w9oRcDPtKWS9TfGxGowqnINOq1fJlEERfFrUI/M+Jjdyz
 pTpoGA574uDNQUFDhWEbI68sYvogySXoQKSxawpExeWkFYq
X-Received: by 2002:a05:6a00:22c7:b0:881:4b47:f30b with SMTP id
 d2e1a72fcca58-8814b47f8a5mr8459405b3a.12.1790699902380; 
 Tue, 29 Sep 2026 09:38:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH v2 16/61] net/af_xdp: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:19 -0700
Message-ID: <20260929163800.1108305-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

parse_integer_arg(), parse_budget_arg() and parse_hex_arg() open coded
the string to number conversion. parse_budget_arg() checked neither the
end pointer nor errno, so "busy_budget=foo" was silently taken as zero,
and it stored the unvalidated result before testing it, so a rejected
argument still overwrote the caller's default. Replace all three with
the kvargs helpers, keeping only the wrappers which apply a range or a
width that no handler provides.

The shared_umem, force_copy, use_cni and use_pinned_map arguments are
booleans, and are already stored as bool in the internals, so parse them
as bool rather than as int. They use rte_kvargs_process_opt(), so that a
bare key with no value enables the option.

Queue counts and indexes are counts, not signed quantities, so use
uint16_t for them; the ethdev layer cannot address more queues than that
anyway. The ethtool channel counts are 32 bit, so clamp them to
RTE_MAX_QUEUES_PER_PORT rather than truncating.

Collect the parsed arguments into a struct af_xdp_devargs and drive the
parsing from a table, which replaces the fifteen argument parameter list
of parse_parameters() and the thirteen of init_internals() with a single
pointer. The kvargs list is now freed by the function which parsed it,
rather than by the one which did not allocate it, which also fixes the
leak on the paths where probe returned early after parse_parameters()
succeeded.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 431 ++++++++++++++--------------
 1 file changed, 217 insertions(+), 214 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 9c99dcec20..6d346a736f 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -178,10 +178,10 @@ struct pkt_tx_queue {
 struct pmd_internals {
 	int if_index;
 	char if_name[IFNAMSIZ];
-	int start_queue_idx;
-	int queue_cnt;
-	int max_queue_cnt;
-	int configured_queue_cnt;
+	uint16_t start_queue_idx;
+	uint16_t queue_cnt;
+	uint16_t max_queue_cnt;
+	uint16_t configured_queue_cnt;
 	uint32_t mode_flag;
 	bool shared_umem;
 	char prog_path[PATH_MAX];
@@ -258,6 +258,24 @@ static const char * const valid_arguments[] = {
 	NULL
 };
 
+/* Device arguments, as parsed from the vdev argument string. */
+struct af_xdp_devargs {
+	char if_name[IFNAMSIZ];
+	uint16_t start_queue_idx;
+	uint16_t queue_cnt;
+	bool shared_umem;
+	char prog_path[PATH_MAX];
+	int busy_budget;		/**< -1 until the default is applied */
+	bool force_copy;
+	bool use_cni;
+	bool use_pinned_map;
+	char dp_path[PATH_MAX];
+	uint32_t xdp_mode;
+	int rx_timestamp_offset;	/**< -1 when not specified */
+	int rx_timestamp_valid_offset;	/**< -1 when not specified */
+	uint8_t rx_timestamp_valid_mask;
+};
+
 static const struct rte_eth_link pmd_link = {
 	.link_speed = RTE_ETH_SPEED_NUM_10G,
 	.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
@@ -2270,67 +2288,85 @@ static const struct eth_dev_ops ops_afxdp_dp = {
 	.read_clock = eth_af_xdp_read_clock,
 };
 
-/** parse busy_budget argument */
+/**
+ * Parse busy_budget, which is a uint16_t stored in an int so that -1 can
+ * mean "not specified" until the default is applied.
+ */
 static int
 parse_budget_arg(const char *key __rte_unused,
 		  const char *value, void *extra_args)
 {
-	int *i = (int *)extra_args;
-	char *end;
+	int64_t budget;
+	int ret;
 
-	*i = strtol(value, &end, 10);
-	if (*i < 0 || *i > UINT16_MAX) {
-		AF_XDP_LOG_LINE(ERR, "Invalid busy_budget %i, must be >= 0 and <= %u",
-				*i, UINT16_MAX);
-		return -EINVAL;
+	ret = rte_kvargs_to_int(value, 0, UINT16_MAX, &budget);
+	if (ret < 0) {
+		AF_XDP_LOG_LINE(ERR, "Invalid busy_budget, must be >= 0 and <= %u",
+				UINT16_MAX);
+		return ret;
 	}
 
+	*(int *)extra_args = budget;
 	return 0;
 }
 
-/** parse integer from integer argument */
+/** parse queue_count, which must leave at least one queue */
 static int
-parse_integer_arg(const char *key __rte_unused,
-		  const char *value, void *extra_args)
+parse_queue_count_arg(const char *key __rte_unused,
+		      const char *value, void *extra_args)
 {
-	int *i = (int *)extra_args;
-	char *end;
-	long val;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
+	uint64_t queue_cnt;
+	int ret;
 
-	errno = 0;
-	val = strtol(value, &end, 10);
-	if (errno != 0 || end == value || *end != '\0' || val < 0 || val > INT_MAX) {
-		AF_XDP_LOG_LINE(ERR, "Argument has to be a valid non-negative integer.");
-		return -EINVAL;
+	ret = rte_kvargs_to_uint(value, 1, RTE_MAX_QUEUES_PER_PORT, &queue_cnt);
+	if (ret < 0) {
+		AF_XDP_LOG_LINE(ERR, "Invalid queue count, must be >= 1 and <= %u",
+				RTE_MAX_QUEUES_PER_PORT);
+		return ret;
 	}
 
-	*i = (int)val;
+	*(uint16_t *)extra_args = queue_cnt;
 	return 0;
 }
 
-/** parse hex from argument */
+/**
+ * Parse a metadata offset into the packet headroom. Stored in an int so
+ * that -1 can mean "not specified"; a negative value from the user would
+ * be indistinguishable from that, so only zero and above are accepted.
+ */
 static int
-parse_hex_arg(const char *key __rte_unused,
-	      const char *value, void *extra_args)
+parse_offset_arg(const char *key __rte_unused,
+		 const char *value, void *extra_args)
 {
-	int *i = (int *)extra_args;
-	char *end;
-	unsigned long val;
+	int64_t offset;
+	int ret;
 
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
+	ret = rte_kvargs_to_int(value, 0, XDP_PACKET_HEADROOM, &offset);
+	if (ret < 0) {
+		AF_XDP_LOG_LINE(ERR, "Invalid metadata offset, must be >= 0 and <= %u",
+				XDP_PACKET_HEADROOM);
+		return ret;
+	}
 
-	errno = 0;
-	val = strtoul(value, &end, 16);
-	if (errno != 0 || end == value || *end != '\0' || val > UINT8_MAX) {
+	*(int *)extra_args = offset;
+	return 0;
+}
+
+/** parse the validity hint mask, a bare hexadecimal byte */
+static int
+parse_mask_arg(const char *key __rte_unused,
+	       const char *value, void *extra_args)
+{
+	uint64_t mask;
+	int ret;
+
+	ret = rte_kvargs_to_hex(value, UINT8_MAX, &mask);
+	if (ret < 0) {
 		AF_XDP_LOG_LINE(ERR, "Validity mask must be a valid hex byte (0-0xFF).");
-		return -EINVAL;
+		return ret;
 	}
 
-	*i = (int)val;
+	*(uint8_t *)extra_args = mask;
 	return 0;
 }
 
@@ -2396,12 +2432,14 @@ parse_prog_arg(const char *key __rte_unused,
 }
 
 static int
-xdp_get_channels_info(const char *if_name, int *max_queues,
-				int *configured_queues)
+xdp_get_channels_info(const char *if_name, uint16_t *max_queues,
+				uint16_t *configured_queues)
 {
+	const uint32_t max_q = RTE_MAX_QUEUES_PER_PORT;
 	struct ethtool_channels channels;
 	struct ifreq ifr;
-	int fd, ret, rxtx_q_count;
+	uint32_t rxtx_q_count;
+	int fd, ret;
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (fd < 0)
@@ -2423,6 +2461,9 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
 	/* For drivers with rx/tx queue configured */
 	rxtx_q_count = RTE_MIN(channels.rx_count, channels.tx_count);
 
+	/* The ethtool counts are 32 bit, but a port cannot have more
+	 * queues than the ethdev layer allows.
+	 */
 	if ((channels.max_combined == 0 && rxtx_q_count == 0) || errno == EOPNOTSUPP) {
 		/* If the device says it has no channels, then all traffic
 		 * is sent to a single stream, so max queues = 1.
@@ -2430,12 +2471,14 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
 		*max_queues = 1;
 		*configured_queues = 1;
 	} else if (channels.max_combined > 0) {
-		*max_queues = channels.max_combined;
-		*configured_queues = channels.combined_count;
+		*max_queues = RTE_MIN(channels.max_combined, max_q);
+		*configured_queues = RTE_MIN(channels.combined_count, max_q);
 		AF_XDP_LOG_LINE(INFO, "Using Combined queues configuration");
 	} else {
-		*max_queues = RTE_MIN(channels.max_rx, channels.max_tx);
-		*configured_queues = rxtx_q_count;
+		uint32_t max_rxtx = RTE_MIN(channels.max_rx, channels.max_tx);
+
+		*max_queues = RTE_MIN(max_rxtx, max_q);
+		*configured_queues = RTE_MIN(rxtx_q_count, max_q);
 		AF_XDP_LOG_LINE(INFO, "Using Rx/Tx queues configuration");
 	}
 
@@ -2445,92 +2488,64 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
 }
 
 static int
-parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
-		 int *queue_cnt, int *shared_umem, char *prog_path,
-		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode,
-		 int *rx_timestamp_offset, int *rx_timestamp_valid_offset,
-		 int *rx_timestamp_valid_mask)
+parse_parameters(struct rte_kvargs *kvlist, struct af_xdp_devargs *devargs)
 {
-	int ret;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_IFACE_ARG,
-				 &parse_name_arg, if_name);
-	if (ret < 0)
-		goto free_kvlist;
+	/*
+	 * The boolean arguments are processed with rte_kvargs_process_opt()
+	 * so that a bare key, with no value, enables the option.
+	 */
+	static const struct {
+		const char *key;
+		arg_handler_t handler;
+		size_t offset;
+		bool optional_value;
+	} args[] = {
+		{ ETH_AF_XDP_IFACE_ARG, parse_name_arg,
+		  offsetof(struct af_xdp_devargs, if_name) },
+		{ ETH_AF_XDP_START_QUEUE_ARG, rte_kvargs_handle_u16,
+		  offsetof(struct af_xdp_devargs, start_queue_idx) },
+		{ ETH_AF_XDP_QUEUE_COUNT_ARG, parse_queue_count_arg,
+		  offsetof(struct af_xdp_devargs, queue_cnt) },
+		{ ETH_AF_XDP_SHARED_UMEM_ARG, rte_kvargs_handle_bool,
+		  offsetof(struct af_xdp_devargs, shared_umem), true },
+		{ ETH_AF_XDP_PROG_ARG, parse_prog_arg,
+		  offsetof(struct af_xdp_devargs, prog_path) },
+		{ ETH_AF_XDP_BUDGET_ARG, parse_budget_arg,
+		  offsetof(struct af_xdp_devargs, busy_budget) },
+		{ ETH_AF_XDP_FORCE_COPY_ARG, rte_kvargs_handle_bool,
+		  offsetof(struct af_xdp_devargs, force_copy), true },
+		{ ETH_AF_XDP_USE_CNI_ARG, rte_kvargs_handle_bool,
+		  offsetof(struct af_xdp_devargs, use_cni), true },
+		{ ETH_AF_XDP_USE_PINNED_MAP_ARG, rte_kvargs_handle_bool,
+		  offsetof(struct af_xdp_devargs, use_pinned_map), true },
+		{ ETH_AF_XDP_DP_PATH_ARG, parse_prog_arg,
+		  offsetof(struct af_xdp_devargs, dp_path) },
+		{ ETH_AF_XDP_MODE_ARG, parse_mode_arg,
+		  offsetof(struct af_xdp_devargs, xdp_mode) },
+		{ ETH_AF_XDP_RX_TIMESTAMP_OFFSET_ARG, parse_offset_arg,
+		  offsetof(struct af_xdp_devargs, rx_timestamp_offset) },
+		{ ETH_AF_XDP_RX_TIMESTAMP_VALID_OFFSET_ARG, parse_offset_arg,
+		  offsetof(struct af_xdp_devargs, rx_timestamp_valid_offset) },
+		{ ETH_AF_XDP_RX_TIMESTAMP_VALID_MASK_ARG, parse_mask_arg,
+		  offsetof(struct af_xdp_devargs, rx_timestamp_valid_mask) },
+	};
+	unsigned int i;
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_START_QUEUE_ARG,
-				 &parse_integer_arg, start_queue);
-	if (ret < 0)
-		goto free_kvlist;
+	for (i = 0; i < RTE_DIM(args); i++) {
+		void *target = RTE_PTR_ADD(devargs, args[i].offset);
+		int ret;
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_QUEUE_COUNT_ARG,
-				 &parse_integer_arg, queue_cnt);
-	if (ret < 0 || *queue_cnt <= 0) {
-		ret = -EINVAL;
-		goto free_kvlist;
+		if (args[i].optional_value)
+			ret = rte_kvargs_process_opt(kvlist, args[i].key,
+						     args[i].handler, target);
+		else
+			ret = rte_kvargs_process(kvlist, args[i].key,
+						 args[i].handler, target);
+		if (ret < 0)
+			return ret;
 	}
 
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_SHARED_UMEM_ARG,
-				&parse_integer_arg, shared_umem);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_PROG_ARG,
-				 &parse_prog_arg, prog_path);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_BUDGET_ARG,
-				&parse_budget_arg, busy_budget);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_FORCE_COPY_ARG,
-				&parse_integer_arg, force_copy);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_USE_CNI_ARG,
-				 &parse_integer_arg, use_cni);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_USE_PINNED_MAP_ARG,
-				 &parse_integer_arg, use_pinned_map);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
-				 &parse_prog_arg, dp_path);
-
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
-				 &parse_mode_arg, xdp_mode);
-
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_OFFSET_ARG,
-				 &parse_integer_arg, rx_timestamp_offset);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_VALID_OFFSET_ARG,
-				 &parse_integer_arg, rx_timestamp_valid_offset);
-	if (ret < 0)
-		goto free_kvlist;
-
-	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_VALID_MASK_ARG,
-				 &parse_hex_arg, rx_timestamp_valid_mask);
-	if (ret < 0)
-		goto free_kvlist;
-
-free_kvlist:
-	rte_kvargs_free(kvlist);
-	return ret;
+	return 0;
 }
 
 static int
@@ -2564,57 +2579,54 @@ get_iface_info(const char *if_name,
 }
 
 static struct rte_eth_dev *
-init_internals(struct rte_vdev_device *dev, const char *if_name,
-	       int start_queue_idx, int queue_cnt, int shared_umem,
-	       const char *prog_path, int busy_budget, int force_copy,
-	       int use_cni, int use_pinned_map, const char *dp_path, uint32_t xdp_mode,
-	       int rx_timestamp_offset, int rx_timestamp_valid_offset,
-	       int rx_timestamp_valid_mask)
+init_internals(struct rte_vdev_device *dev,
+	       const struct af_xdp_devargs *devargs)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
+	const uint16_t queue_cnt = devargs->queue_cnt;
 	struct pmd_process_private *process_private;
 	struct pmd_internals *internals;
 	struct rte_eth_dev *eth_dev;
+	uint16_t i;
 	int ret;
-	int i;
 
 	internals = rte_zmalloc_socket(name, sizeof(*internals), 0, numa_node);
 	if (internals == NULL)
 		return NULL;
 
-	internals->start_queue_idx = start_queue_idx;
+	internals->start_queue_idx = devargs->start_queue_idx;
 	internals->queue_cnt = queue_cnt;
-	strlcpy(internals->if_name, if_name, IFNAMSIZ);
-	strlcpy(internals->prog_path, prog_path, PATH_MAX);
+	strlcpy(internals->if_name, devargs->if_name, IFNAMSIZ);
+	strlcpy(internals->prog_path, devargs->prog_path, PATH_MAX);
 	internals->custom_prog_configured = 0;
 
 #ifndef ETH_AF_XDP_SHARED_UMEM
-	if (shared_umem) {
+	if (devargs->shared_umem) {
 		AF_XDP_LOG_LINE(ERR, "Shared UMEM feature not available. "
 				"Check kernel and libbpf version");
 		goto err_free_internals;
 	}
 #endif
-	internals->shared_umem = shared_umem;
-	internals->force_copy = force_copy;
-	internals->use_cni = use_cni;
-	internals->use_pinned_map = use_pinned_map;
-	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
-	strlcpy(internals->dp_path, dp_path, PATH_MAX);
-	internals->rx_timestamp_offset = rx_timestamp_offset;
-	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
-	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
-
-	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
+	internals->shared_umem = devargs->shared_umem;
+	internals->force_copy = devargs->force_copy;
+	internals->use_cni = devargs->use_cni;
+	internals->use_pinned_map = devargs->use_pinned_map;
+	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | devargs->xdp_mode;
+	strlcpy(internals->dp_path, devargs->dp_path, PATH_MAX);
+	internals->rx_timestamp_offset = devargs->rx_timestamp_offset;
+	internals->rx_timestamp_valid_offset = devargs->rx_timestamp_valid_offset;
+	internals->rx_timestamp_valid_mask = devargs->rx_timestamp_valid_mask;
+
+	if (xdp_get_channels_info(internals->if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
 		AF_XDP_LOG_LINE(ERR, "Failed to get channel info of interface: %s",
-				if_name);
+				internals->if_name);
 		goto err_free_internals;
 	}
 
 	if (queue_cnt > internals->configured_queue_cnt) {
-		AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger than configured queue count %d.",
+		AF_XDP_LOG_LINE(ERR, "Specified queue count %u is larger than configured queue count %u.",
 				queue_cnt, internals->configured_queue_cnt);
 		goto err_free_internals;
 	}
@@ -2637,12 +2649,12 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	for (i = 0; i < queue_cnt; i++) {
 		internals->tx_queues[i].pair = &internals->rx_queues[i];
 		internals->rx_queues[i].pair = &internals->tx_queues[i];
-		internals->rx_queues[i].xsk_queue_idx = start_queue_idx + i;
-		internals->tx_queues[i].xsk_queue_idx = start_queue_idx + i;
-		internals->rx_queues[i].busy_budget = busy_budget;
+		internals->rx_queues[i].xsk_queue_idx = internals->start_queue_idx + i;
+		internals->tx_queues[i].xsk_queue_idx = internals->start_queue_idx + i;
+		internals->rx_queues[i].busy_budget = devargs->busy_budget;
 	}
 
-	ret = get_iface_info(if_name, &internals->eth_addr,
+	ret = get_iface_info(internals->if_name, &internals->eth_addr,
 			     &internals->if_index);
 	if (ret)
 		goto err_free_tx;
@@ -2828,23 +2840,17 @@ get_dflt_dp_path(char *dp_path, size_t size, const char *if_name,
 static int
 rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 {
-	struct rte_kvargs *kvlist;
-	char if_name[IFNAMSIZ] = {'\0'};
-	int xsk_start_queue_idx = ETH_AF_XDP_DFLT_START_QUEUE_IDX;
-	int xsk_queue_cnt = ETH_AF_XDP_DFLT_QUEUE_COUNT;
-	int shared_umem = 0;
-	char prog_path[PATH_MAX] = {'\0'};
-	int busy_budget = -1, ret;
-	int force_copy = 0;
-	int use_cni = 0;
-	int use_pinned_map = 0;
-	uint32_t xdp_mode = 0;
-	char dp_path[PATH_MAX] = {'\0'};
-	int rx_timestamp_offset = -1;
-	int rx_timestamp_valid_offset = -1;
-	int rx_timestamp_valid_mask = 0;
+	struct af_xdp_devargs devargs = {
+		.start_queue_idx = ETH_AF_XDP_DFLT_START_QUEUE_IDX,
+		.queue_cnt = ETH_AF_XDP_DFLT_QUEUE_COUNT,
+		.busy_budget = -1,
+		.rx_timestamp_offset = -1,
+		.rx_timestamp_valid_offset = -1,
+	};
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
+	struct rte_kvargs *kvlist;
+	int ret;
 
 	AF_XDP_LOG_LINE(INFO, "Initializing pmd_af_xdp for %s", name);
 
@@ -2885,97 +2891,98 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 		return -EINVAL;
 	}
 
-	if (parse_parameters(kvlist, if_name, &xsk_start_queue_idx,
-			     &xsk_queue_cnt, &shared_umem, prog_path,
-			     &busy_budget, &force_copy, &use_cni, &use_pinned_map,
-			     dp_path, &xdp_mode, &rx_timestamp_offset,
-			     &rx_timestamp_valid_offset, &rx_timestamp_valid_mask) < 0) {
+	ret = parse_parameters(kvlist, &devargs);
+	rte_kvargs_free(kvlist);
+	if (ret < 0) {
 		AF_XDP_LOG_LINE(ERR, "Invalid kvargs value");
 		return -EINVAL;
 	}
 
-	if (strlen(if_name) == 0) {
+	if (strlen(devargs.if_name) == 0) {
 		AF_XDP_LOG_LINE(ERR, "Network interface must be specified");
 		return -EINVAL;
 	}
 
-	if (rx_timestamp_offset >= 0) {
-		if (rx_timestamp_offset < (int)sizeof(uint64_t) ||
-		    rx_timestamp_offset > XDP_PACKET_HEADROOM) {
-			AF_XDP_LOG_LINE(ERR,
-				"Timestamp offset must be between %zu and %u bytes",
-				sizeof(uint64_t), XDP_PACKET_HEADROOM);
-			return -EINVAL;
-		}
+	/* The offsets are already bounded by XDP_PACKET_HEADROOM when parsed. */
+	if (devargs.rx_timestamp_offset >= 0 &&
+	    devargs.rx_timestamp_offset < (int)sizeof(uint64_t)) {
+		AF_XDP_LOG_LINE(ERR,
+			"Timestamp offset must be between %zu and %u bytes",
+			sizeof(uint64_t), XDP_PACKET_HEADROOM);
+		return -EINVAL;
 	}
 
-	if (rx_timestamp_valid_offset >= 0) {
-		if (rx_timestamp_offset < 0) {
+	if (devargs.rx_timestamp_valid_offset >= 0) {
+		if (devargs.rx_timestamp_offset < 0) {
 			AF_XDP_LOG_LINE(ERR,
 				"Timestamp offset must be configured when validity offset is configured");
 			return -EINVAL;
 		}
-		if (rx_timestamp_valid_offset < 1 ||
-		    rx_timestamp_valid_offset > XDP_PACKET_HEADROOM) {
+		if (devargs.rx_timestamp_valid_offset < 1) {
 			AF_XDP_LOG_LINE(ERR,
 				"Validity hint offset must be between 1 and %u bytes",
 				XDP_PACKET_HEADROOM);
 			return -EINVAL;
 		}
-		if (rx_timestamp_valid_offset > rx_timestamp_offset - (int)sizeof(uint64_t) &&
-		    rx_timestamp_valid_offset <= rx_timestamp_offset) {
+		if (devargs.rx_timestamp_valid_offset >
+				devargs.rx_timestamp_offset - (int)sizeof(uint64_t) &&
+		    devargs.rx_timestamp_valid_offset <= devargs.rx_timestamp_offset) {
 			AF_XDP_LOG_LINE(ERR,
 				"Validity hint offset %d overlaps with 8-byte timestamp at offset %d",
-				rx_timestamp_valid_offset, rx_timestamp_offset);
+				devargs.rx_timestamp_valid_offset,
+				devargs.rx_timestamp_offset);
 			return -EINVAL;
 		}
-		if (rx_timestamp_valid_mask == 0) {
+		if (devargs.rx_timestamp_valid_mask == 0) {
 			AF_XDP_LOG_LINE(ERR,
 				"Validity mask cannot be zero when validity offset is configured");
 			return -EINVAL;
 		}
 	}
 
-	if (use_cni && use_pinned_map) {
+	if (devargs.use_cni && devargs.use_pinned_map) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG);
 		return -EINVAL;
 	}
 
-	if ((use_cni || use_pinned_map) && busy_budget > 0) {
+	if ((devargs.use_cni || devargs.use_pinned_map) && devargs.busy_budget > 0) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' or '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG,
 			ETH_AF_XDP_BUDGET_ARG);
 		return -EINVAL;
 	}
 
-	if ((use_cni || use_pinned_map) && strnlen(prog_path, PATH_MAX)) {
+	if ((devargs.use_cni || devargs.use_pinned_map) &&
+	    strnlen(devargs.prog_path, PATH_MAX)) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' or '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG,
 			ETH_AF_XDP_PROG_ARG);
 		return -EINVAL;
 	}
 
-	if (use_cni && !strnlen(dp_path, PATH_MAX)) {
+	if (devargs.use_cni && !strnlen(devargs.dp_path, PATH_MAX)) {
 		/* The UDS path is bounded by sun_path, not by PATH_MAX. */
-		ret = get_dflt_dp_path(dp_path,
+		ret = get_dflt_dp_path(devargs.dp_path,
 				RTE_SIZEOF_FIELD(struct sockaddr_un, sun_path),
-				if_name, DP_UDS_SOCK);
+				devargs.if_name, DP_UDS_SOCK);
 		if (ret < 0)
 			return ret;
 		AF_XDP_LOG_LINE(INFO, "'%s' parameter not provided, setting value to '%s'",
-			ETH_AF_XDP_DP_PATH_ARG, dp_path);
+			ETH_AF_XDP_DP_PATH_ARG, devargs.dp_path);
 	}
 
-	if (use_pinned_map && !strnlen(dp_path, PATH_MAX)) {
-		ret = get_dflt_dp_path(dp_path, sizeof(dp_path), if_name, DP_XSK_MAP);
+	if (devargs.use_pinned_map && !strnlen(devargs.dp_path, PATH_MAX)) {
+		ret = get_dflt_dp_path(devargs.dp_path, sizeof(devargs.dp_path),
+				devargs.if_name, DP_XSK_MAP);
 		if (ret < 0)
 			return ret;
 		AF_XDP_LOG_LINE(INFO, "'%s' parameter not provided, setting value to '%s'",
-			ETH_AF_XDP_DP_PATH_ARG, dp_path);
+			ETH_AF_XDP_DP_PATH_ARG, devargs.dp_path);
 	}
 
-	if ((!use_cni && !use_pinned_map) && strnlen(dp_path, PATH_MAX)) {
+	if ((!devargs.use_cni && !devargs.use_pinned_map) &&
+	    strnlen(devargs.dp_path, PATH_MAX)) {
 		AF_XDP_LOG_LINE(ERR, "'%s' parameter is set, but '%s' or '%s' were not enabled",
 			ETH_AF_XDP_DP_PATH_ARG, ETH_AF_XDP_USE_CNI_ARG,
 			ETH_AF_XDP_USE_PINNED_MAP_ARG);
@@ -2986,10 +2993,10 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	 * The socket address is copied into sun_path which is much shorter than
 	 * PATH_MAX, reject an oversized path instead of silently truncating it.
 	 */
-	if (use_cni && strnlen(dp_path, PATH_MAX) >=
+	if (devargs.use_cni && strnlen(devargs.dp_path, PATH_MAX) >=
 		       RTE_SIZEOF_FIELD(struct sockaddr_un, sun_path)) {
 		AF_XDP_LOG_LINE(ERR, "'%s' value '%s' is too long for a unix socket address",
-				ETH_AF_XDP_DP_PATH_ARG, dp_path);
+				ETH_AF_XDP_DP_PATH_ARG, devargs.dp_path);
 		return -ENAMETOOLONG;
 	}
 
@@ -2999,21 +3006,17 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 		char numa_path[PATH_MAX];
 
 		snprintf(numa_path, sizeof(numa_path), "/sys/class/net/%s/device/numa_node",
-			 if_name);
+			 devargs.if_name);
 		if (access(numa_path, R_OK) != 0 || eal_parse_sysfs_value(numa_path, &numa) != 0)
 			dev->device.numa_node = rte_socket_id();
 		else
 			dev->device.numa_node = numa;
 	}
 
-	busy_budget = busy_budget == -1 ? ETH_AF_XDP_DFLT_BUSY_BUDGET :
-					busy_budget;
+	if (devargs.busy_budget == -1)
+		devargs.busy_budget = ETH_AF_XDP_DFLT_BUSY_BUDGET;
 
-	eth_dev = init_internals(dev, if_name, xsk_start_queue_idx,
-				 xsk_queue_cnt, shared_umem, prog_path,
-				 busy_budget, force_copy, use_cni, use_pinned_map,
-				 dp_path, xdp_mode, rx_timestamp_offset,
-				 rx_timestamp_valid_offset, rx_timestamp_valid_mask);
+	eth_dev = init_internals(dev, &devargs);
 	if (eth_dev == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to init internals");
 		return -1;
-- 
2.53.0

