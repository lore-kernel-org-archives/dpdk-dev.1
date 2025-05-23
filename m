Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC36C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 10:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D225D4060F;
	Fri, 23 May 2025 12:36:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A396C400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 12:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747996569; x=1779532569;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3rvzZehCRLgkx0ZWvpkU+zNiJk+a4yhYmCWf8mPPpeE=;
 b=I7CElEF21Mmmdvm7+XtDzWYAJqWKAbiO4XUTKjt+Bq58h3UPnhIFd7jG
 aeuioJvtszLV4Avyd6HbOXgg/XrsRSfaG4KkN4KnElFXrZvg+7NiHBjRi
 ScjhduTxf+BuVqe/lnKqvjwubN/NQe/AVJ6+uoSugGczGMH5Yi5PTHtIE
 rFLjcIQdqpJhIsk2Yzh9v6yW7aaOdUQw2Fc0ZKBZ2XvV0YMsuJsN7GVoy
 FCv1dKFEFCvevgPdiHLjZEtzOvuuoqBqiITErcD7iAH2qpVS5mZMFPexW
 eYnHPhRW5JYpeh8SN1mXSP86oHGl4fkWMd6qX1mU41Yg0uuoNRvWQ4Arz Q==;
X-CSE-ConnectionGUID: i+9b0kC/RKytSS7e2csQZQ==
X-CSE-MsgGUID: kizDiM8OR/CeOgDitwbhjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="52677929"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="52677929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 03:36:08 -0700
X-CSE-ConnectionGUID: MjBJzmjkTeu2n19FqWa+Ww==
X-CSE-MsgGUID: pa0QD0MRSOisSBUS4/bO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="164332931"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa002.fm.intel.com with ESMTP; 23 May 2025 03:36:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 1/2] app/testpmd: harmonize case in help strings
Date: Fri, 23 May 2025 11:36:04 +0100
Message-ID: <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
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

Notes:
    v1 -> v2:
    - Make TM uniformly uppercase instead of lowercase

 app/test-pmd/cmdline.c    |  4 ++--
 app/test-pmd/cmdline_tm.c | 46 +++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index b6152c07e6..712d307ae0 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -8112,7 +8112,7 @@ static cmdline_parse_token_string_t cmd_operate_set_counter_name =
 static cmdline_parse_inst_t cmd_operate_set_counter = {
 	.f = cmd_operate_set_counter_parsed,
 	.data = NULL,
-	.help_str = "port (port_id) enable|disable <counter_name>",
+	.help_str = "port <port_id> enable|disable <counter_name>",
 	.tokens = {
 		(void *)&cmd_operate_set_counter_port,
 		(void *)&cmd_operate_set_counter_port_id,
@@ -9068,7 +9068,7 @@ static cmdline_parse_token_string_t cmd_dump_dump =
 static cmdline_parse_inst_t cmd_dump = {
 	.f = cmd_dump_parsed,  /* function to call */
 	.data = NULL,      /* 2nd arg of func */
-	.help_str = "Dump status",
+	.help_str = "dump status",
 	.tokens = {        /* token list, NULL terminated */
 		(void *)&cmd_dump_dump,
 		NULL,
diff --git a/app/test-pmd/cmdline_tm.c b/app/test-pmd/cmdline_tm.c
index 7ade91549c..2b165b62c6 100644
--- a/app/test-pmd/cmdline_tm.c
+++ b/app/test-pmd/cmdline_tm.c
@@ -327,7 +327,7 @@ static void cmd_show_port_tm_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_cap = {
 	.f = cmd_show_port_tm_cap_parsed,
 	.data = NULL,
-	.help_str = "Show Port TM Capabilities",
+	.help_str = "show port TM capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_cap_show,
 		(void *)&cmd_show_port_tm_cap_port,
@@ -475,7 +475,7 @@ static void cmd_show_port_tm_level_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_level_cap = {
 	.f = cmd_show_port_tm_level_cap_parsed,
 	.data = NULL,
-	.help_str = "Show port TM hierarchical level capabilities",
+	.help_str = "show port TM hierarchical level capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_level_cap_show,
 		(void *)&cmd_show_port_tm_level_cap_port,
@@ -598,7 +598,7 @@ static void cmd_show_port_tm_node_cap_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_cap = {
 	.f = cmd_show_port_tm_node_cap_parsed,
 	.data = NULL,
-	.help_str = "Show Port TM Hierarchy node capabilities",
+	.help_str = "show port TM hierarchy node capabilities",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_cap_show,
 		(void *)&cmd_show_port_tm_node_cap_port,
@@ -716,7 +716,7 @@ static void cmd_show_port_tm_node_stats_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_stats = {
 	.f = cmd_show_port_tm_node_stats_parsed,
 	.data = NULL,
-	.help_str = "Show port tm node stats",
+	.help_str = "show port TM node stats",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_stats_show,
 		(void *)&cmd_show_port_tm_node_stats_port,
@@ -795,7 +795,7 @@ static void cmd_show_port_tm_node_type_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_show_port_tm_node_type = {
 	.f = cmd_show_port_tm_node_type_parsed,
 	.data = NULL,
-	.help_str = "Show port tm node type",
+	.help_str = "show port TM node type",
 	.tokens = {
 		(void *)&cmd_show_port_tm_node_type_show,
 		(void *)&cmd_show_port_tm_node_type_port,
@@ -942,7 +942,7 @@ static void cmd_add_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_node_shaper_profile = {
 	.f = cmd_add_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Add port tm node private shaper profile",
+	.help_str = "add port TM node private shaper profile",
 	.tokens = {
 		(void *)&cmd_add_port_tm_node_shaper_profile_add,
 		(void *)&cmd_add_port_tm_node_shaper_profile_port,
@@ -1029,7 +1029,7 @@ static void cmd_del_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node_shaper_profile = {
 	.f = cmd_del_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node private shaper profile",
+	.help_str = "delete port TM node private shaper profile",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_shaper_profile_del,
 		(void *)&cmd_del_port_tm_node_shaper_profile_port,
@@ -1130,7 +1130,7 @@ static void cmd_add_port_tm_node_shared_shaper_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_node_shared_shaper = {
 	.f = cmd_add_port_tm_node_shared_shaper_parsed,
 	.data = NULL,
-	.help_str = "add/update port tm node shared shaper",
+	.help_str = "add/update port TM node shared shaper",
 	.tokens = {
 		(void *)&cmd_add_port_tm_node_shared_shaper_cmd_type,
 		(void *)&cmd_add_port_tm_node_shared_shaper_port,
@@ -1210,7 +1210,7 @@ static void cmd_del_port_tm_node_shared_shaper_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node_shared_shaper = {
 	.f = cmd_del_port_tm_node_shared_shaper_parsed,
 	.data = NULL,
-	.help_str = "delete port tm node shared shaper",
+	.help_str = "delete port TM node shared shaper",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_shared_shaper_del,
 		(void *)&cmd_del_port_tm_node_shared_shaper_port,
@@ -1390,7 +1390,7 @@ static void cmd_add_port_tm_node_wred_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_node_wred_profile = {
 	.f = cmd_add_port_tm_node_wred_profile_parsed,
 	.data = NULL,
-	.help_str = "Add port tm node wred profile",
+	.help_str = "add port TM node wred profile",
 	.tokens = {
 		(void *)&cmd_add_port_tm_node_wred_profile_add,
 		(void *)&cmd_add_port_tm_node_wred_profile_port,
@@ -1483,7 +1483,7 @@ static void cmd_del_port_tm_node_wred_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node_wred_profile = {
 	.f = cmd_del_port_tm_node_wred_profile_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node wred profile",
+	.help_str = "delete port TM node wred profile",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_wred_profile_del,
 		(void *)&cmd_del_port_tm_node_wred_profile_port,
@@ -1577,7 +1577,7 @@ static void cmd_set_port_tm_node_shaper_profile_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_set_port_tm_node_shaper_profile = {
 	.f = cmd_set_port_tm_node_shaper_profile_parsed,
 	.data = NULL,
-	.help_str = "Set port tm node shaper profile",
+	.help_str = "set port TM node shaper profile",
 	.tokens = {
 		(void *)&cmd_set_port_tm_node_shaper_profile_set,
 		(void *)&cmd_set_port_tm_node_shaper_profile_port,
@@ -1744,7 +1744,7 @@ static void cmd_add_port_tm_nonleaf_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_nonleaf_node = {
 	.f = cmd_add_port_tm_nonleaf_node_parsed,
 	.data = NULL,
-	.help_str = "Add port tm nonleaf node",
+	.help_str = "add port TM nonleaf node",
 	.tokens = {
 		(void *)&cmd_add_port_tm_nonleaf_node_add,
 		(void *)&cmd_add_port_tm_nonleaf_node_port,
@@ -1911,7 +1911,7 @@ static void cmd_add_port_tm_nonleaf_node_pmode_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_nonleaf_node_pmode = {
 	.f = cmd_add_port_tm_nonleaf_node_pmode_parsed,
 	.data = NULL,
-	.help_str = "Add port tm nonleaf node pktmode",
+	.help_str = "add port TM nonleaf node pktmode",
 	.tokens = {
 		(void *)&cmd_add_port_tm_nonleaf_node_pmode_add,
 		(void *)&cmd_add_port_tm_nonleaf_node_pmode_port,
@@ -2089,7 +2089,7 @@ static void cmd_add_port_tm_leaf_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_add_port_tm_leaf_node = {
 	.f = cmd_add_port_tm_leaf_node_parsed,
 	.data = NULL,
-	.help_str = "Add port tm leaf node",
+	.help_str = "add port TM leaf node",
 	.tokens = {
 		(void *)&cmd_add_port_tm_leaf_node_add,
 		(void *)&cmd_add_port_tm_leaf_node_port,
@@ -2301,7 +2301,7 @@ static void cmd_del_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_del_port_tm_node = {
 	.f = cmd_del_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Delete port tm node",
+	.help_str = "delete port TM node",
 	.tokens = {
 		(void *)&cmd_del_port_tm_node_del,
 		(void *)&cmd_del_port_tm_node_port,
@@ -2394,7 +2394,7 @@ static void cmd_set_port_tm_node_parent_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_set_port_tm_node_parent = {
 	.f = cmd_set_port_tm_node_parent_parsed,
 	.data = NULL,
-	.help_str = "Set port tm node parent",
+	.help_str = "set port TM node parent",
 	.tokens = {
 		(void *)&cmd_set_port_tm_node_parent_set,
 		(void *)&cmd_set_port_tm_node_parent_port,
@@ -2465,7 +2465,7 @@ static void cmd_suspend_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_suspend_port_tm_node = {
 	.f = cmd_suspend_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Suspend port tm node",
+	.help_str = "suspend port TM node",
 	.tokens = {
 		(void *)&cmd_suspend_port_tm_node_suspend,
 		(void *)&cmd_suspend_port_tm_node_port,
@@ -2530,7 +2530,7 @@ static void cmd_resume_port_tm_node_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_resume_port_tm_node = {
 	.f = cmd_resume_port_tm_node_parsed,
 	.data = NULL,
-	.help_str = "Resume port tm node",
+	.help_str = "resume port TM node",
 	.tokens = {
 		(void *)&cmd_resume_port_tm_node_resume,
 		(void *)&cmd_resume_port_tm_node_port,
@@ -2602,7 +2602,7 @@ static void cmd_port_tm_hierarchy_commit_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_port_tm_hierarchy_commit = {
 	.f = cmd_port_tm_hierarchy_commit_parsed,
 	.data = NULL,
-	.help_str = "Commit port tm hierarchy",
+	.help_str = "commit port TM hierarchy",
 	.tokens = {
 		(void *)&cmd_port_tm_hierarchy_commit_port,
 		(void *)&cmd_port_tm_hierarchy_commit_tm,
@@ -2685,7 +2685,7 @@ static void cmd_port_tm_mark_ip_ecn_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_port_tm_mark_ip_ecn = {
 	.f = cmd_port_tm_mark_ip_ecn_parsed,
 	.data = NULL,
-	.help_str = "set port tm mark ip_ecn <port> <green> <yellow> <red>",
+	.help_str = "set port TM mark ip_ecn <port> <green> <yellow> <red>",
 	.tokens = {
 		(void *)&cmd_port_tm_mark_ip_ecn_set,
 		(void *)&cmd_port_tm_mark_ip_ecn_port,
@@ -2772,7 +2772,7 @@ static void cmd_port_tm_mark_ip_dscp_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_port_tm_mark_ip_dscp = {
 	.f = cmd_port_tm_mark_ip_dscp_parsed,
 	.data = NULL,
-	.help_str = "set port tm mark ip_dscp <port> <green> <yellow> <red>",
+	.help_str = "set port TM mark ip_dscp <port> <green> <yellow> <red>",
 	.tokens = {
 		(void *)&cmd_port_tm_mark_ip_dscp_set,
 		(void *)&cmd_port_tm_mark_ip_dscp_port,
@@ -2859,7 +2859,7 @@ static void cmd_port_tm_mark_vlan_dei_parsed(void *parsed_result,
 cmdline_parse_inst_t cmd_port_tm_mark_vlan_dei = {
 	.f = cmd_port_tm_mark_vlan_dei_parsed,
 	.data = NULL,
-	.help_str = "set port tm mark vlan_dei <port> <green> <yellow> <red>",
+	.help_str = "set port TM mark vlan_dei <port> <green> <yellow> <red>",
 	.tokens = {
 		(void *)&cmd_port_tm_mark_vlan_dei_set,
 		(void *)&cmd_port_tm_mark_vlan_dei_port,
-- 
2.47.1

