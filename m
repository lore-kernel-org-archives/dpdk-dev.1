Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568AC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 10:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAEC4406B8;
	Fri, 23 May 2025 12:36:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 66425400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 12:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747996570; x=1779532570;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3CR9TlNBeeQbDem4BMfI/rlzU665bp8SFGB6hbLZkKs=;
 b=mV6CuESuIQ7Ld5niQ8wa387rVMgU6q7xOX4bmzkHJ09A9GHdyv+H8zgX
 OAbfC2zpJodbbZ31eZyZaxpBrNy+W7C/ht+r/wkN9a4Lr3Weoj1TdtTi6
 UoKWhd6MfuUV7phDkDNiaf1WmvdkyFRz9eoQyX9S0ZGuwGhTvlyXorSKI
 8hhqD9UOk1gRQduNU4VerNvpzy+QrsDm5yyCqrvhFcmjO7+cU9ou36CH7
 r5FOd3bggKk5U5BEw5kUszGK8YM2o2HMcvObUPAuYXhpmhqvPmIUQnphQ
 TP00yxdi27L3h/mt6xtrKd6p1Q9pWaAMUe2XrrI2usIcJKgQwfzbfJEbV Q==;
X-CSE-ConnectionGUID: sqJcdEzLQgmtQWPQsaBU5w==
X-CSE-MsgGUID: ZxSSmfThR0+5+5+0Z2wy1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="52677930"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="52677930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:36:10 -0700
X-CSE-ConnectionGUID: c6tDJvQWR8yjK6MABlUClA==
X-CSE-MsgGUID: JtO4W7yHQfSgQkCDxCbnCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="164332937"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa002.fm.intel.com with ESMTP; 23 May 2025 03:36:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/2] app/testpmd: sort commands by help string
Date: Fri, 23 May 2025 11:36:05 +0100
Message-ID: <3fcf495162a926f844322dcff7485eaebc23ab14.1747996555.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
References: 
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

When using '?' to find commands, it occasionally is difficult to find the
needed commands because all commands are not in alphabetical order, but
rather can be ordered rather arbitrarily.

To address this, use help string to order commands. This sacrifices some
amount of grouping (i.e. when tm commands go one after another), but may
improve discoverability (and most similar commands tend to have similar
help strings and will be located closer together anyway).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v1 -> v2:
    - Removed outdated comment

 app/test-pmd/cmdline.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 712d307ae0..3ed0e23080 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13986,6 +13986,76 @@ testpmd_add_driver_commands(struct testpmd_driver_commands *c)
 	TAILQ_INSERT_TAIL(&driver_commands_head, c, next);
 }
 
+static int
+cmd_cmp(const void *l, const void *r)
+{
+	cmdline_parse_inst_t *l_cmd = *(cmdline_parse_inst_t * const*)l;
+	cmdline_parse_inst_t *r_cmd = *(cmdline_parse_inst_t * const*)r;
+	int l_idx = -1, r_idx = -1;
+	size_t i;
+
+	/* these commands should always be at the top of the list */
+	cmdline_parse_inst_t const *top_cmds[] = {
+		&cmd_help_brief,
+		&cmd_help_long,
+		&cmd_quit,
+		&cmd_start,
+		&cmd_stop,
+	};
+
+	/* there may be NULL values - push them to the end */
+	if (l_cmd == NULL)
+		return 1;
+	if (r_cmd == NULL)
+		return -1;
+
+	/* should circuit on equality - shouldn't happen anyway */
+	if (l_cmd == r_cmd)
+		return 0;
+
+	/* try finding both commands in list header */
+	for (i = 0; i < RTE_DIM(top_cmds); i++) {
+		cmdline_parse_inst_t const *tmp = top_cmds[i];
+		if (l_idx == -1 && l_cmd == tmp)
+			l_idx = i;
+		if (r_idx == -1 && r_cmd == tmp)
+			r_idx = i;
+	}
+
+	if (l_idx >= 0 && r_idx < 0)
+		/* l in list, r not in list */
+		return -1;
+	if (l_idx < 0 && r_idx >= 0)
+		/* l not in list, r in list */
+		return 1;
+	if (l_idx >= 0 && r_idx >= 0)
+		/* both in list */
+		return l_idx < r_idx ? -1 : 1;
+
+	/*
+	 * Neither are in top list. Comparing commands is difficult because
+	 * there are multiple types of tokens, some of which are custom and
+	 * cannot be generalized. What we'll do instead is compare help strings,
+	 * because those tend to be fairly consistently specified.
+	 */
+	const char *l_helpstr = l_cmd->help_str;
+	const char *r_helpstr = r_cmd->help_str;
+	int ret;
+
+	/* some commands do not have help strings, push them to the back */
+	if (l_helpstr == NULL && r_helpstr == NULL)
+		return 0;
+	if (l_helpstr == NULL)
+		return 1;
+	if (r_helpstr == NULL)
+		return -1;
+
+	ret = strcmp(l_helpstr, r_helpstr);
+	if (ret == 0)
+		return 0;
+	return ret < 0 ? -1 : 1;
+}
+
 int
 init_cmdline(void)
 {
@@ -13997,6 +14067,10 @@ init_cmdline(void)
 	cmd_set_fwd_mode_init();
 	cmd_set_fwd_retry_mode_init();
 
+	/* sort built-in command array */
+	qsort(builtin_ctx, RTE_DIM(builtin_ctx) - 1, sizeof(builtin_ctx[0]), cmd_cmp);
+
+	/* count total number of commands */
 	count = 0;
 	for (i = 0; builtin_ctx[i] != NULL; i++)
 		count++;
@@ -14010,12 +14084,18 @@ init_cmdline(void)
 	if (main_ctx == NULL)
 		return -1;
 
+	/* copy built-in commands */
 	count = 0;
 	for (i = 0; builtin_ctx[i] != NULL; i++, count++)
 		main_ctx[count] = builtin_ctx[i];
+
+	/* copy driver-specific commands */
 	TAILQ_FOREACH(c, &driver_commands_head, next) {
+		size_t start = count;
 		for (i = 0; c->commands[i].ctx != NULL; i++, count++)
 			main_ctx[count] = c->commands[i].ctx;
+		/* sort driver-specific commands, per driver */
+		qsort(&main_ctx[start], i, sizeof(main_ctx[0]), cmd_cmp);
 	}
 
 	return 0;
-- 
2.47.1

