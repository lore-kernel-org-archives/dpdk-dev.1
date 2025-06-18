Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23323C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65395427C2;
	Wed, 18 Jun 2025 09:44:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A3D5B427AC;
 Wed, 18 Jun 2025 09:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750232656; x=1781768656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5zUidJoSNv6FwyKVyCplDVB5gm6ir3uxvRY1z+t8bz0=;
 b=LFSNnu/OyWSRJ3NhiIF7byJQHcXf9soj6kZI0+X88K/xcJh6UJ3xJd1r
 WThA9IND8dRQ553QHVCoS0WASFLamqHmnpnFD0Py/RxS2M5bvOkn9378r
 u8SuXpB3yUl4Mec49mt5s6A0V6/x04mzCYm8Ja5iSOeGOLgtDqlgrrWRx
 cBvanQhTL5sgq4DQWQKmt6JS/cjY1JX9yuJRHoVc2dSHfjUlD1R/jLO5m
 IbRg1gBDx2jaMDgiEcs5mHVyVzlZI3v5eH4XQV5sMHPFOKAvvmsKPe0RP
 n9Aw430TH7ewdyUwC7vT78R29RKy0GBvhRTr4EsKkoFNTxiuW7xe/4nne w==;
X-CSE-ConnectionGUID: 7mHGSes4Q3y7q5sxp+cg/A==
X-CSE-MsgGUID: /bikXgxsTvOR1swuIMCcGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63096900"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63096900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:44:15 -0700
X-CSE-ConnectionGUID: yDh5eLteRgSyGBgbaVsB0g==
X-CSE-MsgGUID: bdIE86nuTLyDqOahW+2Pwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="150112917"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:44:12 -0700
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/2] net/ice: fix getting DCF RSS hash
Date: Wed, 18 Jun 2025 07:08:43 +0000
Message-Id: <20250618070844.174484-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611095058.114465-1-mingjinx.ye@intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
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

When getting the rss hash configuration, it returns the currently
configured rss_hf instead of the default value.

Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
v2: Split into 2 patches
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index efff76afa8..a21b6e5972 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1452,8 +1452,7 @@ ice_dcf_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
 		return -ENOTSUP;
 
-	/* Just set it to default value now. */
-	rss_conf->rss_hf = ICE_RSS_OFFLOAD_ALL;
+	rss_conf->rss_hf = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
 
 	if (!rss_conf->rss_key)
 		return 0;
-- 
2.25.1

