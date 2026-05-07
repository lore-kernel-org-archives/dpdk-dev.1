Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10DCCD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF381406B6;
	Thu,  7 May 2026 17:00:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1D1134066F
 for <dev@dpdk.org>; Thu,  7 May 2026 17:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778166002; x=1809702002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KRzdjJB2D9XCa9CrQV9BNarKpvJOuGNiidP2Z2YuQQ8=;
 b=W8PxkhnlPJDdIjbUnucipVes1AueAVHIm0YncVP9Ac6hsKR1qENIkO1b
 NJT9NfwYShnA6dlTxLytxvUfGFE8Vb0iSyxliq59Umcal+L2q+mFlsyFa
 JtJy2vFnLQal4fHbdmnRBwD3tXljMjDaac8CFqfEUGcHfBkrlR3iqdQAe
 sPdOt1EoNHprPQ11576rO7yYzxYIZC/n9M5RkordhaseygMnx2HKuQZg9
 nAx9jURwtiDWz9KcSlUaBk0wBLsoeiH7NcC/kjVo9AL7ixGtKDZH+a6Pg
 H/i4knke4QnQAwcea+8ydj5adedO2lAqqlHxmQxm9lhZ1kslC7IlQvLE4 A==;
X-CSE-ConnectionGUID: BCnaXSZnQ+mam53ZtNDmxA==
X-CSE-MsgGUID: TqrD/nW6SlqWOGGZTT14DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738163"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738163"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 08:00:01 -0700
X-CSE-ConnectionGUID: ck+uCfwYTF+jC/ryqMl6MQ==
X-CSE-MsgGUID: 2WeBdtMXREuOw1iIGLH7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818201"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 08:00:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 4/6] cmdline: add explicit help function for bool type
Date: Thu,  7 May 2026 15:59:47 +0100
Message-ID: <20260507145950.197753-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507145950.197753-1-bruce.richardson@intel.com>
References: <20260507145950.197753-1-bruce.richardson@intel.com>
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

Rather than using the string help output, have a specific boolean help
output that prints out on|off as the options.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/cmdline/cmdline_parse_bool.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
index a3f7adab58..d5d5499531 100644
--- a/lib/cmdline/cmdline_parse_bool.c
+++ b/lib/cmdline/cmdline_parse_bool.c
@@ -13,13 +13,17 @@
 #include "cmdline_parse.h"
 #include "cmdline_parse_bool.h"
 
+static int
+cmdline_get_help_bool(cmdline_parse_token_hdr_t *tk, char *dstbuf,
+		unsigned int size);
+
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03)
 struct cmdline_token_ops cmdline_token_bool_ops = {
 	.parse = cmdline_parse_bool,
 	.complete_get_nb = NULL,
 	.complete_get_elt = NULL,
-	.get_help = cmdline_get_help_string,
+	.get_help = cmdline_get_help_bool,
 };
 
 static cmdline_parse_token_string_t cmd_parse_token_bool = {
@@ -32,6 +36,18 @@ static cmdline_parse_token_string_t cmd_parse_token_bool = {
 	}
 };
 
+/* get help for bool token */
+static int
+cmdline_get_help_bool(__rte_unused cmdline_parse_token_hdr_t *tk,
+		char *dstbuf, unsigned int size)
+{
+	if (dstbuf == NULL || size == 0)
+		return -1;
+
+	strlcpy(dstbuf, "on|off", size);
+	return 0;
+}
+
 /* parse string to bool */
 int
 cmdline_parse_bool(__rte_unused cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
-- 
2.51.0

