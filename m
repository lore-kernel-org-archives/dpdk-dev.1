Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6971CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68B6840669;
	Tue, 14 Oct 2025 09:05:46 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 52BE24065A
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:05:45 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id F2CBD14001EC;
 Tue, 14 Oct 2025 03:05:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Tue, 14 Oct 2025 03:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760425544; x=
 1760511944; bh=7Bp/bl0zOnH49aQQa7yAGl2c+Sf12UY7vkZYAbk5ZVc=; b=h
 ZCNfwU27jfM2xXehAnPtSYlVgdzgppXfZ9C7CHUMC7sVtiGVxEsUt7JfSXjJUM3/
 kv6ykBHlV5lEBB9QSQPthI5v71MQ4q5tvEOIUfyklh1/+n+68FXLFJOhaNfJGt/t
 2S1eenS3AZTvnV1WcrJ/9KxmawW9hdGPBaQVa6VWr1QQl7+8w9nprKOpKnhRHFZR
 X6Jmz0jeoystzYqo7roy0weGzXxWdUR5u8KSfHuqbaSWumRwCxN8bJ/WUUJ9odie
 pWeu7u+kpf9ATJRANw+vyfUtOR10c3kvx/sEgeXt+Ckdq+4kJyS/4Ar866qDDMcr
 dj0ZVXbCPokxZoohqlH5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760425544; x=1760511944; bh=7
 Bp/bl0zOnH49aQQa7yAGl2c+Sf12UY7vkZYAbk5ZVc=; b=YZpgcTHmBx0b4Oy2t
 X00k4YA4NbZK3qV31YKePlcSi+a9FfReSbJJ/ycjtPdVGkRbBOPwmSJP72ZD+lP3
 9yMcLFlh6c2vpyUFfdiJm9+4OcURgv+GyPZsLMX5RWORu64sciumFEP024ZrH2A8
 TV5n3eTRBdUi9W8LthYr4kGrIiLoDf3Lq2to+G6bZjYBhmOXe2dQe775hFa3jJ5M
 oKXNQIYpTM04zg48dLaMmgvSNQGk7PVO5ixta1cUNdgY0ipnqL/nNMfItbRlqReB
 idsq5Fhy98QHlMrn5wMfDtWwsTeIZhD8LiuN3Z7t/FEeUqRDuM1oD76FivBj/5px
 /kIuQ==
X-ME-Sender: <xms:SPbtaHvWrEiqBetBkdLL8MosBBO6D3sTgmH96fpFZmLdmmp_2Haxlw>
 <xme:SPbtaDbz3SwAEL9BzcZzOnufzoAVFIBNDd6CGCBCHXei5lPmZ5XQuChKiAbFgQe1v
 AUWBXYkb6f-hPKuhVRmYqIa01kiBJyzaYbq-Co39k3T-V88MuyquA>
X-ME-Received: <xmr:SPbtaJyI05ph13YbO0H6DZWf9B9zdaH7wnrAEVuSF1c9yFNNWxIBjk6F12FaP3C7lbl3oth8lW5UeIjuBMN4ahhNQ3GhQQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SPbtaLhWay-UwFhSmaByO9w8L9mw3-bMbLlFroF9YN4rE5CzmBwdEA>
 <xmx:SPbtaFkYgQ3FN4V6vJGKivS0Zw6uezSwOvOev6T2V1GVzhfIKtrAhg>
 <xmx:SPbtaBjCkupUBPjiZHTAK382E6tuj2oyeO_TFzUKkFh-gJV0A3_jbg>
 <xmx:SPbtaJ0Is8C1rg7KAlktr9CAa4QFWQXl-R-9chDP2pRwUcbEms9shA>
 <xmx:SPbtaAQfmSbTbsGZ85z5Z0T9m4O-QWac2vM19j2T4xqT33TJOuBfOOsx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:05:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Date: Tue, 14 Oct 2025 08:58:34 +0200
Message-ID: <20251014070517.922137-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014070517.922137-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
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

Dump the mbuf history to the console or to a file.

The dump will contain:
- Operation history for each mbuf
- Summary and statistics about all mbufs

Dump the history of all mbufs:
	testpmd> dump mbuf history all [file]

Dump the history of one mbuf pool:
	testpmd> dump mbuf history mempool <mp_name> [file]

Dump the history of one mbuf:
	testpmd> dump mbuf history one <mbuf_addr> [file]

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/cmdline.c                      | 174 ++++++++++++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  13 ++
 2 files changed, 187 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 487a95cd16..e2d5b6696f 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -40,6 +40,7 @@
 #include <rte_gro.h>
 #endif
 #include <rte_mbuf_dyn.h>
+#include <rte_mbuf_history.h>
 #include <rte_trace.h>
 
 #include <cmdline_rdline.h>
@@ -296,6 +297,15 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"dump log_types\n"
 			"    Dumps the log level for all the dpdk modules\n\n"
 
+			"dump mbuf history all [file_name]\n"
+			"    Dumps the mbuf history for all mempools\n\n"
+
+			"dump mbuf history mempool <mempool_name> [file_name]\n"
+			"    Dumps the history for a specific mempool\n\n"
+
+			"dump mbuf history one <mbuf_addr> [file_name]\n"
+			"    Dumps the history for a specific mbuf (use 0x<address> format)\n\n"
+
 			"show port (port_id) speed_lanes capabilities"
 			"	Show speed lanes capabilities of a port.\n\n"
 		);
@@ -9243,6 +9253,164 @@ static cmdline_parse_inst_t cmd_dump_named = {
 	},
 };
 
+struct cmd_dump_mbuf_history_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t mbuf;
+	cmdline_fixed_string_t history;
+	cmdline_fixed_string_t obj;
+	cmdline_fixed_string_t name;
+	cmdline_fixed_string_t addr;
+	cmdline_fixed_string_t file;
+};
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, dump, "dump");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_mbuf =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, mbuf, "mbuf");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_history =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, history, "history");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_one =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, obj, "one");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_mempool =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, obj, "mempool");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_all =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, obj, "all");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, name, NULL);
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_addr =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, addr, NULL);
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_file =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, file, NULL);
+
+static void cmd_dump_mbuf_history_parsed(void *parsed_result,
+		struct cmdline *cl,
+		__rte_unused void *data)
+{
+	struct cmd_dump_mbuf_history_result *res = parsed_result;
+	FILE *out = stdout;
+
+	if (strcmp(res->file, "") != 0) {
+		out = fopen(res->file, "w");
+		if (out == NULL) {
+			cmdline_printf(cl,
+					"Failed to open file '%s'\n",
+					res->file);
+			return;
+		}
+	}
+
+	if (strcmp(res->obj, "all") == 0) {
+		rte_mbuf_history_dump_all(out);
+		if (out != stdout)
+			cmdline_printf(cl,
+					"Dump written in '%s'\n",
+					res->file);
+	} else if (strcmp(res->obj, "mempool") == 0) {
+		struct rte_mempool *mp = rte_mempool_lookup(res->name);
+		if (mp == NULL) {
+			cmdline_printf(cl,
+					"Failed to find mempool '%s'\n",
+					res->name);
+			return;
+		}
+		rte_mbuf_history_dump_mempool(out, mp);
+		if (out != stdout)
+			cmdline_printf(cl,
+					"Dump for mempool '%s' written in '%s'\n",
+					res->name, res->file);
+	} else if (strcmp(res->obj, "one") == 0) {
+		struct rte_mbuf *mbuf;
+		uintptr_t mbuf_addr;
+		if (sscanf(res->addr, "0x%" SCNxPTR, &mbuf_addr) != 1) {
+			cmdline_printf(cl,
+					"Invalid mbuf pointer format. Use 0x<address>\n");
+			return;
+		}
+		mbuf = (struct rte_mbuf *)mbuf_addr;
+		rte_mbuf_history_dump(out, mbuf);
+		if (out != stdout)
+			cmdline_printf(cl,
+					"Dump for mbuf '%p' written in '%s'\n",
+					mbuf, res->file);
+	}
+
+	if (out != stdout)
+		fclose(out);
+}
+
+static cmdline_parse_inst_t cmd_dump_mbuf_history_one_stdout = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history one <address>",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_one,
+		(void *)&cmd_dump_mbuf_history_addr,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_one_to_file = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history one <address> [file]",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_one,
+		(void *)&cmd_dump_mbuf_history_addr,
+		(void *)&cmd_dump_mbuf_history_file,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_mempool_stdout = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history mempool <name>",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_mempool,
+		(void *)&cmd_dump_mbuf_history_name,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_mempool_to_file = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history mempool <name> [file]",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_mempool,
+		(void *)&cmd_dump_mbuf_history_name,
+		(void *)&cmd_dump_mbuf_history_file,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_all_stdout = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history all",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_all,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_all_to_file = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history all [file]",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_all,
+		(void *)&cmd_dump_mbuf_history_file,
+		NULL,
+	},
+};
+
 /* *** Filters Control *** */
 
 #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
@@ -13982,6 +14150,12 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_cleanup_txq_mbufs,
 	&cmd_dump_simple,
 	&cmd_dump_named,
+	&cmd_dump_mbuf_history_all_stdout,
+	&cmd_dump_mbuf_history_all_to_file,
+	&cmd_dump_mbuf_history_mempool_stdout,
+	&cmd_dump_mbuf_history_mempool_to_file,
+	&cmd_dump_mbuf_history_one_stdout,
+	&cmd_dump_mbuf_history_one_to_file,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e4bef31d06..2e984bf5f1 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -633,6 +633,19 @@ Dumps the log level for all the dpdk modules::
 
    testpmd> dump log_types
 
+dump mbuf history
+~~~~~~~~~~~~~~~~~
+
+The mbuf history is tracked
+if enabled at compilation with ``RTE_MBUF_HISTORY_DEBUG``.
+
+This tracking can be displayed or saved to a file
+for all mbufs or specific ones selected by pointer or mempool name::
+
+   testpmd> dump mbuf history all [file]
+   testpmd> dump mbuf history mempool <mp_name> [file]
+   testpmd> dump mbuf history one <mbuf_addr> [file]
+
 show (raw_encap|raw_decap)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.51.0

