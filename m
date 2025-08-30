Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE40CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 17:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 447FB4068E;
	Sat, 30 Aug 2025 19:17:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 367D340678
 for <dev@dpdk.org>; Sat, 30 Aug 2025 19:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756574242; x=1788110242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rfDA4TuHxLtZ9bp9WILJvx6MyIGt8I45FkcSoW7Zz+c=;
 b=H780v5+sE7VpB3VxUzow1eginyrjhLjXQeCpKrcLx1d9HMzaWsrYeSbK
 tbPfr0MKr8aUJnKIefMkJ7CmPshgnmwLqrelfgleLuFZtEl6AbnjNuX/h
 Y618LTLcRlvboDhlUYJIYbdSxR8/+pv1wOJgENPJ7sBUD3lFgs+YqY37/
 KTxGj5P3ITy2YNzjhWN9jgBnit5zRbRlF7QCF+Wh3YDeUjUodfZAxogX9
 ZiWy3K0RmdCL2n2ej1KjX9QQOIlClstJLQMHkbCS1gQQLGwZ+csfmhpYz
 9ta0yJ3cdeV9zkMILm3c/qpvpYehe9DCJfC0I3B0eYPGgAOhIXYGgOKzQ g==;
X-CSE-ConnectionGUID: EAkMy9iKSMOhBTcmfEpmCg==
X-CSE-MsgGUID: 7ECiQ5R6TO28vf3390ssyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58781206"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58781206"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2025 10:17:21 -0700
X-CSE-ConnectionGUID: dL/LQA4URg63ovM33bTmoA==
X-CSE-MsgGUID: Yq6YfkWYQtCw7oLFy0aaog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="174966906"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 10:17:19 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [RFC PATCH 5/6] ethdev: remove dcb_capability_en from rte_eth_conf
Date: Sat, 30 Aug 2025 17:17:05 +0000
Message-ID: <20250830171706.428977-6-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
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

Currently there are DCB configuration capability flags that are suppose
to enable DCB Priority Groups (aka Traffic Classes), and Priority Flow
Control. The former is not used anywhere at all, while the latter us used
in some drivers, but is used to enable PFC on all existing Traffic
Classes, which feels like a questionable design choice.

It is recommended to use existing API to enable PFC on specific Traffic
Class.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-pmd/cmdline.c  | 19 +++----------------
 app/test-pmd/testpmd.c  | 12 ++----------
 app/test-pmd/testpmd.h  |  1 -
 lib/ethdev/rte_ethdev.h |  8 --------
 4 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 82322f3456..346dd7c133 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3526,7 +3526,6 @@ parse_dcb_token_find(char *split_str[], int split_num, int *param_num)
 
 static int
 parse_dcb_token_value(char *token_str,
-		      uint8_t *pfc_en,
 		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
 		      uint8_t *prio_tc_en,
 		      uint8_t *keep_qnum)
@@ -3549,17 +3548,6 @@ parse_dcb_token_value(char *token_str,
 		split_str[split_num++] = token;
 	} while (1);
 
-	/* parse fixed parameter "pfc-en" first. */
-	token = split_str[0];
-	if (strcmp(token, "on") == 0)
-		*pfc_en = 1;
-	else if (strcmp(token, "off") == 0)
-		*pfc_en = 0;
-	else {
-		fprintf(stderr, "Bad Argument: pfc-en must be on or off\n");
-		return -EINVAL;
-	}
-
 	if (split_num == 1)
 		return 0;
 
@@ -3612,7 +3600,6 @@ cmd_config_dcb_parsed(void *parsed_result,
 	uint8_t prio_tc_en = 0;
 	uint8_t keep_qnum = 0;
 	struct rte_port *port;
-	uint8_t pfc_en = 0;
 	int ret;
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN))
@@ -3644,7 +3631,7 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en, &keep_qnum);
+	ret = parse_dcb_token_value(res->token_str, prio_tc, &prio_tc_en, &keep_qnum);
 	if (ret != 0)
 		return;
 
@@ -3652,11 +3639,11 @@ cmd_config_dcb_parsed(void *parsed_result,
 	if (!strncmp(res->vt_en, "on", 2))
 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
 				(int)res->num_tcs,
-				pfc_en, prio_tc, prio_tc_en, keep_qnum);
+				prio_tc, prio_tc_en, keep_qnum);
 	else
 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
 				(int)res->num_tcs,
-				pfc_en, prio_tc, prio_tc_en, keep_qnum);
+				prio_tc, prio_tc_en, keep_qnum);
 	if (ret != 0) {
 		fprintf(stderr, "Cannot initialize network ports.\n");
 		return;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 3a55434d44..8602781aac 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4093,8 +4093,7 @@ const uint16_t vlan_tags[] = {
 
 static void
 get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
-		 int num_tcs, uint8_t pfc_en,
-		 uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
+		 int num_tcs, uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
 {
 	uint8_t dcb_tc_val, i;
 
@@ -4195,11 +4194,6 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_DCB;
 	}
 
-	if (pfc_en)
-		eth_conf->dcb_capability_en =
-				RTE_ETH_DCB_PG_SUPPORT | RTE_ETH_DCB_PFC_SUPPORT;
-	else
-		eth_conf->dcb_capability_en = RTE_ETH_DCB_PG_SUPPORT;
 }
 
 static void
@@ -4209,7 +4203,6 @@ clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
 
 	eth_conf->rxmode.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
 	eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
-	eth_conf->dcb_capability_en = 0;
 	if (dcb_config) {
 		/* Unset VLAN filter configuration if already config DCB. */
 		eth_conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
@@ -4222,7 +4215,6 @@ int
 init_port_dcb_config(portid_t pid,
 		     enum dcb_mode_enable dcb_mode,
 		     int num_tcs,
-		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
 		     uint8_t prio_tc_en,
 		     uint8_t keep_qnum)
@@ -4267,7 +4259,7 @@ init_port_dcb_config(portid_t pid,
 
 	if (num_tcs > 1) {
 		/* set configuration of DCB in vt mode and DCB in non-vt mode */
-		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
+		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, prio_tc, prio_tc_en);
 		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
 		/* remove RSS HASH offload for DCB in vt mode */
 		if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 4ff982ed3f..bb1aaec918 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1151,7 +1151,6 @@ uint8_t port_is_bonding_member(portid_t member_pid);
 
 int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
 		     int num_tcs,
-		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
 		     uint8_t prio_tc_en,
 		     uint8_t keep_qnum);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0bd86e1e7d..60532e0155 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -858,11 +858,6 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)
 #define RTE_ETH_DCB_NUM_QUEUES          128 /**< Maximum nb. of DCB queues. */
 /**@}*/
 
-/**@{@name DCB capabilities */
-#define RTE_ETH_DCB_PG_SUPPORT      RTE_BIT32(0) /**< Priority Group(ETS) support. */
-#define RTE_ETH_DCB_PFC_SUPPORT     RTE_BIT32(1) /**< Priority Flow Control support. */
-/**@}*/
-
 /**@{@name VLAN offload bits */
 #define RTE_ETH_VLAN_STRIP_OFFLOAD   0x0001 /**< VLAN Strip  On/Off */
 #define RTE_ETH_VLAN_FILTER_OFFLOAD  0x0002 /**< VLAN Filter On/Off */
@@ -1528,9 +1523,6 @@ struct rte_eth_conf {
 		struct rte_eth_vmdq_tx_conf vmdq_tx_conf;
 		/* VMDQ and DCB Tx queue mapping configuration. */
 	} tx_adv_conf; /**< Port Tx DCB configuration (union). */
-	/** Currently,Priority Flow Control(PFC) are supported,if DCB with PFC
-	    is needed,and the variable must be set RTE_ETH_DCB_PFC_SUPPORT. */
-	uint32_t dcb_capability_en;
 	struct rte_eth_intr_conf intr_conf; /**< Interrupt mode configuration. */
 };
 
-- 
2.43.0

