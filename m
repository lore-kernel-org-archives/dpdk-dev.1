Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD0DCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC3F240BA0;
	Thu, 15 Oct 2026 16:43:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 32F1A40BA3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075382; x=1823611382;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rKt53opgVBGgmLzHxy+epuOj7/Mxv8qyuYsNvdEvqsI=;
 b=KUzLsDrXeLo+xrinznXOnkgmbHt6RwASu065WBnHRBMjFCy1HqbB73xa
 BuAa+AmC915JghjLlRET1dmTDoZGpS39OYASLWMB+wQgMASl7PevRDihs
 iuDMndMtphl6pgMyhxlr11JOrM/B2jHWNi3AH2Dt3/+cPh8T0DXshqRNc
 HlU0hPYS63MJUM/biCSYwaF7lYmUoL/6BjqCZtDqVF2wEEV78M464uX3V
 q0qK5TUgnLVU5iWDq+RMRAAPUN0SldDLFpmgiTz2c00j/Y2Eq6k2JqPHg
 xdfc0kUvLK6AwlWgTv+nVuhEpeWxPTTz5oep8hDNNYLclyIrTmnNAoc8Q w==;
X-CSE-ConnectionGUID: 7Fi0k8vUQd2k5USn2aI+kQ==
X-CSE-MsgGUID: h+MGr5A8QBWlROVv0J8kFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="949836"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="949836"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:43:01 -0700
X-CSE-ConnectionGUID: UpLugARLRsasnCoKKhZAow==
X-CSE-MsgGUID: eEru7VbRSFS7twzth/Ddlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1959216"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 07:43:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/iavf: remove dead code
Date: Thu, 15 Oct 2026 15:42:59 +0100
Message-ID: <000a4926363e5be631db4f8209bed02d11369912.1792075372.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

When configuring Rx queue interrupts, there is dead code in one of the
banches. Remove it.

Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 6abdabfb94..937b1fdad3 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -901,10 +901,6 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
 				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
 				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
-			/* debug - check for success! the return value
-			 * should be 2, offset is 0x2800
-			 */
-			/* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
 		} else {
 			/* If no WB_ON_ITR offload flags, need to set
 			 * interrupt for descriptor write back.
-- 
2.52.0

