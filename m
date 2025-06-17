Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34979C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 08:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F4740B9F;
	Tue, 17 Jun 2025 10:24:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9EDD240B8C
 for <dev@dpdk.org>; Tue, 17 Jun 2025 10:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750148656; x=1781684656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v+n4cmPgKQPaxbkDOtpjB7Sif7wmN+cYIBej8qW1Bjg=;
 b=JEPcCDX4nNJwe3oqC8+EP+WWeP/BgNE+ounja6vF2k8YmChEYkrp7tOk
 u98zHZyQJUft8/g5qC7d37SnpwOf00m3r2FEVFnULV+/a0JdUqFu/5I/e
 IJpI3drVShjTk47JW1kUVvrul9zQSeSFuq3r7GLazngpYk542BmI/KlNe
 e04n0QiDggcJqUkJU/+Sl24cD7Qulx7myr9B+y8X0ArkJKj60aN8eNCAk
 zzAAS5WAcQ+Gocu6g9F2vBjURqMLc+jfd8/esAvc5xm/3n1O5xDVYcnw9
 9SGV5jYGMaHq3WaQBLeunzCHjhBnjmgfK446Z9j3yxoWKX2LYSMS3OUVG w==;
X-CSE-ConnectionGUID: i0FFnFnuS6K3K/fD0P90iw==
X-CSE-MsgGUID: 4BvIzofSRM+vZ494KzbmQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52449728"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52449728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:24:16 -0700
X-CSE-ConnectionGUID: HucCFATdR3yuG/rJAz0LOQ==
X-CSE-MsgGUID: XqNBwqd0Qv27Ow0qszKLNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148563832"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2025 01:24:14 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v5 2/4] net/ice: add read clock feature
Date: Tue, 17 Jun 2025 00:14:27 +0000
Message-ID: <20250617001429.551262-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617001429.551262-1-soumyadeep.hore@intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
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
 drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 7cc083ca32..588edbca2d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev *dev,
 static int ice_timesync_write_time(struct rte_eth_dev *dev,
 				   const struct timespec *timestamp);
 static int ice_timesync_disable(struct rte_eth_dev *dev);
+static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 static int ice_fec_get_capability(struct rte_eth_dev *dev, struct rte_eth_fec_capa *speed_fec_capa,
 			   unsigned int num);
 static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
@@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.timesync_read_time           = ice_timesync_read_time,
 	.timesync_write_time          = ice_timesync_write_time,
 	.timesync_disable             = ice_timesync_disable,
+	.read_clock                   = eth_ice_read_clock,
 	.tm_ops_get                   = ice_tm_ops_get,
 	.fec_get_capability           = ice_fec_get_capability,
 	.fec_get                      = ice_fec_get,
@@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct timespec system_time;
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &system_time);
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

