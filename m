Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D673C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:16:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 459BA40BA6;
	Fri, 20 Feb 2026 11:15:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0664140659
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582510; x=1803118510;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0OO31yC4fqlcAQG1cyKjirBRloYtBW0KDdyF7NC9Kt8=;
 b=BZ5bLODBS3sAnrXAUkXJCfU4CC1AOsSUJwNbWRN7NJWjDoQYKO5rHatW
 XzUljTh3sXj/QJcJ5vFXG6aA4fVRMYXPu1ejR1+1yKMs0J1IdaXDxxAb8
 1qlYBn/cTiZAwNfAgKT0hcmOsvM27SDxuBlcJn9LPe1aEu/SngGIr/cZv
 NkmJF6/0Irs6TpaREfkSumsJ9olF9rqCWz7CjXXkZPZe8irOx/09jwlsI
 6Llr8vFrYSvZpH2Oh3lw/iqfeJ9ZmuaxoocD4vaQUauMJ5E7hJXl56z4h
 /hXY/vNkLDMP40CU1k5qdHVCGOYOQOMrU0mNfNhgbFfiqL77DIENYeOcl Q==;
X-CSE-ConnectionGUID: f/RIZbSGSfaRm3SQJptSFg==
X-CSE-MsgGUID: Tb9l55OISIi9Nqv2J05wDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283364"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283364"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:10 -0800
X-CSE-ConnectionGUID: uvaXUaEKSPK9kQ2uVB/Sxw==
X-CSE-MsgGUID: p+x4zuuaTOylrXratlJ7jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038537"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 17/27] net/iavf: decouple hash uninit from parser uninit
Date: Fri, 20 Feb 2026 10:14:24 +0000
Message-ID: <ca4d0b950b377fdb7ca5f6df25343dd9edc03a7c.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c |  3 +++
 drivers/net/intel/iavf/iavf_hash.c   | 12 ++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 39949acc11..6054321771 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -566,4 +566,5 @@ void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
 void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
+void iavf_hash_uninit(struct iavf_adapter *ad);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 954bce723d..b45da4d8b1 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2977,6 +2977,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* free iAVF security device context all related resources */
 	iavf_security_ctx_destroy(adapter);
 
+	/* remove RSS configuration */
+	iavf_hash_uninit(adapter);
+
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index a40fed7542..cb10eeab78 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -77,7 +77,7 @@ static int
 iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		  struct rte_flow_error *error);
 static void
-iavf_hash_uninit(struct iavf_adapter *ad);
+iavf_hash_uninit_parser(struct iavf_adapter *ad);
 static void
 iavf_hash_free(struct rte_flow *flow);
 static int
@@ -680,7 +680,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.init = iavf_hash_init,
 	.create = iavf_hash_create,
 	.destroy = iavf_hash_destroy,
-	.uninit = iavf_hash_uninit,
+	.uninit = iavf_hash_uninit_parser,
 	.free = iavf_hash_free,
 	.type = IAVF_FLOW_ENGINE_HASH,
 };
@@ -1641,6 +1641,12 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
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
@@ -1658,8 +1664,6 @@ iavf_hash_uninit(struct iavf_adapter *ad)
 	rss_conf = &ad->dev_data->dev_conf.rx_adv_conf.rss_conf;
 	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
 		PMD_DRV_LOG(ERR, "fail to delete default RSS");
-
-	iavf_unregister_parser(&iavf_hash_parser, ad);
 }
 
 static void
-- 
2.47.3

