Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3660ECD6E45
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E8EE4065A;
	Thu, 28 May 2026 23:38:22 +0200 (CEST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) by mails.dpdk.org (Postfix) with ESMTP id 7996B4042F
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:21 +0200 (CEST)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-660512d80b4so34184d50.1
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004301;
 x=1780609101; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Vb8gqUSALd+M4Mq5+cyOsxKHfy6MmB8l7loJZBp6GA=;
 b=hRRCKouI8w1ZK5HVCpA8w8MB8YcK0USTCFyI4h/XPUVBG2iZTKjXEE2yHEi+EI8BpQ
 AaNqmeZ82arUbtGH2sJzZv56aDbEvmbXpMCGugN0XXz00LWkMHrbXRBGoppoSw7C57/e
 gC1AVa0WUH6erG9TxGf3ys753hlHKRQy2gzGALNbkkeVKOI31g6N4wGqfiroepzB5skO
 UsPUK6M3tOQ1zoJN9JO8MCs1nMjfPR0BTTwQKZCnjlUAEU5+HD2XJ4fjafBB6UTeaVGL
 Tu71CRxlWUFFcg3/u7lNg06NHYY1iqK1T4weCHbtXdX6pXyq5j71ZB4faJ+7YgW9YKzj
 2UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004301; x=1780609101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Vb8gqUSALd+M4Mq5+cyOsxKHfy6MmB8l7loJZBp6GA=;
 b=HAEmnFkKLUPDxQ2a68m5IUIJtU15KJ03eQ4A4d8LsxHXsRBRZaYjXibDo+K3JOxAa+
 +KRbYL/FDWcWA/xI6Y9ngbCczrzw1GRR1X1Y4/KN9EcbHpSxqLOMh0hK+Y8zT5+Hvni1
 rGNhgXfDGYlqmKnlNA02y0sTPk2SN0wSSntDu5wNXZeujAQTxggaHElm/DMNV/BGS+5g
 nnLFOB4My5KeylzQ/g+ZqFsOb38bTM6IDjFFIJpvIgJVx2ZgnH4dWwPKpa6o7G9t7vvP
 xaAbwLH3mCOBeVOsAKgOXUwWOssge6ua1OafCFhg87W+PPhJQtPaOgUfLNuuAyqVELgc
 k2Aw==
X-Gm-Message-State: AOJu0YxTbS0GfQ6Zf3x0NrcYFtIxdYwUhrU9PWmrP5Cx3M09jju+T6D7
 gc9XQOK3o69S/vM58q+XLGsX7KXoto2JCCFPIa7CWX3JulUZnVfCz3Vt4JFVCaD6064SBbcrgh+
 irBUJ
X-Gm-Gg: Acq92OFkauXvLRmoPcLZU4KPmj4UGy9RKt5lMwIwWwOKyHqtp2toaPojQR8CA8ux7OA
 +Xm4/6OeGOVSXSlhL3ZkgkO+XDEdcqRqYT/ahpcfz1gwa8Fd4b6rDp7h1O8hEMtXDvTi4upZjUd
 kPHxvxErZ6JwoPfIhjvAFRq/HCyHlVgLKbXOFB8DNiEzPpkLfGDH8rr4rcCGw02XLrOt30E5GqP
 fQeVD/RqfIEeYb9bKWV+uCpoKIvePCK8JFtLWUgW+DRBwDxKCmMYo67McnV1dvf72iSZnVU+RR2
 1pq/BZkmHYepJM6D7kfD7elQi0TYr9aiu9ce9xOTj3jCE0t2GLtu6MGiTNAL4vraGtTQpt2xfS8
 nsrUsEJvKWpPZy6DtOD+IdahVR/wfWGYbfO01Or4YDW4w+4OO9TezejXc9XnmuYkUJTXMBCJWj7
 fmBTGwnj/m6VWprkLWylcp3mLcDZNnRqUz/9QamTr7SwDmnJHs1rOOhnBTUR7a8KyVvYIKYtkCw
 L0RsrkiJmU=
X-Received: by 2002:a05:690e:1559:20b0:65e:15fb:2413 with SMTP id
 956f58d0204a3-66050fdee07mr110289d50.48.1780004300635; 
 Thu, 28 May 2026 14:38:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 1/8] app/testpmd: remove support for flow director
Date: Thu, 28 May 2026 14:37:13 -0700
Message-ID: <20260528213816.562910-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
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

The flow director API is deprecated and will be removed in 26.11.
Remove it from testpmd now since testpmd CLI is not a stable API.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c                      |  21 +--
 app/test-pmd/config.c                       | 163 --------------------
 app/test-pmd/testpmd.h                      |   3 -
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  36 -----
 4 files changed, 6 insertions(+), 217 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index cc9c462498..a5022bde04 100644
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
@@ -7510,11 +7510,6 @@ static void cmd_showportall_parsed(void *parsed_result,
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
@@ -7527,14 +7522,14 @@ static cmdline_parse_token_string_t cmd_showportall_port =
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
@@ -7572,10 +7567,6 @@ static void cmd_showport_parsed(void *parsed_result,
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
@@ -7587,7 +7578,7 @@ static cmdline_parse_token_string_t cmd_showport_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_showport_result, port, "port");
 static cmdline_parse_token_string_t cmd_showport_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_showport_result, what,
-				 "info#summary#stats#xstats#fdir#dcb_tc");
+				 "info#summary#stats#xstats#dcb_tc");
 static cmdline_parse_token_num_t cmd_showport_portnum =
 	TOKEN_NUM_INITIALIZER(struct cmd_showport_result, portnum, RTE_UINT16);
 
@@ -7595,7 +7586,7 @@ static cmdline_parse_inst_t cmd_showport = {
 	.f = cmd_showport_parsed,
 	.data = NULL,
 	.help_str = "show|clear port "
-		"info|summary|stats|xstats|fdir|dcb_tc "
+		"info|summary|stats|xstats|dcb_tc "
 		"<port_id>",
 	.tokens = {
 		(void *)&cmd_showport_show,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c950793aaf..12fc679250 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -7041,169 +7041,6 @@ flowtype_to_str(uint16_t flow_type)
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
index 1a54535470..0a4ab188bb 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1185,9 +1185,6 @@ int all_ports_stopped(void);
 int port_is_stopped(portid_t port_id);
 int port_is_started(portid_t port_id);
 void pmd_test_exit(void);
-#if defined(RTE_NET_I40E) || defined(RTE_NET_IXGBE)
-void fdir_get_infos(portid_t port_id);
-#endif
 void port_rss_reta_info(portid_t port_id,
 			struct rte_eth_rss_reta_entry64 *reta_conf,
 			uint16_t nb_entries);
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index f99b29b423..1d079f521a 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2266,42 +2266,6 @@ Where the threshold type can be:
 
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
 
-- 
2.53.0

