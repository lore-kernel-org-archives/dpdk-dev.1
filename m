Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E22E6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641AD40616;
	Tue, 17 Feb 2026 13:15:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A2ACB40B98
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330506; x=1802866506;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VuxFB/TLN2caU0WG1JHVpRh+UkJD1SsUAPrRLg55DJA=;
 b=mYF1A9l4Y5w7jvIaZI8ul1NlxNTXuo7R0DsKD/UvyoJlsxMKrKnJ4h26
 iMbPpw+XoXhsdJquNZmEldIrJSWTf2wuBrIWs6bToqDbkM+POHR690SzI
 zW6/YiH5G3ew+n+RbHNBlSpdNipRLAkayTGPBuLiYzhyYVklAyzonOBPD
 4YbtryUCLC3XrA0Wph4+YMZFDtEGXEvLoSwfjDdyNtvkAt3r0GpiPxXPn
 vVrjU/GfB+8IxJXEv7AlkJGrABAV8B7h2E8yD7dqCs9pKLUqjMYnmpGPx
 +pyF6cyxuDMrCSC2TrkDoy6xz+kjWjPHYzCoNm6xZVlRLqGOl8h83i59e w==;
X-CSE-ConnectionGUID: iufbS4IQRtqUnqgmIk1F2Q==
X-CSE-MsgGUID: jS1XCRtoTre7ID4qS2U27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996061"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996061"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:05 -0800
X-CSE-ConnectionGUID: EkJCXBsqQDW/U8EBO7lcQw==
X-CSE-MsgGUID: V90kkJIPQZSCRA9ykc8Ngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396845"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 23/27] net/iavf: avoid rte malloc in irq map config
Date: Tue, 17 Feb 2026 12:14:12 +0000
Message-ID: <636dbce03d24903067fdb8658de89da4fb3cbd69.1771330391.git.anatoly.burakov@intel.com>
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

Currently, when configuring IRQ maps, we are using rte_zmalloc followed
by an immediate rte_free. This is not needed as this memory is not being
stored anywhere, so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index a947ff92cf..498b8816fc 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1294,7 +1294,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	len = sizeof(struct virtchnl_irq_map_info) +
 	      sizeof(struct virtchnl_vector_map) * vf->nb_msix;
 
-	map_info = rte_zmalloc("map_info", len, 0);
+	map_info = calloc(1, len);
 	if (!map_info)
 		return -ENOMEM;
 
@@ -1318,7 +1318,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
 
-	rte_free(map_info);
+	free(map_info);
 	return err;
 }
 
@@ -1336,7 +1336,7 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
 	len = sizeof(struct virtchnl_queue_vector_maps) +
 	      sizeof(struct virtchnl_queue_vector) * (num - 1);
 
-	map_info = rte_zmalloc("map_info", len, 0);
+	map_info = calloc(1, len);
 	if (!map_info)
 		return -ENOMEM;
 
@@ -1359,7 +1359,7 @@ iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_MAP_QUEUE_VECTOR");
 
-	rte_free(map_info);
+	free(map_info);
 	return err;
 }
 
-- 
2.47.3

