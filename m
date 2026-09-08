Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD4C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11DA40E16;
	Tue,  8 Sep 2026 09:32:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 89C9C4026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852766; x=1820388766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mstzZ6h8Vftnj4XjVmts0zGmoGPsSPsVsJRau1glxbA=;
 b=M4NC8abGV/lFMrqoQyH7iyyLVWxiYF74m2lRFuwJdRVtsIt7hKG+3DJU
 fk/vYyKvFHFT8l18mI38X0PkTepzKI1/NTX5CXp8umL8nrmgkC8uWI7Cl
 MOLf6PN1JaGma8+WS0mVDd68ACzGGV6OekJGSDE7c1i0pB9jRe5ChC9Qf
 TS0oUhxmevg/loP6V9Bw5IuR1u1YRfEDAOhpVzGQJi1oAoyn3Dcb7LlAR
 cU7EozbsYVyHhhqiE9hZvmVzIrf8DQnVBaT83n9ghrwMbWjdePJcOr//Z
 6N0yvt4texY524ehbV/G27S44pWJvaNFfh91AxgXBYTsLuPpM5FPpSEiI g==;
X-CSE-ConnectionGUID: XhqqxFY3Tsyibal+MqfaFg==
X-CSE-MsgGUID: si+ZqBqDQtOv3fVYQCsADg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89290214"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89290214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:32:46 -0700
X-CSE-ConnectionGUID: e2PRUQtjS9O6ombUg3UAGw==
X-CSE-MsgGUID: Ls0A0dvzRN64BNGKdM1Uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275057133"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 00:32:43 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v5 5/5] app/testpmd: add Tx timestamp capabilities command
Date: Tue,  8 Sep 2026 13:02:06 +0530
Message-ID: <20260908073206.1236372-6-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908073206.1236372-1-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
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

Add "show port <port_id> tx_timestamp_caps" to report the Tx timestamp
slot capabilities of a port: the slot type reported by the driver and the
number of available slots.

When the port supports per-packet slots, the command also performs an
allocate and release round-trip so the slot management API can be
exercised from the command line.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 app/test-pmd/cmdline.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..54a1c4ba36 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -14213,6 +14213,84 @@ static cmdline_parse_inst_t cmd_set_dev_led = {
 	},
 };
 
+/* *** show port tx_timestamp capabilities *** */
+struct cmd_show_port_tx_ts_caps_result {
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t port;
+	portid_t port_id;
+	cmdline_fixed_string_t tx_timestamp_caps;
+};
+
+static void cmd_show_port_tx_ts_caps_parsed(void *parsed_result,
+					    __rte_unused struct cmdline *cl,
+					    __rte_unused void *data)
+{
+	struct cmd_show_port_tx_ts_caps_result *res = parsed_result;
+	struct rte_eth_timesync_tx_slot_caps caps;
+	uint32_t slot_id;
+	int ret;
+
+	ret = rte_eth_timesync_tx_slot_caps(
+			res->port_id, &caps);
+	if (ret == -ENOTSUP) {
+		printf("Port %u: Tx timestamp slot API not supported\n",
+		       res->port_id);
+		return;
+	}
+	if (ret < 0) {
+		printf("Port %u: get capabilities failed (%d)\n",
+		       res->port_id, ret);
+		return;
+	}
+
+	printf("Port %u Tx timestamp capabilities:\n", res->port_id);
+	printf("  Type      : %s\n",
+	       caps.type == RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET ? "per-packet" :
+	       caps.type == RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG ? "single-reg" :
+	       "none");
+	printf("  Max slots : %u\n", caps.max_slots);
+
+	if (caps.type != RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET)
+		return;
+
+	/* Quick alloc/release round-trip to prove the API works */
+	ret = rte_eth_timesync_tx_slot_alloc(res->port_id, &slot_id);
+	if (ret == 0) {
+		printf("  Alloc test: slot_id=%u OK\n", slot_id);
+		ret = rte_eth_timesync_tx_slot_release(
+				res->port_id, slot_id);
+		printf("  Release   : %s\n", ret == 0 ? "OK" : "FAILED");
+	} else {
+		printf("  Alloc test: failed (%d)\n", ret);
+	}
+}
+
+static cmdline_parse_token_string_t cmd_show_port_tx_ts_caps_show =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_port_tx_ts_caps_result,
+				 show, "show");
+static cmdline_parse_token_string_t cmd_show_port_tx_ts_caps_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_port_tx_ts_caps_result,
+				 port, "port");
+static cmdline_parse_token_num_t cmd_show_port_tx_ts_caps_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_show_port_tx_ts_caps_result,
+			      port_id, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_show_port_tx_ts_caps_keyword =
+	TOKEN_STRING_INITIALIZER(struct cmd_show_port_tx_ts_caps_result,
+				 tx_timestamp_caps, "tx_timestamp_caps");
+
+static cmdline_parse_inst_t cmd_show_port_tx_ts_caps = {
+	.f = cmd_show_port_tx_ts_caps_parsed,
+	.data = NULL,
+	.help_str = "show port <port_id> tx_timestamp_caps",
+	.tokens = {
+		(void *)&cmd_show_port_tx_ts_caps_show,
+		(void *)&cmd_show_port_tx_ts_caps_port,
+		(void *)&cmd_show_port_tx_ts_caps_port_id,
+		(void *)&cmd_show_port_tx_ts_caps_keyword,
+		NULL,
+	},
+};
+
 /* ******************************************************************************** */
 
 /* list of instructions */
@@ -14469,6 +14547,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_port_cman_config,
 	&cmd_config_tx_affinity_map,
 	&cmd_set_dev_led,
+	&cmd_show_port_tx_ts_caps,
 	NULL,
 };
 
-- 
2.55.0

