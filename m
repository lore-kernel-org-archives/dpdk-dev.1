Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE86CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AA97427E9;
	Thu, 16 Oct 2025 22:36:19 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 70B314026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:18 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 297EF140018F;
 Thu, 16 Oct 2025 16:36:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 16:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760646978;
 x=1760733378; bh=1FFhlSUSAs/rJnxldBg4IQxhSoJ5USpHTK1aCbSWvNg=; b=
 MOfYoqENirKkGCnk8SgrRAqd/8VhgABaZxe3AOt+1V37Wqp7eA6y6S2dKEAXCG8X
 Kpq+VnOEk+dAY/fZlT0AvhuE8+NBZysA3NYdtXvALZw7/NxmwDy9eviYXbCjVhQg
 jCUdK5vNu+fJINXJTOWI4+D+2fScps3Mu1ljauHivU+hseSitTPs/jru/75eyP/u
 1+0BWJskTRYUiwm/cKt8NghHFt6Ci4TLPAfreqgjvNh5u+9agfrUedQTLc6+BrCd
 4Vl3baUciwr5wgt8fC15+F/HiALyRgPxgfnAZjBgD/LSasL02/Au+/ie6azospQZ
 +3iRQxaX+aglLeWzMjNALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760646978; x=
 1760733378; bh=1FFhlSUSAs/rJnxldBg4IQxhSoJ5USpHTK1aCbSWvNg=; b=D
 CgSAk8ZXNL3EbPcNpS7i1mqumSwteHriMJb8hp0QgmftxyRcKx55u1fuHXfYR8Do
 /dKTq4EHCDvgh7stwRE1hvNFmG/IbodpZOZWK2Hb46nLbrq0PubOFAnWqHG9FghI
 nOG0K+hhaIoZ++QTeaBhAt15hW/EQpKn9Zk+WrBSzZA9j6vipVUD8VgIr6co7fLg
 HDQg7UelxJbaZ4M6uq+MzckXr9eWUUc4klwBP5Jwt1UPfGTg3dIg8AspVj2VZOcx
 xYt+g8cNppEgQreOsB9yWirnKkAito/IR5SPqN6x//4XXnIeMCJJQsNX0wob6QJZ
 qCllFEbjE+Puh6jGVvxew==
X-ME-Sender: <xms:QVfxaBmxJhzLypJTFQVF5Q_INu_VQSEHCQJT1rANd75gRv9Jl2E6Xw>
 <xme:QVfxaHz80T8jfi8VMEwTrD8fBYMGmDQkuPdFz0mZ_Yl0tjq2rKhqkBSyYqxQB2noK
 JRTMMJjwr9qCI5_yRaP2_CIYoechJ9AVqm_YSX3v8QK2h4VhV4YFKo>
X-ME-Received: <xmr:QVfxaGpfmC0rqw5cBV5XzBeLg8PNy_Mdz98MEAwrlvHY9hvFuN5on0I0dSCfcmoy9LKQwb9g6CXg4MGHSzQI74aKZWzaQ9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvhhhomhgr
 shcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecugg
 ftrfgrthhtvghrnheptdeiffffgeefteelhfekueetueduffejgfelvedtieejudekgfev
 heetheehgeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
 homhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgr
 tghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhs
 hhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfi
 horhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrmhgrnhdruggvvghprdhsihhn
 ghhhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:QVfxaG7gHzBhxsDckMEX-YcsoT2SYydDX0zNVHTMNIKw4sFbbKwXRQ>
 <xmx:QVfxaNc-4VXAV4P567WTYNTB1GXhicNqDQRu7X5gg4KCs7VCl4z5uQ>
 <xmx:QVfxaL5ZQN7_7Wd1B7qnAfAn4GV5ohmGIn6moRismvYFaS9XcvuNGw>
 <xmx:QVfxaEu-4zgmLqmy5R1yWY1Ik2TI2uQzaRV0Ssj0gpLlA-M9GNkvHA>
 <xmx:QlfxaPtR1WaPlWwKWzq2eEbOA5dJY4W3jSDNOUljsDxIDIS94ZjMjSM9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v7 6/7] app/testpmd: add commands to dump mbuf history
Date: Thu, 16 Oct 2025 22:34:44 +0200
Message-ID: <20251016203557.2554678-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
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
index d332236924..9205bc8573 100644
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
@@ -14020,6 +14159,10 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
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
index 23a4a86cc3..e423abd40e 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -634,6 +634,19 @@ Dumps the log level for all the dpdk modules::
 
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

