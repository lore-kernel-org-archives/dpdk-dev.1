Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443BC021B8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 20:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1349402CA;
	Sat,  1 Mar 2025 21:53:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3928140281;
 Sat,  1 Mar 2025 21:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740862413; x=1772398413;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4L373j9hH/7kydgiAF4TxqjhoxENOqWiqbBjvRUebFM=;
 b=ZJIqJHL1ngy7tRy5nvkDwzSmHCSXSlnOeCD5qguRNwHw5Zuq3XAWyZfR
 wqDk7PmCYwlo69m7p7ZbqVefcYrflfLY5ipFagbVyk/GJKJxTi7q4kQBF
 9rq86s9W15S2IwHhFACrRCPvaHyApD2CYzeSskj0wq+d130Bif0h7/BGR
 2BcnFU+GDmp4QIVXDZ1SBzNkrl511Vf59VQNNd4rLY8c5YtJ1yhAe+J4Z
 Hlfk2gj/fqPqnLbgpxzjgbCM8vxSDDgUObSB/fWpYOLM87xceW5rZjJN0
 WkDuFq7whTqcDntV19WLeKs2Fjgrar6CyX+XObvO+DwvUsBepftrV5ofW g==;
X-CSE-ConnectionGUID: OyyvyAuNR7qH+yBO5faMRg==
X-CSE-MsgGUID: YLiwjj6vScizVsHPhJMvKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41655069"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; d="scan'208";a="41655069"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2025 12:53:31 -0800
X-CSE-ConnectionGUID: vULi91upRIWaBnqYeL7AeQ==
X-CSE-MsgGUID: 7D3L23rgR1Op6YnGCrsvgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; d="scan'208";a="148447078"
Received: from unknown (HELO silpixa00401176.ir.intel.com) ([10.243.23.51])
 by orviesa002.jf.intel.com with ESMTP; 01 Mar 2025 12:53:30 -0800
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix flow engines order
Date: Sat,  1 Mar 2025 20:53:27 +0000
Message-ID: <20250301205327.569853-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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
index 5c34e0385f..f7a44223ac 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2239,11 +2239,11 @@ static struct ice_flow_parser *get_flow_parser(uint32_t group)
 {
 	switch (group) {
 	case 0:
-		return &ice_switch_parser;
+		return &ice_fdir_parser;
 	case 1:
 		return &ice_acl_parser;
 	case 2:
-		return &ice_fdir_parser;
+		return &ice_switch_parser;
 	default:
 		return NULL;
 	}
@@ -2298,6 +2298,13 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
 	}
 
 	for (int i = 0; i < ICE_FLOW_ENGINE_NB; i++) {
+		/**
+		 * Evaluate parsers in the following order:
+		 * FDIR - for exact match rules
+		 * ACL - for some subset of wildcard matching rules
+		 * Switch - for the rest. This engine is placed after ACL
+		 * because it scales worse than ACL for different wildcard masks.
+		 **/
 		parser = get_flow_parser(i);
 		if (parser == NULL) {
 			rte_flow_error_set(error, EINVAL,
-- 
2.43.0

