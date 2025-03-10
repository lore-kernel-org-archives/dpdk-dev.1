Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717CDC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 17:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9592440268;
	Mon, 10 Mar 2025 18:40:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 15D07400D7;
 Mon, 10 Mar 2025 18:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741628441; x=1773164441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D8Ik3i891uMH3/9IAH+0W14junplMbJX866zRA/idBM=;
 b=Qr1HqFDejesE6EA/xBAHY5LTamOq3F1iZiKLzhxWY6YckhNHPEzrynfe
 +VdtxZhI5wSsalwoODj5G8c/Mcx/o5vAQQKxOvzkW6dCXS3YOxRHmIBKq
 Epf4RgEr4OWfQTcAmpBXBIXK0s4M5UMrsx1oF1xKFgldzxeuaQOw5Pe9S
 FUscwdkYfd1+UEtrpJYUIpn9yR4tKd2g6LJst72ViCFoHlHR5xipea8L6
 1CdyfxYb3q8Mn8X9bP9LdY+Dv9LfdvwymWCXuVorH8179Z5usFY2g3f6F
 7wC43egRoUb33GWR2cEF6uNQA9yivaHhORXADtZB7+B60Z04lraiJP2V9 A==;
X-CSE-ConnectionGUID: 3EtzPRNWTwOdH99HSnkvNA==
X-CSE-MsgGUID: p4FI3nDeSnafKLZLNGeKGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="67995017"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="67995017"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 10:40:39 -0700
X-CSE-ConnectionGUID: BEswRQ2JRIOTuFBCHGVUYA==
X-CSE-MsgGUID: 9XV8qm//S+yDJRIiUy8C3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="120075167"
Received: from unknown (HELO silpixa00401176.ir.intel.com) ([10.243.23.51])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 10:40:38 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com,
	stable@dpdk.org
Subject: [PATCH v2] net/ice: fix flow engines order
Date: Mon, 10 Mar 2025 17:40:28 +0000
Message-ID: <20250310174028.876789-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301205327.569853-1-vladimir.medvedkin@intel.com>
References: <20250301205327.569853-1-vladimir.medvedkin@intel.com>
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

Reorder flow engine evaluation for RTE flow rule installation.
Currently, the driver evaluates rules with engines in the order they are
executed in the hardware. However, in this situation, some wildcarded flows
that are also supported by the ACL engine are installed as switch engine
rules, which scales poorly with each distinct wildcard mask configuration.

Fixes: fabc9e1322e2 ("net/ice: fix flows handling")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 5c34e0385f..4049157eab 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2239,9 +2239,9 @@ static struct ice_flow_parser *get_flow_parser(uint32_t group)
 {
 	switch (group) {
 	case 0:
-		return &ice_switch_parser;
-	case 1:
 		return &ice_acl_parser;
+	case 1:
+		return &ice_switch_parser;
 	case 2:
 		return &ice_fdir_parser;
 	default:
@@ -2298,6 +2298,13 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 	}
 
 	for (int i = 0; i < ICE_FLOW_ENGINE_NB; i++) {
+		/**
+		 * Evaluate parsers in the following order:
+		 * ACL - for some subset of wildcard matching rules
+		 * Switch - This engine is placed after ACL because
+		 * it scales worse than ACL for different wildcard masks.
+		 * FDIR - for exact match rules
+		 **/
 		parser = get_flow_parser(i);
 		if (parser == NULL) {
 			rte_flow_error_set(error, EINVAL,
-- 
2.43.0

