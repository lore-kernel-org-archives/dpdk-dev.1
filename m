Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B81125851
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B4C40EDD;
	Wed, 11 Mar 2026 17:20:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 48CC5402E7;
 Wed, 11 Mar 2026 17:20:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773246001; x=1804782001;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=krok794c6NyyL8rjCV/vmU6HEWZkdYG2+95JmIv1bbo=;
 b=mS0SWc3t9Y1c5jM8Y6E6L9kKdqnfWStGK9H5boOch4aocx/datjCegEZ
 0Zs3fuNU3jRrRBBrNusDy+iU7o95Ds6Z3zkTVkiTOblqCwKSyHg/Ah+f0
 6t+DyEmRqldlgpz6mE01LUqB8Wvh+bYAjvdHJL33PouxqA4QgC0YuR5yj
 R5+0XhtlGgi07MufAgS8Mb7UAh2toUHm67EdIxr4lk94KYD6xRpVSc8Kt
 WYDScXvJkBw+UXOq1pJux1IjpWs4o+AMc/wq/HGBsDuYXK7YpkCd8sDRF
 KFFCJWlNOHqT8hWI/0byB2+Se51MmcI/R0MU+2p1azZ1DAcKtd2AL7Om7 A==;
X-CSE-ConnectionGUID: cvHX2lFSQXGIRiSUXyewSQ==
X-CSE-MsgGUID: aIo4+P4pSR2Z59qPvY/5ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78213405"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="78213405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 09:19:59 -0700
X-CSE-ConnectionGUID: Lvmjo2YjQc6b7k+Ssp0P8w==
X-CSE-MsgGUID: Bxa2U8F2SNO14ZlLXP3hAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="251026828"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 09:19:58 -0700
From: John McNamara <john.mcnamara@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, John McNamara <john.mcnamara@intel.com>,
 stable@dpdk.org
Subject: [PATCH v1] net/i40e: fix unused variable issue
Date: Wed, 11 Mar 2026 16:19:15 +0000
Message-ID: <20260311161955.1833722-1-john.mcnamara@intel.com>
X-Mailer: git-send-email 2.51.0
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

Fix issue where I40E_SUCCESS was assigned to a return variable
but was overwritten before it could be used.

Coverity issue: 501831
Fixes: baf1d4cd8aed ("net/i40e: upgrade AQ command of MAC/VLAN remove")
Cc: stable@dpdk.org

Signed-off-by: John McNamara <john.mcnamara@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index af736f59be..100a751225 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -7243,9 +7243,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 
 		if (ret != I40E_SUCCESS) {
 			/* Do not report as an error when firmware returns ENOENT */
-			if (aq_status == I40E_AQ_RC_ENOENT) {
-				ret = I40E_SUCCESS;
-			} else {
+			if (aq_status != I40E_AQ_RC_ENOENT) {
 				PMD_DRV_LOG(ERR, "Failed to remove macvlan filter");
 				return ret;
 			}
-- 
2.51.0

