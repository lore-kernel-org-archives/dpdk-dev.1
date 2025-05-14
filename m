Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6FAC3ABCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 13:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D04EB402E5;
	Wed, 14 May 2025 15:02:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 61A95402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 15:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747227736; x=1778763736;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2dqMO8S1i/9GbhHCGnHCGkYZyH4slsGIpdd75HfhAKU=;
 b=B6y0iM6GY+KWscdqQb5nTs4pOSOKqIOrVIK18gyF3P4uUJ2YShrHxZgx
 b4Psagm1cFjmuelVe6AJ9ATjdZO5R0zBl9nZkSSUIEaD623dC1tpxWmK9
 OwOSZxAg3PPOEVYmDLyPrU48vynm/lM3RyziKpn97msK6G2fddSf30eUF
 BWwhUWrpS3goSIuVztgelamMM0GTerLusKSejfs3drKf559+TCdB6NCYl
 25/cdkIqoCrHyM8pTuf7vtx+fo1mZcA9UeEqPXL8ccmW9l2NgxbpRJwFD
 ZxLO8yqaX45piuX/uE23bngGW7XdLdSqftOpGIDDpTq+0+S3TRPLvOGeK g==;
X-CSE-ConnectionGUID: TQ0wOVu0Sq6G7yvHNYbCgg==
X-CSE-MsgGUID: 2B0ZXqzwQH6XV+uOd7K5Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52926906"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="52926906"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 06:02:15 -0700
X-CSE-ConnectionGUID: /YIukbM7SemHepKhJiYl4Q==
X-CSE-MsgGUID: 9SxO3la1QBOwm4iVfLs1aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="137921788"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 14 May 2025 06:02:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v1 1/2] app/testpmd: harmonize case in help strings
Date: Wed, 14 May 2025 14:02:11 +0100
Message-ID: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

Most testpmd help strings are lower case. Amend those that aren't.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline.c    |  4 ++--
 app/test-pmd/cmdline_tm.c | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d4bb3ec998..a8f1b8ad67 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -8078,7 +8078,7 @@ static cmdline_parse_token_string_t cmd_operate_set_counter_name =
 static cmdline_parse_inst_t cmd_operate_set_counter = {
 	.f = cmd_operate_set_counter_parsed,
 	.data = NULL,
-	.help_str = "port (port_id) enable|disable <counter_name>",
+	.help_str = "port <port_id> enable|disable <counter_name>",
 	.tokens = {
 		(void *)&cmd_operate_set_counter_port,
 		(void *)&cmd_operate_set_counter_port_id,
@@ -9034,7 +9034,7 @@ static cmdline_parse_token_string_t cmd_dump_dump =
 static cmdline_parse_inst_t cmd_dump = {
 	.f = cmd_dump_parsed,  /* function to call */
 	.data = NULL,      /* 2nd arg of func */
-	.help_str = "Dump status",
+	.help_str = "dump status",
 	.tokens = {        /* token list, NULL terminated */
 		(void *)&cmd_dump_dump,
 		NULL,
diff --git a/app/test-pmd/cmdline_tm.c b/app/test-pmd/cmdline_tm.c
index 7ade91549c..acf86c1ef0 100644
--- a/app/test-pmd/cmdline_tm.c
+++ b/app/test-pmd/cmdline_tm.c
@@ -327,7 +327,7 @@ static void cmd_show_port_tm_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_cap = {
 	.f = cmd_show_port_tm_cap_parsed,
 	.data = NULL,
-	.help_str = "Show Port TM Capabilities",
+	.help_str = "show port tm capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_cap_show,
 		(void *)&cmd_show_port_tm_cap_port,
@@ -475,7 +475,7 @@ static void cmd_show_port_tm_level_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_level_cap = {
 	.f = cmd_show_port_tm_level_cap_parsed,
 	.data = NULL,
-	.help_str = "Show port TM hierarchical level capabilities",
+	.help_str = "show port tm hierarchical level capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_level_cap_show,
 		(void *)&cmd_show_port_tm_level_cap_port,
@@ -598,7 +598,7 @@ static void cmd_show_port_tm_node_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_cap = {
 	.f = cmd_show_port_tm_node_cap_parsed,
 	.data = NULL,
-	.help_str = "Show Port TM Hierarchy node capabilities",
+	.help_str = "show port tm Hierarchy node capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_cap_show,
 		(void *)&cmd_show_port_tm_node_cap_port,
@@ -716,7 +716,7 @@ static void cmd_show_port_tm_node_stats_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_stats = {
 	.f = cmd_show_port_tm_node_stats_parsed,
 	.data = NULL,
-	.help_str = "Show port tm node stats",
+	.help_str = "show port tm node stats",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_stats_show,
 		(void *)&cmd_show_port_tm_node_stats_port,
@@ -795,7 +795,7 @@ static void cmd_show_port_tm_node_type_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_type = {
 	.f = cmd_show_port_tm_node_type_parsed,
 	.data = NULL,
-	.help_str = "Show port tm node type",
+	.help_str = "show port tm node type",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_type_show,
 		(void *)&cmd_show_port_tm_node_type_port,
@@ -942,7 +942,7 @@ static void cmd_add_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_node_shaper_profile = {
 	.f = cmd_add_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Add port tm node private shaper profile",
+	.help_str = "add port tm node private shaper profile",
 	.tokens = {
 		(void *)&cmd_add_port_tm_node_shaper_profile_add,
 		(void *)&cmd_add_port_tm_node_shaper_profile_port,
@@ -1029,7 +1029,7 @@ static void cmd_del_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node_shaper_profile = {
 	.f = cmd_del_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node private shaper profile",
+	.help_str = "delete port tm node private shaper profile",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_shaper_profile_del,
 		(void *)&cmd_del_port_tm_node_shaper_profile_port,
@@ -1390,7 +1390,7 @@ static void cmd_add_port_tm_node_wred_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_node_wred_profile = {
 	.f = cmd_add_port_tm_node_wred_profile_parsed,
 	.data = NULL,
-	.help_str = "Add port tm node wred profile",
+	.help_str = "add port tm node wred profile",
 	.tokens = {
 		(void *)&cmd_add_port_tm_node_wred_profile_add,
 		(void *)&cmd_add_port_tm_node_wred_profile_port,
@@ -1483,7 +1483,7 @@ static void cmd_del_port_tm_node_wred_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node_wred_profile = {
 	.f = cmd_del_port_tm_node_wred_profile_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node wred profile",
+	.help_str = "delete port tm node wred profile",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_wred_profile_del,
 		(void *)&cmd_del_port_tm_node_wred_profile_port,
@@ -1577,7 +1577,7 @@ static void cmd_set_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_set_port_tm_node_shaper_profile = {
 	.f = cmd_set_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Set port tm node shaper profile",
+	.help_str = "set port tm node shaper profile",
 	.tokens = {
 		(void *)&cmd_set_port_tm_node_shaper_profile_set,
 		(void *)&cmd_set_port_tm_node_shaper_profile_port,
@@ -1744,7 +1744,7 @@ static void cmd_add_port_tm_nonleaf_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_nonleaf_node = {
 	.f = cmd_add_port_tm_nonleaf_node_parsed,
 	.data = NULL,
-	.help_str = "Add port tm nonleaf node",
+	.help_str = "add port tm nonleaf node",
 	.tokens = {
 		(void *)&cmd_add_port_tm_nonleaf_node_add,
 		(void *)&cmd_add_port_tm_nonleaf_node_port,
@@ -1911,7 +1911,7 @@ static void cmd_add_port_tm_nonleaf_node_pmode_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_nonleaf_node_pmode = {
 	.f = cmd_add_port_tm_nonleaf_node_pmode_parsed,
 	.data = NULL,
-	.help_str = "Add port tm nonleaf node pktmode",
+	.help_str = "add port tm nonleaf node pktmode",
 	.tokens = {
 		(void *)&cmd_add_port_tm_nonleaf_node_pmode_add,
 		(void *)&cmd_add_port_tm_nonleaf_node_pmode_port,
@@ -2089,7 +2089,7 @@ static void cmd_add_port_tm_leaf_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_leaf_node = {
 	.f = cmd_add_port_tm_leaf_node_parsed,
 	.data = NULL,
-	.help_str = "Add port tm leaf node",
+	.help_str = "add port tm leaf node",
 	.tokens = {
 		(void *)&cmd_add_port_tm_leaf_node_add,
 		(void *)&cmd_add_port_tm_leaf_node_port,
@@ -2301,7 +2301,7 @@ static void cmd_del_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node = {
 	.f = cmd_del_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node",
+	.help_str = "delete port tm node",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_del,
 		(void *)&cmd_del_port_tm_node_port,
@@ -2394,7 +2394,7 @@ static void cmd_set_port_tm_node_parent_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_set_port_tm_node_parent = {
 	.f = cmd_set_port_tm_node_parent_parsed,
 	.data = NULL,
-	.help_str = "Set port tm node parent",
+	.help_str = "set port tm node parent",
 	.tokens = {
 		(void *)&cmd_set_port_tm_node_parent_set,
 		(void *)&cmd_set_port_tm_node_parent_port,
@@ -2465,7 +2465,7 @@ static void cmd_suspend_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_suspend_port_tm_node = {
 	.f = cmd_suspend_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Suspend port tm node",
+	.help_str = "suspend port tm node",
 	.tokens = {
 		(void *)&cmd_suspend_port_tm_node_suspend,
 		(void *)&cmd_suspend_port_tm_node_port,
@@ -2530,7 +2530,7 @@ static void cmd_resume_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_resume_port_tm_node = {
 	.f = cmd_resume_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Resume port tm node",
+	.help_str = "resume port tm node",
 	.tokens = {
 		(void *)&cmd_resume_port_tm_node_resume,
 		(void *)&cmd_resume_port_tm_node_port,
@@ -2602,7 +2602,7 @@ static void cmd_port_tm_hierarchy_commit_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_port_tm_hierarchy_commit = {
 	.f = cmd_port_tm_hierarchy_commit_parsed,
 	.data = NULL,
-	.help_str = "Commit port tm hierarchy",
+	.help_str = "commit port tm hierarchy",
 	.tokens = {
 		(void *)&cmd_port_tm_hierarchy_commit_port,
 		(void *)&cmd_port_tm_hierarchy_commit_tm,
-- 
2.47.1

