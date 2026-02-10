Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DEEA813E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 776E340E4C;
	Tue, 10 Feb 2026 17:14:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id DB00C40E4B
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740076; x=1802276076;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S2DwF2UEtpRAeoxf+hu6icOBotmi/T9xb0bSi1hpwrE=;
 b=Sck7C4dQ++ZX5jFZrKVFuPFXl11EaQ/Dw89K/S44Jq70w3l3YCMqHQE5
 K3BN2XsjCHEUwv1mM7NNQ13NCJ2XBWuqZKh7P62/gS5N+RlH5YrkcDsfO
 NLNlTJFHu/2xecfYicHoL+htC7hryeF7dp2idhoDS3eHDvpSJNXGDFq7Y
 M8WpO5mNJJTO4xGseD4RWEqV03wOei3gthJurX8AQjanpvpZKs8KMBEch
 KUWhMOmC/auagxyNPvYUJZSwpah2B97toNJDd1xUe2B/tnMklpiKDAMaj
 Vsck1MRBeO15MJYwe0iH4NP6KwnbRsY2u7QkvEi7Dqr4C+uu9e6AjO52J A==;
X-CSE-ConnectionGUID: FwKnA0QIS5CQnDXSmruX1w==
X-CSE-MsgGUID: w3a+m8nYRwGrw4VHonemhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286298"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286298"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:35 -0800
X-CSE-ConnectionGUID: ZDZgyvelQfmm4zMsF0K/PA==
X-CSE-MsgGUID: eHWSBuacQ9yAtdS8yCv1zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127840"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 23/26] net/iavf: avoid rte malloc in irq map config
Date: Tue, 10 Feb 2026 16:13:52 +0000
Message-ID: <3fd89e09ad7fb7afe1906a6b02050c04bb31b24d.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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

Currently, when configuring IRQ maps, we are using rte_zmalloc followed
by an immediate rte_free. This is not needed as this memory is not being
stored anywhere, so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index af1f5fbfc0..d0cc8673e1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1295,7 +1295,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	len = sizeof(struct virtchnl_irq_map_info) +
 	      sizeof(struct virtchnl_vector_map) * vf->nb_msix;
 
-	map_info = rte_zmalloc("map_info", len, 0);
+	map_info = calloc(1, len);
 	if (!map_info)
 		return -ENOMEM;
 
@@ -1319,7 +1319,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
 
-	rte_free(map_info);
+	free(map_info);
 	return err;
 }
 
@@ -1337,7 +1337,7 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
 	len = sizeof(struct virtchnl_queue_vector_maps) +
 	      sizeof(struct virtchnl_queue_vector) * (num - 1);
 
-	map_info = rte_zmalloc("map_info", len, 0);
+	map_info = calloc(1, len);
 	if (!map_info)
 		return -ENOMEM;
 
@@ -1360,7 +1360,7 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_MAP_QUEUE_VECTOR");
 
-	rte_free(map_info);
+	free(map_info);
 	return err;
 }
 
-- 
2.47.3

