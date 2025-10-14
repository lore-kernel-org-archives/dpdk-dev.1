Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF4CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9CF1406FF;
	Tue, 14 Oct 2025 14:41:12 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 5F780406BA
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:41:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B20907A0130;
 Tue, 14 Oct 2025 08:41:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 08:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760445670;
 x=1760532070; bh=23at8QTyR4GVWSCHhP0LjhSBTs7dyKYah5Hs37wX2Nw=; b=
 St9b9PGKl27Tv+GuvstYlDwiBPBQ4PVbuEIDGWHYlde4NhskpM5wJchs72QWNjKe
 h3/X5jlwu/NvIercTp4GM0EteCxXAygPducWFVNN1yFoTb2k7lyP3r5RUPS0Y+GY
 hzDPtalzEAQmcIeTXzpq8+sAWoPPi2cTXukm+BXx7tlYaqDtQ4XcCnsJvNA/we7j
 1S8lgrnBU3CF9aaSjdE4iej16Z+I+FpPrYTkMnCONjhx+oWiDWaVg2NdRYrcH/xl
 6k9ggXvIz0r6AqH9hyRLygBOrO6l7XOC44ygiSP6lZZJuQyLtRP5mvos+F4lYfYK
 swtM1g0L5HMhqRZVjlSsSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760445670; x=
 1760532070; bh=23at8QTyR4GVWSCHhP0LjhSBTs7dyKYah5Hs37wX2Nw=; b=b
 UF8s6zgpqN41wAZeOtU5GcGyjQ13Q/M0zeItw3bC9tPv6i/s80Qvk8C/qum1kcW7
 oEGR4Cn8GFrnr0tm9vxKQFt2f4f6xToHZx3jE1T76n72iAT7XMuerourWKVWoz4B
 nigZuEydcbERjPqnDb2ZkqYHrPJK+m0txsSmYV5WwWElJ209MkvYLQ8DB1KksWh3
 rpd5dkXJu+o5mZW6gMX9Nc1wqLnRzf65pRGYA6R5qG5ScXhKBkFRfNufjrDLxlGl
 MLRKGceu4d7bF3qA8fb0l5DTXHp4xBjowdCoaj/tb4u9FtbFXUFV6cUvG47/xgC/
 HoM7NJ/ElOSjtD0nBevRg==
X-ME-Sender: <xms:5kTuaKwD7Wp8JKHIQzKN8sJpnMM6Qg1jw3wSRqYeLIzMGZRrThnkwg>
 <xme:5kTuaNqOzxDlsknqlpZ8jvUC41VpRo9xr1p-AO8qktIg-7vkUqNEvM-wnLulV5nJE
 2-fT8D7Do2NTC9NF117lNwDIZoO9FejrrJ0rYpr4RfruPuB1lyTjg>
X-ME-Received: <xmr:5kTuaB6zfV7wq78LJ7tkbkmbhbXg-Pqsa2wor1tFxXXVnhSUSnjT4CkrU90YWIInBru8AIlhOKZoPVhMtp0Z5vs64zdNpxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvhhhomhgr
 shcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecugg
 ftrfgrthhtvghrnheptdeiffffgeefteelhfekueetueduffejgfelvedtieejudekgfev
 heetheehgeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgr
 tghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhs
 hhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfi
 horhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrmhgrnhdruggvvghprdhsihhn
 ghhhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:5kTuaMcTXjl_XnpKcv7YoyEeM6FEIfj-hP1Vmujow9awwZHcvWsvXw>
 <xmx:5kTuaO6j9k5z_3hUYcc2M7NGuifp1Pg6C8pabn7vLaR8oz0yNYkZmA>
 <xmx:5kTuaLt0aAFeFBIK0YH8W986XkZSDg8E-KpsikY7iUGi-PLofHEHnA>
 <xmx:5kTuaGgVC4spQRiQJ5n12OJfeK4hBIftrBqq3LXBTn1kcdxEvE28fQ>
 <xmx:5kTuaNLQIBzORmCHgJUshj8wTvtnXvM-RUmPMwA1wJsBQKGVjmdcJXaX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:41:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v6 6/7] app/testpmd: add commands to dump mbuf history
Date: Tue, 14 Oct 2025 14:33:39 +0200
Message-ID: <20251014124046.1032293-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014124046.1032293-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Dump the history of one mbuf:
	testpmd> dump mbuf history <mbuf_addr> [file]

Dump the history of one mbuf pool:
	testpmd> dump mbuf pool history <mp_name> [file]

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test-pmd/cmdline.c                      | 143 ++++++++++++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  13 ++
 2 files changed, 156 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 487a95cd16..cc35540115 100644
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
+			"dump mbuf history <mbuf_addr> [file_name]\n"
+			"    Dumps the history for a specific mbuf (use 0x<address> format)\n\n"
+
+			"dump mbuf pool history <mempool_name> [file_name]\n"
+			"    Dumps the history for a specific mempool\n\n"
+
 			"show port (port_id) speed_lanes capabilities"
 			"	Show speed lanes capabilities of a port.\n\n"
 		);
@@ -9243,6 +9253,135 @@ static cmdline_parse_inst_t cmd_dump_named = {
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
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_obj =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, obj, NULL);
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_pool =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, obj, "pool");
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_result, name, NULL);
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
+	} else if (strcmp(res->obj, "pool") == 0) {
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
+	} else {
+		struct rte_mbuf *mbuf;
+		uintptr_t mbuf_addr;
+		if (sscanf(res->obj, "0x%" SCNxPTR, &mbuf_addr) != 1) {
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
+static cmdline_parse_inst_t cmd_dump_mbuf_history_stdout = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history all|<address>",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_obj,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_history_to_file = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf history all|<address> [file]",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_obj,
+		(void *)&cmd_dump_mbuf_history_file,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_pool_history_stdout = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf pool history <name>",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_pool,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_name,
+		NULL,
+	},
+};
+static cmdline_parse_inst_t cmd_dump_mbuf_pool_history_to_file = {
+	.f = cmd_dump_mbuf_history_parsed,
+	.help_str = "dump mbuf pool history <name> [file]",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_dump,
+		(void *)&cmd_dump_mbuf_history_mbuf,
+		(void *)&cmd_dump_mbuf_history_pool,
+		(void *)&cmd_dump_mbuf_history_history,
+		(void *)&cmd_dump_mbuf_history_name,
+		(void *)&cmd_dump_mbuf_history_file,
+		NULL,
+	},
+};
+
 /* *** Filters Control *** */
 
 #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
@@ -13982,6 +14121,10 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_cleanup_txq_mbufs,
 	&cmd_dump_simple,
 	&cmd_dump_named,
+	&cmd_dump_mbuf_history_stdout,
+	&cmd_dump_mbuf_history_to_file,
+	&cmd_dump_mbuf_pool_history_stdout,
+	&cmd_dump_mbuf_pool_history_to_file,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e4bef31d06..f3b9a55fb2 100644
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
+   testpmd> dump mbuf history <mbuf_addr> [file]
+   testpmd> dump mbuf pool history <mp_name> [file]
+
 show (raw_encap|raw_decap)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.51.0

