Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F2F8A14D
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 09:58:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C310F40297;
	Thu, 16 Apr 2026 11:58:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B852C40144;
 Thu, 16 Apr 2026 11:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776333490; x=1807869490;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gk8NScug3k5EmIVUcDx31GRUWrfcQgjCKdIQAgQ41gY=;
 b=ZJSLzwgwIPAJu+QLQL0vzZDzhCmTxaaj5pGEpQb9h6yiaqiWQQG6Z7Lo
 +Vcza04N2TBRU4+DiXnpDIsVfM9bu/Nkc814YrnLxzRZPA4mgXu/1/ZCZ
 sf9YFbFCLK3QGFsVrjdSACh2HWZuRnOSXH4UF8WgpwFyTVGDoNxQH6eeZ
 DDwHaMt1essdnvxVXiiUQiqEN9MBy+Y7X6HJpWbkLq87kYBolgTv0YRaT
 WpRXBq7KWSikqVvpJVvYYrgfARoNfrmeOA+zG+IhzZpwBBoBab7TOYBbY
 5PrWmiVchjad5q+vYsbrpDx/ac/MNkK105czSDMHTXqBeNUZ7l/dds2Ve Q==;
X-CSE-ConnectionGUID: bP4Ar90KTFC8MRAdVTLNcQ==
X-CSE-MsgGUID: DDhBGnsfSrWHSBpGGUS57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="102789170"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="102789170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 02:58:08 -0700
X-CSE-ConnectionGUID: 239tuwKSQiWJ8AjPoKvgoQ==
X-CSE-MsgGUID: ENTXq9MMQUqibdiF/WlEKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="229857189"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa010.jf.intel.com with ESMTP; 16 Apr 2026 02:58:07 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, fanzhang.oss@gmail.com,
 stable@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH] crypto/scheduler: fix typo
Date: Thu, 16 Apr 2026 09:57:39 +0000
Message-ID: <20260416095739.105062-1-radu.nicolau@intel.com>
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

Small typo, pending_deq_ops used instead of pending_enq_ops.

Bugzilla ID: 1537

Fixes: 6812b9bf470e ("crypto/scheduler: use unified session")
Cc: fanzhang.oss@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/scheduler/scheduler_multicore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/scheduler/scheduler_multicore.c b/drivers/crypto/scheduler/scheduler_multicore.c
index a21b522f9f..70f8a25b70 100644
--- a/drivers/crypto/scheduler/scheduler_multicore.c
+++ b/drivers/crypto/scheduler/scheduler_multicore.c
@@ -191,11 +191,11 @@ mc_scheduler_worker(struct rte_cryptodev *dev)
 					worker->qp_id,
 					&enq_ops[pending_enq_ops_idx],
 					pending_enq_ops);
-			if (processed_ops < pending_deq_ops)
+			if (processed_ops < pending_enq_ops)
 				scheduler_retrieve_sessions(
 					&enq_ops[pending_enq_ops_idx +
 						processed_ops],
-					pending_deq_ops - processed_ops);
+					pending_enq_ops - processed_ops);
 			pending_enq_ops -= processed_ops;
 			pending_enq_ops_idx += processed_ops;
 			inflight_ops += processed_ops;
-- 
2.52.0

