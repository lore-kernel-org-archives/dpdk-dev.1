Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746ACCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0CBF40E0F;
	Wed, 15 Oct 2025 12:07:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1140140276;
 Wed, 15 Oct 2025 12:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522852; x=1792058852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5XogHaTpdCnAS8GiSLjUZ1S0IeeBV5e3GTdgH9YpAxA=;
 b=H0OWajiLA7M7Pptc5a+BesDclubWYWlGaLDnUI5ufhD37rOCNB1EZKt5
 75LBZllKv3j03NSxelvThh578A4Zc5PfsULonpPGCbq/U1YfosIzOf5wG
 aTg7i79b9G+uY4hzbHZLNmSuB9WG0yKR0oI7DKixl/1aNZxaYtK6bmBI2
 CCQU4uA22lmncGEvY3Uieg7ievIeLy8WcSI6jPMbgpe1G14w+z054uEoo
 Bp9Ka6ajYbNipbh0EJqOccM5YNqL0VMy1I7zo6LkiCNnHJhUZazqvZaO0
 MvupUZ6FuZpeqN8ptf/DcU+RL+rMQblWM4acC23vJzBnCJKHbiURIQ6iH w==;
X-CSE-ConnectionGUID: 6tU4puBdQluHGWp8avrocg==
X-CSE-MsgGUID: JVIEt1ahSJqyb5hpe1N60A==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371776"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371776"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:31 -0700
X-CSE-ConnectionGUID: 1QUHYdQwSXqnt+gJtIattQ==
X-CSE-MsgGUID: 0MaNC/4kRMSWcSh42crK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262596"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 1/7] net/intel: fix Rx vector capability detection
Date: Wed, 15 Oct 2025 10:07:17 +0000
Message-Id: <20251015100723.1603296-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
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

The common function for detecting whether an rxq could use a vector
rx path would automatically disqualify rx queues that had the
timestamp offload enabled. This was incorrect behaviour because the
iavf driver which uses this common function supports timestamp offload
on its vector paths. Fix this by removing the conditional check for
timestamp offload.

Fixes: 9eb60580d155 ("net/intel: extract common Rx vector criteria")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 741808f573..d3e4492ff1 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -235,9 +235,8 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
 			(nb_desc % rx_free_thresh) != 0)
 		return false;
 
-	/* no driver supports timestamping or buffer split on vector path */
-	if ((offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) ||
-			(offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
+	/* no driver supports buffer split on vector path */
+	if (offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
 		return false;
 
 	return true;
-- 
2.34.1

