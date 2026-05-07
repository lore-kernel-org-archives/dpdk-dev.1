Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7690ECD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38DCA40684;
	Thu,  7 May 2026 17:00:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 55CF34066A;
 Thu,  7 May 2026 17:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778166001; x=1809702001;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TGazXUHsAc2oyxFd6t/3l+cXVCZLWE3MyroPJM+IVRU=;
 b=NH8nzE+V+Mo6hHJSYgHURhEqpgp7GAq/YLc+ld/st77Nk/oIpYpyPH+P
 NY+yBx0u3ADIHLjQK0k0kdw6W/hk5mWsalOsPlvtBiLxVKWX7cUummr2V
 EqiBAb6sE3T7sDYd9W6V1ONGfCv/WG/BLngoz5zlp/cizV1uDq597+v+O
 Hg3+RofGvDxc9pR8flTU5Q5Daww6JjyN222DfXkTpGfoKZ3kJwwf2gUvv
 Pn5YEfS2YQVP41aScyUPKUmuY5CoCXp2e+W+r4qipsxz9scl4gslD2LK3
 v+ocLgpPSsZtsmbyLgid26zSHR05NkH9DOwXQ6mMg/IFJu5+cTDEjhuc1 A==;
X-CSE-ConnectionGUID: M+IfGS7eSyaBScWHN66Omg==
X-CSE-MsgGUID: J4flQbfuSqylrzVUQxQrhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738160"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738160"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 08:00:00 -0700
X-CSE-ConnectionGUID: SPAvvnqgRBG36Y7dCVgsDA==
X-CSE-MsgGUID: 5MFUtN01SEiYBa5wslMqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818187"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 07:59:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH 3/6] cmdline: harden parser result buffer handling
Date: Thu,  7 May 2026 15:59:46 +0100
Message-ID: <20260507145950.197753-4-bruce.richardson@intel.com>
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

The cmdline parser had a few result-buffer safety gaps.

In boolean token parsing, the parser could write through a NULL output
pointer in parse-only paths (for example completion/match checks).  Add
proper output-pointer and output-size checks before storing the parsed
value.

In instruction matching, reject token offsets that are equal to the
result buffer size, not only greater than it, so tokens are never parsed
with a zero-sized output window at the end of the buffer.

In completion formatting, handle truncated strlcpy() output before
appending help text, preventing offset/size misuse when the destination
buffer is small.

Fixes: 985465997b73 ("ethdev: add xstats API to enable/disable counter")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
Note: the first fixes line, though strange, is valid. The cmdline
library bool handling was added as part of the ethdev commit.
---
 lib/cmdline/cmdline_parse.c      |  6 ++++--
 lib/cmdline/cmdline_parse_bool.c | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/cmdline/cmdline_parse.c b/lib/cmdline/cmdline_parse.c
index 201fddb8c3..d55c8db19d 100644
--- a/lib/cmdline/cmdline_parse.c
+++ b/lib/cmdline/cmdline_parse.c
@@ -133,7 +133,7 @@ match_inst(cmdline_parse_inst_t *inst, const char *buf,
 		} else {
 			unsigned rb_sz;
 
-			if (token_hdr.offset > resbuf_size) {
+			if (token_hdr.offset >= resbuf_size) {
 				printf("Parse error(%s:%d): Token offset(%u) "
 					"exceeds maximum size(%u)\n",
 					__FILE__, __LINE__,
@@ -519,7 +519,9 @@ cmdline_complete(struct cmdline *cl, const char *buf, int *state,
 				}
 				(*state)++;
 				l=strlcpy(dst, tmpbuf, size);
-				if (l>=0 && token_hdr.ops->get_help) {
+				if ((unsigned int)l >= size)
+					return 1;
+				if (token_hdr.ops->get_help) {
 					token_hdr.ops->get_help(token_p, tmpbuf,
 								sizeof(tmpbuf));
 					help_str = inst->help_str;
diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
index e03cc3d545..a3f7adab58 100644
--- a/lib/cmdline/cmdline_parse_bool.c
+++ b/lib/cmdline/cmdline_parse_bool.c
@@ -35,17 +35,30 @@ static cmdline_parse_token_string_t cmd_parse_token_bool = {
 /* parse string to bool */
 int
 cmdline_parse_bool(__rte_unused cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
-	__rte_unused unsigned int ressize)
+	unsigned int ressize)
 {
 	cmdline_fixed_string_t on_off = {0};
+	uint8_t val;
+
+	if (!srcbuf || !*srcbuf)
+		return -1;
+
+	if (res != NULL && ressize < sizeof(uint8_t))
+		return -1;
+
 	if (cmdline_token_string_ops.parse
 			(&cmd_parse_token_bool.hdr, srcbuf, on_off, sizeof(on_off)) < 0)
 		return -1;
 
 	if (strcmp((char *)on_off, "on") == 0)
-		*(uint8_t *)res = 1;
+		val = 1;
 	else if (strcmp((char *)on_off, "off") == 0)
-		*(uint8_t *)res = 0;
+		val = 0;
+	else
+		return -1;
+
+	if (res != NULL)
+		*(uint8_t *)res = val;
 
 	return strlen(on_off);
 }
-- 
2.51.0

