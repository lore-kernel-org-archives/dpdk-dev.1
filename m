Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA393C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE5A440ED0;
	Tue, 17 Jun 2025 15:23:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B401E40E5E
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750166590; x=1781702590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FwJ1gnkKmBbGDffhOXgLF/YCRj829aJXzwCs83mP+3E=;
 b=gdHsQqzCw2TAlDJul7tTmaFWFR+OE+Pe6jFXGPYB8QTWQLG+czloIzcn
 akXczm5TM1GWgFDjgAkxwxCr0ZkPBqFA78VzD4jwDQmXL3vODOgkLH1w/
 PjN/JsQfVbGBqEK98wxXOB6L10psuNHKgGPWU0A2VLpIHucAWnz5ukxhE
 sn2LwVjjV1ziDUGFYSCA5iBwHgUadglT7P3/fzMyFTLrd//o0ewhqa8CZ
 5y+YFQgvYeToPCzNXMQw9bQ+NRfr0PzlfpjLBdpPbDkedEZgUYLA9BJ1j
 lvfp5/DPl1nBHcjXlbk+KArzNKrtL+Gbz1ALGJ4ik+VEBKJncZPhhnuJk A==;
X-CSE-ConnectionGUID: 0Upb3IzcQLa111UihEC0DA==
X-CSE-MsgGUID: 6bgT/iqMTWe36t0BxlQu+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="54960510"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="54960510"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 06:23:10 -0700
X-CSE-ConnectionGUID: NJAGOxICQ+yH5ZGncKucYA==
X-CSE-MsgGUID: uMqawAsXS/Cc0vJwSOqzjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="172022254"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 17 Jun 2025 06:23:08 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v6 2/4] net/ice: add read clock feature
Date: Tue, 17 Jun 2025 05:13:35 +0000
Message-ID: <20250617051337.563233-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617051337.563233-1-soumyadeep.hore@intel.com>
References: <20250617001429.551262-5-soumyadeep.hore@intel.com>
 <20250617051337.563233-1-soumyadeep.hore@intel.com>
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
index 7cc083ca32..3d4c855cbe 100644
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
+#ifdef RTE_EXEC_ENV_FREEBSD
+	clock_gettime(CLOCK_MONOTONIC, &system_time);
+#else
+	clock_gettime(CLOCK_MONOTONIC_RAW, &system_time);
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

