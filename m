Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82242606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PkWoVKbZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97EB540265;
	Tue,  3 Nov 2026 18:30:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id ED89E400D6;
 Tue,  3 Nov 2026 18:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727048; x=1825263048;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RGCMmoZEsQqtWn/vfLZmay9Bjk81qBIYwOilztuh30w=;
 b=PkWoVKbZkGfStiHF/T1glMGzXIcmYOhtrXCBRSA0J0AVRkiyD3pGunt2
 1dup61/kldMyngMPxmzhgG4ApkYtP2keVw963XyRCn0SVoZKVkurnkS+/
 92WWMxWd5mRp+mYID8IonCQGWFmBgsi2g05qPptmQaI7uv1SOTBvi0Ixr
 Oske+RUUfeD/TOQF/U5T8wRbuWhvT148cwjr7/0rpNBWlhMyqDtu/pedW
 3ubLlyfwQyvwGR7jPnGCozxio8egMzSSiGvZLhPI4DwXmFlwCX8gqEJ0H
 vKnMF41YUJj3I8Q6FMGIsRDibo/4t1ASJiDDKsnuKMRhFXnLsU/QegBLI A==;
X-CSE-ConnectionGUID: 9A/wvhv8QySETiURe6SnKQ==
X-CSE-MsgGUID: aU17HVVBQPGiO87GJdd81w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553274"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553274"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:28:58 -0800
X-CSE-ConnectionGUID: uHDq/uNIQM+wURhdFQ694w==
X-CSE-MsgGUID: u6QSUX67SEmR77hDdQ+0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495702"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:57 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>, stable@dpdk.org
Subject: [PATCH v1 2/5] baseband/acc: fix queue depth computation error
Date: Tue,  3 Nov 2026 09:28:59 -0800
Message-Id: <20261103172902.4152956-3-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103172902.4152956-1-hernan.vargas@intel.com>
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix to the computation of available dequeue size.
Protects notably for possible negative scenarios when dequeuing
descriptors.

Fixes: e640f6cdfa84 ("baseband/acc200: add LDPC processing")
Cc: stable@dpdk.org

Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
---
 drivers/baseband/acc/acc_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/acc_common.h
index 3d411cd25f..255e0971b8 100644
--- a/drivers/baseband/acc/acc_common.h
+++ b/drivers/baseband/acc/acc_common.h
@@ -1602,7 +1602,7 @@ acc_ring_avail_enq(struct acc_queue *q)
 static inline uint32_t
 acc_ring_avail_deq(struct acc_queue *q)
 {
-	return (q->sw_ring_depth + q->sw_ring_head - q->sw_ring_tail) & q->sw_ring_wrap_mask;
+	return (q->sw_ring_head - q->sw_ring_tail) & q->sw_ring_wrap_mask;
 }
 
 /* Check room in AQ for the enqueues batches into Qmgr */
-- 
2.34.1

