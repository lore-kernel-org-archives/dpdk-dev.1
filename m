Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA41CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F964066B;
	Mon, 13 Oct 2025 23:20:46 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 07FF540662
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:45 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3C91B7A0331;
 Mon, 13 Oct 2025 17:20:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 17:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390444; x=
 1760476844; bh=yS37F5eyKL9MmJAOh3Ks5jPQVOBHIszBr6eWV2+TRw8=; b=M
 RRUWNUYVbTJu7Rjmb2OlufmB68WLhAS3gdWQhulCvzAthEiDKWQelqg0Gg/g/uTf
 CMzGdTyL+4CjtYAfry0jk5n2UA7nFVmrih0vh1qUJ4mAf6fnBJ4W1/NxYEl+8rCu
 7PZ6jC6R3itP9vA/uZGrEltVIJTPaS8Z5Re7itgxZhfVN8DueVaV6BBXH6FLBJmO
 U7iga/m6OIfq7mFEQcEWgD6lWEGKXCza5ZAx3Qzf1c/j1U2dc2Io7li1TEwh9wSR
 F63NBE0oWYHodP8d46L4y16SumSNOc2+Hs89Llx+cHJZwsjK9xRBKpTUHO7u/O7F
 I1on4gBVyTzZFR3hyvl+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390444; x=1760476844; bh=y
 S37F5eyKL9MmJAOh3Ks5jPQVOBHIszBr6eWV2+TRw8=; b=RXgS5d99d6CLW3i2Y
 BpEmPOoX/AkNGUpZpSW6L1+0XjdSD5vMUJxraUAI9OKSYRWlyNjhmQv9Um29j8mj
 Q4kafTnqLMA9KbVwogZozzifYHNzVnoVJHpDsUv2N2z++A8m+Nw9iTi9nkGnSJJb
 M15MwiXZsgaLu4SALzCnyGppvAofK+JwSp9eQA9WNjvumwO/ssRc07hdY5/0oZ6P
 a9BwrpYBuSZoImlNeu8U/5esfPvkg0wyrb7Y/lOP4hrAdbapytO6axK1pYLlYuV8
 LQowtTsS2XMB7W8YvsYIGDsMqog6Ql1AqkjH910PU2Kiao7WFLCwylvjKwxqKEWn
 VJ6hg==
X-ME-Sender: <xms:K23taG0G6gXPvy_DsBiw1dVQPZVYy3sKssGFpRnlGrVHexV2-sNC_A>
 <xme:K23taEDJFsjv7Moi9elmzFcjOO_ys1uNriSJ14Zeqtiw23iTnLXnCkZ6ESWdw9M5n
 LhCYhaPXb42x4Se1842Juc4tAxPc5UxCmbIHIWNHzHQJCk1sqsD8g>
X-ME-Received: <xmr:K23taN6mi7_OsVrW-XRoA7LCw6-nMWlf4q0IoYDwpVlM6Nj6el7bid0kzeg3RwvgoM-x529DK88yDQcSyKUbQ_tgQkT34hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:K23taNKE111QOPaoKoWqnz02WOQY3GKBmX-jZMt2EUT1aMGVQK8PeA>
 <xmx:K23taGsV9A5ecOX44pjUXR6nPJx4E1qlrATef2lZ5qgR7hbWIP-FwQ>
 <xmx:K23taMKufsBEYCya9Y1wco_W5Dxjrm78YjBmZPIXG75eemVnCYbhhw>
 <xmx:K23taP-If2X7X-Q5JaVnb-2jTuL0NN52qHQ66OKqoRrhmDXufRv80w>
 <xmx:LG3taJ-NoZU9AxBwSQuvQ_vrNeBrj9GQX86-I79njoT0xRH_EolDtBs6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 6/7] app/testpmd: add commands to dump mbuf history
Date: Mon, 13 Oct 2025 23:16:06 +0200
Message-ID: <20251013212019.892032-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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
index b6db44c65f..76b8841a5c 100644
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

