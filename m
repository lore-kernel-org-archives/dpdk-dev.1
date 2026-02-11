Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627AE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BBF40E09;
	Wed, 11 Feb 2026 14:53:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4D50840B9E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818034; x=1802354034;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iLqch4QoI1UefhB5R3FFySLh7zvnvi2P/NZH8mqF/ls=;
 b=O97UXq/5K0cr8i4ihJexs/heP3AJN+bSNCJKQ76Sc0Xir5N5cHTUGQKf
 RFNzTgBN1YYBc0LN5EenZ+J0CHIDP6l7zF+LpgMwuBWRWtiu9c9+dPIn1
 3FO/aNTZUzNP+oULQeZ4i+yOvFl+Sln30kmgvQs4KS72PZx2bJAfZr/fU
 7/3RFGGiAYKs0yD9MKI3CCIsXTpSCRAynVeCV2qsQuJnO3KEJGIyHyxCw
 qwsVRWxnMBs4Pyiq42jhnonM9KI4QzHmRWutDH/n+b6tSRyrbFwiS4Oxt
 tnVvdVB1NOB3uhcIHz5mHvjudTa0LkbVBha2Y15ZipolLzdQQBLSjrsVx g==;
X-CSE-ConnectionGUID: la3iQve1QQaECfB5Y8DYzQ==
X-CSE-MsgGUID: DrXnU9TQROuJe3Q4rVs7Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808267"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808267"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:54 -0800
X-CSE-ConnectionGUID: 08lVkZ0tS7yIapDbeVWA+g==
X-CSE-MsgGUID: ONvKcrb2R4CXk0+6S2mHFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359643"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 18/27] net/iavf: decouple hash uninit from parser uninit
Date: Wed, 11 Feb 2026 13:53:00 +0000
Message-ID: <23bf81f0886841dfef6357cd8ab9b539e1c21138.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

Currently, parser deinitialization will trigger removal of current RSS
configuration. This should not be done as part of parser deinitialization,
but should rather be a separate step in dev close flow.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c |  4 ++++
 drivers/net/intel/iavf/iavf_hash.c   | 13 +++++++++----
 drivers/net/intel/iavf/iavf_hash.h   | 13 +++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/intel/iavf/iavf_hash.h

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 802e095174..70eb7e7ec5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -35,6 +35,7 @@
 #include "iavf_generic_flow.h"
 #include "rte_pmd_iavf.h"
 #include "iavf_ipsec_crypto.h"
+#include "iavf_hash.h"
 
 /* devargs */
 #define IAVF_PROTO_XTR_ARG         "proto_xtr"
@@ -2972,6 +2973,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* free iAVF security device context all related resources */
 	iavf_security_ctx_destroy(adapter);
 
+	/* remove RSS configuration */
+	iavf_hash_uninit(adapter);
+
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index a40fed7542..d864998402 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -22,6 +22,7 @@
 #include "iavf_log.h"
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include "iavf_hash.h"
 
 #define IAVF_PHINT_NONE				0
 #define IAVF_PHINT_GTPU				BIT_ULL(0)
@@ -77,7 +78,7 @@ static int
 iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		  struct rte_flow_error *error);
 static void
-iavf_hash_uninit(struct iavf_adapter *ad);
+iavf_hash_uninit_parser(struct iavf_adapter *ad);
 static void
 iavf_hash_free(struct rte_flow *flow);
 static int
@@ -680,7 +681,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.init = iavf_hash_init,
 	.create = iavf_hash_create,
 	.destroy = iavf_hash_destroy,
-	.uninit = iavf_hash_uninit,
+	.uninit = iavf_hash_uninit_parser,
 	.free = iavf_hash_free,
 	.type = IAVF_FLOW_ENGINE_HASH,
 };
@@ -1641,6 +1642,12 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
 }
 
 static void
+iavf_hash_uninit_parser(struct iavf_adapter *ad)
+{
+	iavf_unregister_parser(&iavf_hash_parser, ad);
+}
+
+void
 iavf_hash_uninit(struct iavf_adapter *ad)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
@@ -1658,8 +1665,6 @@ iavf_hash_uninit(struct iavf_adapter *ad)
 	rss_conf = &ad->dev_data->dev_conf.rx_adv_conf.rss_conf;
 	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
 		PMD_DRV_LOG(ERR, "fail to delete default RSS");
-
-	iavf_unregister_parser(&iavf_hash_parser, ad);
 }
 
 static void
diff --git a/drivers/net/intel/iavf/iavf_hash.h b/drivers/net/intel/iavf/iavf_hash.h
new file mode 100644
index 0000000000..2348f32673
--- /dev/null
+++ b/drivers/net/intel/iavf/iavf_hash.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _IAVF_HASH_H_
+#define _IAVF_HASH_H_
+
+#include "iavf.h"
+
+void
+iavf_hash_uninit(struct iavf_adapter *ad);
+
+#endif /* _IAVF_HASH_H_ */
-- 
2.47.3

