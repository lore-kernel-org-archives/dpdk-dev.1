Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C25606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f8MWliNA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC00C40285;
	Tue, 10 Nov 2026 13:17:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 1204540281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794313024; x=1825849024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=COsqPXeSuYDG/lBFbbyM77UQHimkmqAULFCEWc/Kct8=;
 b=f8MWliNA+Vtf6Wtv2PiFkBP1lB0yoNDfuP5U0BbaSqHw3OXETaMUdmAP
 1ygkOgL5oWlHl6FMlXyVekhqcg53v9xXOGSceAjrooC63byoczMXgjzAO
 PrOKu/vREEDh9aA8JR4g0Msqff5jHuKz+RQaxHqHBo17ZLCyAezfqBprk
 7E+WcxuHI0M7YWLemDk3MV14PJ7b8LgI5d2tg4p/pMnL4Ya8HLxkoOPZ7
 g252Ew2V2uW6jo1di4UG5M7atQ7SWABTjkA8Mffa2CxWXfIp1AYIfvsHO
 5lh1rRjfHp8uvPdclUSq7nG36nihMgi/2k5ywTSBbyj59F8UHk64Fsd0v w==;
X-CSE-ConnectionGUID: agGQcUR6StCnnEXMlsXboQ==
X-CSE-MsgGUID: gz7oz3LiSgiscZUATdj3cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3050578"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3050578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:17:02 -0800
X-CSE-ConnectionGUID: xCQ8693IQNSHCNa21XvVrA==
X-CSE-MsgGUID: hRlK0xuARIqI7bjRfHm9Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8003298"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by orviesa003.jf.intel.com with ESMTP; 10 Nov 2026 04:17:01 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3] app/testpmd: add explicit link autonegotiation control
Date: Tue, 10 Nov 2026 12:16:57 +0000
Message-ID: <20261110121658.1536152-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103155033.3740814-1-bruce.richardson@intel.com>
References: <20261103155033.3740814-1-bruce.richardson@intel.com>
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

This patch does so by adding optional "autoneg on|off" setting after
speed and duplex settings specified by the user. This new option adjusts
the presence or absence of the FIXED speed bit in the ethdev
configuration structure "rte_eth_conf.link_speeds" bitmap. For backward
compatibility, the default value is "autoneg off" for fixed speeds if
not specified, meaning that the RTE_ETH_LINK_SPEED_FIXED flag is set on
the speed value by default.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V3:
* change type of new function to bool from uint32_t since value is only
  used as a flag
* Use proper ".. note::" syntax for newly added note in the testpmd docs

V2:
* changed syntax to more closely match that of ethtool, adding
  autoneg on|off at the end of the command.
* increased compatibility by ensuring that when no autoneg value is
  specified, a numeric speed sets the fixed flag (autoneg off), while an
  "auto" speed keeps autoneg on.
---
 app/test-pmd/cmdline.c                      | 91 +++++++++++++++++++--
 doc/guides/rel_notes/release_26_11.rst      |  6 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 11 ++-
 3 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 51078a2a73..cdee12a507 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -726,8 +726,8 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"port config (port_id|all)"
 			" speed (10|100|1000|2500|5000|10000|25000|40000|50000|"
 			"100000|200000|400000|800000|auto)"
-			" duplex (half|full|auto)\n"
-			"    Set speed and duplex for all ports or port_id\n\n"
+			" duplex (half|full|auto) [autoneg (on|off)]\n"
+			"    Set speed and duplex; optionally enable or disable link autonegotiation\n\n"
 
 			"port config (port_id|all) loopback (mode)\n"
 			"    Set loopback mode for all ports or port_id\n\n"
@@ -1395,10 +1395,22 @@ struct cmd_config_speed_all {
 	cmdline_fixed_string_t item2;
 	cmdline_fixed_string_t value1;
 	cmdline_fixed_string_t value2;
+	cmdline_fixed_string_t autoneg;
+	cmdline_fixed_string_t autoneg_value;
 };
 
+static bool
+link_speed_is_fixed(const char *speed, const char *autoneg)
+{
+	if (autoneg == NULL)
+		/* if no flag specified, set fixed speed if speed is not "auto" */
+		return strcmp(speed, "auto") != 0;
+
+	return strcmp(autoneg, "off") == 0;
+}
+
 static int
-parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
+parse_and_check_speed_duplex(char *speedstr, char *duplexstr, bool fixed, uint32_t *speed)
 {
 
 	int duplex;
@@ -1455,8 +1467,13 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
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
@@ -1464,9 +1481,11 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
 static void
 cmd_config_speed_all_parsed(void *parsed_result,
 			__rte_unused struct cmdline *cl,
-			__rte_unused void *data)
+			void *data)
 {
 	struct cmd_config_speed_all *res = parsed_result;
+	/* data is used to identify command variant with/without explicit autoneg setting */
+	const char *autoneg = data != NULL ? res->autoneg_value : NULL;
 	uint32_t link_speed;
 	portid_t pid;
 
@@ -1476,7 +1495,7 @@ cmd_config_speed_all_parsed(void *parsed_result,
 	}
 
 	if (parse_and_check_speed_duplex(res->value1, res->value2,
-			&link_speed) < 0)
+			link_speed_is_fixed(res->value1, autoneg), &link_speed) < 0)
 		return;
 
 	RTE_ETH_FOREACH_DEV(pid) {
@@ -1504,6 +1523,10 @@ static cmdline_parse_token_string_t cmd_config_speed_all_item2 =
 static cmdline_parse_token_string_t cmd_config_speed_all_value2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value2,
 						"half#full#auto");
+static cmdline_parse_token_string_t cmd_config_speed_all_autoneg_token =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, autoneg, "autoneg");
+static cmdline_parse_token_string_t cmd_config_speed_all_autoneg_value =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, autoneg_value, "on#off");
 
 static cmdline_parse_inst_t cmd_config_speed_all = {
 	.f = cmd_config_speed_all_parsed,
@@ -1524,6 +1547,27 @@ static cmdline_parse_inst_t cmd_config_speed_all = {
 	},
 };
 
+static cmdline_parse_inst_t cmd_config_speed_all_autoneg = {
+	.f = cmd_config_speed_all_parsed,
+	.data = &cmd_config_speed_all_autoneg,
+	.help_str = "port config all speed "
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000|auto "
+		"duplex half|full|auto autoneg on|off",
+	.tokens = {
+		(void *)&cmd_config_speed_all_port,
+		(void *)&cmd_config_speed_all_keyword,
+		(void *)&cmd_config_speed_all_all,
+		(void *)&cmd_config_speed_all_item1,
+		(void *)&cmd_config_speed_all_value1,
+		(void *)&cmd_config_speed_all_item2,
+		(void *)&cmd_config_speed_all_value2,
+		(void *)&cmd_config_speed_all_autoneg_token,
+		(void *)&cmd_config_speed_all_autoneg_value,
+		NULL,
+	},
+};
+
 /* *** configure speed for specific port *** */
 struct cmd_config_speed_specific {
 	cmdline_fixed_string_t port;
@@ -1533,14 +1577,18 @@ struct cmd_config_speed_specific {
 	cmdline_fixed_string_t item2;
 	cmdline_fixed_string_t value1;
 	cmdline_fixed_string_t value2;
+	cmdline_fixed_string_t autoneg;
+	cmdline_fixed_string_t autoneg_value;
 };
 
 static void
 cmd_config_speed_specific_parsed(void *parsed_result,
 				__rte_unused struct cmdline *cl,
-				__rte_unused void *data)
+				void *data)
 {
 	struct cmd_config_speed_specific *res = parsed_result;
+	/* data is used to identify command variant with/without explicit autoneg setting */
+	const char *autoneg = data != NULL ? res->autoneg_value : NULL;
 	uint32_t link_speed;
 
 	if (port_id_is_invalid(res->id, ENABLED_WARN))
@@ -1552,7 +1600,7 @@ cmd_config_speed_specific_parsed(void *parsed_result,
 	}
 
 	if (parse_and_check_speed_duplex(res->value1, res->value2,
-			&link_speed) < 0)
+			link_speed_is_fixed(res->value1, autoneg), &link_speed) < 0)
 		return;
 
 	ports[res->id].dev_conf.link_speeds = link_speed;
@@ -1582,6 +1630,10 @@ static cmdline_parse_token_string_t cmd_config_speed_specific_item2 =
 static cmdline_parse_token_string_t cmd_config_speed_specific_value2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, value2,
 							"half#full#auto");
+static cmdline_parse_token_string_t cmd_config_speed_specific_autoneg_token =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, autoneg, "autoneg");
+static cmdline_parse_token_string_t cmd_config_speed_specific_autoneg_value =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, autoneg_value, "on#off");
 
 static cmdline_parse_inst_t cmd_config_speed_specific = {
 	.f = cmd_config_speed_specific_parsed,
@@ -1602,6 +1654,27 @@ static cmdline_parse_inst_t cmd_config_speed_specific = {
 	},
 };
 
+static cmdline_parse_inst_t cmd_config_speed_specific_autoneg = {
+	.f = cmd_config_speed_specific_parsed,
+	.data = &cmd_config_speed_specific_autoneg,
+	.help_str = "port config <port_id> speed "
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000|auto "
+		"duplex half|full|auto autoneg on|off",
+	.tokens = {
+		(void *)&cmd_config_speed_specific_port,
+		(void *)&cmd_config_speed_specific_keyword,
+		(void *)&cmd_config_speed_specific_id,
+		(void *)&cmd_config_speed_specific_item1,
+		(void *)&cmd_config_speed_specific_value1,
+		(void *)&cmd_config_speed_specific_item2,
+		(void *)&cmd_config_speed_specific_value2,
+		(void *)&cmd_config_speed_specific_autoneg_token,
+		(void *)&cmd_config_speed_specific_autoneg_value,
+		NULL,
+	},
+};
+
 static int
 parse_speed_lanes_cfg(portid_t pid, uint32_t lanes)
 {
@@ -14357,7 +14430,9 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_operate_detach_device,
 	&cmd_set_port_setup_on,
 	&cmd_config_speed_all,
+	&cmd_config_speed_all_autoneg,
 	&cmd_config_speed_specific,
+	&cmd_config_speed_specific_autoneg,
 	&cmd_config_speed_lanes_all,
 	&cmd_config_speed_lanes_specific,
 	&cmd_show_speed_lanes,
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..29fccf09e3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -340,6 +340,12 @@ New Features
   Added ``dpdk-validate-bpf`` tool to pre-validate eBPF programs
   for compatibility with the ``lib/bpf`` execution context.
 
+* **Added explicit link autonegotiation control in testpmd.**
+
+  Added an optional ``autoneg on|off`` setting after ``duplex`` in the port speed configuration command.
+  For compatibility with older behavior, if unspecified,
+  auto-negotiation is disabled by default for numeric speeds, and enabled for "auto" speed selection.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index a967bbef76..866f8057c1 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2167,7 +2167,16 @@ port config - speed
 Set the speed and duplex mode for all ports or a specific port::
 
    testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|800000|auto) \
-            duplex (half|full|auto)
+            duplex (half|full|auto) [autoneg (on|off)]
+
+With ``autoneg on``, the selected speed is advertised with link autonegotiation enabled.
+With ``autoneg off``, link autonegotiation is disabled and the selected speed is forced.
+If ``autoneg`` parameter is omitted for a numeric speed, link autonegotiation is disabled.
+The ``auto`` speed advertises all supported speeds and enables link autonegotiation if ``autoneg`` is omitted.
+
+.. note ::
+
+   Combining ``auto`` speed with ``autoneg off`` is an error.
 
 port config - queues/descriptors
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.55.0

