Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB8C44500
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A2A40BA3;
	Fri,  3 Jul 2026 15:19:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 65AC4409FA;
 Fri,  3 Jul 2026 15:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084794; x=1814620794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oo7OREAPNhWOhRJ8IQWYuYxTqxnUUC3fr61upEPtlFI=;
 b=WKXXEYZUg8Mp3PDHUd1WnD2g5KMz5hhrAUFqfVwe9zRXE4DNRo6KlYJr
 6KLSZ7iSR7/BJr5264AdzaUXLrfMMQ8Fahym7Qma2/+t2vYr4ydZwCLdC
 aRiCq6xCfZCEL9VkAetpwZ3u7+w4/jOxSNWvYTsrYL0QHPAAv901Af/CE
 7/2RILESv49n544utcrg7UquysbxLJRfPK2SZJG2rnPCK5v/cF7nR+/mY
 IpfdAqKGNbKQ6yUMql+cLAgtQMJSvfQJB/yLhoJIa5HENjLfgFOhRKWbQ
 hFjvYgf3hNC9X4ALrF8zaj/g8dav4CS6PiYt7NslE7ns/EH30jezsv6oc A==;
X-CSE-ConnectionGUID: zkuRUf3TRJS3tkPxFmx6CA==
X-CSE-MsgGUID: hHEHIfNFSzm3CRCqx6zF1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486675"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486675"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:53 -0700
X-CSE-ConnectionGUID: c+59TStNQDqHQQJCIkC7fQ==
X-CSE-MsgGUID: UJjvOZkaT42pJF7SjkBNqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439862"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 4/6] net/ice: fix buffer leak in config of Tx queue TM node
Date: Fri,  3 Jul 2026 14:19:18 +0100
Message-ID: <20260703131921.4102325-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703131921.4102325-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
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

Only the error leg handled free of the adminq message buffer when
configuring a Tx queue traffic management node. Fix this by freeing the
buffer unconditionally after the adminq call. Also, remove the use of
dpdk-specific memory allocation, replacing it with generic alloc and
free routines.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 94ded15fa7..2e6ef9c264 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2022 Intel Corporation
  */
+#include <stdlib.h>
+
 #include <rte_ethdev.h>
 #include <rte_tm_driver.h>
 
@@ -714,7 +716,7 @@ ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32
 		uint8_t txqs_moved = 0;
 		uint16_t buf_size = ice_struct_size(buf, txqs, 1);
 
-		buf = ice_malloc(hw, buf_size);
+		buf = calloc(1, buf_size);
 		if (buf == NULL)
 			return -ENOMEM;
 
@@ -727,9 +729,9 @@ ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32
 
 		int ret = ice_aq_move_recfg_lan_txq(hw, 1, true, false, false, false, 50,
 						NULL, buf, buf_size, &txqs_moved, NULL);
+		free(buf);
 		if (ret || txqs_moved == 0) {
 			PMD_DRV_LOG(ERR, "move lan queue %u failed", qid);
-			ice_free(hw, buf);
 			return ICE_ERR_PARAM;
 		}
 
-- 
2.53.0

