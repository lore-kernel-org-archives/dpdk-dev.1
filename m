Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A1C61CE8
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Jun 2025 05:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C3D94064C;
	Sat,  7 Jun 2025 07:29:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E058240651
 for <dev@dpdk.org>; Sat,  7 Jun 2025 07:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749274176; x=1780810176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eCIFHZFca5rkzk2GEjIG8U9+LyvPjVJO7I3OSnoWSXw=;
 b=KPWUfZUsvLIhEqvKVQzh8SJl4xhUqAIW0Bw1E5ilxJbseO8mvm4jBCNw
 HxAxfPsX16hQKDWo8fa6yKYSzmJTvYbCDeL9P0UZKVmw35MxawhBdsrtA
 I8+x0Ip6SDCNRg0o1l2ZILLirvuhTLT+pr5G4TyNIGMNGgPzJIXviIuo9
 +q3t3e8Wp6XIZW4KiHHY15zaVRGN7Iqku4XdK6Cut3jFm5oD43X1YM6m2
 /tsfIOluXYqzNet0c7CqV8eij4GjU1491jgm1iRHWDQ1JcjbzVwwD8pNb
 JtW0g3qDrygcwqaqJWk28XVuT3KsnwurAL9TbCbf/iOXzclaHI5kEe7VZ w==;
X-CSE-ConnectionGUID: cLIcJiczQx2YaxJ1E+iOsQ==
X-CSE-MsgGUID: i4mcESslQ8Oi+ZoMUDYs6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="55087284"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="55087284"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 22:29:35 -0700
X-CSE-ConnectionGUID: 5pJHNSwsRLqKfBMjnFWIUw==
X-CSE-MsgGUID: 0D8FjJBuQhqYWQIgfTxwpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="146953433"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2025 22:29:32 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 2/6] net/intel: add read clock feature in ICE
Date: Fri,  6 Jun 2025 21:19:43 +0000
Message-ID: <20250606211947.473544-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606211947.473544-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-1-soumyadeep.hore@intel.com>
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
index 7cc083ca32..9478ba92df 100644
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
+	.read_clock					  = eth_ice_read_clock,
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
+	clock_gettime(CLOCK_REALTIME, &system_time);
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

