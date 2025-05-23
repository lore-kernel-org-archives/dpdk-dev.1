Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C01C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 10:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 219C240685;
	Fri, 23 May 2025 12:09:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D19B540658
 for <dev@dpdk.org>; Fri, 23 May 2025 12:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747994974; x=1779530974;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OZUOKfzNNMhmktkdGB0q4vjm5JDgbVNrgJxYySHYaQU=;
 b=Fj4vEs6MqIeWDlWIYU47t4aGW6JXqF7ticJDXgAszKda0FLYSyXqFLwT
 QkfnCuVY35jr1FWHy95re2z6iUQ2QXXNZYr/rI7uqrTFajqL2sPVP+pDg
 3ViWVRY8+PtCn9DAmIabuDlztr9bRU0jXhLXVknUNPtB042WrZktyeAM+
 Ly24/bS8hD036bSDNeDE7FXyQBDCXHQRMLANryJMvY/sEmUVLFhanY9Oj
 /vPc/YgZz8WLIg7Iz3VppOZwX7fLmnG5zCohg5hxIHcGjEog9o/w/YpCK
 bQTPrps4GcVauKWXWLkNunR9mRAMTXpBGYJMuDUG/T+bzUHOlIIKeu2dz Q==;
X-CSE-ConnectionGUID: cP+wiVX2S36ucg9VucrqNA==
X-CSE-MsgGUID: JmVZi3bCTcG2vBKsvnKXKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50194165"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="50194165"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:09:33 -0700
X-CSE-ConnectionGUID: kJe/lN4LRYim1Ra3OR40Ug==
X-CSE-MsgGUID: lDfmnGSxShOoRlU5f2e/FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="141143253"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 23 May 2025 03:09:32 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v1 2/2] app/testpmd: sort commands by help string
Date: Fri, 23 May 2025 11:09:28 +0100
Message-ID: <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
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
Message-ID: <20250523100928.ZqaTOPX0bSJDR0X6OufevY5laIoMgD8nxS4zeuL-_xc@z>

When using '?' to find commands, it occasionally is difficult to find the
needed commands because all commands are not in alphabetical order, but
rather can be ordered rather arbitrarily.

To address this, use help string to order commands. This sacrifices some
amount of grouping (i.e. when tm commands go one after another), but may
improve discoverability (and most similar commands tend to have similar
help strings and will be located closer together anyway).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index a8f1b8ad67..c91fe732b6 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13951,6 +13951,78 @@ testpmd_add_driver_commands(struct testpmd_driver_commands *c)
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
+		&cmd_load_from_file,
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
+	/* we need case-insensitive compare */
+	ret = strcmp(l_helpstr, r_helpstr);
+	if (ret == 0)
+		return 0;
+	return ret < 0 ? -1 : 1;
+}
+
 int
 init_cmdline(void)
 {
@@ -13962,6 +14034,10 @@ init_cmdline(void)
 	cmd_set_fwd_mode_init();
 	cmd_set_fwd_retry_mode_init();
 
+	/* sort built-in command array */
+	qsort(builtin_ctx, RTE_DIM(builtin_ctx) - 1, sizeof(builtin_ctx[0]), cmd_cmp);
+
+	/* count total number of commands */
 	count = 0;
 	for (i = 0; builtin_ctx[i] != NULL; i++)
 		count++;
@@ -13975,12 +14051,18 @@ init_cmdline(void)
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

