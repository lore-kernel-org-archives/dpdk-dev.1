Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B3CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 14:31:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15C3240669;
	Mon, 29 Sep 2025 16:31:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D3A2940668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759156278; x=1790692278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6EurHzA9zFEceclTT66UNsZg4vvXfBt/mCg209slkww=;
 b=hcuZGkIq9KXCEcz6Gd+2C5HAblYh72gSFP3FrMByJx1+cy3C8fiYDlQ3
 e8D8kzLYTimAuhic5IfGMpyNot9FucQ8FJaVJKAj/rS70iaWRK2d9sR4e
 8UK+zGvdFwSOzXc5A4xmag19ckORMg4Z1kW0/VnuSYLor5EQ12S9+jSnY
 HBGHym5nDlapvNsGdQxZmOJZB7hLTipAAptANxBtjWULxTP0imAK6BX/6
 u1vZTboGtSdppV5gz7+c9VtgqTg9dex8Dv2KhMvFAPHHr6znukPNMNXGv
 0VhS0AzF+OY96x9YCmt7+hWvmbF6YkutFBL+XsBl+oQLaX0hnEb9MXn8z g==;
X-CSE-ConnectionGUID: /qSGXUTXRYuxdcwXdMsogw==
X-CSE-MsgGUID: 0cNGBedRQV2Fv8VTml4PMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72076968"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="72076968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 07:31:15 -0700
X-CSE-ConnectionGUID: PwnpJSxYSx2gKLyiUCU26w==
X-CSE-MsgGUID: 5MJLWLjdRNGvkrlskJ/3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="183440205"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 29 Sep 2025 07:31:14 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/2] net/iavf: add reset VF command to testpmd
Date: Mon, 29 Sep 2025 14:30:39 +0000
Message-Id: <20250929143039.547207-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929143039.547207-1-ciara.loftus@intel.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
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

This patch adds an IAVF testpmd command "port reset_vf <port_id>" which
will send a request to the PF to reset the given VF.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_testpmd.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index 775179fc01..588f9bbeb3 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -69,6 +69,52 @@ static cmdline_parse_inst_t cmd_enable_tx_lldp = {
 	},
 };
 
+struct cmd_reset_vf_result {
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t reset_vf;
+	portid_t port_id;
+};
+
+static cmdline_parse_token_string_t cmd_reset_vf_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_reset_vf_result,
+		port, "port");
+static cmdline_parse_token_string_t cmd_reset_vf_reset_vf =
+	TOKEN_STRING_INITIALIZER(struct cmd_reset_vf_result,
+		reset_vf, "reset_vf");
+static cmdline_parse_token_num_t cmd_reset_vf_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_reset_vf_result,
+		port_id, RTE_UINT16);
+
+static void
+cmd_reset_vf_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_reset_vf_result *res = parsed_result;
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	ret = rte_pmd_iavf_reset(res->port_id);
+	if (ret < 0)
+		fprintf(stderr, "Request to reset VF failed for port %u: %s\n",
+			res->port_id, rte_strerror(-ret));
+	else
+		printf("VF reset requested for port %u\n", res->port_id);
+}
+
+static cmdline_parse_inst_t cmd_reset_vf = {
+	.f = cmd_reset_vf_parsed,
+	.data = NULL,
+	.help_str = "port reset_vf <port_id>",
+	.tokens = {
+		(void *)&cmd_reset_vf_port,
+		(void *)&cmd_reset_vf_reset_vf,
+		(void *)&cmd_reset_vf_port_id,
+		NULL,
+	},
+};
+
 static struct testpmd_driver_commands iavf_cmds = {
 	.commands = {
 	{
@@ -76,7 +122,13 @@ static struct testpmd_driver_commands iavf_cmds = {
 		"set tx lldp (on|off)\n"
 		"    Set iavf Tx lldp packet(currently only supported on)\n\n",
 	},
+	{
+		&cmd_reset_vf,
+		"port reset_vf (port_id)\n"
+		"    Send a request to the PF to reset the VF\n\n",
+	},
 	{ NULL, NULL },
 	},
 };
+
 TESTPMD_ADD_DRIVER_COMMANDS(iavf_cmds)
-- 
2.34.1

