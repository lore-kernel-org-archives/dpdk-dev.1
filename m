Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B7C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D76A40A71;
	Fri, 10 Jul 2026 12:34:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3F14D4067C;
 Fri, 10 Jul 2026 12:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679653; x=1815215653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oo7OREAPNhWOhRJ8IQWYuYxTqxnUUC3fr61upEPtlFI=;
 b=i93ROcEjWmij7J58U69I6OSSlHPdZVSzyNrsfJbCaPWSKzUJIUkXCI64
 OrBfYbqd073rUxJziEZn2jSFBxPoUZ0Mb6nA9RmNwiLg9N7zd3+fpsGa4
 c5++NjOW4gLgO8u4pd3RitHIDqO8ur+p/LZ0LJwFs4VtS6EVW6MnvpWfZ
 vIHHHAGaiBCafASukNW75XPr5cCEI6GFY5oXSvGoVL99Y+k2SnZtxfhVP
 GRW2UwQPq31b2YKFN4I4WjZDpfgEZaiDFCNR70MqJmJCvi3iVtwdVbwzy
 Z4aUNBeQmrsaMUgeDx2/clX8MdhO/FyzxNyvna/YswTKWUBMF89PaQSkC g==;
X-CSE-ConnectionGUID: +69qqFxgQu2EavTsjWXQDA==
X-CSE-MsgGUID: ByaWcO73TySnZao3LBhStQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428987"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428987"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:12 -0700
X-CSE-ConnectionGUID: 2G20AO0TR0G4FrVPR/5oig==
X-CSE-MsgGUID: RejbUOuORZaxIhtPrdLDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163179"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 4/6] net/ice: fix buffer leak in config of Tx queue TM node
Date: Fri, 10 Jul 2026 11:34:01 +0100
Message-ID: <20260710103403.1548864-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710103403.1548864-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260710103403.1548864-1-bruce.richardson@intel.com>
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

