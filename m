Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D76CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE8D4069D;
	Tue, 14 Oct 2025 14:41:10 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 94E234068E
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:41:08 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id E7B881D00041;
 Tue, 14 Oct 2025 08:41:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 08:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760445667; x=
 1760532067; bh=wuHuocugBEUxvkFz20EBRDrPHCmFSHnlmCWF93Y9hCY=; b=W
 AayzR15PrkydCJ2tZ6wi2m2pElV2Z2r9r9OvVaaSI7pLHZcExDQ+D9lj2SliEUoG
 nnK6JsQgKYUMBnW483UBjAsDWZ7yDqR6jnQhgMBS3VTo//vVEDJPDIziMPhkF3e8
 zsSnep3SQTnqCchbGpe/kJmUIEJuzFqZaQWHwFIp0G0wZV6M0Kn9C7P/udGD0Txk
 4FA9abRSLzFHBdEjRAZ6bVFlKFevGEbUXfCeZM+1arMc4Oeikv7Qvd7crI+8RNN4
 fbrLhwseK76HUIMxUJDiJb3dR71Bs0URSPe/RX2M74d6qyJDfyxOrtiJCbru+WXq
 aQR/iayN+N4PC3UDJfPjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760445667; x=1760532067; bh=w
 uHuocugBEUxvkFz20EBRDrPHCmFSHnlmCWF93Y9hCY=; b=F+u0TpfPuyXqxmoJf
 Pg+DhPRgu/oJ4nDoWkaHyEBqJ4CJ9SllF4xQ40mHlFyJaoJhKUI/aNua6dXo260K
 EHJJaJq46Ac2EmqIWnVXQP6GNfZZ8JmvZTAgEvj9dxUGofPR9tb5ZHQQHLNdS6Ml
 dgclzv2eIKrmeWmSDFBf7h2pm4plKOrMXBFPtTAgEFFYh1CqtG43rsNen73AfcbY
 OPRkUutX78oouk2HBf2geQtXZ/zNxDVuS1eF3rLTs1bye4EwfZTbqumNnYrN9rQw
 Oer5J0eRXzJTXZbW/KrzN7Aw8CiB2R/vo9mG5X/KxwwDMwzV3qQytOgbqZzo1EO+
 XXG8g==
X-ME-Sender: <xms:40TuaLXUDyhKg9HoYfbx2MnOzB9IjVZ9Av8DbBkuGiM1gAT-zE3hpg>
 <xme:40TuaOhN5ONDBLRHErBHtl2fvlLWQqe9mmiWUyB2s8NI2ck_f3BMRAoQYmbkziH7X
 D7HAru57KtvFOz4UGNVn2UD3sMKx56vvohgYpIQZIMtXQXeucW1Rg>
X-ME-Received: <xmr:40TuaGYSHDaZ9M33j6_O3MsNE5xnDwpsBH-7Rv6E2IHuqT1yeCQyNbHK37eoeoF_1ZgcqzbxWt8N8xA2-DQhAEKt7jLuKUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggt
 hhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitg
 hhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhh
 rghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhg
 hhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:40TuaLp9Uav7LzSlAmUni-gm1SlVIm2zhgYpQEw8QGT3rp4sDH5MfQ>
 <xmx:40TuaDOAY0dqJus-CTbayYyREzAF-6hXQOLO1gH_axasnU4lGQ8hxw>
 <xmx:40TuaOrVPsLs3drJBVZOfQFy5K_KwHdI6XUl1ECINk1GauBJ-6PBHg>
 <xmx:40TuaAclXpByTZO4I5mhfsC9XyXZeLehsrpNsu-Ao8jrkpPrlq_tBw>
 <xmx:40TuaAd_i4uFpUAOiSKtVC8kXqj7-6xGpE3OZd1u7pnzgrwyG8_DXfus>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:41:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v6 5/7] app/testpmd: use space separator in dump commands
Date: Tue, 14 Oct 2025 14:33:38 +0200
Message-ID: <20251014124046.1032293-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014124046.1032293-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
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

In order to make dump commands look like other commands
which have keywords separated with space,
replace these commands:
	- dump_physmem
	- dump_socket_mem
	- dump_memzone
	- dump_struct_sizes
	- dump_ring [name]
	- dump_mempool [name]
	- dump_devargs
	- dump_lcores
	- dump_trace
	- dump_log_types
with these ones:
	- dump physmem
	- dump socket_mem
	- dump memzone
	- dump struct_sizes
	- dump ring [name]
	- dump mempool [name]
	- dump devargs
	- dump lcores
	- dump trace
	- dump log_types

Both parsing functions (with and without name argument)
are merged together.

The function cmd_dump_init() is removed
as it seems useless to define tokens at runtime.

Trace is explicitly warned as not supported on Windows,
because #ifndef in the tokens is not possible with MSVC.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/cmdline.c                      | 196 +++++++++-----------
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  20 +-
 2 files changed, 99 insertions(+), 117 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3731fba370..487a95cd16 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -266,34 +266,34 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show port (port_id) flow_ctrl"
 			"	Show flow control info of a port.\n\n"
 
-			"dump_physmem\n"
+			"dump physmem\n"
 			"    Dumps all physical memory segment layouts\n\n"
 
-			"dump_socket_mem\n"
+			"dump socket_mem\n"
 			"    Dumps the memory usage of all sockets\n\n"
 
-			"dump_memzone\n"
+			"dump memzone\n"
 			"    Dumps the layout of all memory zones\n\n"
 
-			"dump_struct_sizes\n"
+			"dump struct_sizes\n"
 			"    Dumps the size of all memory structures\n\n"
 
-			"dump_ring\n"
+			"dump ring [name]\n"
 			"    Dumps the status of all or specific element in DPDK rings\n\n"
 
-			"dump_mempool\n"
+			"dump mempool [name]\n"
 			"    Dumps the statistics of all or specific memory pool\n\n"
 
-			"dump_devargs\n"
+			"dump devargs\n"
 			"    Dumps the user device list\n\n"
 
-			"dump_lcores\n"
+			"dump lcores\n"
 			"    Dumps the logical cores list\n\n"
 
-			"dump_trace\n"
+			"dump trace\n"
 			"    Dumps the tracing data to the folder according to the current EAL settings\n\n"
 
-			"dump_log_types\n"
+			"dump log_types\n"
 			"    Dumps the log level for all the dpdk modules\n\n"
 
 			"show port (port_id) speed_lanes capabilities"
@@ -9085,9 +9085,33 @@ static cmdline_parse_inst_t cmd_cfg_tunnel_udp_port = {
 
 /* ******************************************************************************** */
 
-struct cmd_dump_result {
+struct cmd_dump_simple_result {
 	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t obj;
+	cmdline_fixed_string_t name;
 };
+static cmdline_parse_token_string_t cmd_dump_simple_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_simple_result, dump, "dump");
+static cmdline_parse_token_string_t cmd_dump_simple_obj =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_simple_result, obj,
+		"physmem#"
+		"socket_mem#"
+		"memzone#"
+		"struct_sizes#"
+		"ring#"
+		"mempool#"
+		"devargs#"
+		"lcores#"
+		"trace#"
+		"log_types"
+);
+static cmdline_parse_token_string_t cmd_dump_named_obj =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_simple_result, obj,
+		"ring#"
+		"mempool#"
+);
+static cmdline_parse_token_string_t cmd_dump_named_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_simple_result, name, NULL);
 
 static void
 dump_struct_sizes(void)
@@ -9099,7 +9123,6 @@ dump_struct_sizes(void)
 #undef DUMP_SIZE
 }
 
-
 /* Dump the socket memory statistics on console */
 static void
 dump_socket_mem(FILE *f)
@@ -9114,7 +9137,6 @@ dump_socket_mem(FILE *f)
 	static size_t last_allocs;
 	static size_t last_total;
 
-
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
 		if (rte_malloc_get_socket_stats(i, &socket_stats) ||
 		    !socket_stats.heap_totalsz_bytes)
@@ -9149,113 +9171,74 @@ dump_socket_mem(FILE *f)
 	last_total = total;
 }
 
-static void cmd_dump_parsed(void *parsed_result,
-			    __rte_unused struct cmdline *cl,
-			    __rte_unused void *data)
+static void cmd_dump_simple_parsed(void *parsed_result,
+		struct cmdline *cl,
+		__rte_unused void *data)
 {
-	struct cmd_dump_result *res = parsed_result;
+	struct cmd_dump_simple_result *res = parsed_result;
 
-	if (!strcmp(res->dump, "dump_physmem"))
+	if (strcmp(res->obj, "physmem") == 0)
 		rte_dump_physmem_layout(stdout);
-	else if (!strcmp(res->dump, "dump_socket_mem"))
+	else if (strcmp(res->obj, "socket_mem") == 0)
 		dump_socket_mem(stdout);
-	else if (!strcmp(res->dump, "dump_memzone"))
+	else if (strcmp(res->obj, "memzone") == 0)
 		rte_memzone_dump(stdout);
-	else if (!strcmp(res->dump, "dump_struct_sizes"))
+	else if (strcmp(res->obj, "struct_sizes") == 0)
 		dump_struct_sizes();
-	else if (!strcmp(res->dump, "dump_ring"))
-		rte_ring_list_dump(stdout);
-	else if (!strcmp(res->dump, "dump_mempool"))
-		rte_mempool_list_dump(stdout);
-	else if (!strcmp(res->dump, "dump_devargs"))
+	else if (strcmp(res->obj, "ring") == 0) {
+		if (strcmp(res->name, "") == 0) {
+			rte_ring_list_dump(stdout);
+		} else {
+			struct rte_ring *r;
+			r = rte_ring_lookup(res->name);
+			if (r == NULL) {
+				cmdline_printf(cl, "Cannot find ring\n");
+				return;
+			}
+			rte_ring_dump(stdout, r);
+		}
+	} else if (strcmp(res->obj, "mempool") == 0) {
+		if (strcmp(res->name, "") == 0) {
+			rte_mempool_list_dump(stdout);
+		} else {
+			struct rte_mempool *mp;
+			mp = rte_mempool_lookup(res->name);
+			if (mp == NULL) {
+				cmdline_printf(cl, "Cannot find mempool\n");
+				return;
+			}
+			rte_mempool_dump(stdout, mp);
+		}
+	} else if (strcmp(res->obj, "devargs") == 0)
 		rte_devargs_dump(stdout);
-	else if (!strcmp(res->dump, "dump_lcores"))
+	else if (strcmp(res->obj, "lcores") == 0)
 		rte_lcore_dump(stdout);
-#ifndef RTE_EXEC_ENV_WINDOWS
-	else if (!strcmp(res->dump, "dump_trace"))
+	else if (strcmp(res->obj, "trace") == 0)
+#ifdef RTE_EXEC_ENV_WINDOWS
+		cmdline_printf(cl, "trace is not supported on Windows\n");
+#else
 		rte_trace_save();
 #endif
-	else if (!strcmp(res->dump, "dump_log_types"))
+	else if (strcmp(res->obj, "log_types") == 0)
 		rte_log_dump(stdout);
 }
 
-static cmdline_parse_token_string_t cmd_dump_dump =
-	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
-		"" /* defined at init */);
-
-static void
-cmd_dump_init(void)
-{
-	cmd_dump_dump.string_data.str =
-		"dump_physmem#"
-		"dump_memzone#"
-		"dump_socket_mem#"
-		"dump_struct_sizes#"
-		"dump_ring#"
-		"dump_mempool#"
-		"dump_devargs#"
-		"dump_lcores#"
-#ifndef RTE_EXEC_ENV_WINDOWS
-		"dump_trace#"
-#endif
-		"dump_log_types";
-}
-
-static cmdline_parse_inst_t cmd_dump = {
-	.f = cmd_dump_parsed,  /* function to call */
-	.data = NULL,      /* 2nd arg of func */
-	.help_str = "Dump status",
-	.tokens = {        /* token list, NULL terminated */
-		(void *)&cmd_dump_dump,
+static cmdline_parse_inst_t cmd_dump_simple = {
+	.f = cmd_dump_simple_parsed,
+	.help_str = "Dump objects",
+	.tokens = {
+		(void *)&cmd_dump_simple_dump,
+		(void *)&cmd_dump_simple_obj,
 		NULL,
 	},
 };
-
-/* ******************************************************************************** */
-
-struct cmd_dump_one_result {
-	cmdline_fixed_string_t dump;
-	cmdline_fixed_string_t name;
-};
-
-static void cmd_dump_one_parsed(void *parsed_result, struct cmdline *cl,
-				__rte_unused void *data)
-{
-	struct cmd_dump_one_result *res = parsed_result;
-
-	if (!strcmp(res->dump, "dump_ring")) {
-		struct rte_ring *r;
-		r = rte_ring_lookup(res->name);
-		if (r == NULL) {
-			cmdline_printf(cl, "Cannot find ring\n");
-			return;
-		}
-		rte_ring_dump(stdout, r);
-	} else if (!strcmp(res->dump, "dump_mempool")) {
-		struct rte_mempool *mp;
-		mp = rte_mempool_lookup(res->name);
-		if (mp == NULL) {
-			cmdline_printf(cl, "Cannot find mempool\n");
-			return;
-		}
-		rte_mempool_dump(stdout, mp);
-	}
-}
-
-static cmdline_parse_token_string_t cmd_dump_one_dump =
-	TOKEN_STRING_INITIALIZER(struct cmd_dump_one_result, dump,
-				 "dump_ring#dump_mempool");
-
-static cmdline_parse_token_string_t cmd_dump_one_name =
-	TOKEN_STRING_INITIALIZER(struct cmd_dump_one_result, name, NULL);
-
-static cmdline_parse_inst_t cmd_dump_one = {
-	.f = cmd_dump_one_parsed,  /* function to call */
-	.data = NULL,      /* 2nd arg of func */
-	.help_str = "dump_ring|dump_mempool <name>: Dump one ring/mempool",
-	.tokens = {        /* token list, NULL terminated */
-		(void *)&cmd_dump_one_dump,
-		(void *)&cmd_dump_one_name,
+static cmdline_parse_inst_t cmd_dump_named = {
+	.f = cmd_dump_simple_parsed,
+	.help_str = "dump ring|mempool <name>: Dump one ring/mempool",
+	.tokens = {
+		(void *)&cmd_dump_simple_dump,
+		(void *)&cmd_dump_named_obj,
+		(void *)&cmd_dump_named_name,
 		NULL,
 	},
 };
@@ -13997,8 +13980,8 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_config_rss_hash_key,
 	&cmd_config_rss_hash_algo,
 	&cmd_cleanup_txq_mbufs,
-	&cmd_dump,
-	&cmd_dump_one,
+	&cmd_dump_simple,
+	&cmd_dump_named,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
@@ -14131,7 +14114,6 @@ init_cmdline(void)
 	/* initialize non-constant commands */
 	cmd_set_fwd_mode_init();
 	cmd_set_fwd_retry_mode_init();
-	cmd_dump_init();
 
 	count = 0;
 	for (i = 0; builtin_ctx[i] != NULL; i++)
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index fefcf5b419..e4bef31d06 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -568,70 +568,70 @@ dump physmem
 
 Dumps all physical memory segment layouts::
 
-   testpmd> dump_physmem
+   testpmd> dump physmem
 
 dump memzone
 ~~~~~~~~~~~~
 
 Dumps the layout of all memory zones::
 
-   testpmd> dump_memzone
+   testpmd> dump memzone
 
 dump socket memory
 ~~~~~~~~~~~~~~~~~~
 
 Dumps the memory usage of all sockets::
 
-   testpmd> dump_socket_mem
+   testpmd> dump socket_mem
 
 dump struct size
 ~~~~~~~~~~~~~~~~
 
 Dumps the size of all memory structures::
 
-   testpmd> dump_struct_sizes
+   testpmd> dump struct_sizes
 
 dump ring
 ~~~~~~~~~
 
 Dumps the status of all or specific element in DPDK rings::
 
-   testpmd> dump_ring [ring_name]
+   testpmd> dump ring [ring_name]
 
 dump mempool
 ~~~~~~~~~~~~
 
 Dumps the statistics of all or specific memory pool::
 
-   testpmd> dump_mempool [mempool_name]
+   testpmd> dump mempool [mempool_name]
 
 dump devargs
 ~~~~~~~~~~~~
 
 Dumps the user device list::
 
-   testpmd> dump_devargs
+   testpmd> dump devargs
 
 dump lcores
 ~~~~~~~~~~~
 
 Dumps the logical cores list::
 
-   testpmd> dump_lcores
+   testpmd> dump lcores
 
 dump trace
 ~~~~~~~~~~
 
 Dumps the tracing data to the folder according to the current EAL settings::
 
-   testpmd> dump_trace
+   testpmd> dump trace
 
 dump log types
 ~~~~~~~~~~~~~~
 
 Dumps the log level for all the dpdk modules::
 
-   testpmd> dump_log_types
+   testpmd> dump log_types
 
 show (raw_encap|raw_decap)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.51.0

