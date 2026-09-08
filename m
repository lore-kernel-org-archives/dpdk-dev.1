Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E4C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE902427D4;
	Tue,  8 Sep 2026 17:22:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A5A72427B0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788880951; x=1820416951;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Vu+ojUf5mjY+9scDoY9VeboknjESkpM447B5g2PyVe8=;
 b=TposJy5CUvRnOSA31BsX/ynAvopbSTp9hnDVLRKit62N0bMc2shgbVpX
 M1eRDG6Qq6zjZlLe9vVIWEtheg7K9y/GTrRK25yfDp+Hd4cxFasAj9MNt
 DcA5L/1ZwQrktFktODBl5OlTamFYNGMzFdKaQI6/BmXL1Ppsd3ZM5PBwE
 X9gSoJvsMLw1efxjVYG9WU5ycP9SWf7w714W9CF+5gom+YzXYB3UepOAw
 WY6QDJ/iVWZc5J9pPAXTLTev+0T3muacm0i3GM8+rLK1BUHpOGF8EklBp
 qe2aQdzGe7Rtp8izJafFPlu2kHeYYV1HQMyDfu8Y9NkSb1KBLTt89jWXZ A==;
X-CSE-ConnectionGUID: xfc+qRH8RL6KTAmaJGmGgQ==
X-CSE-MsgGUID: Zkh7cB8wQuym4CsyPjkZyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89330249"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89330249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:22:30 -0700
X-CSE-ConnectionGUID: w0uRyn+NTx29gnRqR2JxwA==
X-CSE-MsgGUID: PjjqDVhLTaqDcXbjIrcTRQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2026 08:22:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 19/19] net/i40e: advertise flow keep capability
Date: Tue,  8 Sep 2026 16:21:01 +0100
Message-ID: <933106cfdcfca0634f9db234e064a831397b5cf1.1788880125.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788880122.git.anatoly.burakov@intel.com>
 <cover.1788880122.git.anatoly.burakov@intel.com>
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

The i40e driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 8c35a64780..746fdd564e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3662,7 +3662,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
-	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
 						sizeof(uint32_t);
-- 
2.52.0

