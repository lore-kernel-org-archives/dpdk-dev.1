Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FDC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 946CB40616;
	Tue, 18 Aug 2026 15:19:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5BD40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059179; x=1818595179;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fQKdZnQwjSXhZ04vBr4NOaQ+0kUclYy0avQA1zi0eh0=;
 b=HlHUw2wPkyK887tz/mOBHJkN6rNSCx+k6toknh9G9CQ1AWVU1ikGXCAQ
 fNn/RVkly6/B/y+UkItldZkrGL9cYaSyJ0kzDO6HrxpM70A8Txj25GeRT
 7hO8xKQ8yz0ZY4o8u5XA4HHtOb3UKcA/hj/Zammwrp9vUbtyWxuE4u8pF
 0SHhc6TWoCpyPwPpJkf7b/lu0kPsMpmbRd3y9kwRvPOIvJs3+zoeS/hRX
 B6lXUYCyBVpvVsvvHbIVHsamw33ZfLmOUN/0WTRPQAc5BKBeoEmuPUUjO
 puAnZe4Q9iYm6Y+yyOYNXipe0RyT5CWPUwstD2F1rcaO0YkFWFqo5qb0I w==;
X-CSE-ConnectionGUID: q0Bhg0w1Sh+Y58JPA4eQJA==
X-CSE-MsgGUID: RJoV8fhBRICDhfNthrD5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669415"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:39 -0700
X-CSE-ConnectionGUID: 7im/OKHPQNWYcJeYVTZj1w==
X-CSE-MsgGUID: iAVauCrCQcmuNkRb8W22qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015689"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 2/6] net/ixgbe: remove unnecessary dev pointer
Date: Tue, 18 Aug 2026 14:19:28 +0100
Message-ID: <ce3008f2ee4d820c3def1ed703398b03543d16a0.1787059138.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
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

