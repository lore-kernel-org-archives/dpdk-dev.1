Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145FEDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AA8E40B9C;
	Fri, 13 Feb 2026 11:27:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 278574060A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978433; x=1802514433;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iLqch4QoI1UefhB5R3FFySLh7zvnvi2P/NZH8mqF/ls=;
 b=O8pFoBxcoLFr+rWkXB0jhpsy8mcXzR5zhPQ8YVol7tQ+TQNWsLx+hoB5
 A4jwMhSyFk36qDjBdjD0a+m9LxlZ+ZUmqEiMrspEOlb5jlKs5Zd0Gllba
 5CGjd0dqZxkkXEYZruzsfXQfmNKpNj5LOvZPPVZiFwUiZ3ixS6Jqd3v5a
 H++AhMtRFAcwhOpWEwqerpLA/BpYFITo79H6zYCdyd597CYMVkEjmbD5c
 ziSyrf8IfOSAkul8LdiUabSo/PfG+VujA9yxfwZqIi/mqHg+9c9sxrgPd
 ES/PC4oeQh300Ggn9bjUlYoMEgvk8JDX0DRO27pJiY6NX4sl7YCFcIGmL w==;
X-CSE-ConnectionGUID: 2Qfxz64qSc+sZDUMuQpFWQ==
X-CSE-MsgGUID: OS5TB207QaasX8ax/Madzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603108"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603108"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:13 -0800
X-CSE-ConnectionGUID: Klh3xzAjRtSQ9D15XIaxlQ==
X-CSE-MsgGUID: BdKT/ZkUThuJi+kj4ykwdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028118"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 18/27] net/iavf: decouple hash uninit from parser uninit
Date: Fri, 13 Feb 2026 10:26:29 +0000
Message-ID: <3b7b2c7a8f5e1e83650e5e64262b15273735dbf4.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

