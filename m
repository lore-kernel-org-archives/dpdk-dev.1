Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627ECC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 422F9406B6;
	Thu,  6 Aug 2026 07:10:21 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id D5D1D40431
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:19 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso428939a12.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993019;
 x=1786597819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kBFDEU4eOYsdNGleAmGOPWSE9H3nqT4h3xfbWmBZVMM=;
 b=eNBlJq+8/MHe/xrpyTXIaICPT/XlNgNWCoE8Q3xIhKNOf/tcgRYGP3lORK633rliz/
 dP5auA53Cn6fbGAXkzW7gmMR1lpYM//Ne/AndtTtrm42kbYzExV7LjN4MN8OD/cW5Pq0
 2FYuziEJAx8OTi62G+EO5c0EIjQGpY07QgihvQQCQ+DgLDRYLdC6wmAqTglttTadQGi0
 MLGL/xSN0a3p5QeS3aZhc6nnBflQyM8gFDS8hV9ll4ItuMflA3/ddXe6SQuttRjS0mbb
 4dQBAFNzfL5xGiKDhkXq6OWCokRsp4ZBN6oejaXEE+ZegWi6eYoP0LlzYrlbMVk8S0Yg
 CyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993019; x=1786597819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kBFDEU4eOYsdNGleAmGOPWSE9H3nqT4h3xfbWmBZVMM=;
 b=GdV3ygXqzHrv7qkuIBVgv4Odj4/Tmp9Qv03YHnVyyRqbwvXaR0fsmTpcu/Z5qEiHQy
 eTXDvb2rrleuBxNp1UA77JMieJbZaoTakGlWG/g7wipl8gdx/JIqqmopsr+OjrcgQi+E
 x3+osjZSrbRV/kBnlp86Ho3aXIQvkwjwJgBGcHyKukSSYkOiPkLnjMQ5CX/jwZNlQiVG
 f55tim4o9bz1GZzBA7/IDHJNzvfhrCFhqhqNZLEFQQ7J1R9vRZ0bvTjDQNHtQ206NKoo
 nZZ2/OXlcy3XV99wyyA9E40MgRM0F+uqsriroBMhQL5TdT5xecTB4NekGQInLTnyxOVm
 4irw==
X-Gm-Message-State: AOJu0Yykxpdg78hu2tIljJYo4XFAb2LDE5WkOb9OetlFeEkHw7tpBGcB
 CwdsEkytkr+5cMShjwaHFBDSKHr8ZlvlpLsUvPa8YetXz1oFH77pBnjXDUsB6YaCjiDcfvNTwW2
 ozQE0Ufs=
X-Gm-Gg: AR+sD12U60DX5N9VRF/6k5Gm8TKL8Hmk1/fKFR0ycjOuH40LZwmzN7s0E17sJdpXcI8
 h3RyIKGvMntUUo3geGbDHm6EflVB3jNAVhBkCDzxQaMJqeVZkM8ws3jl4IQHFYxKVF9ABA7ma8A
 dU95cBjbwrOUCzVM0ZwMPOEK8LZXJGMblJXfP4j9ff+JeuoZM6FCrEEqxe+EvVyins+1oCcw6/S
 sSBhlMFuqM4ZOkBF/35DD2vtlgVH7Yq+93HkMDUc4vCCzfb2TiZOrrPEnZ4zpL16VRCQ1w2d7Tg
 XfJDNnlqE+uM9yzTHmgHj2wOu4GPSO+xWXrG3EqU9aVjsVH7Ctd8c5fPExPwiLmkdwVy+lKLSXZ
 dXvK7j6AebUj7loOogmHL60jy+rkCsy1dqEBUf1Q3uvqMPb11L442d2RLvorDD6JqPKQ6XaYqCu
 DUbgdShIOp1+zF9CvA2LpWx0YM13K54ztRz+Xrf0hEm9Sf/MIm7/OQ6Bffz+Fw5V7nz6vzcH9J0
 JUOVgQpXpD6EjZjo+n4XCIeifhG9DHzZqq9Ag==
X-Received: by 2002:a05:6a21:a97:b0:3c4:3750:2c03 with SMTP id
 adf61e73a8af0-3cb9c1a2a27mr5343402637.9.1785993018864; 
 Wed, 05 Aug 2026 22:10:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 05/23] app/testpmd: remove support for flow director
Date: Wed,  5 Aug 2026 22:08:59 -0700
Message-ID: <20260806051004.166778-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

The legacy flow director API is deprecated and being removed.
Drop it from testpmd; the testpmd CLI is not a stable API.

Removed commands:
  show port fdir (port_id|all)
  clear port fdir (port_id|all)

Also, update documentation of testpmd to not refer to Flow Director.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c                      |  21 +--
 app/test-pmd/config.c                       | 163 --------------------
 app/test-pmd/testpmd.h                      |   3 -
 doc/guides/testpmd_app_ug/intro.rst         |   4 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  56 ++-----
 5 files changed, 17 insertions(+), 230 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..c142a8ec50 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -163,7 +163,7 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"Display:\n"
 			"--------\n\n"
 
-			"show port (info|stats|summary|xstats|fdir|dcb_tc) (port_id|all)\n"
+			"show port (info|stats|summary|xstats|dcb_tc) (port_id|all)\n"
 			"    Display information for port_id, or all.\n\n"
 
 			"show port info (port_id) representor\n"
@@ -189,7 +189,7 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show port (port_id) rss-hash [key | algorithm]\n"
 			"    Display the RSS hash functions, RSS hash key and RSS hash algorithms of port\n\n"
 
-			"clear port (info|stats|xstats|fdir) (port_id|all)\n"
+			"clear port (info|stats|xstats) (port_id|all)\n"
 			"    Clear information for port_id, or all.\n\n"
 
 			"show (rxq|txq) info (port_id) (queue_id)\n"
@@ -7514,11 +7514,6 @@ static void cmd_showportall_parsed(void *parsed_result,
 	else if (!strcmp(res->what, "xstats"))
 		RTE_ETH_FOREACH_DEV(i)
 			nic_xstats_display(i);
-#if defined(RTE_NET_I40E) || defined(RTE_NET_IXGBE)
-	else if (!strcmp(res->what, "fdir"))
-		RTE_ETH_FOREACH_DEV(i)
-			fdir_get_infos(i);
-#endif
 	else if (!strcmp(res->what, "dcb_tc"))
 		RTE_ETH_FOREACH_DEV(i)
 			port_dcb_info_display(i);
@@ -7531,14 +7526,14 @@ static cmdline_parse_token_string_t cmd_showportall_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_showportall_result, port, "port");
 static cmdline_parse_token_string_t cmd_showportall_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_showportall_result, what,
-				 "info#summary#stats#xstats#fdir#dcb_tc");
+				 "info#summary#stats#xstats#dcb_tc");
 static cmdline_parse_token_string_t cmd_showportall_all =
 	TOKEN_STRING_INITIALIZER(struct cmd_showportall_result, all, "all");
 static cmdline_parse_inst_t cmd_showportall = {
 	.f = cmd_showportall_parsed,
 	.data = NULL,
 	.help_str = "show|clear port "
-		"info|summary|stats|xstats|fdir|dcb_tc all",
+		"info|summary|stats|xstats|dcb_tc all",
 	.tokens = {
 		(void *)&cmd_showportall_show,
 		(void *)&cmd_showportall_port,
@@ -7576,10 +7571,6 @@ static void cmd_showport_parsed(void *parsed_result,
 		nic_stats_display(res->portnum);
 	else if (!strcmp(res->what, "xstats"))
 		nic_xstats_display(res->portnum);
-#if defined(RTE_NET_I40E) || defined(RTE_NET_IXGBE)
-	else if (!strcmp(res->what, "fdir"))
-		 fdir_get_infos(res->portnum);
-#endif
 	else if (!strcmp(res->what, "dcb_tc"))
 		port_dcb_info_display(res->portnum);
 }
@@ -7591,7 +7582,7 @@ static cmdline_parse_token_string_t cmd_showport_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_showport_result, port, "port");
 static cmdline_parse_token_string_t cmd_showport_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_showport_result, what,
-				 "info#summary#stats#xstats#fdir#dcb_tc");
+				 "info#summary#stats#xstats#dcb_tc");
 static cmdline_parse_token_num_t cmd_showport_portnum =
 	TOKEN_NUM_INITIALIZER(struct cmd_showport_result, portnum, RTE_UINT16);
 
@@ -7599,7 +7590,7 @@ static cmdline_parse_inst_t cmd_showport = {
 	.f = cmd_showport_parsed,
 	.data = NULL,
 	.help_str = "show|clear port "
-		"info|summary|stats|xstats|fdir|dcb_tc "
+		"info|summary|stats|xstats|dcb_tc "
 		"<port_id>",
 	.tokens = {
 		(void *)&cmd_showport_show,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index aa03eb99cc..582e7287be 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -7056,169 +7056,6 @@ flowtype_to_str(uint16_t flow_type)
 	return NULL;
 }
 
-#if defined(RTE_NET_I40E) || defined(RTE_NET_IXGBE)
-
-static inline void
-print_fdir_flex_payload(struct rte_eth_fdir_flex_conf *flex_conf, uint32_t num)
-{
-	struct rte_eth_flex_payload_cfg *cfg;
-	uint32_t i, j;
-
-	for (i = 0; i < flex_conf->nb_payloads; i++) {
-		cfg = &flex_conf->flex_set[i];
-		if (cfg->type == RTE_ETH_RAW_PAYLOAD)
-			printf("\n    RAW:  ");
-		else if (cfg->type == RTE_ETH_L2_PAYLOAD)
-			printf("\n    L2_PAYLOAD:  ");
-		else if (cfg->type == RTE_ETH_L3_PAYLOAD)
-			printf("\n    L3_PAYLOAD:  ");
-		else if (cfg->type == RTE_ETH_L4_PAYLOAD)
-			printf("\n    L4_PAYLOAD:  ");
-		else
-			printf("\n    UNKNOWN PAYLOAD(%u):  ", cfg->type);
-		for (j = 0; j < num; j++)
-			printf("  %-5u", cfg->src_offset[j]);
-	}
-	printf("\n");
-}
-
-static inline void
-print_fdir_flex_mask(struct rte_eth_fdir_flex_conf *flex_conf, uint32_t num)
-{
-	struct rte_eth_fdir_flex_mask *mask;
-	uint32_t i, j;
-	const char *p;
-
-	for (i = 0; i < flex_conf->nb_flexmasks; i++) {
-		mask = &flex_conf->flex_mask[i];
-		p = flowtype_to_str(mask->flow_type);
-		printf("\n    %s:\t", p ? p : "unknown");
-		for (j = 0; j < num; j++)
-			printf(" %02x", mask->mask[j]);
-	}
-	printf("\n");
-}
-
-static inline void
-print_fdir_flow_type(uint32_t flow_types_mask)
-{
-	int i;
-	const char *p;
-
-	for (i = RTE_ETH_FLOW_UNKNOWN; i < RTE_ETH_FLOW_MAX; i++) {
-		if (!(flow_types_mask & (1 << i)))
-			continue;
-		p = flowtype_to_str(i);
-		if (p)
-			printf(" %s", p);
-		else
-			printf(" unknown");
-	}
-	printf("\n");
-}
-
-static int
-get_fdir_info(portid_t port_id, struct rte_eth_fdir_info *fdir_info,
-		    struct rte_eth_fdir_stats *fdir_stat)
-{
-	int ret = -ENOTSUP;
-
-#ifdef RTE_NET_I40E
-	if (ret == -ENOTSUP) {
-		ret = rte_pmd_i40e_get_fdir_info(port_id, fdir_info);
-		if (!ret)
-			ret = rte_pmd_i40e_get_fdir_stats(port_id, fdir_stat);
-	}
-#endif
-#ifdef RTE_NET_IXGBE
-	if (ret == -ENOTSUP) {
-		ret = rte_pmd_ixgbe_get_fdir_info(port_id, fdir_info);
-		if (!ret)
-			ret = rte_pmd_ixgbe_get_fdir_stats(port_id, fdir_stat);
-	}
-#endif
-	switch (ret) {
-	case 0:
-		break;
-	case -ENOTSUP:
-		fprintf(stderr, "\n FDIR is not supported on port %-2d\n",
-			port_id);
-		break;
-	default:
-		fprintf(stderr, "programming error: (%s)\n", strerror(-ret));
-		break;
-	}
-	return ret;
-}
-
-void
-fdir_get_infos(portid_t port_id)
-{
-	struct rte_eth_fdir_stats fdir_stat;
-	struct rte_eth_fdir_info fdir_info;
-
-	static const char *fdir_stats_border = "########################";
-
-	if (port_id_is_invalid(port_id, ENABLED_WARN))
-		return;
-
-	memset(&fdir_info, 0, sizeof(fdir_info));
-	memset(&fdir_stat, 0, sizeof(fdir_stat));
-	if (get_fdir_info(port_id, &fdir_info, &fdir_stat))
-		return;
-
-	printf("\n  %s FDIR infos for port %-2d     %s\n",
-	       fdir_stats_border, port_id, fdir_stats_border);
-	printf("  MODE: ");
-	if (fdir_info.mode == RTE_FDIR_MODE_PERFECT)
-		printf("  PERFECT\n");
-	else if (fdir_info.mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN)
-		printf("  PERFECT-MAC-VLAN\n");
-	else if (fdir_info.mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
-		printf("  PERFECT-TUNNEL\n");
-	else if (fdir_info.mode == RTE_FDIR_MODE_SIGNATURE)
-		printf("  SIGNATURE\n");
-	else
-		printf("  DISABLE\n");
-	if (fdir_info.mode != RTE_FDIR_MODE_PERFECT_MAC_VLAN
-		&& fdir_info.mode != RTE_FDIR_MODE_PERFECT_TUNNEL) {
-		printf("  SUPPORTED FLOW TYPE: ");
-		print_fdir_flow_type(fdir_info.flow_types_mask[0]);
-	}
-	printf("  FLEX PAYLOAD INFO:\n");
-	printf("  max_len:       %-10"PRIu32"  payload_limit: %-10"PRIu32"\n"
-	       "  payload_unit:  %-10"PRIu32"  payload_seg:   %-10"PRIu32"\n"
-	       "  bitmask_unit:  %-10"PRIu32"  bitmask_num:   %-10"PRIu32"\n",
-		fdir_info.max_flexpayload, fdir_info.flex_payload_limit,
-		fdir_info.flex_payload_unit,
-		fdir_info.max_flex_payload_segment_num,
-		fdir_info.flex_bitmask_unit, fdir_info.max_flex_bitmask_num);
-	if (fdir_info.flex_conf.nb_payloads > 0) {
-		printf("  FLEX PAYLOAD SRC OFFSET:");
-		print_fdir_flex_payload(&fdir_info.flex_conf, fdir_info.max_flexpayload);
-	}
-	if (fdir_info.flex_conf.nb_flexmasks > 0) {
-		printf("  FLEX MASK CFG:");
-		print_fdir_flex_mask(&fdir_info.flex_conf, fdir_info.max_flexpayload);
-	}
-	printf("  guarant_count: %-10"PRIu32"  best_count:    %"PRIu32"\n",
-	       fdir_stat.guarant_cnt, fdir_stat.best_cnt);
-	printf("  guarant_space: %-10"PRIu32"  best_space:    %"PRIu32"\n",
-	       fdir_info.guarant_spc, fdir_info.best_spc);
-	printf("  collision:     %-10"PRIu32"  free:          %"PRIu32"\n"
-	       "  maxhash:       %-10"PRIu32"  maxlen:        %"PRIu32"\n"
-	       "  add:	         %-10"PRIu64"  remove:        %"PRIu64"\n"
-	       "  f_add:         %-10"PRIu64"  f_remove:      %"PRIu64"\n",
-	       fdir_stat.collision, fdir_stat.free,
-	       fdir_stat.maxhash, fdir_stat.maxlen,
-	       fdir_stat.add, fdir_stat.remove,
-	       fdir_stat.f_add, fdir_stat.f_remove);
-	printf("  %s############################%s\n",
-	       fdir_stats_border, fdir_stats_border);
-}
-
-#endif /* RTE_NET_I40E || RTE_NET_IXGBE */
-
 void
 set_vf_traffic(portid_t port_id, uint8_t is_rx, uint16_t vf, uint8_t on)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 083171853c..f7c10ab6b8 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1212,9 +1212,6 @@ int all_ports_stopped(void);
 int port_is_stopped(portid_t port_id);
 int port_is_started(portid_t port_id);
 void pmd_test_exit(void);
-#if defined(RTE_NET_I40E) || defined(RTE_NET_IXGBE)
-void fdir_get_infos(portid_t port_id);
-#endif
 void port_rss_reta_info(portid_t port_id,
 			struct rte_eth_rss_reta_entry64 *reta_conf,
 			uint16_t nb_entries);
diff --git a/doc/guides/testpmd_app_ug/intro.rst b/doc/guides/testpmd_app_ug/intro.rst
index 5d8d8cf4eb..35321b084a 100644
--- a/doc/guides/testpmd_app_ug/intro.rst
+++ b/doc/guides/testpmd_app_ug/intro.rst
@@ -7,8 +7,8 @@ Introduction
 This document is a user guide for the ``testpmd`` example application that is shipped as part of the Data Plane Development Kit.
 
 The ``testpmd`` application can be used to test the DPDK in a packet forwarding mode
-and also to access NIC hardware features such as Flow Director.
-It also serves as a example of how to build a more fully-featured application using the DPDK SDK.
+and also to access NIC hardware offload and flow features.
+It also serves as an example of how to build a more fully-featured application using the DPDK SDK.
 
 The guide shows how to build and run the testpmd application and
 how to configure the application from the command line and the run-time environment.
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e65376df54..09783bead1 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -7,7 +7,7 @@ Testpmd Runtime Functions
 Where the testpmd application is started in interactive mode, (``-i|--interactive``),
 it displays a prompt that can be used to start and stop forwarding,
 configure the application, display statistics (including the extended NIC
-statistics aka xstats) , set the Flow Director and other tasks::
+statistics aka xstats), set offload parameters and other tasks::
 
    testpmd>
 
@@ -22,10 +22,10 @@ If you type a partial command and hit ``<TAB>`` you get a list of the available
 
    testpmd> show port <TAB>
 
-       info [Mul-choice STRING]: show|clear port info|stats|xstats|fdir|dcb_tc|cap X
-       info [Mul-choice STRING]: show|clear port info|stats|xstats|fdir|dcb_tc|cap all
-       stats [Mul-choice STRING]: show|clear port info|stats|xstats|fdir|dcb_tc|cap X
-       stats [Mul-choice STRING]: show|clear port info|stats|xstats|fdir|dcb_tc|cap all
+       info [Mul-choice STRING]: show|clear port info|stats|xstats|dcb_tc|cap X
+       info [Mul-choice STRING]: show|clear port info|stats|xstats|dcb_tc|cap all
+       stats [Mul-choice STRING]: show|clear port info|stats|xstats|dcb_tc|cap X
+       stats [Mul-choice STRING]: show|clear port info|stats|xstats|dcb_tc|cap all
        ...
 
 
@@ -160,7 +160,7 @@ show port
 
 Display information for a given port or all ports::
 
-   testpmd> show port (info|summary|stats|xstats|fdir|dcb_tc|cap) (port_id|all)
+   testpmd> show port (info|summary|stats|xstats|dcb_tc|cap) (port_id|all)
 
 The available information categories are:
 
@@ -172,8 +172,6 @@ The available information categories are:
 
 * ``xstats``: RX/TX extended NIC statistics.
 
-* ``fdir``: Flow Director information and statistics.
-
 * ``dcb_tc``: DCB information such as TC mapping.
 
 For example:
@@ -262,7 +260,7 @@ clear port
 
 Clear the port statistics and forward engine statistics for a given port or for all ports::
 
-   testpmd> clear port (info|stats|xstats|fdir) (port_id|all)
+   testpmd> clear port (info|stats|xstats) (port_id|all)
 
 For example::
 
@@ -2288,42 +2286,6 @@ Where the threshold type can be:
 
 These threshold options are also available from the command-line.
 
-port config pctype mapping
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Reset pctype mapping table::
-
-   testpmd> port config (port_id) pctype mapping reset
-
-Update hardware defined pctype to software defined flow type mapping table::
-
-   testpmd> port config (port_id) pctype mapping update (pctype_id_0[,pctype_id_1]*) (flow_type_id)
-
-where:
-
-* ``pctype_id_x``: hardware pctype id as index of bit in bitmask value of the pctype mapping table.
-
-* ``flow_type_id``: software flow type id as the index of the pctype mapping table.
-
-port config input set
-~~~~~~~~~~~~~~~~~~~~~
-
-Config RSS/FDIR/FDIR flexible payload input set for some pctype::
-
-   testpmd> port config (port_id) pctype (pctype_id) \
-            (hash_inset|fdir_inset|fdir_flx_inset) \
-	    (get|set|clear) field (field_idx)
-
-Clear RSS/FDIR/FDIR flexible payload input set for some pctype::
-
-   testpmd> port config (port_id) pctype (pctype_id) \
-            (hash_inset|fdir_inset|fdir_flx_inset) clear all
-
-where:
-
-* ``pctype_id``: hardware packet classification types.
-* ``field_idx``: hardware field index.
-
 port config udp_tunnel_port
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -5519,10 +5481,10 @@ L2TPv2 RSS rules can be created by the following commands::
    testpmd> flow create 0 ingress pattern eth / ipv6 / udp / l2tpv2 / ppp / ipv6
             / end actions rss types ipv6 end queues end / end
 
-Sample L2TPv2 FDIR rules
+Sample L2TPv2 flow rules
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-L2TPv2 FDIR rules can be created by the following commands::
+L2TPv2 flow rules can be created by the following commands::
 
    testpmd> flow create 0 ingress pattern eth / ipv4 / udp / l2tpv2 type control
             session_id is 0x1111 / end actions queue index 3 / end
-- 
2.53.0

