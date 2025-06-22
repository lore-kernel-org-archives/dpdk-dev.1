Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F12C7115A
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Jun 2025 18:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94DD40277;
	Sun, 22 Jun 2025 20:14:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 19F1340270;
 Sun, 22 Jun 2025 20:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750616037; x=1782152037;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ICxLgAyk7UBP0xhmdINEHVJxkQfauWf/cH++sTye004=;
 b=b3dxIRJP0zqBaTp3+b8TIX4F7GfH6HHeaAPQRVpWFfnj1rOPpE9rZfwK
 h7JGYjtEMamV0d+PY3e/Bjm/rjujXE4ZnxqZBp1SPDxQswMaE2v0wBID0
 B0ZY8+rRTNuPUmRXdugv0JhLaSSX10vqStzzce00WmU1Q+Tl5GL3whyd1
 gJbX8TARB9IqN1EsZI1ZGqfz3ZzJZ7/3dtSjC20iM6zLKeSgRQxLjw79X
 5RrKGjMufllkSlgSeJw4/WayIV80AxEB/YMl70mriBp3dVPeSCF/jA4YM
 MXWInfsHIAHNfjgbHA//r9L6WjG+3XsiGYF+cNLo6wWth0CrpNITBLWOp A==;
X-CSE-ConnectionGUID: 1WYW48fmQ22wkaxOka5j5Q==
X-CSE-MsgGUID: dz34qMVQTpCyBlIweRFYng==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="70387946"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="70387946"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 11:13:56 -0700
X-CSE-ConnectionGUID: 5ZjoM47JQtm4DUvJBBAVTQ==
X-CSE-MsgGUID: DL5Eev+mTliMz28UrYZXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="155698464"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa005.fm.intel.com with ESMTP; 22 Jun 2025 11:13:55 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v1] app/eventdev: fix number of releases sent during cleanup
Date: Sun, 22 Jun 2025 13:13:52 -0500
Message-Id: <20250622181352.440499-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
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

During cleanup, only send releases for events app was
not able to enqueue. Current code is sending releases for
entire dequeue burst.

Fixes: f0b68c0b2af7 ("app/eventdev: clean up worker state before exit")
Cc: stable@dpdk.org

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 app/test-eventdev/test_perf_common.c     | 4 ++--
 app/test-eventdev/test_pipeline_common.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 4709de8b07..f77557e765 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1833,9 +1833,9 @@ perf_worker_cleanup(struct rte_mempool *const pool, uint8_t dev_id,
 		for (i = nb_enq; i < nb_deq; i++)
 			rte_mempool_put(pool, events[i].event_ptr);
 
-		for (i = 0; i < nb_deq; i++)
+		for (i = nb_enq; i < nb_deq; i++)
 			events[i].op = RTE_EVENT_OP_RELEASE;
-		rte_event_enqueue_burst(dev_id, port_id, events, nb_deq);
+		rte_event_enqueue_burst(dev_id, port_id, events + nb_enq, nb_deq - nb_enq);
 	}
 	rte_event_port_quiesce(dev_id, port_id, perf_event_port_flush, pool);
 }
diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index 204117ef7f..c1382ac188 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -684,10 +684,10 @@ pipeline_worker_cleanup(uint8_t dev, uint8_t port, struct rte_event ev[],
 				rte_pktmbuf_free(ev[i].mbuf);
 		}
 
-		for (i = 0; i < deq; i++)
+		for (i = enq; i < deq; i++)
 			ev[i].op = RTE_EVENT_OP_RELEASE;
 
-		rte_event_enqueue_burst(dev, port, ev, deq);
+		rte_event_enqueue_burst(dev, port, ev + enq, deq - enq);
 	}
 
 	rte_event_port_quiesce(dev, port, pipeline_event_port_flush, NULL);
-- 
2.39.1

