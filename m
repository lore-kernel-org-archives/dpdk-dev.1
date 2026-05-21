Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99446CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 05:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8A740290;
	Thu, 21 May 2026 07:58:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E6FDA4028D
 for <dev@dpdk.org>; Thu, 21 May 2026 07:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779343131; x=1810879131;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ptv/28ti/bxzQUTfp4j4EH4z8oX0CVYvpX8IPdS3zz0=;
 b=FMpHXrNrDjWJOSAzfIy4QKajHjCtFGuaaY+5SGb5Poc6GzQfbkUUb3gd
 6lhTH5xhtxjjuMfuAXrbvEObZl+O2Ufb2vMgaHd8ij/ZVdvyIxXQfxOJG
 Pxb31mQJoaJaqw//TUCeq5NQYhyQsWEv31IyfI6+KnTSsth5vzSKh5eoy
 rJKibHbfd4n9VZz0RsKUIzbMUzPM1+Sjl+pweAFyhKvcq187+1wXNbNEm
 zbjlNddEO9LfKOnIMiHaKMeh0GPHuCX1pWOleztRjXmEMHO2yBHUZwQra
 3WJ5dWkuIdx7SSFbfGYM9ZTunzqmz3auoI34YvFX+wvfKKSd8+GDNURMh w==;
X-CSE-ConnectionGUID: SbI2XdqxTPCUnmnOsCNPBA==
X-CSE-MsgGUID: dQQoxXxSRDqYuZQAPDvAsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80109778"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="80109778"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 22:58:50 -0700
X-CSE-ConnectionGUID: 6/FTj3l6R1uJ5dO3WJf3EA==
X-CSE-MsgGUID: okbk+dcdQV647ymJhwYR/g==
X-ExtLoop1: 1
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by fmviesa003.fm.intel.com with ESMTP; 20 May 2026 22:58:47 -0700
From: Megha Ajmera <megha.ajmera@intel.com>
To: bruce.richardson@intel.com, cristian.dumitrescu@intel.com,
 praveen.shetty@intel.com, dev@dpdk.org
Subject: [PATCH] app/test-pmd: add generic PROG action parser support
Date: Thu, 21 May 2026 11:26:12 +0530
Message-Id: <20260521055612.508916-1-megha.ajmera@intel.com>
X-Mailer: git-send-email 2.34.1
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
 app/test-pmd/cmdline_flow.c | 584 +++++++++++++++++++++++++++++++++++-
 1 file changed, 581 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ebc036b14b..b429ff7267 100644
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
@@ -981,6 +988,24 @@ struct action_sample_data {
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
+	uint32_t length;
+	struct action_prog_argument_data args[ACTION_PROG_MAX_ARGS];
+};
 /** Storage for struct rte_flow_action_sample. */
 struct raw_sample_conf {
 	struct rte_flow_action data[ACTION_SAMPLE_ACTIONS_NUM];
@@ -2310,6 +2335,7 @@ static const enum index next_action[] = {
 	ACTION_RAW_DECAP,
 	ACTION_SET_TAG,
 	ACTION_SET_META,
+	ACTION_PROG,
 	ACTION_SET_IPV4_DSCP,
 	ACTION_SET_IPV6_DSCP,
 	ACTION_AGE,
@@ -2565,6 +2591,23 @@ static const enum index action_set_meta[] = {
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
@@ -2803,6 +2846,27 @@ static int parse_vc_action_set_meta(struct context *ctx,
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
@@ -7816,6 +7880,48 @@ static const struct token token_list[] = {
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
@@ -10415,6 +10521,449 @@ parse_vc_action_set_meta(struct context *ctx, const struct token *token,
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
+	RTE_SET_USED(token);
+	RTE_SET_USED(str);
+	RTE_SET_USED(size);
+
+	/* Token name must match. */
+	if (parse_default(ctx, token, str, len, NULL, 0) < 0)
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
+static int __prog_argument_name_args_push(struct context *ctx, const struct token *token,
+					  const char *str, unsigned int len, void *buf,
+					  unsigned int size, uint32_t arg_ind)
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
+static int __prog_argument_size_args_push(struct context *ctx, const struct token *token,
+					  const char *str, unsigned int len, void *buf,
+					  unsigned int size, uint32_t arg_ind)
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
+static int __prog_argument_value_args_push(struct context *ctx, const struct token *token,
+					   const char *str, unsigned int len, void *buf,
+					   unsigned int size, uint32_t arg_ind)
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
+	if (__prog_argument_name_args_push(ctx, token, str, len, buf, size,
+					      arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return __prog_argument_name_args_push(ctx, token, str, len, buf, size,
+					    max_arg_ind);
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
+	if (__prog_argument_size_args_push(ctx, token, str, len, buf, size,
+					      arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return __prog_argument_size_args_push(ctx, token, str, len, buf, size,
+					    max_arg_ind);
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
+	RTE_SET_USED(size);
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
+	if (__prog_argument_value_args_push(ctx, token, str, len, buf, size,
+					       arg_ind) < 0)
+		return -1;
+
+	return ret;
+
+error_push:
+	return __prog_argument_value_args_push(ctx, token, str, len, buf, size,
+					     max_arg_ind);
+}
+
+/**
+ * Convert action_prog_data to rte_flow_action_prog.
+ * Converts PROG actions from action_prog_data format to rte_flow_action_prog format.
+ *
+ * @param actions     The flow actions array
+ * @param action_count Optional count of actions. If 0, will count until END action
+ * @return            0 on success, negative value on failure
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
+	/* If action_count is 0, count the actions until END action */
+	if (prog_action_count == 0) {
+		while (actions[i].type != RTE_FLOW_ACTION_TYPE_END)
+			i++;
+		prog_action_count = i + 1; /* Include END action */
+		i = 0; /* Reset counter for the processing loop */
+	}
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
+					if (args[j].size == 0)
+						continue;
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
+					memcpy(value,
+					       &prog_data->args[j].value,
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
+		prog = actions[idx].conf;
+		if (!prog)
+			continue;
+
+		for (j = 0; j < prog->args_num; j++) {
+			free((void *)(uintptr_t)prog->args[j].name);
+			free((void *)(uintptr_t)prog->args[j].value);
+		}
+		free(prog->args);
+		free((void *)(uintptr_t)prog->name);
+		free(prog);
+	}
+}
+
 static int
 parse_vc_action_sample(struct context *ctx, const struct token *token,
 			 const char *str, unsigned int len, void *buf,
@@ -13380,6 +13929,8 @@ indirect_action_list_conf_get(uint32_t conf_id)
 static void
 cmd_flow_parsed(const struct buffer *in)
 {
+	int ret;
+
 	switch (in->command) {
 	case INFO:
 		port_flow_get_info(in->port);
@@ -13561,9 +14112,36 @@ cmd_flow_parsed(const struct buffer *in)
 				   &in->args.vc.tunnel_ops);
 		break;
 	case CREATE:
-		port_flow_create(in->port, &in->args.vc.attr,
-				 in->args.vc.pattern, in->args.vc.actions,
-				 &in->args.vc.tunnel_ops, in->args.vc.user_id);
+		{
+			uint32_t *converted_idx;
+			uint32_t converted_idx_num = 0;
+
+			converted_idx = calloc(in->args.vc.actions_n,
+					       sizeof(*converted_idx));
+			if (!converted_idx) {
+				fprintf(stderr,
+					"Warning: Failed to allocate conversion index list\n");
+				break;
+			}
+
+			/* Convert from action_prog_data to rte_flow_action_prog. */
+			ret = convert_action_prog_to_rte_flow(in->args.vc.actions,
+						      0,
+						      converted_idx,
+						      in->args.vc.actions_n,
+						      &converted_idx_num);
+			if (ret < 0)
+				fprintf(stderr,
+					"Warning: Failed to convert program action data: %s\n",
+					strerror(-ret));
+			port_flow_create(in->port, &in->args.vc.attr,
+					 in->args.vc.pattern, in->args.vc.actions,
+					 &in->args.vc.tunnel_ops, in->args.vc.user_id);
+			free_action_prog_converted(in->args.vc.actions,
+						   converted_idx,
+						   converted_idx_num);
+			free(converted_idx);
+		}
 		break;
 	case DESTROY:
 		port_flow_destroy(in->port, in->args.destroy.rule_n,
-- 
2.34.1

