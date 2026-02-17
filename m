Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C80E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5244F40BA0;
	Tue, 17 Feb 2026 13:15:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A233D406BC
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330500; x=1802866500;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iLqch4QoI1UefhB5R3FFySLh7zvnvi2P/NZH8mqF/ls=;
 b=VIIyeRCCd+EZxwpft1hc3tJ8tG/0eV/uf0BixukBiUosKhMBtVC7DPzi
 cPn5+LlqrBb3Fl0XY+qrhbOAIBwQI72WtCuwTkNGN0CpnNJSZ5gq/NNgD
 VEuUbYvmT/a5027KhpmJkcELvTw91AJy9OdBV9HoBXaloLBBDenFq5Y7H
 OoXWHhxz3SAvt1DEbFfqM8QAhWta036E6dT/AQ1plZwqZ7wKncXOsEY2d
 2EcCQtLyovFCyUQaWTOyttdEyZYFIIPHYY37Et2FxhVkmEM2iIGkDAbV4
 GIQiyrvbyem+qY27w745Sa8+Hl+WVmlS2d/o4C7TvDMWmCr6pxbOnkziz Q==;
X-CSE-ConnectionGUID: M0Jn1AuMQg2AVQ3/GJk92w==
X-CSE-MsgGUID: XLZ3lsM9Sl6/KTi8YurinQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996045"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996045"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:59 -0800
X-CSE-ConnectionGUID: z487IlHBRLeRmWobv4AfSA==
X-CSE-MsgGUID: MS2IZqYQR+279kzKxYkX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396825"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 18/27] net/iavf: decouple hash uninit from parser uninit
Date: Tue, 17 Feb 2026 12:14:07 +0000
Message-ID: <fe4f79aa942cf12f25d0231e26449064e5b69c49.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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

