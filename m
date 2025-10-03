Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C23CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 10:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D58B402C1;
	Fri,  3 Oct 2025 12:24:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 18CA640262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 12:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759487052; x=1791023052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DlvzJEss6D7SMtZVR5Ps6C0aqpMz09ZUizdbMIhbD2k=;
 b=D6EiMUSIAQ8xlre6kHXZOXyKGWCfni8zjK7vIJGXQGq0iIiCN1U3i4uL
 MvGjp4WcCqAaHYeU+CwQHC/qaArM0ioUlkVW28nuM2GCzEFTutOEgmyoA
 5reDt76gTA9fHus8VlklehM8ySTjP1awdwvNDj9R1goVs090rLQlo9nsb
 4Zb+bfRuc6tD7wHiHtm6PcB7nr75SVhOkyTuOn4472X2SsOnblOrF/4nD
 OOpwnN/mrdVVOSFSgRKOcScuk0LkncDeusC9XLEXKsaAb18uFsGgrIFSp
 eH2PqB3eEqUNDwh6TAWcbhrdM4T4+WkxZ6N6gqrrerCuPoxpeBTCBd7iQ w==;
X-CSE-ConnectionGUID: DO9HlA5uQuuYFgSI0lH83g==
X-CSE-MsgGUID: 2sxNkbyOQSGoW7HTBDBuDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61931482"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61931482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 03:24:11 -0700
X-CSE-ConnectionGUID: cF1xLViOT2q3Q8CsXuTSCA==
X-CSE-MsgGUID: u+lnJGX8Q96jkxQ+GioR4w==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 03 Oct 2025 03:24:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/2] net/iavf: add restore command to testpmd
Date: Fri,  3 Oct 2025 10:23:59 +0000
Message-Id: <20251003102359.823028-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003102359.823028-1-ciara.loftus@intel.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <20251003102359.823028-1-ciara.loftus@intel.com>
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

