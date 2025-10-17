Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45897CCD1A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1310242DA7;
	Fri, 17 Oct 2025 13:11:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 03EB2427A2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699499; x=1792235499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=84neQvJ1nx7kn4/4HWm8JNhpobjXpeKxbBSYHnY+6EA=;
 b=Cj3i/xoWgv3FVOeGVK8M8/SR1hU7T7pHtcaCrukzKlHLnImX+mHqxgPC
 dZteALMgPY515d/9LDEnPljCz1UgoGm3+DT34F3sxMDrW8Hqlslr9K3d2
 q3cJ85fMNlJ334636fSIa1cxrVgt0rwcLHv/cPIEYkzSUkVi0Odx8aH1l
 ODCLSmdQBxQy9+KuZowRdvmA5H17wLCPoAZlZmMGJ7OryU2EkFZAsuwku
 G28psp60CoojqQ3uQ3oQiIMBucZeITQkInoZZV8KZ6Cq4X6rfB2CWy8LN
 xz8Hy/jl5ef9mgK2lmrMczV9leg/CTsSkBHFtuN8lf6DKn5cFJMN6lp69 w==;
X-CSE-ConnectionGUID: AIIOtpo9SIqxg5fCDdLpig==
X-CSE-MsgGUID: C3ieFUsISlS2yjfCGmvOMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74023717"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74023717"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:11:38 -0700
X-CSE-ConnectionGUID: jqIkam3CRXi33rp93hPZYA==
X-CSE-MsgGUID: JlFppIxLRG6JTHuCtvvlBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182654507"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 04:11:37 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 3/3] app/testpmd: support port reinitialisation
Date: Fri, 17 Oct 2025 11:11:09 +0000
Message-Id: <20251017111109.1734792-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017111109.1734792-1-ciara.loftus@intel.com>
References: <20251017111109.1734792-1-ciara.loftus@intel.com>
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

Add a new command for reinitialising the port. It differs from the "port
reset" command in that resets but also reinitialises the device,
restoring it to its original configuration and in some cases restarting
it if the driver supports it.

The command uses the following syntax:

 port reinit <port_id>

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 app/test-pmd/cmdline.c | 15 ++++++++++-----
 app/test-pmd/testpmd.c | 26 ++++++++++++++++++++++++++
 app/test-pmd/testpmd.h |  1 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7803e14bdc..b63b614ef9 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -1100,7 +1100,7 @@ static cmdline_parse_inst_t cmd_help_long = {
 };
 
 
-/* *** start/stop/close all ports *** */
+/* *** start/stop/close/reset/reinit all ports *** */
 struct cmd_operate_port_result {
 	cmdline_fixed_string_t keyword;
 	cmdline_fixed_string_t name;
@@ -1121,6 +1121,8 @@ static void cmd_operate_port_parsed(void *parsed_result,
 		close_port(RTE_PORT_ALL);
 	else if (!strcmp(res->name, "reset"))
 		reset_port(RTE_PORT_ALL);
+	else if (!strcmp(res->name, "reinit"))
+		reinit_port(RTE_PORT_ALL);
 	else
 		fprintf(stderr, "Unknown parameter\n");
 }
@@ -1130,14 +1132,14 @@ static cmdline_parse_token_string_t cmd_operate_port_all_cmd =
 								"port");
 static cmdline_parse_token_string_t cmd_operate_port_all_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_operate_port_result, name,
-						"start#stop#close#reset");
+						"start#stop#close#reset#reinit");
 static cmdline_parse_token_string_t cmd_operate_port_all_all =
 	TOKEN_STRING_INITIALIZER(struct cmd_operate_port_result, value, "all");
 
 static cmdline_parse_inst_t cmd_operate_port = {
 	.f = cmd_operate_port_parsed,
 	.data = NULL,
-	.help_str = "port start|stop|close|reset all: Start/Stop/Close/Reset all ports",
+	.help_str = "port start|stop|close|reset|reinit all: Start/Stop/Close/Reset/Reinit all ports",
 	.tokens = {
 		(void *)&cmd_operate_port_all_cmd,
 		(void *)&cmd_operate_port_all_port,
@@ -1167,6 +1169,8 @@ static void cmd_operate_specific_port_parsed(void *parsed_result,
 		close_port(res->value);
 	else if (!strcmp(res->name, "reset"))
 		reset_port(res->value);
+	else if (!strcmp(res->name, "reinit"))
+		reinit_port(res->value);
 	else
 		fprintf(stderr, "Unknown parameter\n");
 }
@@ -1176,7 +1180,7 @@ static cmdline_parse_token_string_t cmd_operate_specific_port_cmd =
 							keyword, "port");
 static cmdline_parse_token_string_t cmd_operate_specific_port_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_operate_specific_port_result,
-						name, "start#stop#close#reset");
+						name, "start#stop#close#reset#reinit");
 static cmdline_parse_token_num_t cmd_operate_specific_port_id =
 	TOKEN_NUM_INITIALIZER(struct cmd_operate_specific_port_result,
 							value, RTE_UINT8);
@@ -1184,7 +1188,8 @@ static cmdline_parse_token_num_t cmd_operate_specific_port_id =
 static cmdline_parse_inst_t cmd_operate_specific_port = {
 	.f = cmd_operate_specific_port_parsed,
 	.data = NULL,
-	.help_str = "port start|stop|close|reset <port_id>: Start/Stop/Close/Reset port_id",
+	.help_str = "port start|stop|close|reset|reinit <port_id>: "
+			"Start/Stop/Close/Reset/Reinit port_id",
 	.tokens = {
 		(void *)&cmd_operate_specific_port_cmd,
 		(void *)&cmd_operate_specific_port_port,
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1a48b00e93..e1635a3035 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3412,6 +3412,32 @@ reset_port(portid_t pid)
 	printf("Done\n");
 }
 
+void
+reinit_port(portid_t pid)
+{
+	int diag;
+	portid_t pi;
+
+	if (port_id_is_invalid(pid, ENABLED_WARN))
+		return;
+
+	printf("Reinitializing ports...\n");
+
+	RTE_ETH_FOREACH_DEV(pi) {
+		if (pid != pi && pid != (portid_t)RTE_PORT_ALL)
+			continue;
+
+		if (is_proc_primary()) {
+			diag = rte_eth_dev_reinit(pi);
+			if (diag != 0)
+				fprintf(stderr, "Failed to reinit port %d. diag=%d\n",
+					pi, diag);
+		}
+	}
+
+	printf("Done\n");
+}
+
 static char *
 convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_size)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index fa46865c67..e47dfa3f65 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1169,6 +1169,7 @@ int start_port(portid_t pid);
 void stop_port(portid_t pid);
 void close_port(portid_t pid);
 void reset_port(portid_t pid);
+void reinit_port(portid_t pid);
 void attach_port(char *identifier);
 void detach_devargs(char *identifier);
 void detach_port_device(portid_t port_id);
-- 
2.34.1

