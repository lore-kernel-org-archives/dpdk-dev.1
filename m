Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F0CCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 04:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE4040264;
	Mon,  1 Jun 2026 06:17:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 359B04025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 06:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780287465; x=1811823465;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=y5sdFnpg31bZ9GgL9JxaBWwKFihKSBrskrjw1l5gc6A=;
 b=LDZ8ODcq4Hcup7p1GqWwJJVWhf1/71KH+mUBu/ZSnc5g6Atm+2fNgosW
 4I+vMikf3ZKWpnMK32XCX8D6kD99NnekZeGYH9xTq0LRVH6TOu2rBOrDR
 EWAzc8XQOACIz0S/3n0QbNLtGL8KyLgpN02X8khpAypMfIGZbC7VpD++l
 8FiytCEV7VQ2HgsOQSUcfMZCVVWTcBtWoglkdfO1w1KVzsp5CAW5a0M/X
 Z2TEquWZmMlIWzoyZKarkI05PuJKaIetNpbNpP8J3werqnNnr0c+mizWh
 TQSz00LCbdY+AfybCKMGcRrntmxcvjJyCBhKH0zshD1T/GhgLOSIOTO/S g==;
X-CSE-ConnectionGUID: Ybe9BZLiRxeRtH1oQYTDfA==
X-CSE-MsgGUID: grsbqPYYQrywSWRqVWTaOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91721810"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="91721810"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2026 21:17:44 -0700
X-CSE-ConnectionGUID: mL+HdxzDRaOBruc7FWmYWg==
X-CSE-MsgGUID: 7RR62f4RTqOb1XpM8EijcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="243546057"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa009.jf.intel.com with ESMTP; 31 May 2026 21:17:41 -0700
From: Megha Ajmera <megha.ajmera@intel.com>
To: bruce.richardson@intel.com, cristian.dumitrescu@intel.com,
 praveen.shetty@intel.com, aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v3] app/test-pmd: add generic PROG action parser support
Date: Mon,  1 Jun 2026 09:46:17 +0530
Message-Id: <20260601041617.1513988-1-megha.ajmera@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521101354.726240-1-megha.ajmera@intel.com>
References: <20260521101354.726240-1-megha.ajmera@intel.com>
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

Add parser support for a generic PROG flow action in testpmd.

The update adds CLI tokens and parsing logic for program name and
argument tuples (name, size, value), enabling programmable action
configuration through the flow command interface.

Example flow rule:
  flow create 0 ingress pattern eth / end actions prog name my_prog
  argument name arg0 size 4 value 10 / end

Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
---
v3:
* Addressed review comments from Stephen Hemminger.

v2:
* Fixed compilation warning.

 app/test-pmd/cmdline_flow.c                 | 901 ++++++++++++++++++--
 doc/guides/rel_notes/release_26_07.rst      |   5 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  14 +
 3 files changed, 859 insertions(+), 61 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ebc036b14b..295b5ab58f 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -714,6 +714,13 @@ enum index {
 	ACTION_SET_META,
 	ACTION_SET_META_DATA,
 	ACTION_SET_META_MASK,
+	/* ACTION PROG */
+	ACTION_PROG,
+	ACTION_PROG_NAME,
+	ACTION_PROG_ARGUMENT,
+	ACTION_PROG_ARGUMENT_NAME,
+	ACTION_PROG_ARGUMENT_SIZE,
+	ACTION_PROG_ARGUMENT_VALUE,
 	ACTION_SET_IPV4_DSCP,
 	ACTION_SET_IPV4_DSCP_VALUE,
 	ACTION_SET_IPV6_DSCP,
@@ -981,6 +988,28 @@ struct action_sample_data {
 	struct rte_flow_action_sample conf;
 	uint32_t idx;
 };
+
+#define ACTION_PROG_MAX_ARGS 32
+#define ACTION_PROG_NAME_LEN_MAX 64
+#define ACTION_PROG_ARG_NAME_LEN_MAX 16
+
+struct action_prog_argument_data {
+	char name[ACTION_PROG_ARG_NAME_LEN_MAX];
+	uint32_t length;
+	uint32_t size;
+	uint64_t value;
+};
+
+struct action_prog_data {
+	char name[ACTION_PROG_NAME_LEN_MAX];
+	uint32_t args_num;
+	/*
+	 * COMMON_STRING parser stores name length here via parse_string() args
+	 * triple. Conversion does not consume it beyond ensuring bounded write.
+	 */
+	uint32_t length;
+	struct action_prog_argument_data args[ACTION_PROG_MAX_ARGS];
+};
 /** Storage for struct rte_flow_action_sample. */
 struct raw_sample_conf {
 	struct rte_flow_action data[ACTION_SAMPLE_ACTIONS_NUM];
@@ -2310,6 +2339,7 @@ static const enum index next_action[] = {
 	ACTION_RAW_DECAP,
 	ACTION_SET_TAG,
 	ACTION_SET_META,
+	ACTION_PROG,
 	ACTION_SET_IPV4_DSCP,
 	ACTION_SET_IPV6_DSCP,
 	ACTION_AGE,
@@ -2565,6 +2595,23 @@ static const enum index action_set_meta[] = {
 	ZERO,
 };
 
+/** ACTION PROG */
+static const enum index next_action_prog[] = {
+	ACTION_PROG_NAME,
+	ACTION_PROG_ARGUMENT,
+	ACTION_NEXT,
+	ZERO,
+};
+
+static const enum index next_prog_arg[] = {
+	ACTION_PROG_ARGUMENT_NAME,
+	ACTION_PROG_ARGUMENT_SIZE,
+	ACTION_PROG_ARGUMENT_VALUE,
+	ACTION_PROG_ARGUMENT,
+	ACTION_NEXT,
+	ZERO,
+};
+
 static const enum index action_set_ipv4_dscp[] = {
 	ACTION_SET_IPV4_DSCP_VALUE,
 	ACTION_NEXT,
@@ -2803,6 +2850,27 @@ static int parse_vc_action_set_meta(struct context *ctx,
 				    const struct token *token, const char *str,
 				    unsigned int len, void *buf,
 					unsigned int size);
+static int parse_vc_action_prog(struct context *ctx, const struct token *token,
+				const char *str, unsigned int len, void *buf,
+				unsigned int size);
+static int parse_vc_action_prog_argument(struct context *ctx, const struct token *token,
+				 const char *str, unsigned int len,
+				 void *buf, unsigned int size);
+static int parse_vc_action_prog_argument_name(struct context *ctx,
+				      const struct token *token,
+				      const char *str, unsigned int len,
+				      void *buf, unsigned int size);
+static int parse_vc_action_prog_argument_size(struct context *ctx,
+				      const struct token *token,
+				      const char *str, unsigned int len,
+				      void *buf, unsigned int size);
+static int parse_vc_action_prog_argument_value(struct context *ctx,
+				       const struct token *token,
+				       const char *str, unsigned int len,
+				       void *buf, unsigned int size);
+static void free_action_prog_converted(struct rte_flow_action *actions,
+				      const uint32_t *converted_idx,
+				      uint32_t converted_idx_num);
 static int parse_vc_action_sample(struct context *ctx,
 				    const struct token *token, const char *str,
 				    unsigned int len, void *buf,
@@ -7816,6 +7884,48 @@ static const struct token token_list[] = {
 			     (struct rte_flow_action_set_meta, mask)),
 		.call = parse_vc_conf,
 	},
+	[ACTION_PROG] = {
+		.name = "prog",
+		.help = "Program action: action prog name <name> [argument ...]",
+		.priv = PRIV_ACTION(PROG,
+				sizeof(struct action_prog_data)),
+		.next = NEXT(next_action_prog),
+		.call = parse_vc_action_prog,
+	},
+	[ACTION_PROG_NAME] = {
+		.name = "name",
+		.help = "Action name",
+		.next = NEXT(next_action_prog, NEXT_ENTRY(COMMON_STRING)),
+		.args = ARGS(ARGS_ENTRY_ARB(0, 0),
+			    ARGS_ENTRY(struct action_prog_data, length),
+			    ARGS_ENTRY_ARB(0,
+				    ACTION_PROG_NAME_LEN_MAX)),
+		.call = parse_vc_conf,
+	},
+	[ACTION_PROG_ARGUMENT] = {
+		.name = "argument",
+		.help = "Keyword: argument",
+		.next = NEXT(next_prog_arg),
+		.call = parse_vc_action_prog_argument,
+	},
+	[ACTION_PROG_ARGUMENT_NAME] = {
+		.name = "name",
+		.help = "Argument Name",
+		.next = NEXT(next_prog_arg, NEXT_ENTRY(COMMON_STRING)),
+		.call = parse_vc_action_prog_argument_name,
+	},
+	[ACTION_PROG_ARGUMENT_SIZE] = {
+		.name = "size",
+		.help = "Argument size (bytes)",
+		.next = NEXT(next_prog_arg, NEXT_ENTRY(COMMON_UNSIGNED)),
+		.call = parse_vc_action_prog_argument_size,
+	},
+	[ACTION_PROG_ARGUMENT_VALUE] = {
+		.name = "value",
+		.help = "Argument value",
+		.next = NEXT(next_prog_arg, NEXT_ENTRY(COMMON_UNSIGNED)),
+		.call = parse_vc_action_prog_argument_value,
+	},
 	[ACTION_SET_IPV4_DSCP] = {
 		.name = "set_ipv4_dscp",
 		.help = "set DSCP value",
@@ -8408,7 +8518,7 @@ parse_init(struct context *ctx, const struct token *token,
 	struct buffer *out = buf;
 
 	/* Token name must match. */
-	if (parse_default(ctx, token, str, len, NULL, 0) < 0)
+	if (parse_default(ctx, token, str, len, buf, size) < 0)
 		return -1;
 	/* Nothing else to do if there is no buffer. */
 	if (!out)
@@ -8434,7 +8544,7 @@ parse_ia(struct context *ctx, const struct token *token,
 	struct buffer *out = buf;
 
 	/* Token name must match. */
-	if (parse_default(ctx, token, str, len, NULL, 0) < 0)
+	if (parse_default(ctx, token, str, len, buf, size) < 0)
 		return -1;
 	/* Nothing else to do if there is no buffer. */
 	if (!out)
@@ -10415,6 +10525,511 @@ parse_vc_action_set_meta(struct context *ctx, const struct token *token,
 	return len;
 }
 
+/** Parse PROG action */
+static int
+parse_vc_action_prog(struct context *ctx, const struct token *token,
+			const char *str, unsigned int len, void *buf,
+			unsigned int size)
+{
+	struct buffer *out = buf;
+	struct action_prog_data *prog_data;
+	int ret;
+
+	ret = parse_vc(ctx, token, str, len, buf, size);
+	if (ret < 0)
+		return ret;
+
+	/* Nothing else to do if there is no buffer. */
+	if (!out)
+		return ret;
+
+	if (!out->args.vc.actions_n)
+		return -1;
+
+	/* Point to selected object. */
+	ctx->object = out->args.vc.data;
+	ctx->objmask = NULL;
+
+	prog_data = ctx->object;
+	prog_data->args_num = 0;
+
+	return ret;
+}
+
+/** Called when args keyword is encountered */
+static int
+parse_vc_action_prog_argument(struct context *ctx, const struct token *token,
+				 const char *str, unsigned int len,
+				 void *buf, unsigned int size)
+{
+	struct buffer *out = buf;
+	struct action_prog_data *prog_data;
+
+	/* Token name must match. */
+	if (parse_default(ctx, token, str, len, buf, size) < 0)
+		return -1;
+
+	/* Nothing else to do if there is no buffer. */
+	if (!out)
+		return len;
+
+	if (!out->args.vc.actions_n)
+		return len;
+
+	/* Point to selected object. */
+	ctx->object = out->args.vc.data;
+	ctx->objmask = NULL;
+
+	prog_data = ctx->object;
+	if (prog_data->args_num >= ACTION_PROG_MAX_ARGS)
+		return -1;
+	prog_data->args_num++;
+
+	return len;
+}
+
+static int prog_argument_name_args_push(struct context *ctx, const struct token *token,
+					 const char *str, unsigned int len, void *buf,
+					 unsigned int size, uint32_t arg_ind)
+{
+	static struct arg arg_addr[ACTION_PROG_MAX_ARGS];
+	static struct arg arg_len[ACTION_PROG_MAX_ARGS];
+	static struct arg arg_data[ACTION_PROG_MAX_ARGS];
+	/* Calculate the base size based on the actual structure size */
+	uint32_t prog_data_base_size = offsetof(struct action_prog_data, args);
+
+	RTE_SET_USED(token);
+	RTE_SET_USED(str);
+	RTE_SET_USED(len);
+	RTE_SET_USED(buf);
+	RTE_SET_USED(size);
+
+	arg_addr[arg_ind].offset = prog_data_base_size +
+		offsetof(struct action_prog_argument_data, name) +
+		(arg_ind * sizeof(struct action_prog_argument_data));
+	arg_addr[arg_ind].size = 0;
+
+	if (push_args(ctx, &arg_addr[arg_ind]))
+		return -1;
+	arg_len[arg_ind].offset = prog_data_base_size +
+			  offsetof(struct action_prog_argument_data, length) +
+			  (arg_ind * sizeof(struct action_prog_argument_data));
+	arg_len[arg_ind].size = sizeof(((struct action_prog_argument_data *)0)->length);
+
+	if (push_args(ctx, &arg_len[arg_ind]))
+		return -1;
+	arg_data[arg_ind].offset = prog_data_base_size +
+			   offsetof(struct action_prog_argument_data, name) +
+			   (arg_ind * sizeof(struct action_prog_argument_data));
+	arg_data[arg_ind].size =
+		sizeof(((struct action_prog_argument_data *)0)->name);
+
+	if (push_args(ctx, &arg_data[arg_ind]))
+		return -1;
+
+	return 0;
+}
+
+static int prog_argument_size_args_push(struct context *ctx, const struct token *token,
+					 const char *str, unsigned int len, void *buf,
+					 unsigned int size, uint32_t arg_ind)
+{
+	static struct arg arg[ACTION_PROG_MAX_ARGS];
+	uint32_t prog_data_base_size = offsetof(struct action_prog_data, args);
+
+	RTE_SET_USED(token);
+	RTE_SET_USED(str);
+	RTE_SET_USED(len);
+	RTE_SET_USED(buf);
+	RTE_SET_USED(size);
+
+	arg[arg_ind].offset = prog_data_base_size +
+		      offsetof(struct action_prog_argument_data, size) +
+		      (arg_ind * sizeof(struct action_prog_argument_data));
+	arg[arg_ind].size = sizeof(((struct action_prog_argument_data *)0)->size);
+
+	if (push_args(ctx, &arg[arg_ind]))
+		return -1;
+
+	return 0;
+}
+
+static int prog_argument_value_args_push(struct context *ctx, const struct token *token,
+				  const char *str, unsigned int len, void *buf,
+				  unsigned int size, uint32_t arg_ind)
+{
+	static struct arg arg[ACTION_PROG_MAX_ARGS];
+	uint32_t prog_data_base_size = offsetof(struct action_prog_data, args);
+
+	RTE_SET_USED(token);
+	RTE_SET_USED(str);
+	RTE_SET_USED(len);
+	RTE_SET_USED(buf);
+	RTE_SET_USED(size);
+
+	arg[arg_ind].offset = prog_data_base_size +
+		      offsetof(struct action_prog_argument_data, value) +
+		      (arg_ind * sizeof(struct action_prog_argument_data));
+	arg[arg_ind].size = sizeof(((struct action_prog_argument_data *)0)->value);
+
+	if (push_args(ctx, &arg[arg_ind]))
+		return -1;
+
+	return 0;
+}
+
+static int
+parse_vc_action_prog_argument_name(struct context *ctx,
+				      const struct token *token,
+				      const char *str, unsigned int len,
+				      void *buf, unsigned int size)
+{
+	struct buffer *out = buf;
+	struct action_prog_data *prog_data;
+	uint32_t arg_ind;
+	uint32_t max_arg_ind = (ACTION_PROG_MAX_ARGS - 1);
+	int ret;
+
+	ret = parse_vc_conf(ctx, token, str, len, buf, size);
+	if (ret < 0)
+		return ret;
+
+	/* Nothing else to do if there is no buffer. */
+	if (!out)
+		goto error_push;
+
+	if (!ctx->object)
+		goto error_push;
+
+	prog_data = ctx->object;
+	if (prog_data->args_num == 0)
+		goto error_push;
+	arg_ind = prog_data->args_num - 1;
+	if (prog_argument_name_args_push(ctx, token, str, len, buf, size,
+					     arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return prog_argument_name_args_push(ctx, token, str, len, buf, size,
+				   max_arg_ind);
+}
+
+static int
+parse_vc_action_prog_argument_size(struct context *ctx,
+				      const struct token *token,
+				      const char *str, unsigned int len,
+				      void *buf, unsigned int size)
+{
+	struct buffer *out = buf;
+	struct action_prog_data *prog_data;
+	uint32_t arg_ind;
+	uint32_t max_arg_ind = (ACTION_PROG_MAX_ARGS - 1);
+	int ret;
+
+	ret = parse_vc_conf(ctx, token, str, len, buf, size);
+	if (ret < 0)
+		return ret;
+
+	/* Nothing else to do if there is no buffer. */
+	if (!out)
+		goto error_push;
+
+	if (!ctx->object)
+		goto error_push;
+
+	ctx->object = out->args.vc.data;
+	ctx->objmask = NULL;
+	prog_data = ctx->object;
+	if (prog_data->args_num == 0)
+		goto error_push;
+	arg_ind = prog_data->args_num - 1;
+	if (prog_argument_size_args_push(ctx, token, str, len, buf, size,
+				     arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return prog_argument_size_args_push(ctx, token, str, len, buf, size,
+				   max_arg_ind);
+}
+
+static int
+parse_vc_action_prog_argument_value(struct context *ctx,
+				       const struct token *token,
+				       const char *str, unsigned int len,
+				       void *buf, unsigned int size)
+{
+	struct buffer *out = buf;
+	struct action_prog_data *prog_data;
+	uint32_t arg_ind;
+	uint32_t max_arg_ind = (ACTION_PROG_MAX_ARGS - 1);
+	int ret;
+
+	ret = parse_vc_conf(ctx, token, str, len, buf, size);
+	if (ret < 0)
+		return ret;
+
+	/* Nothing else to do if there is no buffer. */
+	if (!out)
+		goto error_push;
+
+	if (!ctx->object)
+		goto error_push;
+
+	ctx->object = out->args.vc.data;
+	ctx->objmask = NULL;
+	prog_data = ctx->object;
+	if (prog_data->args_num == 0)
+		goto error_push;
+	arg_ind = prog_data->args_num - 1;
+	if (prog_argument_value_args_push(ctx, token, str, len, buf, size,
+				      arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return prog_argument_value_args_push(ctx, token, str, len, buf, size,
+				    max_arg_ind);
+}
+
+/**
+ * Convert action_prog_data to rte_flow_action_prog.
+ * Converts PROG actions from action_prog_data format to rte_flow_action_prog format.
+ *
+ * @param actions           The flow actions array.
+ * @param prog_action_count Number of actions in @p actions array (bounded).
+ * @return                  0 on success, negative value on failure.
+ */
+static int
+convert_action_prog_to_rte_flow(struct rte_flow_action *actions,
+				uint32_t prog_action_count,
+				uint32_t *converted_idx,
+				uint32_t converted_idx_cap,
+				uint32_t *converted_idx_num)
+{
+	uint32_t i = 0;
+	uint32_t j;
+	uint32_t k;
+	rte_be64_t be_value;
+	const struct action_prog_data *prog_data;
+	struct rte_flow_action_prog *prog;
+	struct rte_flow_action_prog_argument *args;
+	uint8_t *value;
+	bool arg_error;
+	int ret = 0;
+
+	if (converted_idx_num)
+		*converted_idx_num = 0;
+
+	/* Process all actions */
+	for (i = 0; i < prog_action_count; i++) {
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_PROG) {
+			prog_data = (const struct action_prog_data *)actions[i].conf;
+			if (!prog_data) {
+				fprintf(stderr, "Prog action found but no data provided\n");
+				ret = -EINVAL;
+				continue;
+			}
+
+			prog = calloc(1, sizeof(struct rte_flow_action_prog));
+			if (!prog) {
+				fprintf(stderr, "Failed to allocate memory for prog action\n");
+				ret = -ENOMEM;
+				continue;
+			}
+
+			prog->name = strdup(prog_data->name);
+			if (!prog->name) {
+				fprintf(stderr, "Failed to allocate memory for prog name\n");
+				free(prog);
+				ret = -ENOMEM;
+				continue;
+			}
+
+			prog->args_num = prog_data->args_num;
+
+			if (prog->args_num > 0) {
+				args = calloc(prog->args_num,
+					      sizeof(struct rte_flow_action_prog_argument));
+				if (!args) {
+					fprintf(stderr,
+						"Failed to allocate memory for prog arguments\n");
+					free((void *)(uintptr_t)prog->name);
+					free(prog);
+					ret = -ENOMEM;
+					continue;
+				}
+
+				arg_error = false;
+				for (j = 0; j < prog->args_num; j++) {
+					args[j].name = strdup(prog_data->args[j].name);
+					if (!args[j].name) {
+						fprintf(stderr,
+							"Failed to allocate memory for argument name\n");
+						ret = -ENOMEM;
+						arg_error = true;
+						break;
+					}
+
+					args[j].size = prog_data->args[j].size;
+					if (args[j].size == 0) {
+						fprintf(stderr,
+							"Invalid PROG argument size 0 for '%s'\n",
+							args[j].name);
+						free((void *)(uintptr_t)args[j].name);
+						ret = -EINVAL;
+						arg_error = true;
+						break;
+					}
+					if (args[j].size > sizeof(prog_data->args[j].value)) {
+						free((void *)(uintptr_t)args[j].name);
+						arg_error = true;
+						ret = -EINVAL;
+						break;
+					}
+
+					value = malloc(args[j].size);
+					if (!value) {
+						fprintf(stderr,
+							"Failed to allocate memory for argument value\n");
+						free((void *)(uintptr_t)args[j].name);
+						ret = -ENOMEM;
+						arg_error = true;
+						break;
+					}
+
+					be_value = rte_cpu_to_be_64(prog_data->args[j].value);
+					memcpy(value,
+					       (const uint8_t *)&be_value +
+					       (sizeof(be_value) - args[j].size),
+					       args[j].size);
+					args[j].value = value;
+				}
+
+				if (arg_error) {
+					/* Free all allocated resources */
+					for (k = 0; k < j; k++) {
+						free((void *)(uintptr_t)args[k].name);
+						free((void *)(uintptr_t)args[k].value);
+					}
+					free(args);
+					free((void *)(uintptr_t)prog->name);
+					free(prog);
+					continue;
+				}
+
+				prog->args = args;
+			}
+
+			actions[i].conf = prog;
+			if (converted_idx && converted_idx_num &&
+			    *converted_idx_num < converted_idx_cap)
+				converted_idx[(*converted_idx_num)++] = i;
+		}
+	}
+
+	return ret;
+}
+
+static void
+free_action_prog_converted(struct rte_flow_action *actions,
+			   const uint32_t *converted_idx,
+			   uint32_t converted_idx_num)
+{
+	uint32_t i;
+
+	for (i = 0; i < converted_idx_num; i++) {
+		uint32_t idx = converted_idx[i];
+		struct rte_flow_action_prog *prog;
+		uint32_t j;
+
+		if (actions[idx].type != RTE_FLOW_ACTION_TYPE_PROG)
+			continue;
+
+		prog = (struct rte_flow_action_prog *)(uintptr_t)actions[idx].conf;
+		if (!prog)
+			continue;
+
+		for (j = 0; j < prog->args_num; j++) {
+			free((void *)(uintptr_t)prog->args[j].name);
+			free((void *)(uintptr_t)prog->args[j].value);
+		}
+		free((void *)(uintptr_t)prog->args);
+		free((void *)(uintptr_t)prog->name);
+		free(prog);
+	}
+}
+
+struct action_prog_conv_ctx {
+	struct rte_flow_action *actions;
+	uint32_t *converted_idx;
+	uint32_t converted_idx_num;
+};
+
+static int
+prepare_action_prog_conversion(struct rte_flow_action *actions,
+				      uint32_t actions_n,
+				      const char *op_name,
+				      struct action_prog_conv_ctx *ctx)
+{
+	int ret;
+
+	memset(ctx, 0, sizeof(*ctx));
+	if (!actions)
+		return 0;
+	if (actions_n == 0) {
+		fprintf(stderr,
+			"%s: invalid action count (0) for PROG conversion\n",
+			op_name);
+		return -EINVAL;
+	}
+
+	ctx->actions = actions;
+	ctx->converted_idx = calloc(actions_n, sizeof(*ctx->converted_idx));
+	if (!ctx->converted_idx) {
+		fprintf(stderr,
+			"%s: failed to allocate conversion index list\n",
+			op_name);
+		return -ENOMEM;
+	}
+
+	ret = convert_action_prog_to_rte_flow(actions, actions_n,
+					      ctx->converted_idx, actions_n,
+					      &ctx->converted_idx_num);
+	if (ret < 0) {
+		fprintf(stderr,
+			"%s: failed to convert program action data: %s\n",
+			op_name, strerror(-ret));
+		free_action_prog_converted(actions, ctx->converted_idx,
+					   ctx->converted_idx_num);
+		free(ctx->converted_idx);
+		ctx->converted_idx = NULL;
+		ctx->converted_idx_num = 0;
+		ctx->actions = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void
+release_action_prog_conversion(struct action_prog_conv_ctx *ctx)
+{
+	if (!ctx->converted_idx)
+		return;
+
+	free_action_prog_converted(ctx->actions, ctx->converted_idx,
+				   ctx->converted_idx_num);
+	free(ctx->converted_idx);
+	ctx->converted_idx = NULL;
+	ctx->converted_idx_num = 0;
+	ctx->actions = NULL;
+}
+
 static int
 parse_vc_action_sample(struct context *ctx, const struct token *token,
 			 const char *str, unsigned int len, void *buf,
@@ -13326,10 +13941,17 @@ indirect_action_flow_conf_create(const struct buffer *in)
 {
 	int len, ret;
 	uint32_t i;
+	struct action_prog_conv_ctx conv_ctx;
 	struct indlst_conf *indlst_conf = NULL;
 	size_t base = RTE_ALIGN(sizeof(*indlst_conf), 8);
 	struct rte_flow_action *src = in->args.vc.actions;
 
+	ret = prepare_action_prog_conversion(src, in->args.vc.actions_n,
+					     "INDIRECT_ACTION_FLOW_CONF_CREATE",
+					     &conv_ctx);
+	if (ret < 0)
+		goto end;
+
 	if (!in->args.vc.actions_n)
 		goto end;
 	len = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, NULL, 0, src, NULL);
@@ -13356,6 +13978,7 @@ indirect_action_flow_conf_create(const struct buffer *in)
 		indlst_conf->conf[i] = indlst_conf->actions[i].conf;
 	SLIST_INSERT_HEAD(&indlst_conf_head, indlst_conf, next);
 end:
+	release_action_prog_conversion(&conv_ctx);
 	if (indlst_conf)
 		printf("created indirect action list configuration %u\n",
 		       in->args.vc.attr.group);
@@ -13380,6 +14003,8 @@ indirect_action_list_conf_get(uint32_t conf_id)
 static void
 cmd_flow_parsed(const struct buffer *in)
 {
+	int ret;
+
 	switch (in->command) {
 	case INFO:
 		port_flow_get_info(in->port);
@@ -13407,15 +14032,26 @@ cmd_flow_parsed(const struct buffer *in)
 				in->args.templ_destroy.template_id);
 		break;
 	case ACTIONS_TEMPLATE_CREATE:
-		port_flow_actions_template_create(in->port,
-				in->args.vc.act_templ_id,
-				&((const struct rte_flow_actions_template_attr) {
-					.ingress = in->args.vc.attr.ingress,
-					.egress = in->args.vc.attr.egress,
-					.transfer = in->args.vc.attr.transfer,
-				}),
-				in->args.vc.actions,
-				in->args.vc.masks);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "ACTIONS_TEMPLATE_CREATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_flow_actions_template_create(in->port,
+					in->args.vc.act_templ_id,
+					&((const struct rte_flow_actions_template_attr) {
+						.ingress = in->args.vc.attr.ingress,
+						.egress = in->args.vc.attr.egress,
+						.transfer = in->args.vc.attr.transfer,
+					}),
+					in->args.vc.actions,
+					in->args.vc.masks);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case ACTIONS_TEMPLATE_DESTROY:
 		port_flow_actions_template_destroy(in->port,
@@ -13438,18 +14074,40 @@ cmd_flow_parsed(const struct buffer *in)
 			(in->port, in->args.table_destroy.table_id[0]);
 		break;
 	case GROUP_SET_MISS_ACTIONS:
-		port_queue_group_set_miss_actions(in->port, &in->args.vc.attr,
-						  in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "GROUP_SET_MISS_ACTIONS",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_group_set_miss_actions(in->port, &in->args.vc.attr,
+							  in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case TABLE_RESIZE:
 		port_flow_template_table_resize(in->port, in->args.table.id,
 						in->args.table.attr.nb_flows);
 		break;
 	case QUEUE_CREATE:
-		port_queue_flow_create(in->port, in->queue, in->postpone,
-			in->args.vc.table_id, in->args.vc.rule_id,
-			in->args.vc.pat_templ_id, in->args.vc.act_templ_id,
-			in->args.vc.pattern, in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "QUEUE_CREATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_flow_create(in->port, in->queue, in->postpone,
+				in->args.vc.table_id, in->args.vc.rule_id,
+				in->args.vc.pat_templ_id, in->args.vc.act_templ_id,
+				in->args.vc.pattern, in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case QUEUE_DESTROY:
 		port_queue_flow_destroy(in->port, in->queue, in->postpone,
@@ -13462,9 +14120,20 @@ cmd_flow_parsed(const struct buffer *in)
 					       in->args.destroy.rule[0]);
 		break;
 	case QUEUE_UPDATE:
-		port_queue_flow_update(in->port, in->queue, in->postpone,
-				in->args.vc.rule_id, in->args.vc.act_templ_id,
-				in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "QUEUE_UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_flow_update(in->port, in->queue, in->postpone,
+					in->args.vc.rule_id, in->args.vc.act_templ_id,
+					in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case PUSH:
 		port_queue_flow_push(in->port, in->queue);
@@ -13487,16 +14156,27 @@ cmd_flow_parsed(const struct buffer *in)
 		break;
 	case QUEUE_INDIRECT_ACTION_CREATE:
 	case QUEUE_INDIRECT_ACTION_LIST_CREATE:
-		port_queue_action_handle_create(
-				in->port, in->queue, in->postpone,
-				in->args.vc.attr.group,
-				in->command == QUEUE_INDIRECT_ACTION_LIST_CREATE,
-				&((const struct rte_flow_indir_action_conf) {
-					.ingress = in->args.vc.attr.ingress,
-					.egress = in->args.vc.attr.egress,
-					.transfer = in->args.vc.attr.transfer,
-				}),
-				in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "QUEUE_INDIRECT_ACTION_CREATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_action_handle_create(
+					in->port, in->queue, in->postpone,
+					in->args.vc.attr.group,
+					in->command == QUEUE_INDIRECT_ACTION_LIST_CREATE,
+					&((const struct rte_flow_indir_action_conf) {
+						.ingress = in->args.vc.attr.ingress,
+						.egress = in->args.vc.attr.egress,
+						.transfer = in->args.vc.attr.transfer,
+					}),
+					in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case QUEUE_INDIRECT_ACTION_DESTROY:
 		port_queue_action_handle_destroy(in->port,
@@ -13505,10 +14185,21 @@ cmd_flow_parsed(const struct buffer *in)
 					   in->args.ia_destroy.action_id);
 		break;
 	case QUEUE_INDIRECT_ACTION_UPDATE:
-		port_queue_action_handle_update(in->port,
-						in->queue, in->postpone,
-						in->args.vc.attr.group,
-						in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "QUEUE_INDIRECT_ACTION_UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_action_handle_update(in->port,
+							in->queue, in->postpone,
+							in->args.vc.attr.group,
+							in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case QUEUE_INDIRECT_ACTION_QUERY:
 		port_queue_action_handle_query(in->port,
@@ -13516,23 +14207,45 @@ cmd_flow_parsed(const struct buffer *in)
 					       in->args.ia.action_id);
 		break;
 	case QUEUE_INDIRECT_ACTION_QUERY_UPDATE:
-		port_queue_action_handle_query_update(in->port, in->queue,
-						      in->postpone,
-						      in->args.ia.action_id,
-						      in->args.ia.qu_mode,
-						      in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "QUEUE_INDIRECT_ACTION_QUERY_UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_queue_action_handle_query_update(in->port, in->queue,
+							      in->postpone,
+							      in->args.ia.action_id,
+							      in->args.ia.qu_mode,
+							      in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case INDIRECT_ACTION_CREATE:
 	case INDIRECT_ACTION_LIST_CREATE:
-		port_action_handle_create(
-				in->port, in->args.vc.attr.group,
-				in->command == INDIRECT_ACTION_LIST_CREATE,
-				&((const struct rte_flow_indir_action_conf) {
-					.ingress = in->args.vc.attr.ingress,
-					.egress = in->args.vc.attr.egress,
-					.transfer = in->args.vc.attr.transfer,
-				}),
-				in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "INDIRECT_ACTION_CREATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_action_handle_create(
+					in->port, in->args.vc.attr.group,
+					in->command == INDIRECT_ACTION_LIST_CREATE,
+					&((const struct rte_flow_indir_action_conf) {
+						.ingress = in->args.vc.attr.ingress,
+						.egress = in->args.vc.attr.egress,
+						.transfer = in->args.vc.attr.transfer,
+					}),
+					in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case INDIRECT_ACTION_FLOW_CONF_CREATE:
 		indirect_action_flow_conf_create(in);
@@ -13543,27 +14256,71 @@ cmd_flow_parsed(const struct buffer *in)
 					   in->args.ia_destroy.action_id);
 		break;
 	case INDIRECT_ACTION_UPDATE:
-		port_action_handle_update(in->port, in->args.vc.attr.group,
-					  in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "INDIRECT_ACTION_UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_action_handle_update(in->port, in->args.vc.attr.group,
+						  in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case INDIRECT_ACTION_QUERY:
 		port_action_handle_query(in->port, in->args.ia.action_id);
 		break;
 	case INDIRECT_ACTION_QUERY_UPDATE:
-		port_action_handle_query_update(in->port,
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "INDIRECT_ACTION_QUERY_UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_action_handle_query_update(in->port,
 						in->args.ia.action_id,
 						in->args.ia.qu_mode,
 						in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case VALIDATE:
-		port_flow_validate(in->port, &in->args.vc.attr,
-				   in->args.vc.pattern, in->args.vc.actions,
-				   &in->args.vc.tunnel_ops);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "VALIDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_flow_validate(in->port, &in->args.vc.attr,
+					   in->args.vc.pattern, in->args.vc.actions,
+					   &in->args.vc.tunnel_ops);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case CREATE:
-		port_flow_create(in->port, &in->args.vc.attr,
-				 in->args.vc.pattern, in->args.vc.actions,
-				 &in->args.vc.tunnel_ops, in->args.vc.user_id);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "CREATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_flow_create(in->port, &in->args.vc.attr,
+					 in->args.vc.pattern, in->args.vc.actions,
+					 &in->args.vc.tunnel_ops, in->args.vc.user_id);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case DESTROY:
 		port_flow_destroy(in->port, in->args.destroy.rule_n,
@@ -13571,8 +14328,19 @@ cmd_flow_parsed(const struct buffer *in)
 				  in->args.destroy.is_user_id);
 		break;
 	case UPDATE:
-		port_flow_update(in->port, in->args.vc.rule_id,
-				 in->args.vc.actions, in->args.vc.user_id);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "UPDATE",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_flow_update(in->port, in->args.vc.rule_id,
+					 in->args.vc.actions, in->args.vc.user_id);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case FLUSH:
 		port_flow_flush(in->port);
@@ -13608,8 +14376,19 @@ cmd_flow_parsed(const struct buffer *in)
 		port_flow_tunnel_list(in->port);
 		break;
 	case ACTION_POL_G:
-		port_meter_policy_add(in->port, in->args.policy.policy_id,
-					in->args.vc.actions);
+		{
+			struct action_prog_conv_ctx conv_ctx;
+
+			ret = prepare_action_prog_conversion(in->args.vc.actions,
+							     in->args.vc.actions_n,
+							     "ACTION_POL_G",
+							     &conv_ctx);
+			if (ret < 0)
+				break;
+			port_meter_policy_add(in->port, in->args.policy.policy_id,
+						in->args.vc.actions);
+			release_action_prog_conversion(&conv_ctx);
+		}
 		break;
 	case FLEX_ITEM_CREATE:
 		flex_item_create(in->port, in->args.flex.token,
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..12aeddf7f3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,11 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added PROG action parsing in testpmd flow CLI.**
+
+  Added support for ``actions prog name <name> argument name <n> size <s> value <v>``
+  syntax in testpmd flow commands.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index d6c344bfb3..913dc6d524 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -4321,6 +4321,20 @@ This section lists supported actions and their attributes, if any.
 
   - ``type {unsigned}``: NAT64 translation type
 
+- ``prog``: execute a program action.
+
+   - ``name {string}``: action name.
+   - ``argument``: start a program argument definition, may be repeated.
+   - ``name {string}``: argument name.
+   - ``size {unsigned}``: argument size in bytes (non-zero, up to 8 bytes).
+   - ``value {unsigned}``: argument value serialized in network byte order
+      using the configured ``size``.
+
+   Example::
+
+       testpmd> flow create 0 ingress pattern eth / ipv4 / end actions \
+            prog name foo argument name a size 4 value 10 / end
+
 Destroying flow rules
 ~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

