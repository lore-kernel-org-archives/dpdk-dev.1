Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348D606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ncgb8vWf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8060440289;
	Fri, 30 Oct 2026 15:39:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id B64B240285;
 Fri, 30 Oct 2026 15:39:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793371145; x=1824907145;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JrzYRUyuMacrpMU1Lpfxin8BxpQ/RQNFKNy0CF/XaoU=;
 b=ncgb8vWfjSxofIz6rjOe4pXHdU7pVxHyxXsQnTpcgfVKA4Z/uieRNmyd
 weDMwVF51Q+lPVqorl20fIzU1hmDfaNRAMwoRNKrNC1xOp9A8LRZw5krK
 w/QJWfS0Ks5BGRUqvJX6saURMapzjoJ/AeBFx89ID0DXLWOfDCmkSelOB
 nqBy1r1JYUlFAakL5oKBtxkSp1Oefp2rOn5q/acYcVsHHgK3ZMkOQi9p0
 7vbFaWs8hOiodm9oqAkQ1+T5xLJ1V13ZkG2M29NZRYn1wDr3YhsOkfCzw
 dTxEAjGvOOOpuQZDMpxE8r8AVceUComuv3qx9weGl+CzLMfe/5bkbTZfb A==;
X-CSE-ConnectionGUID: H5ZCtNHcSuSH5BhDaO0VHA==
X-CSE-MsgGUID: ogl2L2lPTa+4E1IzPyLL5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2021200"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2021200"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:39:03 -0700
X-CSE-ConnectionGUID: 8Ptp9FAnSHqMMo2FOWeXwg==
X-CSE-MsgGUID: rG9iMz7MT26DDce8CGBAzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5570847"
Received: from gnrd03.iind.intel.com ([10.190.213.135])
 by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2026 07:39:01 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com, dawid.wesierski@intel.com,
 marek.kasiewicz@intel.com, stable@dpdk.org
Subject: [PATCH v1] net/ice: fix read clock to use PHC hardware time
Date: Fri, 30 Oct 2026 20:08:42 +0530
Message-ID: <20261030143842.2745225-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
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

The ice_read_clock() function was incorrectly using clock_gettime()
with CLOCK_MONOTONIC_RAW to return system time instead of the actual
hardware PHC time. This caused txtime scheduling to use a completely
different time base than the PHC, resulting in all scheduled timestamps
being interpreted as past time by the hardware.

Replace the system clock read with ice_timesync_read_time() which reads
the actual PHC register value, ensuring the application can compute
correct future timestamps relative to the hardware clock.

Fixes: 327fe144ca39 ("net/ice: support clock read")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 11b549a452..136780e744 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -7734,16 +7734,16 @@ ice_timesync_disable(struct rte_eth_dev *dev)
 }
 
 static int
-ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
+ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 {
-	struct timespec system_time;
+	struct timespec ts;
+	int ret;
 
-#ifdef RTE_EXEC_ENV_LINUX
-	clock_gettime(CLOCK_MONOTONIC_RAW, &system_time);
-#else
-	clock_gettime(CLOCK_MONOTONIC, &system_time);
-#endif
-	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+	ret = ice_timesync_read_time(dev, &ts);
+	if (ret)
+		return ret;
+
+	*clock = (uint64_t)ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
 
 	return 0;
 }
-- 
2.43.0

