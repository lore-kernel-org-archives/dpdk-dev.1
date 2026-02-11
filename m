Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF237E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AD3E40E1B;
	Wed, 11 Feb 2026 14:54:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5AAEE406BB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818040; x=1802354040;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S2DwF2UEtpRAeoxf+hu6icOBotmi/T9xb0bSi1hpwrE=;
 b=e+BJTnBd5hyLDDEK0LlMy8jiNOEmelhrp8RouF3TYKABjq2LpBdkYmuh
 Q8Ni5RrOAohMqNnSjHxjJUq6gTZ0b7Vv/ZwOL2OEbo2Gd4ora/3Ok3xBt
 Nc58VTZOQ3wy+I+lujColqad3RPPszoHw1xp6yeC23KbC9MFDhTxVLhIf
 H50CqOjXUcDD4fMo+1GnQ+hI2FPC41C6B1VBQ/tRTmp+r6xxGfpBHFRRE
 bBdBkqgUKsnEM1F6pB8TMvVHV2H7y8ovk+Xu8cDJ9Jc1L+zPJ78WCseIS
 dhgBGQuEWwkTGOQ1uvy4u6q8ksqmdige8MP+/kH9Cffl2hwEoeSHf5OJz g==;
X-CSE-ConnectionGUID: 4Eio6kXRQpqyLp2pepKONg==
X-CSE-MsgGUID: fwe/MQreQz+oamvotitS5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808275"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808275"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:54:00 -0800
X-CSE-ConnectionGUID: WsX8/mvPRzSlRbO/U/oJoA==
X-CSE-MsgGUID: iGYym7bgTQu/gvsARTxjMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359687"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 23/27] net/iavf: avoid rte malloc in irq map config
Date: Wed, 11 Feb 2026 13:53:05 +0000
Message-ID: <fad1d01010d95105398d850c4def20daf06c6d6c.1770817884.git.anatoly.burakov@intel.com>
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

