Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA629CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFE76410EA;
	Wed,  7 Oct 2026 09:56:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8489F40E50;
 Wed,  7 Oct 2026 09:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791359802; x=1822895802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=12ttCDXUDiRmVdFeKBGn1HSMuMB8TyH0Q6fdA+pW7MU=;
 b=bQZLzM0aeOLXq3u0m/Bn3wDP20YAMZy9GtG2s1m74heymxY++ZM3fwtH
 BUyTGchqPWBfHt9eEfxognxobIQXfWW6JwkExxMjGk3yiDfZqXA9We/S2
 Re0AJ5SM/K87Eruengf5IpQ1t/HqQJcbHRnkgFwPyhT9gliuXEOjFHHxz
 7+kO1SiztXk1a2r2xK24pxTXHb3mv2ge27leElKvzMAFNAYHxozdoN9pk
 wmXZAcwWw/bB712FpTp723AhL7si6Rz0WGxtoaPCtiXMM/8hcrVfmmUZ9
 OsLoJefxOpET/nKKYAE8Fo6ZLqRQiYZsukJ4yN9NZPK1lcNEqqKTC0cgS Q==;
X-CSE-ConnectionGUID: KpdWrpQARCC1bNBjPCappw==
X-CSE-MsgGUID: Zvt0D0HXTKKip69NUcOehg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="216889"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="216889"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 00:56:41 -0700
X-CSE-ConnectionGUID: vcpNG3rqRWe1hHBiQyhajw==
X-CSE-MsgGUID: WypsYA1vQ/aMPqHxqrkPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="285301282"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2026 00:56:39 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 2/2] net/ice: fix unchecked Tx time context allocation
Date: Wed,  7 Oct 2026 07:58:20 +0000
Message-Id: <48fb0a4b46839034e70d4050d385efcd736b869d.1791356190.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791356190.git.anurag.mandal@intel.com>
References: <cover.1791356190.git.anurag.mandal@intel.com>
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

ice_tx_queue_start() dereferences the Tx time queue
context buffer returned by ice_malloc() without
NULL check.
On allocation failure, the E830 send-on-timestamp path
therefore crashes instead of reporting "No Memory" error,
and also the already allocated txq_elem buffer gets leaked.

Added the necessary allocation failure check and freed
txq_elem buffer in case of failure to avoid the memory leak.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c8b88fb235..9ad4a01f87 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -898,6 +898,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
 
 		ts_elem = ice_malloc(hw, ts_buf_len);
+		if (!ts_elem) {
+			ice_free(hw, txq_elem);
+			return -ENOMEM;
+		}
 		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
 		ice_set_ctx(hw, (u8 *)&txtime_ctx,
 				ts_elem->txtimeqs[0].txtime_ctx,
-- 
2.34.1

