Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D3C5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC8AF4065A;
	Wed, 19 Aug 2026 14:33:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2CE1B402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142778; x=1818678778;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Hnlt3BP1s6s9kX4bZrQwoMi3gC/JTVeVlBniC2w6Guk=;
 b=hcJUCM4tgQbLxFvLoiqPjPIKpMSIamjfeNJanU0UesSEAh+q3FgJRdlN
 qNxzG07Actg5mUYjoW1n4098mpyTue0vD2TT9mavHWZyOs/phx8gZ8Cby
 a7ZegoQdNUM5MYohB4YRJlY9WeuogWVAKQHcsWjK6IsqB6M+jBQWyhKN0
 pWe5LJgMCvZpBAacPqMF8K8NoMsYu+1wD1EUPB8OGEM/Kd24npbsKjNOJ
 TS/lJnoo260kEBXnarSokwKvn9LccOKWMhYWhTF/CQdfEEJlQ4oZmJPDv
 gRa0/upA2Wo8wwyUTl+2vbm9ATuawA3aoiKdTxLDxmhjgi+RDk9Mp6Q7f Q==;
X-CSE-ConnectionGUID: cZRR44jYTkWKpd8jwC7f4g==
X-CSE-MsgGUID: vo713sdYS5yOAFayO5Wdjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775529"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775529"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:32:57 -0700
X-CSE-ConnectionGUID: D/+bHWpCQgG0iTmBEbYW6Q==
X-CSE-MsgGUID: JNJBD/cxR4CkEgOLBot7oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382544"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:32:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 2/7] net/ixgbe: remove unnecessary dev pointer
Date: Wed, 19 Aug 2026 13:32:34 +0100
Message-ID: <afa6184e6438c4136c3095dbd38b51dd357f357c.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
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

The `ic_session` already contains a `dev_data` pointer, so there is no need
to pass the `dev` pointer to `ixgbe_crypto_remove_sa`.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index aaf657af5f..e2ec402b52 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -268,12 +268,11 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 }
 
 static int
-ixgbe_crypto_remove_sa(struct rte_eth_dev *dev,
-		       struct ixgbe_crypto_session *ic_session)
+ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ic_session->dev_data->dev_private);
 	struct ixgbe_ipsec *priv =
-			IXGBE_DEV_PRIVATE_TO_IPSEC(dev->data->dev_private);
+			IXGBE_DEV_PRIVATE_TO_IPSEC(ic_session->dev_data->dev_private);
 	uint32_t reg_val;
 	int sa_index = -1;
 
@@ -441,7 +440,7 @@ ixgbe_crypto_remove_session(void *device,
 		return -ENODEV;
 	}
 
-	if (ixgbe_crypto_remove_sa(eth_dev, ic_session)) {
+	if (ixgbe_crypto_remove_sa(ic_session)) {
 		PMD_DRV_LOG(ERR, "Failed to remove session");
 		return -EFAULT;
 	}
-- 
2.52.0

