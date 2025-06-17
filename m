Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE4BC7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E64D7427AA;
	Wed, 18 Jun 2025 08:45:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D46F34279F
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750229147; x=1781765147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=12N1bYL99rDHV/NQPUeikh2x64QZCcGsD6+K75GWShs=;
 b=lSx1GmZxSRj2qtd/TeyqT05Dr0V92ut0oanflBntdsTRI3/yGEBE8gb7
 ypRPywaiSEUGJxC91suXBK4lxUtB9SO9qwCq/4iYiGCFQzZag/kC8SKqY
 K5vhlglYTRoFfGe+ZCINJbRdc3FNzGzbdxOd0RYexO2FNCfqzg1lbytLt
 DPcgkIxSVdVh1W2eDlLdqk1nKWgY++vGXTcQ2UpqnBm4h9awr+A3JeSmE
 vp1vA6p63lFNCVz+VWFCapXsIuokuYfP6tH8WB+bSB+PvlwJ4OJgPY5wK
 2eAS/5LZifvi/0voKDB/RhgiREPeytTRGbAKAtwQm06+x4WY2bTVmraa4 A==;
X-CSE-ConnectionGUID: TJQnPxiPSJyx0YveBmuiRw==
X-CSE-MsgGUID: KvrepfSSRlaGSnGDWLoUiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63469071"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63469071"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 23:45:46 -0700
X-CSE-ConnectionGUID: WCIQLNmNTkqMMrYSyyJNag==
X-CSE-MsgGUID: wiBXyUbBS5KoCyjCeU33Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="150110501"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 23:45:45 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 2/4] net/ice: add read clock feature
Date: Tue, 17 Jun 2025 22:36:12 +0000
Message-ID: <20250617223614.568996-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617223614.568996-1-soumyadeep.hore@intel.com>
References: <20250617051337.563233-5-soumyadeep.hore@intel.com>
 <20250617223614.568996-1-soumyadeep.hore@intel.com>
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

Adding eth_ice_read_clock() feature to get current time
for scheduling Packets based on Tx time.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 7cc083ca32..c02935a04d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev *dev,
 static int ice_timesync_write_time(struct rte_eth_dev *dev,
 				   const struct timespec *timestamp);
 static int ice_timesync_disable(struct rte_eth_dev *dev);
+static int ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 static int ice_fec_get_capability(struct rte_eth_dev *dev, struct rte_eth_fec_capa *speed_fec_capa,
 			   unsigned int num);
 static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
@@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.timesync_read_time           = ice_timesync_read_time,
 	.timesync_write_time          = ice_timesync_write_time,
 	.timesync_disable             = ice_timesync_disable,
+	.read_clock                   = ice_read_clock,
 	.tm_ops_get                   = ice_tm_ops_get,
 	.fec_get_capability           = ice_fec_get_capability,
 	.fec_get                      = ice_fec_get,
@@ -6935,6 +6937,21 @@ ice_timesync_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct timespec system_time;
+
+#ifdef RTE_EXEC_ENV_LINUX
+	clock_gettime(CLOCK_MONOTONIC_RAW, &system_time);
+#else
+	clock_gettime(CLOCK_MONOTONIC, &system_time);
+#endif
+	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+
+	return 0;
+}
+
 static const uint32_t *
 ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 					  size_t *no_of_elements)
-- 
2.43.0

