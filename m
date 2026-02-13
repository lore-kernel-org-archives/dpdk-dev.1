Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5707AEDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC9DF40DCD;
	Fri, 13 Feb 2026 11:27:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 032BC40B8C
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978439; x=1802514439;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S2DwF2UEtpRAeoxf+hu6icOBotmi/T9xb0bSi1hpwrE=;
 b=GG09iu+mc8kmJs1horyKVVNkAu36hKPJ88Hd8qVwz+ghbqm4ElKgvpQz
 HvGXhOGV37L8pm7MEXST9DxtzHLuX/rBmIyowyan+wv+sj1vWxmRQItcw
 6SOg3P5AC+TOmY6wK8byAa9TZTEs6Zx63zG25sGQhgQOk9+1j3CouVNRF
 hCQZjr7mkdzpeI0gQ2Kw8U6Pruj89kvCwDJCBOAowsTLxsEom8So+uhnb
 NDh3s/Cxzhu6AOnQa5M9HA5HzuPDsDgyIhrEmUp00vzSj/ItS4o9L10Hd
 1yOL3tpDE4vfaVjAVdszabepepRaafYMwYEwDuketIyggzdty7ZAAgSLL Q==;
X-CSE-ConnectionGUID: mWND0QQcQEyptA3IKLSwCQ==
X-CSE-MsgGUID: L1FY4sJ2Rb2LStFHcbTTNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603115"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:18 -0800
X-CSE-ConnectionGUID: fNP5/MQQSMK+AMm+IwD/UQ==
X-CSE-MsgGUID: cpVl9fNKTHWOfv7FJqtgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028141"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 23/27] net/iavf: avoid rte malloc in irq map config
Date: Fri, 13 Feb 2026 10:26:34 +0000
Message-ID: <fc61ca4f63c17e6170d0af126e4a4fab6aaedbe9.1770978324.git.anatoly.burakov@intel.com>
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

