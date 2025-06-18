Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D3C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCC83427D7;
	Wed, 18 Jun 2025 09:44:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0DB38427CD;
 Wed, 18 Jun 2025 09:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750232663; x=1781768663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1rUPu8bnXmIciwvq5X6mi5at6paQS5x3c0K8xP6y9sw=;
 b=ABCEJDNr9WvuBFVCQ6/zseteqVg4wuZNaR0DTrb6DYapQg3nHBY/V4B0
 RAW9W0jZiF+UZnoxf9H9WhBtLhKk1xcp+SGIEIkopBUNVVcpGTxgmBqDV
 2PzaG5qitoZDeG80nmLRWr0jTBk8xOpiDcaIm8yNvRlz6HkiQN5HWq1wp
 2DQE9jCQzQs0ZCnAn5OInIsxC4PoquAuGNYRVEsIgCs/z/pkZfNzxyEfn
 RnYVv91PMJnJAg57ur64IJ36Fs226ECDEdIv3vdhLjPoIvqhyt0iBGbmF
 CByMjTcS3dlGfwXdw1IjXH5rZsBslyG2N4ZZM4vkNWbt/haCczcZBQRtG A==;
X-CSE-ConnectionGUID: L0+SGKDNSBGMCKTol6aN/Q==
X-CSE-MsgGUID: blGiG90TR5uahovcGtHF5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63096910"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63096910"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:44:22 -0700
X-CSE-ConnectionGUID: 3GrV5qi0TmuirV+Tmw5ESQ==
X-CSE-MsgGUID: seoG6bxVTA+ntY8LBVc/9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="150112993"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:44:20 -0700
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
Date: Wed, 18 Jun 2025 07:08:44 +0000
Message-Id: <20250618070844.174484-2-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618070844.174484-1-mingjinx.ye@intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <20250618070844.174484-1-mingjinx.ye@intel.com>
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

The driver does nothing if the rss key is invalid during the rss
hash update.

Extract the update rss key code from ice_dcf_dev_rss_hash_update to
ice_dcf_set_rss_key and make it consistent with the pf behaviour.

Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
v2: Split into 2 patches
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 35 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index a21b6e5972..accabd0ab9 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1394,31 +1394,38 @@ ice_dcf_dev_rss_reta_query(struct rte_eth_dev *dev,
 }
 
 static int
-ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
-			struct rte_eth_rss_conf *rss_conf)
+ice_dcf_set_rss_key(struct ice_dcf_hw *hw, uint8_t *key, uint8_t key_len)
 {
-	struct ice_dcf_adapter *adapter = dev->data->dev_private;
-	struct ice_dcf_hw *hw = &adapter->real_hw;
-	int ret;
-
-	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
-		return -ENOTSUP;
-
 	/* HENA setting, it is enabled by default, no change */
-	if (!rss_conf->rss_key || rss_conf->rss_key_len == 0) {
+	if (!key || key_len == 0) {
 		PMD_DRV_LOG(DEBUG, "No key to be configured");
 		return 0;
-	} else if (rss_conf->rss_key_len != hw->vf_res->rss_key_size) {
+	} else if (key_len != hw->vf_res->rss_key_size) {
 		PMD_DRV_LOG(ERR, "The size of hash key configured "
 			"(%d) doesn't match the size of hardware can "
-			"support (%d)", rss_conf->rss_key_len,
+			"support (%d)", key_len,
 			hw->vf_res->rss_key_size);
 		return -EINVAL;
 	}
 
-	rte_memcpy(hw->rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
+	rte_memcpy(hw->rss_key, key, key_len);
+
+	return ice_dcf_configure_rss_key(hw);
+}
+
+static int
+ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf)
+{
+	struct ice_dcf_adapter *adapter = dev->data->dev_private;
+	struct ice_dcf_hw *hw = &adapter->real_hw;
+	int ret;
+
+	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
+		return -ENOTSUP;
 
-	ret = ice_dcf_configure_rss_key(hw);
+	/* set hash key */
+	ret = ice_dcf_set_rss_key(hw, rss_conf->rss_key, rss_conf->rss_key_len);
 	if (ret)
 		return ret;
 
-- 
2.25.1

