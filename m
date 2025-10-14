Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16125CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67D0D40656;
	Tue, 14 Oct 2025 14:36:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B744840288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760445391; x=1791981391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LTN4Ay/bFQ9W/ishPZey+U4c6puV50H8TkfQmCpsTCQ=;
 b=FoAdx9qW/N5tEoW2UdKpAcQt9uMPgdjDcQpiC5854cWgKnsa6GyeGpt9
 p3MMUosTG8Tl2kqXyVZEE/qucVA/r/GunW1pJW4j33VjL/070uz94f58k
 0Mescj9Hfyru4XR3QV2Ykw+Ur5iL2+pK7MTpHBK/59YXrtdhC7/nyl3YU
 LsT+UrxmzdpW0Wjgc0U7G3kxKjNt6CdsUvG8jo04ZiFCI6tbw33X2CZN+
 TVIGTKXNu70u/XbzwWaDYNSQY9ge9T9m1DCtIXdzRfkZ/os0gAU/SSFNn
 nx4uPOIpGRiv5AyzqL/bLRiQPb/gMgpXKT5mg5yT+pUd7BcryRS6Fwz/C Q==;
X-CSE-ConnectionGUID: 29tE6PfXQcec752hQsGn4Q==
X-CSE-MsgGUID: hgBGp987RPW/BwPVTVR62Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62308160"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="62308160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:36:30 -0700
X-CSE-ConnectionGUID: txtkfT93QDya4DU/UEDiiQ==
X-CSE-MsgGUID: Gq/cDCIJRHGvAgw9aD48vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181093729"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 05:36:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 2/2] net/iavf: add reinit command to testpmd
Date: Tue, 14 Oct 2025 12:36:24 +0000
Message-Id: <20251014123624.1413473-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014123624.1413473-1-ciara.loftus@intel.com>
References: <20251009102835.926479-1-ciara.loftus@intel.com>
 <20251014123624.1413473-1-ciara.loftus@intel.com>
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

This patch adds an IAVF testpmd command "port reinit <port_id>" which
will send a request to the PF to reset the given VF, followed by the
VF then reinitialising and restarting itself.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v4:
* Rename restore -> reinit
---
 drivers/net/intel/iavf/iavf_testpmd.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index 775179fc01..4731d0b61b 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -69,6 +69,52 @@ static cmdline_parse_inst_t cmd_enable_tx_lldp = {
 	},
 };
 
+struct cmd_reinit_result {
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t reinit;
+	portid_t port_id;
+};
+
+static cmdline_parse_token_string_t cmd_reinit_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_reinit_result,
+		port, "port");
+static cmdline_parse_token_string_t cmd_reinit_reinit =
+	TOKEN_STRING_INITIALIZER(struct cmd_reinit_result,
+		reinit, "reinit");
+static cmdline_parse_token_num_t cmd_reinit_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_reinit_result,
+		port_id, RTE_UINT16);
+
+static void
+cmd_reinit_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_reinit_result *res = parsed_result;
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	ret = rte_pmd_iavf_reinit(res->port_id);
+	if (ret < 0)
+		fprintf(stderr, "Request to reinit VF failed for port %u: %s\n",
+			res->port_id, rte_strerror(-ret));
+	else
+		printf("VF reinit requested for port %u\n", res->port_id);
+}
+
+static cmdline_parse_inst_t cmd_reinit = {
+	.f = cmd_reinit_parsed,
+	.data = NULL,
+	.help_str = "port reinit <port_id>",
+	.tokens = {
+		(void *)&cmd_reinit_port,
+		(void *)&cmd_reinit_reinit,
+		(void *)&cmd_reinit_port_id,
+		NULL,
+	},
+};
+
 static struct testpmd_driver_commands iavf_cmds = {
 	.commands = {
 	{
@@ -76,6 +122,11 @@ static struct testpmd_driver_commands iavf_cmds = {
 		"set tx lldp (on|off)\n"
 		"    Set iavf Tx lldp packet(currently only supported on)\n\n",
 	},
+	{
+		&cmd_reinit,
+		"port reinit (port_id)\n"
+		"    Send a request to the PF to reset the VF, then restore the port\n\n",
+	},
 	{ NULL, NULL },
 	},
 };
-- 
2.34.1

