Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36FCCA470
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 10:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA9F940297;
	Thu,  9 Oct 2025 12:29:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2CEE540277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 12:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760005770; x=1791541770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DlvzJEss6D7SMtZVR5Ps6C0aqpMz09ZUizdbMIhbD2k=;
 b=P83M3n82tNeQSe080NaTknYI6uXRNp5myZ5WHHaxcwT7YeTCK7TxlYYn
 8FFdVH6ywn6tR33/qNsXdGgHm3r9mB7qMOh8HGybj5dtLWyaYIFQ16h0u
 HK+V9WU7tq9y6HVpegY/RQOjUQUkt9PDEF5uLgV57jzSPXsyE+6CHHWZr
 waZ0Lnk7h+ejtfqyZcMQk3RwoNMymLugyhDxzKhvfbLyk3JmgEzDorefe
 KA/okJvm2Ygx0RYxhnvgiKOPHwAzXl6EM+RQ3SEPZS4SkXpSUMiAXq+4g
 7kZgTmAOyR8YIKbNT7Y3sZvhyNassgDIJ+v6rPjlO1et8ERKtXS0VKEBM A==;
X-CSE-ConnectionGUID: fBtH/tj7QCGV6hi2QgWzmQ==
X-CSE-MsgGUID: iG3nUQ0LQkyC+NxLMEhCVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79855988"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79855988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:29:10 -0700
X-CSE-ConnectionGUID: xOD5DilWQ9mJSHynknnaUw==
X-CSE-MsgGUID: 12nEXM3gQOKscmxDHvlzPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="181107747"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa009.fm.intel.com with ESMTP; 09 Oct 2025 03:29:07 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 2/2] net/iavf: add restore command to testpmd
Date: Thu,  9 Oct 2025 10:28:35 +0000
Message-Id: <20251009102835.926479-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009102835.926479-1-ciara.loftus@intel.com>
References: <20251003102359.823028-1-ciara.loftus@intel.com>
 <20251009102835.926479-1-ciara.loftus@intel.com>
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

This patch adds an IAVF testpmd command "port restore <port_id>" which
will send a request to the PF to reset the given VF, followed by the
VF then reinitialising and restarting itself.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_testpmd.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index 775179fc01..2432e015b3 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -69,6 +69,52 @@ static cmdline_parse_inst_t cmd_enable_tx_lldp = {
 	},
 };
 
+struct cmd_restore_result {
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t restore;
+	portid_t port_id;
+};
+
+static cmdline_parse_token_string_t cmd_restore_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_restore_result,
+		port, "port");
+static cmdline_parse_token_string_t cmd_restore_restore =
+	TOKEN_STRING_INITIALIZER(struct cmd_restore_result,
+		restore, "restore");
+static cmdline_parse_token_num_t cmd_restore_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_restore_result,
+		port_id, RTE_UINT16);
+
+static void
+cmd_restore_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl, __rte_unused void *data)
+{
+	struct cmd_restore_result *res = parsed_result;
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	ret = rte_pmd_iavf_restore(res->port_id);
+	if (ret < 0)
+		fprintf(stderr, "Request to restore VF failed for port %u: %s\n",
+			res->port_id, rte_strerror(-ret));
+	else
+		printf("VF restore requested for port %u\n", res->port_id);
+}
+
+static cmdline_parse_inst_t cmd_restore = {
+	.f = cmd_restore_parsed,
+	.data = NULL,
+	.help_str = "port restore <port_id>",
+	.tokens = {
+		(void *)&cmd_restore_port,
+		(void *)&cmd_restore_restore,
+		(void *)&cmd_restore_port_id,
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
+		&cmd_restore,
+		"port restore (port_id)\n"
+		"    Send a request to the PF to reset the VF, then restore the port\n\n",
+	},
 	{ NULL, NULL },
 	},
 };
+
 TESTPMD_ADD_DRIVER_COMMANDS(iavf_cmds)
-- 
2.34.1

