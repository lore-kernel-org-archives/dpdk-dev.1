Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B7CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 23:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A887E40696;
	Wed,  1 Oct 2025 01:39:03 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 04462406BA
 for <dev@dpdk.org>; Wed,  1 Oct 2025 01:39:01 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 536C27A0159;
 Tue, 30 Sep 2025 19:39:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 30 Sep 2025 19:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1759275541; x=
 1759361941; bh=P9DBDynpFVW5yQ8VWLAvw1yFkmx4Dpna0vf9DDkz+3w=; b=H
 hJ1qfYP3tB8bjz/IHtKMy6cE3SvgabclGHrLC+MJ7gAai0UIA85XhhpKVM1tWCjF
 fEqZEswi4RQU+qEJpYhgytI+KvlEXZsIpPYxKLyLwoRaGVIG9heoWCt+i3tJmfU5
 wWpbN3Q6ALjzYhA+sTrmki2n4/A2jSat0Qk4QXvgPrKT5kOGerMh5D/ukjVbQpKe
 U8MqDugWRhaQIG0OkqEG0REs+MeHZTBdVwZOhzxZ0NZFXk6Ji7w3ALrcAJj+ighJ
 lRNlhwkJryvfKDekRCKNEXCFFWKd2Sqg+uXaqTYMCwjaM0O4Z5AC4ry1jrKTmf0F
 Synwev+tyVIIxFEGKxN2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1759275541; x=1759361941; bh=P
 9DBDynpFVW5yQ8VWLAvw1yFkmx4Dpna0vf9DDkz+3w=; b=Cxy0MwNfDhx06hAsz
 uClQwvFNhp+KeZ/xFFphpgAAronIddASXc5iW2QBFQVxEpx8CNNCvNpD+g5uPTVf
 IVHUcPFm6QHkR/DhaHYPxxNJzvKOuyDv510yWS5eDxQLrpL2h2Rw4z4kAJ2gCcoS
 Kvhjisc7ujr5c/TIol5mMLYBjJ6iJmIprQMadTxwxcHCH59+PKwe3DMyGBUwZH6Q
 fhyETaxTEplBI0TlHv09xWEopm8WjIL+QIU+49Q6sMiJ6rlyYiv6sXYYkrh/pw5w
 7l/kNiVXQA2nc4RKzwC7RxuEaRmJVfXbWQ4zS4PA1TI5PJSARSVSGiwxo8ycVmCD
 jQAVA==
X-ME-Sender: <xms:FGrcaEcWEEx-5s83SGMYrpgi-7VYoTJHdhQV-q-IXCcBHUWitk-88A>
 <xme:FGrcaBJlgYGmU91U5QT9Q97i1NafVLiO-sogL3yaPG8k1BnfmVuPSeGUG97k3Q1q5
 qacD6S3A4XZPCfCXq2CxKGJSeAx_fgoZ20PkYizlg8XVpindjYGsg>
X-ME-Received: <xmr:FGrcaEirhjsl1G08QZImZ4mdsYGNJj498f7xahaJMyPjXV07MDw2ikP21lXd4sW77TA664Na395I1152hfRLpMcYvpkF9tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghh
 vghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthh
 grrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgr
 rhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorh
 hkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrmhgrnhdruggvvghprdhsihhnghhh
 sehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:FGrcaPShZ6uvqjWpXRp0j-tWWMp_ZMpCzwSedWkIRVj55OZpEMnSJw>
 <xmx:FGrcaOUI1eaunBAbZ3rnCw0CvN6W3oO9gJb_YQ01Sj9dp6Vu-yYskA>
 <xmx:FGrcaLT1fQbk9S7kcL953eBaiq_omHx1zHR0M72ekR3-V5WNxPF9Bw>
 <xmx:FGrcaAkqBtBBvxODOOzOy22hiGO4AQz5_V54Worc8vwMNBVO_owJ7g>
 <xmx:FWrcaGGB1R5CvzxnH-6eIMQuc1C8rI5WKpMq21M4RsWaC_wJ88rCg_Bb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:38:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 4/5] app/testpmd: add commands to dump mbuf history
Date: Wed,  1 Oct 2025 01:25:05 +0200
Message-ID: <20250930233828.3999565-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930233828.3999565-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
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

From: Shani Peretz <shperetz@nvidia.com>

Dump the mbuf history to the console or to a file.

The dump will contain:
- Operation history for each mbuf
- Summary and statistics about all mbufs

Dump the history of all mbuf pools:
testpmd> dump_mbuf_history_all

Dump the history of one mbuf pool:
testpmd> dump_mbuf_history_single_mempool <mempool_name> [file_name]

Dump the history of one mbuf:
testpmd> dump_mbuf_history_single

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/cmdline.c | 246 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 245 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3731fba370..113db68f8c 100644
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
 			"dump_log_types\n"
 			"    Dumps the log level for all the dpdk modules\n\n"
 
+			"dump_mbuf_history_all\n"
+			"    Dumps the mbuf history for all mempools\n\n"
+
+			"dump_mbuf_history_single <mbuf_ptr>\n"
+			"    Dumps the history for a specific mbuf (use 0x<address> format)\n\n"
+
+			"dump_mbuf_history_single_mempool <mempool_name> [file_name]\n"
+			"    Dumps the history for a specific mempool\n\n"
+
 			"show port (port_id) speed_lanes capabilities"
 			"	Show speed lanes capabilities of a port.\n\n"
 		);
@@ -9177,6 +9187,8 @@ static void cmd_dump_parsed(void *parsed_result,
 #endif
 	else if (!strcmp(res->dump, "dump_log_types"))
 		rte_log_dump(stdout);
+	else if (!strcmp(res->dump, "dump_mbuf_history_all"))
+		rte_mbuf_history_dump_all(stdout);
 }
 
 static cmdline_parse_token_string_t cmd_dump_dump =
@@ -9198,7 +9210,8 @@ cmd_dump_init(void)
 #ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
 #endif
-		"dump_log_types";
+		"dump_log_types#"
+		"dump_mbuf_history";
 }
 
 static cmdline_parse_inst_t cmd_dump = {
@@ -9260,6 +9273,232 @@ static cmdline_parse_inst_t cmd_dump_one = {
 	},
 };
 
+/* Dump mbuf history to file */
+struct cmd_dump_mbuf_to_file_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t file;
+};
+
+static void cmd_dump_mbuf_to_file_parsed(void *parsed_result,
+		struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_dump_mbuf_to_file_result *res = parsed_result;
+	FILE *file = stdout;
+	char *file_name = res->file;
+
+	if (strcmp(res->dump, "dump_mbuf_history_all")) {
+		cmdline_printf(cl, "Invalid dump type\n");
+		return;
+	}
+
+	if (file_name && strlen(file_name)) {
+		file = fopen(file_name, "w");
+		if (!file) {
+			rte_mbuf_history_dump_all(stdout);
+			return;
+		}
+	}
+	rte_mbuf_history_dump_all(file);
+	printf("Flow dump finished\n");
+	if (file_name && strlen(file_name))
+		fclose(file);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result, dump,
+			"dump_mbuf_history_all");
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_file =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result, file, NULL);
+
+static cmdline_parse_inst_t cmd_dump_mbuf_to_file = {
+	.f = cmd_dump_mbuf_to_file_parsed,  /* function to call */
+	.data = NULL,      /* 2nd arg of func */
+	.help_str = "dump_mbuf_history_all <file_name>: Dump mbuf history to file",
+	.tokens = {        /* token list, NULL terminated */
+		(void *)&cmd_dump_mbuf_to_file_dump,
+		(void *)&cmd_dump_mbuf_to_file_file,
+		NULL,
+	},
+};
+
+/* Dump single mbuf history */
+struct cmd_dump_mbuf_history_single_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t mbuf_ptr;
+};
+
+static void cmd_dump_mbuf_history_single_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_dump_mbuf_history_single_result *res = parsed_result;
+	struct rte_mbuf *mbuf;
+	uintptr_t mbuf_addr;
+
+	/* Parse the mbuf pointer from hex string */
+	if (sscanf(res->mbuf_ptr, "0x%" SCNxPTR, &mbuf_addr) != 1) {
+		printf("Invalid mbuf pointer format. Use 0x<address>\n");
+		return;
+	}
+
+	mbuf = (struct rte_mbuf *)mbuf_addr;
+
+	printf("Dumping history for mbuf at %p:\n", mbuf);
+	rte_mbuf_history_dump(stdout, mbuf);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_result, dump,
+			"dump_mbuf_history_single");
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_ptr =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_result, mbuf_ptr,
+			NULL);
+
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single = {
+	.f = cmd_dump_mbuf_history_single_parsed,
+	.data = NULL,
+	.help_str = "dump_mbuf_history_single <mbuf_ptr>: Dump history for specific mbuf",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_single_dump,
+		(void *)&cmd_dump_mbuf_history_single_ptr,
+		NULL,
+	},
+};
+
+/* Dump single mempool history */
+struct cmd_dump_mbuf_history_single_mempool_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t mempool_name;
+};
+
+static void cmd_dump_mbuf_history_single_mempool_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_dump_mbuf_history_single_mempool_result *res = parsed_result;
+	struct rte_mempool *mp;
+
+	mp = rte_mempool_lookup(res->mempool_name);
+	if (mp == NULL) {
+		printf("Mempool '%s' not found\n", res->mempool_name);
+		return;
+	}
+
+	printf("Dumping history for mempool '%s':\n", res->mempool_name);
+
+	rte_mbuf_history_dump_mempool(stdout, mp);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_mempool_result,
+			dump, "dump_mbuf_history_single_mempool");
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_mempool_result,
+			mempool_name, NULL);
+
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool = {
+	.f = cmd_dump_mbuf_history_single_mempool_parsed,
+	.data = NULL,
+	.help_str = "dump_mbuf_history_single_mempool <mempool_name>: Dump history for specific mempool",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_single_mempool_dump,
+		(void *)&cmd_dump_mbuf_history_single_mempool_name,
+		NULL,
+	},
+};
+
+/* Dump single mempool history to file only */
+struct cmd_dump_mbuf_history_single_mempool_to_file_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t mempool_name;
+	cmdline_fixed_string_t file;
+};
+
+static void cmd_dump_mbuf_history_single_mempool_to_file_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_dump_mbuf_history_single_mempool_to_file_result *res = parsed_result;
+	struct rte_mempool *mp;
+	FILE *file = NULL;
+	char *file_name = res->file;
+
+	mp = rte_mempool_lookup(res->mempool_name);
+	if (mp == NULL) {
+		printf("Mempool '%s' not found\n", res->mempool_name);
+		return;
+	}
+
+	if (file_name && strlen(file_name)) {
+		file = fopen(file_name, "w");
+		if (!file) {
+			printf("Failed to open file '%s'\n", file_name);
+			return;
+		}
+	} else {
+		printf("File name required for this command\n");
+		return;
+	}
+
+	printf("Dumping history for mempool '%s' to file '%s'...\n", res->mempool_name, file_name);
+	rte_mbuf_history_dump_mempool(file, mp);
+	printf("Mempool history dump finished\n");
+	fclose(file);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_to_file_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_mempool_to_file_result,
+			dump, "dump_mbuf_history_single_mempool");
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_to_file_name =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_mempool_to_file_result,
+			mempool_name, NULL);
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_to_file_file =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_single_mempool_to_file_result,
+			file, NULL);
+
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool_to_file = {
+	.f = cmd_dump_mbuf_history_single_mempool_to_file_parsed,
+	.data = NULL,
+	.help_str = "dump_mbuf_history_single_mempool <mempool_name> <file_name>: Dump history for specific mempool to file",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_single_mempool_to_file_dump,
+		(void *)&cmd_dump_mbuf_history_single_mempool_to_file_name,
+		(void *)&cmd_dump_mbuf_history_single_mempool_to_file_file,
+		NULL,
+	},
+};
+
+/* Dump all mempools history */
+struct cmd_dump_mbuf_history_all_result {
+	cmdline_fixed_string_t dump;
+};
+
+static void cmd_dump_mbuf_history_all_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	__rte_unused struct cmd_dump_mempool_history_all_result *res = parsed_result;
+
+	printf("Dumping history for all mempools:\n");
+	rte_mbuf_history_dump_all(stdout);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_all_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_all_result, dump,
+			"dump_mbuf_history_all");
+
+static cmdline_parse_inst_t cmd_dump_mbuf_history_all = {
+	.f = cmd_dump_mbuf_history_all_parsed,
+	.data = NULL,
+	.help_str = "dump_mbuf_history_all: Dump history for all mempools",
+	.tokens = {
+		(void *)&cmd_dump_mbuf_history_all_dump,
+		NULL,
+	},
+};
+
+
 /* *** Filters Control *** */
 
 #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
@@ -13999,6 +14238,11 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_cleanup_txq_mbufs,
 	&cmd_dump,
 	&cmd_dump_one,
+	&cmd_dump_mbuf_to_file,
+	&cmd_dump_mbuf_history_single,
+	&cmd_dump_mbuf_history_single_mempool,
+	&cmd_dump_mbuf_history_single_mempool_to_file,
+	&cmd_dump_mbuf_history_all,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
-- 
2.51.0

