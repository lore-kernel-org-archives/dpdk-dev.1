Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3AACA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB7640670;
	Fri, 29 Aug 2025 16:02:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 20D794025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756476164; x=1788012164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oehPLbEheFyUCp1cK8JCdjulyfd5pGk7b29cOEXfrrw=;
 b=Esfk4/ZH7U/VOG25u2f7d7fvER++cWc2QBFFcDw+m0K2Hn2hlXVkn6L+
 /z71If1PanyfEooaNL7Bs8ViN/h+eEG+PaUBfVPIIgIbx7ZF52rMTS4H+
 IYNpu4khYTnEAHx4t04hWbWlLd7CTf7KKD7x8BXVMnLvYL+BpwM6z3Hn2
 2ZXdV0OJNId6+H+QiDUvgtDp1X23gMQP4yLa7i6nNKCzXjmssynezEfSG
 L9DHHMYzl+cpxff81H6eW5f/qGT5sIz5/zmjQjvSAkZ54q/4hAj1tv4SC
 BxwivKRXGSDdtE3ertaF3AbpPc3SGH95ozPaAC9JNgQmhfMApJ7zt8fbe Q==;
X-CSE-ConnectionGUID: TPa/lPLeS2SzQ3p6BCzTtA==
X-CSE-MsgGUID: GR3/PQQaSQGT0FZaUYtS1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84166958"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="84166958"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:02:43 -0700
X-CSE-ConnectionGUID: g0/HeXXsSs6TzKsF0EM0Wg==
X-CSE-MsgGUID: bDQMynAgRrezFmNXCwDFtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170295682"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2025 07:02:42 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 3/3] app/testpmd: support link state on close ethdev API
Date: Fri, 29 Aug 2025 14:02:24 +0000
Message-Id: <20250829140224.1748255-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829140224.1748255-1-ciara.loftus@intel.com>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
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

Allow the user to configure link state on close behaviour via the
link_state_on_close argument. Three options are allowed:
1. down: bring (or keep) the link down
2. up: bring (or keep) the link up
3. initial: restore the link to the state it was in when the device was
started.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 app/test-pmd/cmdline.c                      | 56 +++++++++++++++++++++
 app/test-pmd/config.c                       | 17 +++++++
 app/test-pmd/parameters.c                   | 26 ++++++++++
 app/test-pmd/testpmd.c                      | 16 ++++++
 app/test-pmd/testpmd.h                      |  3 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
 6 files changed, 125 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..79afcca60c 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -679,6 +679,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Set a controllable LED associated with a certain"
 			" port on or off.\n\n"
 
+			"set port (port_id) link_state_on_close (down|up|initial)\n"
+			"    Set link state on close to down, up or initial for a port\n\n"
+
 			, list_pkt_forwarding_modes()
 		);
 	}
@@ -13857,6 +13860,58 @@ static cmdline_parse_inst_t cmd_set_dev_led = {
 	},
 };
 
+/* *** SET LINK STATE ON CLOSE FOR A CERTAIN PORT *** */
+struct cmd_link_state_on_close_result {
+	cmdline_fixed_string_t set;
+	cmdline_fixed_string_t port;
+	portid_t port_id;
+	cmdline_fixed_string_t link_state_on_close;
+	cmdline_fixed_string_t state;
+};
+
+static void
+cmd_set_link_state_on_close_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl,
+		__rte_unused void *data)
+{
+	struct cmd_link_state_on_close_result *res = parsed_result;
+
+	if (strcmp(res->state, "down") == 0)
+		set_link_state_on_close(res->port_id, RTE_ETH_LINK_STATE_ON_CLOSE_DOWN);
+	else if (strcmp(res->state, "up") == 0)
+		set_link_state_on_close(res->port_id, RTE_ETH_LINK_STATE_ON_CLOSE_UP);
+	else if (strcmp(res->state, "initial") == 0)
+		set_link_state_on_close(res->port_id, RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL);
+	else
+		printf("Invalid state: %s\n", res->state);
+}
+
+static cmdline_parse_token_string_t cmd_link_state_on_close_set =
+	TOKEN_STRING_INITIALIZER(struct cmd_link_state_on_close_result, set, "set");
+static cmdline_parse_token_string_t cmd_link_state_on_close_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_link_state_on_close_result, port, "port");
+static cmdline_parse_token_num_t cmd_link_state_on_close_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_link_state_on_close_result, port_id, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_link_state_on_close =
+	TOKEN_STRING_INITIALIZER(struct cmd_link_state_on_close_result, link_state_on_close,
+		"link_state_on_close");
+static cmdline_parse_token_string_t cmd_link_state_on_close_state =
+	TOKEN_STRING_INITIALIZER(struct cmd_link_state_on_close_result, state, "down#up#initial");
+
+static cmdline_parse_inst_t cmd_set_link_state_on_close = {
+	.f = cmd_set_link_state_on_close_parsed,
+	.data = NULL,
+	.help_str = "set port <port_id> link_state_on_close <down/up/initial>",
+	.tokens = {
+		(void *)&cmd_link_state_on_close_set,
+		(void *)&cmd_link_state_on_close_port,
+		(void *)&cmd_link_state_on_close_port_id,
+		(void *)&cmd_link_state_on_close,
+		(void *)&cmd_link_state_on_close_state,
+		NULL,
+	},
+};
+
 /* ******************************************************************************** */
 
 /* list of instructions */
@@ -14105,6 +14160,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_port_cman_config,
 	&cmd_config_tx_affinity_map,
 	&cmd_set_dev_led,
+	&cmd_set_link_state_on_close,
 	NULL,
 };
 
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..c5c5e23b4b 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5429,6 +5429,23 @@ set_dev_led(portid_t port_id, bool active)
 			port_id, rte_strerror(-ret));
 }
 
+void
+set_link_state_on_close(portid_t port_id, enum rte_eth_link_state_on_close state)
+{
+	int ret;
+
+	if (!rte_eth_dev_is_valid_port(port_id)) {
+		fprintf(stderr, "Error: Invalid port number %u\n", port_id);
+		return;
+	}
+
+	ret = rte_eth_dev_set_link_state_on_close(port_id, state);
+
+	if (ret < 0)
+		fprintf(stderr, "Error: Unable to set link state on close for port %u: %s\n",
+			port_id, rte_strerror(-ret));
+}
+
 int
 set_fwd_lcores_list(unsigned int *lcorelist, unsigned int nb_lc)
 {
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..83c077f651 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -253,6 +253,8 @@ enum {
 	TESTPMD_OPT_NUM_PROCS_NUM,
 #define TESTPMD_OPT_PROC_ID "proc-id"
 	TESTPMD_OPT_PROC_ID_NUM,
+#define TESTPMD_OPT_LINK_STATE_ON_CLOSE "link_state_on_close"
+	TESTPMD_OPT_LINK_STATE_ON_CLOSE_NUM,
 
 	TESTPMD_OPT_LONG_MAX_NUM
 };
@@ -378,6 +380,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_RECORD_BURST_STATS),
 	REQUIRED_ARG(TESTPMD_OPT_NUM_PROCS),
 	REQUIRED_ARG(TESTPMD_OPT_PROC_ID),
+	REQUIRED_ARG(TESTPMD_OPT_LINK_STATE_ON_CLOSE),
 	{ 0, 0, NULL, 0 }
 };
 #undef NO_ARG
@@ -930,6 +933,23 @@ parse_link_speed(int n)
 	return speed;
 }
 
+static int
+parse_link_state_on_close(const char *optarg)
+{
+	if (!strcmp(optarg, "down")) {
+		close_state = RTE_ETH_LINK_STATE_ON_CLOSE_DOWN;
+	} else if (!strcmp(optarg, "up")) {
+		close_state = RTE_ETH_LINK_STATE_ON_CLOSE_UP;
+	} else if (!strcmp(optarg, "initial")) {
+		close_state = RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL;
+	} else {
+		fprintf(stderr, "Invalid state: %s\n", optarg);
+		return -1;
+	}
+
+	return 0;
+}
+
 void
 launch_args_parse(int argc, char** argv)
 {
@@ -1733,6 +1753,12 @@ launch_args_parse(int argc, char** argv)
 		case TESTPMD_OPT_PROC_ID_NUM:
 			proc_id = atoi(optarg);
 			break;
+		case TESTPMD_OPT_LINK_STATE_ON_CLOSE_NUM:
+			if (parse_link_state_on_close(optarg)) {
+				rte_exit(EXIT_FAILURE,
+					"invalid link_state_on_close argument\n");
+			}
+			break;
 		default:
 			usage(argv[0]);
 			fprintf(stderr, "Invalid option: %s\n", argv[optind - 1]);
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..4ffa1113cd 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -557,6 +557,11 @@ uint32_t eth_link_speed;
  */
 int proc_id;
 
+/*
+ * Link state on close.
+ */
+enum rte_eth_link_state_on_close close_state;
+
 /*
  * Number of processes in multi-process, used to
  * configure the queues to be polled.
@@ -3103,6 +3108,17 @@ start_port(portid_t pid)
 		p_pi = pi;
 		cnt_pi++;
 
+		/* Configure link state on close */
+		if (close_state) {
+			diag = rte_eth_dev_set_link_state_on_close(pi, close_state);
+			if (diag < 0)
+				fprintf(stderr,
+					"Port %d: Failed to configure link state on close\n",
+					pi);
+			else
+				printf("Link state on close configured for port %i\n", pi);
+		}
+
 		/* start port */
 		diag = eth_dev_start_mp(pi);
 		if (diag < 0) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..9e39bfea5b 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -821,6 +821,8 @@ extern struct rte_flow_action_conntrack conntrack_context;
 extern int proc_id;
 extern unsigned int num_procs;
 
+extern enum rte_eth_link_state_on_close close_state;
+
 static inline bool
 is_proc_primary(void)
 {
@@ -959,6 +961,7 @@ void update_fwd_ports(portid_t new_pid);
 
 void set_fwd_eth_peer(portid_t port_id, char *peer_addr);
 void set_dev_led(portid_t port_id, bool active);
+void set_link_state_on_close(portid_t port_id, enum rte_eth_link_state_on_close state);
 
 void port_mtu_set(portid_t port_id, uint16_t mtu);
 int port_action_handle_create(portid_t port_id, uint32_t id, bool indirect_list,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 6ad83ae50d..96a7dd5470 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1863,6 +1863,13 @@ Set a controllable LED associated with a certain port on or off::
 
    testpmd> set port (port_id) led (on|off)
 
+set port link_state_on_close
+~~~~~~~~~~~~
+
+Set the link state on close for a certain port::
+
+   testpmd> set port (port_id) link_state_on_close (down|up|initial)
+
 Port Functions
 --------------
 
-- 
2.34.1

