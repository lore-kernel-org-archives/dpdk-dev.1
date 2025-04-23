Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E6C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 06:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF5EE402A9;
	Wed, 23 Apr 2025 08:46:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 747904029D;
 Wed, 23 Apr 2025 08:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745390792; x=1776926792;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nOleN+Gb9JqHWyvS+zdUmgq3rvhRHvsRb9Aszde6f7k=;
 b=WdTRXVc2HQLFB/rLb5b26HqmZxXBtx6YUAoDzce4ZH3SOp52uAjX7TEJ
 RhvbhhVGHNJYseSmUyO6UmOZhhgpfFUTQi9ZBNrf8IgNiVROwZrjsf4CM
 gLqj4cgMo8yIuN4KNQbgOQ2WurIrzBc4jvhxtomUqomVe3d1dH7PNhAqA
 LmWdKWeoGb093KwJlFir+VepEufgpc9wJ003Iph/cG8LsPPSOmGEs6+Sq
 IoPkRyFydxmRdnbcqwUCsKjRXpnZ2EHkkT3npvG9fwMIvkZZbkVI4uUxy
 cG+jZo7ow2ljT4/pq17RyvQP0VI6ckyklmv8UDk2WnhmMB7tBMsrRdVUd Q==;
X-CSE-ConnectionGUID: iCvYacTWS86yV5jbqg0DtQ==
X-CSE-MsgGUID: JC2DUxTjQ1+Q9W6CkTQwnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47150742"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="47150742"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 23:46:30 -0700
X-CSE-ConnectionGUID: M+rA0iUyRPqvkTEdI5iuzQ==
X-CSE-MsgGUID: H2efb3h5Tz2TUOZwkCYYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137219450"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 23:46:27 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH] net/intel: enable ethertype filter for E610
Date: Wed, 23 Apr 2025 13:53:39 +0800
Message-Id: <20250423055339.79209-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
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

This commit adds the E610 MAC type to the filter support check.

Fixes: 962549bb27c7 ("net/ixgbe: move MAC type check macros")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 8ad841ea2c..7804b4ca03 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -145,7 +145,7 @@
 #define MAC_TYPE_FILTER_SUP(type)    do {\
 	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
 		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
-		(type) != ixgbe_mac_X550EM_a)\
+		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
 		return -ENOTSUP;\
 } while (0)
 
-- 
2.34.1

