Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F311606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0XrBxlQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2EB94029D;
	Wed, 18 Nov 2026 14:10:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id EB5CD40298;
 Wed, 18 Nov 2026 14:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795007404; x=1826543404;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6iznM62vM0WoEJ7EdyA+0Qm7wOeInHcDIjv3W6s/xlk=;
 b=R0XrBxlQXMSzAauC8xZqRts/J6xpaAi49jJw6yhWSAoEMw8AJ0iwHC9G
 zOM1P2ieRNGRNUASItuZLkEfzEuppjx7hZ5tf3/qjvLQcvS0FRbvChN7L
 594rx6g8SyvJhZ/5Edn7qiYBciV6oFdlMaoKOZrK7ol6ACW9rWm+ktuN1
 asVyVAzEkTTncN3IK/rRAivSOfbiX94NFX1aidXyvhfVitiIyG2MqT6CR
 I82pC2AXDhPHlSc2izqHR5p9gzYax2icns5n2GrSLIs0cWhzT8x4MgsSn
 N/nrU39qLBfqKA/bPTcp1n3gST4I/xdpTZqrWMq2HyvYLe4YNIQ+rexxJ Q==;
X-CSE-ConnectionGUID: XovPJrAqRWmiPcDNQNT+8A==
X-CSE-MsgGUID: yB6fh+OfRTSbTN5EpwEcTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3704358"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3704358"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:10:02 -0800
X-CSE-ConnectionGUID: DjqAfwtwS3SvkPsRjBO1hg==
X-CSE-MsgGUID: rQsbHxSOQk20MfQmrCZ53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="11949757"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa011.fm.intel.com with ESMTP; 18 Nov 2026 05:10:00 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 stephen@networkplumber.org, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>
Subject: [PATCH] examples/ipsec-secgw: remove dead code
Date: Wed, 18 Nov 2026 13:09:51 +0000
Message-ID: <20261118130951.3254687-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

rte_panic() does not return, so the goto statements following it
in parse_cfg_file() and the error_exit cleanup block are unreachable.
Remove them.

Bugzilla ID: 2144
Fixes: 0d547ed03717 ("examples/ipsec-secgw: support configuration file")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 examples/ipsec-secgw/parser.c | 40 +++++++----------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/examples/ipsec-secgw/parser.c b/examples/ipsec-secgw/parser.c
index 29c4d3cb3d..fda6384e5a 100644
--- a/examples/ipsec-secgw/parser.c
+++ b/examples/ipsec-secgw/parser.c
@@ -434,15 +434,11 @@ parse_cfg_file(const char *cfg_filename)
 	uint32_t line_num = 0;
 	struct parse_status status = {0};
 
-	if (f == NULL) {
+	if (f == NULL)
 		rte_panic("Error: invalid file descriptor %s\n", cfg_filename);
-		goto error_exit;
-	}
 
-	if (cl == NULL) {
+	if (cl == NULL)
 		rte_panic("Error: cannot create cmdline instance\n");
-		goto error_exit;
-	}
 
 	cfg_sp_add_rule.data = &status;
 	cfg_sa_add_rule.data = &status;
@@ -460,12 +456,10 @@ parse_cfg_file(const char *cfg_filename)
 
 		line_num++;
 
-		if (strlen(oneline) > 1022) {
+		if (strlen(oneline) > 1022)
 			rte_panic("%s:%u: error: "
 				"the line contains more characters the parser can handle\n",
 				cfg_filename, line_num);
-			goto error_exit;
-		}
 
 		/* process comment char '#' */
 		if (oneline[0] == '#')
@@ -478,47 +472,37 @@ parse_cfg_file(const char *cfg_filename)
 		/* process line concatenator '\' */
 		pos = strchr(oneline, 92);
 		if (pos != NULL) {
-			if (pos != oneline+strlen(oneline) - 2) {
+			if (pos != oneline+strlen(oneline) - 2)
 				rte_panic("%s:%u: error: "
 					"no character should exist after '\\'\n",
 					cfg_filename, line_num);
-				goto error_exit;
-			}
 
 			*pos = '\0';
 
-			if (strlen(oneline) + strlen(str) > 1022) {
+			if (strlen(oneline) + strlen(str) > 1022)
 				rte_panic("%s:%u: error: "
 					"the concatenated line contains more characters the parser can handle\n",
 					cfg_filename, line_num);
-				goto error_exit;
-			}
 
 			strcpy(str + strlen(str), oneline);
 			continue;
 		}
 
 		/* copy the line to str and process */
-		if (strlen(oneline) + strlen(str) > 1022) {
+		if (strlen(oneline) + strlen(str) > 1022)
 			rte_panic("%s:%u: error: "
 				"the line contains more characters the parser can handle\n",
 				cfg_filename, line_num);
-			goto error_exit;
-		}
 		strcpy(str + strlen(str), oneline);
 
 		str[strlen(str)] = '\n';
-		if (cmdline_parse(cl, str) < 0) {
+		if (cmdline_parse(cl, str) < 0)
 			rte_panic("%s:%u: error: parsing \"%s\" failed\n",
 				cfg_filename, line_num, str);
-			goto error_exit;
-		}
 
-		if (status.status < 0) {
+		if (status.status < 0)
 			rte_panic("%s:%u: error: %s", cfg_filename,
 				line_num, status.parse_msg);
-			goto error_exit;
-		}
 
 		memset(str, 0, 1024);
 	} while (1);
@@ -531,12 +515,4 @@ parse_cfg_file(const char *cfg_filename)
 	sp6_sort_arr();
 
 	return 0;
-
-error_exit:
-	if (cl)
-		cmdline_stdin_exit(cl);
-	if (f)
-		fclose(f);
-
-	return -1;
 }
-- 
2.52.0

