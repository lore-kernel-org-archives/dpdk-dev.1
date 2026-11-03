Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F4606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BF5iRTuz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F6840656;
	Tue,  3 Nov 2026 16:50:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id BFD7B40265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793721046; x=1825257046;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N0/xj6lIJ8B7TDbgKZKg+GCFHpRwaAZ1kPYLY+r1eU0=;
 b=BF5iRTuzY9xcbIlv8/9FggMWU5xKRHYFVXP5RLxahY8qevcPL4OZFih1
 S1ZajWtMHJIbsHdDF9bW3/gAs8QQcLo+7fVYwJWIKh39CUakIeddINfiW
 Q6HgqNch8HcU1qkimHYShbqozeYXIFckdVWhxKvLQ1fOePN8PodYRk9ji
 fs9qNvWE3A0Bhf9oCr4k+OYMKPeTbJIDdP46UOCira+q6zCSVaOajI/if
 dnoNAgCUAmXiRp8olrbDC2TyRQTk5lWgkcumKtxvuUmjOWzFRMlKeultO
 JLQKfo3Sxxl7E2KltkySDQz4xsipNH1TYNXUnY4Q7gTfHeiWMd3Q7Uw0S g==;
X-CSE-ConnectionGUID: IDemv4zVTCedgDdEIBnInA==
X-CSE-MsgGUID: XYPBdObYRQWu6fhAuxLDmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2330461"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2330461"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 07:50:44 -0800
X-CSE-ConnectionGUID: Tuq1LORvR3ObJdbam3H63Q==
X-CSE-MsgGUID: n80jFzCoTMe1pIdHB9/yyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6540726"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 03 Nov 2026 07:50:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH] app/test-pmd: add explicit parameter for fixed link speeds
Date: Tue,  3 Nov 2026 15:50:33 +0000
Message-ID: <20261103155033.3740814-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a particular speed was specified for a port in testpmd, the flags
passed to the underlying API call always included the
RTE_ETH_LINK_SPEED_FIXED flag. This flag is not a mandatory part of the
bitmap when setting speeds, and is used to disable autonegotiation.
It's possible to have a link report only a single speed while
still have negotiation enabled, so testpmd needs to be extended to
support setting a speed both with and without the flag.

This patch does so by adding an optional "fixed" keyword after the speed
specified by the user. The presence or absense of the keyword adjusts
the presence or absense of the FIXED speed bit in the ethdev
configuration structure "rte_eth_conf.link_speeds" bitmap.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c                      | 69 ++++++++++++++++++---
 doc/guides/rel_notes/release_26_11.rst      |  8 +++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 10 ++-
 3 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 51078a2a73..ee86f75c09 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -726,8 +726,8 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"port config (port_id|all)"
 			" speed (10|100|1000|2500|5000|10000|25000|40000|50000|"
 			"100000|200000|400000|800000|auto)"
-			" duplex (half|full|auto)\n"
-			"    Set speed and duplex for all ports or port_id\n\n"
+			" [fixed] duplex (half|full|auto)\n"
+			"    Set speed and duplex; fixed disables link autonegotiation\n\n"
 
 			"port config (port_id|all) loopback (mode)\n"
 			"    Set loopback mode for all ports or port_id\n\n"
@@ -1395,10 +1395,11 @@ struct cmd_config_speed_all {
 	cmdline_fixed_string_t item2;
 	cmdline_fixed_string_t value1;
 	cmdline_fixed_string_t value2;
+	cmdline_fixed_string_t fixed;
 };
 
 static int
-parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
+parse_and_check_speed_duplex(char *speedstr, char *duplexstr, bool fixed, uint32_t *speed)
 {
 
 	int duplex;
@@ -1455,8 +1456,13 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
 		}
 	}
 
-	if (*speed != RTE_ETH_LINK_SPEED_AUTONEG)
+	if (fixed) {
+		if (*speed == RTE_ETH_LINK_SPEED_AUTONEG) {
+			fprintf(stderr, "A fixed link requires a specific speed\n");
+			return -1;
+		}
 		*speed |= RTE_ETH_LINK_SPEED_FIXED;
+	}
 
 	return 0;
 }
@@ -1464,7 +1470,7 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
 static void
 cmd_config_speed_all_parsed(void *parsed_result,
 			__rte_unused struct cmdline *cl,
-			__rte_unused void *data)
+			void *data)
 {
 	struct cmd_config_speed_all *res = parsed_result;
 	uint32_t link_speed;
@@ -1476,7 +1482,7 @@ cmd_config_speed_all_parsed(void *parsed_result,
 	}
 
 	if (parse_and_check_speed_duplex(res->value1, res->value2,
-			&link_speed) < 0)
+			data != NULL, &link_speed) < 0)
 		return;
 
 	RTE_ETH_FOREACH_DEV(pid) {
@@ -1504,6 +1510,8 @@ static cmdline_parse_token_string_t cmd_config_speed_all_item2 =
 static cmdline_parse_token_string_t cmd_config_speed_all_value2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value2,
 						"half#full#auto");
+static cmdline_parse_token_string_t cmd_config_speed_all_fixed_token =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, fixed, "fixed");
 
 static cmdline_parse_inst_t cmd_config_speed_all = {
 	.f = cmd_config_speed_all_parsed,
@@ -1524,6 +1532,26 @@ static cmdline_parse_inst_t cmd_config_speed_all = {
 	},
 };
 
+static cmdline_parse_inst_t cmd_config_speed_all_fixed = {
+	.f = cmd_config_speed_all_parsed,
+	.data = &cmd_config_speed_all_fixed,
+	.help_str = "port config all speed "
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000 "
+		"fixed duplex half|full|auto",
+	.tokens = {
+		(void *)&cmd_config_speed_all_port,
+		(void *)&cmd_config_speed_all_keyword,
+		(void *)&cmd_config_speed_all_all,
+		(void *)&cmd_config_speed_all_item1,
+		(void *)&cmd_config_speed_all_value1,
+		(void *)&cmd_config_speed_all_fixed_token,
+		(void *)&cmd_config_speed_all_item2,
+		(void *)&cmd_config_speed_all_value2,
+		NULL,
+	},
+};
+
 /* *** configure speed for specific port *** */
 struct cmd_config_speed_specific {
 	cmdline_fixed_string_t port;
@@ -1533,12 +1561,13 @@ struct cmd_config_speed_specific {
 	cmdline_fixed_string_t item2;
 	cmdline_fixed_string_t value1;
 	cmdline_fixed_string_t value2;
+	cmdline_fixed_string_t fixed;
 };
 
 static void
 cmd_config_speed_specific_parsed(void *parsed_result,
 				__rte_unused struct cmdline *cl,
-				__rte_unused void *data)
+				void *data)
 {
 	struct cmd_config_speed_specific *res = parsed_result;
 	uint32_t link_speed;
@@ -1552,7 +1581,7 @@ cmd_config_speed_specific_parsed(void *parsed_result,
 	}
 
 	if (parse_and_check_speed_duplex(res->value1, res->value2,
-			&link_speed) < 0)
+			data != NULL, &link_speed) < 0)
 		return;
 
 	ports[res->id].dev_conf.link_speeds = link_speed;
@@ -1582,6 +1611,8 @@ static cmdline_parse_token_string_t cmd_config_speed_specific_item2 =
 static cmdline_parse_token_string_t cmd_config_speed_specific_value2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, value2,
 							"half#full#auto");
+static cmdline_parse_token_string_t cmd_config_speed_specific_fixed_token =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, fixed, "fixed");
 
 static cmdline_parse_inst_t cmd_config_speed_specific = {
 	.f = cmd_config_speed_specific_parsed,
@@ -1602,6 +1633,26 @@ static cmdline_parse_inst_t cmd_config_speed_specific = {
 	},
 };
 
+static cmdline_parse_inst_t cmd_config_speed_specific_fixed = {
+	.f = cmd_config_speed_specific_parsed,
+	.data = &cmd_config_speed_specific_fixed,
+	.help_str = "port config <port_id> speed "
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000 "
+		"fixed duplex half|full|auto",
+	.tokens = {
+		(void *)&cmd_config_speed_specific_port,
+		(void *)&cmd_config_speed_specific_keyword,
+		(void *)&cmd_config_speed_specific_id,
+		(void *)&cmd_config_speed_specific_item1,
+		(void *)&cmd_config_speed_specific_value1,
+		(void *)&cmd_config_speed_specific_fixed_token,
+		(void *)&cmd_config_speed_specific_item2,
+		(void *)&cmd_config_speed_specific_value2,
+		NULL,
+	},
+};
+
 static int
 parse_speed_lanes_cfg(portid_t pid, uint32_t lanes)
 {
@@ -14357,7 +14408,9 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_operate_detach_device,
 	&cmd_set_port_setup_on,
 	&cmd_config_speed_all,
+	&cmd_config_speed_all_fixed,
 	&cmd_config_speed_specific,
+	&cmd_config_speed_specific_fixed,
 	&cmd_config_speed_lanes_all,
 	&cmd_config_speed_lanes_specific,
 	&cmd_show_speed_lanes,
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..e7ed2ca13f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -341,6 +341,14 @@ New Features
   for compatibility with the ``lib/bpf`` execution context.
 
 
+* **Added explicit fixed-speed selection in testpmd.**
+
+  Added an optional ``fixed`` keyword to the port speed configuration command.
+  Numeric speeds now leave link autonegotiation enabled unless ``fixed`` is specified.
+  Add ``fixed`` between the speed value and ``duplex`` to disable link autonegotiation,
+  preserving the previous behavior.
+
+
 Removed Items
 -------------
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index a967bbef76..0ab52a8af0 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2167,7 +2167,15 @@ port config - speed
 Set the speed and duplex mode for all ports or a specific port::
 
    testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|800000|auto) \
-            duplex (half|full|auto)
+            [fixed] duplex (half|full|auto)
+
+Without ``fixed``, the selected speed is advertised with link autonegotiation enabled.
+With ``fixed``, link autonegotiation is disabled and the selected speed is forced.
+The ``auto`` speed advertises all supported speeds and cannot be combined with ``fixed``.
+The ``auto`` duplex value selects full duplex; it does not control link autonegotiation.
+Support for these settings depends on the driver and hardware.
+
+
 
 port config - queues/descriptors
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.55.0

