Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C229C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 721B6427DD;
	Tue,  4 Feb 2025 16:12:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C90E342795
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681918; x=1770217918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kvzBvGanW7FlKyCOx5Ue/Xwkcbrl3460KJCzWvDkTeo=;
 b=WoClIo2gXRsdsJRI0zXKGInwsr66mSSyRXsGD46EvX+Ndjb3JOX+/m32
 3qt1alBs9QIb+IUCxRiruVkLaobd2YU3fV7gsg8csCipKegVg/xg7YgM1
 hFm4tL2MJ4Y1vd9LcueFjfDXpQ4GsQDqPXgClp+ib8EwVwUlEATr/1hJZ
 +CqfMedUCx2SJ0KgJfr+hujYXKgZDSnw+/tm6ZwOUE4cZYubpctTsm/GT
 pWqC1PlDsyNxWmize+89hLPKIW0Yi84osYBERAJJbRg35UkFYfSmZ3k/f
 pdeCp770Sw4+Ytu7SwU12PFWwyh5n5Tg0aef0VMTlWedE3ZADpvuuoLmr Q==;
X-CSE-ConnectionGUID: nYlunnczRWWedQxgLm1c7g==
X-CSE-MsgGUID: kV7IiFOPQQynoqQKIgc53A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097133"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097133"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:57 -0800
X-CSE-ConnectionGUID: q/uuiPtARKyb2gl0Gu0Akg==
X-CSE-MsgGUID: +jGvlOcBQF+jyoIaf48WGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792667"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 23/54] net/e1000/base: fix unused value
Date: Tue,  4 Feb 2025 15:10:29 +0000
Message-ID: <f1cd21beea1ff76a0a942aaff4b5c4af778dc6f2.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Static analysis has reported that when there is no get link status callback
function, the value set in the if condition is not used and gets
overwritten in the "out" section of the code. Fix by not seting the
variable.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 611f3e8408..ed4ac25a1c 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -1025,10 +1025,8 @@ s32 e1000_check_for_link_i225(struct e1000_hw *hw)
 	 * changed.  The get_link_status flag is set upon receiving
 	 * a Link Status Change or Rx Sequence Error interrupt.
 	 */
-	if (!mac->get_link_status) {
-		ret_val = E1000_SUCCESS;
+	if (!mac->get_link_status)
 		goto out;
-	}
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
-- 
2.43.5

