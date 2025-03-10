Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D7C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 13:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D244060F;
	Mon, 10 Mar 2025 14:11:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 69CDB402E4;
 Mon, 10 Mar 2025 14:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741612289; x=1773148289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a9WhWOZDDHcCmeg2+zFzwPMouxRksAHQ9tjrnY1mPE4=;
 b=MSq449HnxPgYSFI6iguE0LXU3oC6i8+G3kHZKN4kMPFebnXgNwwE579H
 JNo51moWpgZP4BrcadY/CQLALJuFmJ8vcSUX0HZ2t2opkz/InnRC2tLHH
 uoPYLdtxFwMJWnQHo56s2KN1/UtnsJMfbnkwcCUBRENlb+yjVYdVNx9Md
 ySa2GNbGPM5o3k/ZWVOtP8nPYVrJrResGTwNLHU6ZFr7KDdx/7J4Rx4nT
 1abqM3pJDvxEPWcOpo9KWr1dHfJ/erfNW/ncyVz8WDPc4iM/pukNp9gpn
 piPQLhfmEdwl4riYsiqbdREfFvLRLXuSFygjt9rMXjID4FY5zXGMKs3JZ A==;
X-CSE-ConnectionGUID: werJchdCT3OX3x/j2KYfZQ==
X-CSE-MsgGUID: 5zJ/rVHKSui3zOvXNonQVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53596005"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="53596005"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 06:11:29 -0700
X-CSE-ConnectionGUID: 1ouhP871TTu6lBXq7Qs/wg==
X-CSE-MsgGUID: ZMfOi5ZfSeGnLm6QnlwPbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="119821765"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa006.fm.intel.com with ESMTP; 10 Mar 2025 06:11:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 2/2] net/iavf: fix crash on app exit on FreeBSD
Date: Mon, 10 Mar 2025 13:11:16 +0000
Message-ID: <20250310131116.557117-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310131116.557117-1-bruce.richardson@intel.com>
References: <20250310131116.557117-1-bruce.richardson@intel.com>
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

With the fallback interrupt path now enabled on FreeBSD there are
segmentation faults on app exit, due to the alarm interrupt trying to
access invalid pointers.  Add checks for null to fix these crashes.

Fixes: cd3b124955d4 ("net/iavf: enable interrupt polling")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1ab84b0bfc..2335746f04 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2698,6 +2698,9 @@ void
 iavf_dev_alarm_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
+		return;
+
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t icr0;
 
-- 
2.43.0

